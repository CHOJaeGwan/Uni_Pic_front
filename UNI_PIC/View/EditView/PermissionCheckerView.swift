//
//  PermissionCheckerView.swift
//  UNI_PIC
//
//  Created by 조재관 on 4/16/24.
//

import SwiftUI

struct PermissionCheckerView: UIViewControllerRepresentable {
    var checkCameraPermission: Bool
    var checkPhotoLibraryPermission: Bool

    func makeUIViewController(context: Context) -> some UIViewController {
        return UIViewController() // 더미 뷰 컨트롤러
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
//        if checkCameraPermission {
//            PermissionManager.verifyCameraPermission(from: uiViewController) { granted in
//                if granted{
//                    print("Camera: 권한 허용")
//                }else{
//                    print("Camera: 권한 거부")
//                }
//            }
//        }
//        
//        if checkPhotoLibraryPermission {
//            PermissionManager.verifyPhotoLibraryPermission(from: uiViewController) {status in
//                if status{
//                    print("Album: 권한 허용")
//                }else{
//                    print("Album: 권한 거부")
//                }
//            }
//        }
    }
    
    func checkPermissions(from viewController: UIViewController, completion: @escaping (Bool, Bool) -> Void) {
        var cameraGranted = false
        var photoLibraryGranted = false
        
        let group = DispatchGroup()
        
        if checkCameraPermission {
            group.enter()
            PermissionManager.verifyCameraPermission(from: viewController) { granted in
                cameraGranted = granted
                group.leave()
            }
        }
        
        if checkPhotoLibraryPermission {
            group.enter()
            PermissionManager.verifyPhotoLibraryPermission(from: viewController) { granted in
                photoLibraryGranted = granted
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            completion(cameraGranted, photoLibraryGranted)
        }
    }
}

