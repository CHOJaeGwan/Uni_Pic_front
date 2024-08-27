//
//  PermissionModelView.swift
//  UNI_PIC
//
//  Created by 조재관 on 4/16/24.
//

//import Foundation
//import Combine
//
//class PermissionViewModel: ObservableObject {
//    // 권한 상태를 나타내는 Published 프로퍼티
//    @Published var cameraPermissionGranted: Bool = false
//    @Published var photoLibraryPermissionGranted: Bool = false
//    
//    // 카메라 권한을 확인하고 요청하는 메소드
//    func checkCameraPermission() {
//        PermissionManager.verifyCameraPermission(from: UIApplication.shared.windows.first?.rootViewController ?? UIViewController()) { granted in
//            DispatchQueue.main.async {
//                self.cameraPermissionGranted = granted
//            }
//        }
//    }
//    
//    // 사진 라이브러리 권한을 확인하고 요청하는 메소드
//    func checkPhotoLibraryPermission() {
//        PermissionManager.verifyPhotoLibraryPermission(from: UIApplication.shared.windows.first?.rootViewController ?? UIViewController()) { granted in
//            DispatchQueue.main.async {
//                self.photoLibraryPermissionGranted = granted
//            }
//        }
//    }
//}

