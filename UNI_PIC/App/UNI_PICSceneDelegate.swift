//
//  UNI_PICSceneDelegate.swift
//  UNI_PIC
//
//  Created by 조재관 on 4/10/24.
//

import Foundation
import KakaoSDKAuth
import UIKit

class UNI_PICSceneDelegate: UIResponder, UIWindowSceneDelegate {
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        if let url = URLContexts.first?.url {
            if (AuthApi.isKakaoTalkLoginUrl(url)) {
                _ = AuthController.handleOpenUrl(url: url)
            }
        }
    }
}
