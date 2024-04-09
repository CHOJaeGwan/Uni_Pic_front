//
//  UNI_PICApp.swift
//  UNI_PIC
//
//  Created by 조재관 on 2024/04/02.
//

import SwiftUI
import KakaoSDKCommon
import KakaoSDKAuth

@main
struct UNI_PICApp: App {
    init(){
        let kakaoAppKey = Bundle.main.infoDictionary?["KAKAO_NATIVE_APP_KEY"] ?? ""
        KakaoSDK.initSDK(appKey: kakaoAppKey as! String)
    }
    var body: some Scene {
        WindowGroup {
            // onOpenURL()을 사용해 커스텀 URL 스킴 처리
            SignInView().onOpenURL(perform: { url in
                if (AuthApi.isKakaoTalkLoginUrl(url)) {
                    AuthController.handleOpenUrl(url: url)
                }
            })
        }
    }
}
