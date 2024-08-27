//
//  SplashView2.swift
//  UNI_PIC
//
//  Created by 조재관 on 6/27/24.
//

import SwiftUI

struct SplashView2: View {
    var body: some View {
        ZStack{
            Image("EditBanner")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
                .overlay(Color.black.opacity(0.4))
                .offset(x: -20)
            VStack{
                Text("UNIPIC")
                    .fontWeight(.bold)
                    .font(.system(size: 40))
                    .foregroundStyle(Color.white)
                Text("AI로 만드는 졸업사진")
                    .foregroundStyle(Color.white)
            }
            .vBottom()
            .padding(.bottom, 150)
        }
    }
}

#Preview {
    SplashView2()
}
