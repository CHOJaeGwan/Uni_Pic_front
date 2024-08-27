import SwiftUI
import PhotosUI

struct ResultSelectionView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var cameraVM: CameraViewModel
    @State private var selectedRectangle: Int?
    @State private var shouldNavigateToEditView: Bool = false
    @Binding var isShowingTabBar: Bool
    var uploadedImageURLs: [String] // response로부터 동적으로 전달받은 이미지 URL 배열

    var body: some View {
        NavigationStack() {
            VStack {
                VStack {
                    Text("STEP 3")
                        .fontWeight(.bold)
                        .foregroundStyle(LinearGradientStyle.colorGradient)
                        .padding(.bottom)
                    Text("사진 편집하기")
                }
                .vTop()
                HStack {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .foregroundColor(.red)
                    Text("어플을 종료하지 마세요 (종료시 기회가 날아갈 수 있습니다.)")
                        .foregroundColor(.red)
                        .fontWeight(.bold)
                        .font(.system(size: 12))
                }
                .padding(.top, 20)
                VStack {
                    HStack {
                        ForEach(0..<2, id: \.self) { index in
                            if index < uploadedImageURLs.count {
                                Button {
                                    selectedRectangle = index + 1
                                } label: {
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(selectedRectangle == index + 1 ? LinearGradientStyle.colorGradient : LinearGradientStyle.grayGradient, lineWidth: 5)
                                        .frame(width: CGFloat.screenWidth * 0.48, height: CGFloat.screenHeight * 0.3)
                                        .background(Color("NeutralColor_200"))
                                        .overlay(
                                            AsyncImage(url: URL(string: uploadedImageURLs[index])) { phase in
                                                switch phase {
                                                case .empty:
                                                    ProgressView()
                                                case .success(let image):
                                                    image
                                                        .resizable()
                                                        .scaledToFill()
                                                        .padding(.horizontal,3)
                                                        .padding(.vertical,3)
                                                case .failure:
                                                    Image(systemName: "photo")
                                                @unknown default:
                                                    EmptyView()
                                                }
                                            }
                                            .clipShape(RoundedRectangle(cornerRadius: 8))
                                        )
                                }
                                .clipShape(RoundedRectangle(cornerSize: CGSize(width: 8, height: 8)))
                            }
                        }
                    }

                    HStack {
                        ForEach(2..<4, id: \.self) { index in
                            if index < uploadedImageURLs.count {
                                Button {
                                    selectedRectangle = index + 1
                                } label: {
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(selectedRectangle == index + 1 ? LinearGradientStyle.colorGradient : LinearGradientStyle.grayGradient, lineWidth: 5)
                                        .frame(width: CGFloat.screenWidth * 0.48, height: CGFloat.screenHeight * 0.3)
                                        .background(Color("NeutralColor_200"))
                                        .overlay(
                                            AsyncImage(url: URL(string: uploadedImageURLs[index])) { phase in
                                                switch phase {
                                                case .empty:
                                                    ProgressView()
                                                case .success(let image):
                                                    image
                                                        .resizable()
                                                        .scaledToFill()
                                                        .padding(.horizontal,3)
                                                        .padding(.vertical,3)
                                                case .failure:
                                                    Image(systemName: "photo")
                                                @unknown default:
                                                    EmptyView()
                                                }
                                            }
                                            .clipShape(RoundedRectangle(cornerRadius: 8))
                                        )
                                }
                                .clipShape(RoundedRectangle(cornerSize: CGSize(width: 8, height: 8)))
                            }
                        }
                    }
                }
                .padding()
                .frame(width: CGFloat.screenWidth * 0.9, alignment: .center)

                ZStack {
                    if selectedRectangle != nil {
                        ColorButtonComponent()
                    } else {
                        ButtonComponent()
                    }
                    Text("저장하기!")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(selectedRectangle != nil ? LinearGradientStyle.colorGradient : LinearGradientStyle.blackGradient)
                        .cornerRadius(10)
                }
                .onTapGesture {
                    if let selectedRectangle = selectedRectangle, selectedRectangle <= uploadedImageURLs.count {
                        if let url = URL(string: uploadedImageURLs[selectedRectangle - 1]) {
                            saveImageToAlbum(url: url) {
                                isShowingTabBar = true
                                dismiss()
                            }
                        }
                    }
                }
                .vBottom()
            }
            .padding()
            .navigationDestination(isPresented: $shouldNavigateToEditView) {
                EditView(isShowingTabBar: .constant(true))
            }
            .navigationBarBackButtonHidden(true)
        }
    }

    // 이미지 저장 함수
    func saveImageToAlbum(url: URL, completion: @escaping () -> Void) {
        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data, let image = UIImage(data: data) {
                UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
                DispatchQueue.main.async {
                    completion()
                }
            } else {
                print("이미지를 다운로드하는 데 실패했습니다: \(String(describing: error))")
            }
        }
        dataTask.resume()
    }
}

struct ResultSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        ResultSelectionView(isShowingTabBar: .constant(true),uploadedImageURLs: [])
    }
}
