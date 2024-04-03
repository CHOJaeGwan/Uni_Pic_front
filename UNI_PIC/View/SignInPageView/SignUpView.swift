//
//  SignUpView.swift
//  UNI_PIC
//
//  Created by 조재관 on 2024/04/02.
//

import SwiftUI

struct SignUpView: View {
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0){
                TopView()
                    .frame(height: geometry.size.height * 480 / 852)
                    .ignoresSafeArea()
                loginView()
                    .padding(.top, 40)
                    .background()
            } // VStack
        }
    }
}

struct signupView: View {
    var body: some View{
        Text("로그인").font(.system(size: 20, weight: .bold))
        HStack {
            Text("아직 계정이 없으신가요?")
            
            NavigationLink(destination: SignUpView()) {
                Text("회원가입").underline()
            }.foregroundColor(.black)
       }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
