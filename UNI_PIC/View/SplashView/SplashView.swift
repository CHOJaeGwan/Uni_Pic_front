//
//  SplashView.swift
//  UNI_PIC
//
//  Created by 조재관 on 4/12/24.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack{
            Color("SignInBackgroundColor").ignoresSafeArea(.all)
            
            VStack{
                Image("UNIPICLogo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 93.52443, height: 105.57655)
                    .padding()
                Text("UNIPIC")
                    .fontWeight(.bold)
                    .font(.system(size: 40))
                    .foregroundStyle(LinearGradientStyle.colorGradient)
                    
            }
        }
    }
}

#Preview {
    SplashView()
}
