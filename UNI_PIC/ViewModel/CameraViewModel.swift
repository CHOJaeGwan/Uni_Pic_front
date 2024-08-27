import Foundation
import SwiftUI
import PhotosUI
import Alamofire

@MainActor
class CameraViewModel: ObservableObject {
    @AppStorage("accessToken") var accessToken: String = ""
    @Published private(set) var selectedImages: [UIImage] = []
    @Published var imageSelections: [PhotosPickerItem] = [] {
           didSet {
               setImages(from: imageSelections)
           }
       }
    @Published var uploadedImageURLs: [String] = []
    @Published var isImageUploadCompleted: Bool = false

    private func setImages(from selections: [PhotosPickerItem]) {
        Task {
            var images: [UIImage] = []
            for selection in selections.prefix(6) {
                do {
                    if let data = try await selection.loadTransferable(type: Data.self) {
                        if let uiImage = UIImage(data: data) {
                            if let resizedImage = uiImage.resize(to: CGSize(width: 600, height: 600)) {
                                images.append(resizedImage)
                            } else {
                                images.append(uiImage)
                            }
                        }
                    }
                } catch {
                    print("이미지 로드 에러: \(error.localizedDescription)")
                }
            }
            selectedImages = images
        }
    }

    func postImageData(gender: String, faceShape: String, hairStyle: String) async throws {
        guard !selectedImages.isEmpty else {
            print("선택된 이미지가 없습니다.")
            return
        }

        let url = "http://3.39.13.136:3000/generate"
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)"
        ]

        let parameters: [String: String] = [
            "gender": gender,
            "faceShape": faceShape,
            "hairStyle": hairStyle,
            "faceExpression": "smile"
        ]

        AF.upload(
            multipartFormData: { multipartFormData in
                for (key, value) in parameters {
                    if let data = value.data(using: .utf8) {
                        multipartFormData.append(data, withName: key)
                    }
                }

                for (index, image) in self.selectedImages.enumerated() {
                    if let imageData = image.jpegData(compressionQuality: 1.0) {
                        multipartFormData.append(imageData, withName: "image", fileName: "image\(index + 1).jpg", mimeType: "image/jpeg")
                    }
                }
            },
            to: url,
            headers: headers
        )
        .validate(statusCode: 200..<300)
        .responseDecodable(of: UploadResponse.self) { response in
            switch response.result {
            case .success(let uploadResponse):
                print("이미지 업로드 성공: \(uploadResponse.message)")
                self.uploadedImageURLs = uploadResponse.img
                self.isImageUploadCompleted = true
                print("isImageUploadCompleted:  \(self.isImageUploadCompleted)")
            case .failure(let error):
                if let data = response.data, let responseString = String(data: data, encoding: .utf8) {
                    print("서버 응답: \(responseString)")
                }
                print("이미지 업로드 실패: \(error.localizedDescription)")
                self.isImageUploadCompleted = false
            }
        }
    }
}

struct UploadResponse: Decodable {
    let message: String
    let img: [String]
}

extension UIImage {
    func resize(to targetSize: CGSize) -> UIImage? {
        let size = self.size
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height

        var newSize: CGSize
        if widthRatio > heightRatio {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        }

        let rect = CGRect(origin: .zero, size: newSize)

        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage
    }
}
