//
//  PermissionManager.swift
//  UNI_PIC
//
//  Created by 조재관 on 4/16/24.
//

import AVFoundation
import Photos
import UIKit

class PermissionManager {
    // 카메라 접근 권한 요청
    class func requestCameraPermission(completion: @escaping (Bool) -> Void) {
        AVCaptureDevice.requestAccess(for: .video, completionHandler: { granted in
            DispatchQueue.main.async {
                completion(granted)
            }
        })
    }
    
    // 사진 라이브러리 접근 권한 요청
    class func requestPhotoLibraryPermission(completion: @escaping (Bool) -> Void) {
        PHPhotoLibrary.requestAuthorization { status in
            DispatchQueue.main.async {
                completion(status == .authorized)
            }
        }
    }
    
    // 설정으로 이동하는 알림 표시
    class func presentSettingsAlert(from viewController: UIViewController, for type: String) {
        let message: String
        
        // 접근 유형에 따른 메시지 변경
        if type == "카메라" {
            message = "졸업 사진을 생성할 때 사용될 사진을 선택하고 업로드하려면 카메라에 접근해야 합니다."
        } else if type == "사진 라이브러리" {
            message = "졸업 사진에 사용될 사진을 선택하고 업로드하려면 앨범에 접근해야 합니다."
        } else {
            message = "\(type)을(를) 사용하기 위해서는 설정에서 권한을 허용해야 합니다."
        }
        
        let alertController = UIAlertController(
            title: "\(type) 접근 권한이 거부되었습니다.",
            message: message,
            preferredStyle: .alert
        )
        
        let settingsAction = UIAlertAction(title: "설정으로 이동", style: .default) { (_) -> Void in
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
        
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                    // 설정 앱이 성공적으로 열렸는지 확인
                })
            }
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .default, handler: nil)
        alertController.addAction(settingsAction)
        alertController.addAction(cancelAction)
        
        viewController.present(alertController, animated: true, completion: nil)
    }
    
    // 카메라 접근 권한 확인 및 요청
    class func verifyCameraPermission(from viewController: UIViewController, completion: @escaping (Bool) -> Void) {
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        switch status {
        case .authorized:
            completion(true)
        case .notDetermined:
            requestCameraPermission(completion: completion)
        case .denied, .restricted:
            presentSettingsAlert(from: viewController, for: "카메라")
            completion(false)
        @unknown default:
            completion(false)
        }
    }
    
    // 사진 라이브러리 접근 권한 확인 및 요청
    class func verifyPhotoLibraryPermission(from viewController: UIViewController, completion: @escaping (Bool) -> Void) {
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .authorized:
            completion(true)
        case .limited:
            completion(true)
        case .notDetermined:
            requestPhotoLibraryPermission(completion: completion)
        case .denied, .restricted:
            presentSettingsAlert(from: viewController, for: "사진 라이브러리")
            completion(false)
        @unknown default:
            completion(false)
        }
    }
}

