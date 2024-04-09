//
//  SelectOptionView.swift
//  UNI_PIC
//
//  Created by 조재관 on 2024/04/07.
//

import SwiftUI

struct SelectOptionView: View {
    var body: some View {
        NavigationStack{
            VStack{
                VStack{
                    Text("선택 사항").bold()
                    Text("모델 이미지 학습 참고사항으로 전달됩니다.")
                }.padding(.bottom)
                VStack{
                    Text("성별 선택").bold().hLeading()
                    Text("표정 선택").bold().hLeading()
                    Text("해어스타일").bold().hLeading()
                }
                NavigationLink{
                    StartButtonView()
                }label: {
                    Text("다음으로")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(Color.white)
                        .cornerRadius(10)
                }.vBottom()
            }.padding()
        }}
}

struct SelectOptionView_Previews: PreviewProvider {
    static var previews: some View {
        SelectOptionView()
    }
}
