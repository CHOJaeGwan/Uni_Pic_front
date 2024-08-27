//
//  UNI_PICApp.swift
//  UNI_PIC
//
//  Created by 조재관 on 2024/04/02.
//

import SwiftUI
import KakaoSDKCommon
import KakaoSDKAuth
import Alamofire

@main
struct UNI_PICApp: App {
    @UIApplicationDelegateAdaptor var appDelegate : UNI_PICDelegate
    @StateObject var kakaoAuthVm = KakaoAuthVM()
    @StateObject var remainingCountStore = RemainingCountStore()
    @StateObject private var cameraVM = CameraViewModel()
    @State public var isActive: Bool = false
    @State private var isFirstSplashActive: Bool = false
    @State private var isSecondSplashActive: Bool = false
    @AppStorage("accessToken") var accessToken: String = ""
    @AppStorage("refreshToken") var refreshToken: String = ""
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false
//    init(){
//        let kakaoAppKey = Bundle.main.infoDictionary?["KAKAO_NATIVE_APP_KEY"] ?? ""
//        KakaoSDK.initSDK(appKey: kakaoAppKey as! String)
//    }
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                if isSecondSplashActive {
                    if isLoggedIn {
                        MainView()
                            .onAppear {
                                validateToken()
                            }
                            .environmentObject(remainingCountStore)
                            .environmentObject(cameraVM)
                    } else {
                        SignInView()
                            .onAppear {
                                validateToken()
                            }
                    }
                } else if isFirstSplashActive {
                    SplashView2()
                        .transition(.opacity)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                                withAnimation {
                                    isSecondSplashActive = true
                                }
                            }
                        }
                } else {
                    SplashView()
                        .transition(.opacity)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                                withAnimation {
                                    isFirstSplashActive = true
                                }
                            }
                        }
                }
            }
            .animation(.easeInOut(duration: 1.0), value: isFirstSplashActive)
            .animation(.easeInOut(duration: 1.0), value: isSecondSplashActive)
            .environmentObject(remainingCountStore)
            .environmentObject(cameraVM)
        }
    }

    func validateToken() {
            let url = "http://3.39.13.136:3000/user/refresh-token"
            
            let headers: HTTPHeaders = [
                "Authorization": "Bearer \(refreshToken)"
            ]
            
            AF.request(url, headers: headers).responseData { response in
                switch response.result {
                case .success(let data):
                    if response.response?.statusCode == 200 {
                        do {
                            let tokenResponse = try JSONDecoder().decode(TokenResponse.self, from: data)
                            print("Token is valid")
                            isLoggedIn = true
                            self.accessToken = tokenResponse.accessToken
                            self.refreshToken = tokenResponse.refreshToken
                        } catch {
                            print("Failed to decode token response: \(error)")
                            isLoggedIn = false
                            accessToken = ""
                        }
                    } else {
                        print("Token is invalid, logging out")
                        isLoggedIn = false
                        accessToken = ""
                    }
                case .failure(let error):
                    print("Error: \(error)")
                    isLoggedIn = false
                    accessToken = ""
                }
            }
        }
}

struct TokenResponse: Codable {
    let accessToken: String
    let refreshToken: String
}
