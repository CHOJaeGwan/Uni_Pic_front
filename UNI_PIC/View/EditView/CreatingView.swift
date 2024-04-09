//
//  CreatingView.swift
//  UNI_PIC
//
//  Created by 조재관 on 2024/04/07.
//

import SwiftUI

struct CreatingView: View {
    var body: some View {
        VStack{
            Rectangle()
                .fill(Color.gray)
                .frame(width: CGFloat.screenWidth * 0.9, height: CGFloat.screenWidth * 0.9)
                .cornerRadius(8)
                .padding(.bottom)
            Text("STEP 2")
            Text("AI 사진 생성")
        }.padding().vTop()
    }
}

struct CreatingView_Previews: PreviewProvider {
    static var previews: some View {
        CreatingView()
    }
}
