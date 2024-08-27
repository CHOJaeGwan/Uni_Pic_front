////
//import Foundation
//import UIKit
//
//class ViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate {
//    
//    let imagePicker = UIImagePickerController()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        self.imagePicker.delegate = self
//    }
//    
//    /**
//     카메라 접근 권한 판별하는 함수
//     */
//    func cameraAuth() {
//        AVCaptureDevice.requestAccess(for: .video) { granted in
//            if granted {
//                print("권한 허용")
//                self.openCamera()
//            } else {
//                print("권한 거부")
//                self.showAlertAuth("카메라")
//            }
//        }
//    }
//    
//    /**
//     앨범 접근 권한 판별하는 함수
//     */
//    func albumAuth() {
//    switch PHPhotoLibrary.authorizationStatus() {
//        case .denied:
//            print("거부")
//            self.showAlertAuth("앨범")
//        case .authorized:
//            print("허용")
//            self.openPhotoLibrary()
//        case .notDetermined, .restricted:
//            print("아직 결정하지 않은 상태")
//            PHPhotoLibrary.requestAuthorization { state in
//                if state == .authorized {
//                    self.openPhotoLibrary()
//                } else {
//                    self.dismiss(animated: true, completion: nil)
//                }
//            }
//        default:
//            break
//        }
//    }
//    
//    /**
//     권한을 거부했을 때 띄어주는 Alert 함수
//     - Parameters:
//     - type: 권한 종류
//     */
//    func showAlertAuth(
//        _ type: String
//    ) {
//        if let appName = Bundle.main.infoDictionary!["CFBundleDisplayName"] as? String {
//            let alertVC = UIAlertController(
//                title: "설정",
//                message: "\(appName)이(가) \(type) 접근 허용되어 있지 않습니다. 설정화면으로 가시겠습니까?",
//                preferredStyle: .alert
//            )
//            let cancelAction = UIAlertAction(
//                title: "취소",
//                style: .cancel,
//                handler: nil
//            )
//            let confirmAction = UIAlertAction(title: "확인", style: .default) { _ in
//                UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
//            }
//            alertVC.addAction(cancelAction)
//            alertVC.addAction(confirmAction)
//            self.present(alertVC, animated: true, completion: nil)
//        }
//    }
//    
//    /**
//     아이폰에서 앨범에 접근하는 함수
//     */
//    private func openPhotoLibrary() {
//        if (UIImagePickerController.isSourceTypeAvailable(.photoLibrary)) {
//            self.imagePicker.sourceType = .photoLibrary
//            self.imagePicker.modalPresentationStyle = .currentContext
//            self.present(self.imagePicker, animated: true, completion: nil)
//        } else {
//            print("앨범에 접근할 수 없습니다.")
//        }
//    }
//
//    /**
//     아이폰에서 카메라에 접근하는 함수
//     */
//    private func openCamera() {
//        if (UIImagePickerController.isSourceTypeAvailable(.camera)) {
//            self.imagePicker.sourceType = .camera
//            self.imagePicker.modalPresentationStyle = .currentContext
//            self.present(self.imagePicker, animated: true, completion: nil)
//        } else {
//            print("카메라에 접근할 수 없습니다.")
//        }
//    }
//
//    /**
//     UIImagePickerControllerDelegate에 정의된 메소드 - 선택한 미디어의 정보를 알 수 있음
//     */
//    func imagePickerController(
//        _ picker: UIImagePickerController,
//        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]
//    ) {
//        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
//            print("image_info = \(image)")
//        }
//        dismiss(animated: true, completion: nil)
//    }
//}
