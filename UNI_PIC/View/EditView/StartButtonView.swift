//
//  StartButtonView.swift
//  UNI_PIC
//
//  Created by 조재관 on 2024/04/07.
//

import SwiftUI

struct StartButtonView: View {
    var body: some View {
        NavigationStack{
            VStack{
                NavigationLink{
                    CreatingView()
                } label: {
                    Text("생성 시작!")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(Color.white)
                        .cornerRadius(10)
                }.vBottom()
            }.padding()
        }
    }
}

struct StartButtonView_Previews: PreviewProvider {
    static var previews: some View {
        StartButtonView()
    }
}
