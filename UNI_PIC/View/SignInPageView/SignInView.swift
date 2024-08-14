//
//  MainVIew.swift
//  UNI_PIC
//
//  Created by 조재관 on 2024/04/02.
//

import SwiftUI

struct SignInView: View {
    @StateObject var kakaoAuthVm = KakaoAuthVM()
    @State private var isloggedIn = false
    var body: some View {
        NavigationStack{
            GeometryReader { geometry in
                VStack(spacing: 0){
                    if isloggedIn {
                       MainView()
                    }else{
                        TopView()
                            .frame(height: geometry.size.height * 480 / 852)
                            .ignoresSafeArea()
                        Text("로그인").font(.system(size: 20, weight: .bold))
                            .background().padding(.bottom)
                        Text("소셜계정으로 UNI PIC을 이용해보세요.")
                            .foregroundStyle(Color("NuetralColor_500"))
                        loginComponentView(kakaoAuthVm: kakaoAuthVm, googleAuthVM: GoogleAuthVM(), isLoggedIn: $isloggedIn)
                            .padding(.top, 40)
                            .background()
                        HStack {
                            Text("UNI PIC이 처음이신가요?")
                            NavigationLink(destination: SignUpView()) {
                                Text("회원가입").underline()
                            }.foregroundColor(.black)
                        }.padding(.top, 40)
                    }
                } // VStack
            }
        }
    }
}

struct TopView: View {
    var body: some View {
        ZStack{
            Color("SignInBackgroundColor")
            VStack{
                Text("UNIPIC")
                    .fontWeight(.bold)
                    .font(.system(size: 40))
                    .foregroundStyle(LinearGradientStyle.colorGradient)
                Text("AI로 만드는 졸업사진")
                    .foregroundStyle(LinearGradientStyle.colorGradient)
            }
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
