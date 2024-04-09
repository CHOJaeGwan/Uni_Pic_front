//
//  EditVIew.swift
//  UNI_PIC
//
//  Created by 조재관 on 2024/04/03.
//

import SwiftUI

struct EditView: View {
    var body: some View {
        NavigationStack{
            ZStack{
                GeometryReader { geometry in
                    VStack(spacing: 0){
                        TopView()
                            .frame(height: geometry.size.height * 480 / 852)
                            .ignoresSafeArea()
                        NavigationLink{
                            SelectImageView()
                        } label: {
                             Text("사진 생성하기")
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.blue)
                                .foregroundColor(Color.white)
                                .cornerRadius(10)
                        }
                        .frame(width: CGFloat.screenWidth * 0.9)
                        .vBottom()
                    } // VStack
                }
            }.padding(.bottom)
        }
    }
}

//ZStack{
//    ButtonComponent()
//    Text("사진 생성하기")
//        .padding()
//        .frame(maxWidth: .infinity)
//        .foregroundColor(Color.black)
//}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView()
    }
}
