//
//  loginComponentView.swift
//  UNI_PIC
//
//  Created by 조재관 on 2024/04/08.
//

import SwiftUI
import _AuthenticationServices_SwiftUI

struct loginComponentView: View {
    @StateObject var kakaoAuthVm : KakaoAuthVM = KakaoAuthVM()
    @StateObject var appleAuthVM : AppleAuthVM =  AppleAuthVM()
    @Binding var isLoggedIn: Bool
    var body: some View{
        VStack{
            HStack{
                Button(action:{
                    kakaoAuthVm.handleKakaoLogin()
                }){
                    ZStack{
                        RoundedRectangle(cornerSize: CGSize(width: 10, height: 3))
                            .fill(Color("kakaoColor"))
                        HStack{
                            Image("kakaoLogin")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30, height: 30)
                            Text("SignIn With Kakao")
                                .foregroundStyle(Color.black)
                                .fontWeight(.bold)
                        }
                    }
                }
            }
            .padding(.horizontal)
            .frame(height: 50)
            .hCenter()
        }
        .onReceive(kakaoAuthVm.$isLoggedIn) { newValue in
            isLoggedIn = newValue
        }
    }
}

struct loginComponentView_Previews: PreviewProvider {
    static var previews: some View {
        loginComponentView(kakaoAuthVm: KakaoAuthVM(), isLoggedIn: .constant(false))
    }
}
