//
//  ResultSelectionView.swift
//  UNI_PIC
//
//  Created by 조재관 on 2024/04/08.
//

import SwiftUI

struct ResultSelectionView: View {
    var body: some View {
        NavigationStack{
            ZStack{
                VStack{
                    Text("STEP 3")
                        .padding(.bottom)
                    Text("사진 편집하기")
                }.vTop()
                NavigationLink{
                    RetouchingView()
                }label: {
                    Text("편집하기!")
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

struct ResultSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        ResultSelectionView()
    }
}
