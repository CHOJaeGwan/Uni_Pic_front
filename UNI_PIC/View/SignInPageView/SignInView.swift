//
//  MainVIew.swift
//  UNI_PIC
//
//  Created by 조재관 on 2024/04/02.
//

import SwiftUI

struct SignInView: View {
    var body: some View {
        NavigationStack{
            GeometryReader { geometry in
                VStack(spacing: 0){
                    TopView()
                        .frame(height: geometry.size.height * 480 / 852)
                        .ignoresSafeArea()
                    Text("로그인").font(.system(size: 20, weight: .bold))
                    loginComponentView()
                        .padding(.top, 40)
                        .background()
                    HStack {
                        Text("아직 계정이 없으신가요?")
                        NavigationLink(destination: SignUpView()) {
                            Text("회원가입").underline()
                        }.foregroundColor(.black)
                    }.padding(.top, 40)
                } // VStack
            }
        }
    }
}

struct TopView: View {
    var body: some View {
        Color("SignInBackgroundColor")
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
