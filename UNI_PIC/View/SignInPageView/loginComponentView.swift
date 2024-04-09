//
//  loginComponentView.swift
//  UNI_PIC
//
//  Created by 조재관 on 2024/04/08.
//

import SwiftUI

struct loginComponentView: View {
    @StateObject var kakaoAuthVm : KakaoAuthVM = KakaoAuthVM()
    let loginStatus: (Bool) -> String = {isLoggedIn in return isLoggedIn ? "로그인 상태" : "로그아웃 상태"}
    
    var body: some View{
        VStack{
            HStack{
                ZStack{
                    Circle()
                        .fill(Color.black)
                        .frame(width: 44, height: 44)
                    Image(systemName: "apple.logo")
                        .foregroundColor(.white)
                }
                Spacer()
                Button(action:{
                    kakaoAuthVm.handleKakaoLogin()
                }){
                    ZStack{
                        Circle()
                            .fill(Color("kakaoColor"))
                            .frame(width: 44, height: 44)
                        Image("kakaoLogin")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30, height: 30)
                    }
                }
                Spacer()
                ZStack{
                    Circle()
                        .stroke(Color("NuetralColor_300"), lineWidth:2)
                        .frame(width: 44, height: 44)
                    Image("googleLogin")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30, height: 30)
                }
            }.frame(width: CGFloat.screenWidth * 0.5)
        }
    }
}

struct loginComponentView_Previews: PreviewProvider {
    static var previews: some View {
        loginComponentView()
    }
}
