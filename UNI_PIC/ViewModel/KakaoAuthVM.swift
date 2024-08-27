//
//  KakaoAuthVM.swift
//  UNI_PIC
//
//  Created by 조재관 on 2024/04/08.
//

import Foundation
import Combine
import KakaoSDKAuth
import KakaoSDKUser

class KakaoAuthVM : ObservableObject{
    
    @Published var isLoggedIn : Bool = false
    
    @MainActor
    func handleKakaoLoginWithApp() async -> Bool{
        await withCheckedContinuation{continuation in
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    print(error)
                    continuation.resume(returning: false)
                }
                else {
                    print("loginWithKakaoTalk() success.")
                    
                    //do something
                    _ = oauthToken
                    continuation.resume(returning: true)
                }
            }
        }
        
    }
    
    @MainActor
    func handleKakaoLoginWithAccount() async -> Bool{
        await withCheckedContinuation{continuation in
            UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                    if let error = error {
                        print(error)
                        continuation.resume(returning: false)
                    }
                    else {
                        print("loginWithKakaoAccount() success.")
                        //do something
                        _ = oauthToken
                        continuation.resume(returning: true)
                    }
                }
            }
        }
    
    @MainActor
    func handleKakaoLogin(){
        Task{
            // 카카오톡 설치 여부 확인
            if (UserApi.isKakaoTalkLoginAvailable()) {
                // 카카오 앱을 통해 로그인
                isLoggedIn =  await handleKakaoLoginWithApp()
                print(self.isLoggedIn)
            } else{
                //
                isLoggedIn =  await handleKakaoLoginWithAccount()
                print(self.isLoggedIn)
            }
        }
    }
}
    
