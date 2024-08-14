//
//  GrayBottonComponent.swift
//  UNI_PIC
//
//  Created by 조재관 on 4/30/24.
//

import SwiftUI

struct GrayBottonComponent: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .stroke(LinearGradientStyle.grayGradient, lineWidth: 2)
            .frame(width: CGFloat.screenWidth * 0.9,
                   height: 50)
    }
}

#Preview {
    GrayBottonComponent()
}
