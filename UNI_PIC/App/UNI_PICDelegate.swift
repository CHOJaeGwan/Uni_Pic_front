//
//  UNI_PICDelegate.swift
//  UNI_PIC
//
//  Created by 조재관 on 4/10/24.
//

import Foundation
import UIKit
import KakaoSDKCommon
import KakaoSDKAuth
import FirebaseCore
import FirebaseAuth
import GoogleSignIn

class UNI_PICDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {

        FirebaseApp.configure()
        
        // 메인번들에 있는 카카오 앱키 불러오기
        let kakaoAppKey = Bundle.main.infoDictionary?["KAKAO_NATIVE_APP_KEY"] ?? ""

        // kakao SDK 초기화
        KakaoSDK.initSDK(appKey: kakaoAppKey as! String) 
        return true
    }
    
    @available(iOS 9.0, *)
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
            if (AuthApi.isKakaoTalkLoginUrl(url)) {
                return AuthController.handleOpenUrl(url: url)
            } else{
                return GIDSignIn.sharedInstance.handle(url)
            }
        }
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        
        let sceneConfigutation = UISceneConfiguration(name: nil, sessionRole: connectingSceneSession.role)
        
        sceneConfigutation.delegateClass = UNI_PICSceneDelegate.self

        return sceneConfigutation
    }
}
