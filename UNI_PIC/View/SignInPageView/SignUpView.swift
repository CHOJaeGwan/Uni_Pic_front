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
                Text("회원 가입").font(.system(size: 20, weight: .bold))
                    .padding(.top, 40)
                    .background()
                HStack {
                    Text("회원가입시 UNI PIC 서비스 이용약관에 동의")
                    NavigationLink(destination: SignUpView()) {
                        Text("내용 확인").underline()
                    }.foregroundColor(.black)
                }.padding(.top, 40)
            } // VStack
        }
    }
}

struct signupView: View {
    var body: some View{
        Text("회원가입").font(.system(size: 20, weight: .bold))
        HStack {
            Text("회원가입시 UNI PIC 서비스 이용약관에 동의")
            NavigationLink(destination: SignUpView()) {
                Text("내용확인").underline()
            }.foregroundColor(.black)
       }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
