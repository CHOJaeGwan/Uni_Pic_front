//
//  ColorButtonComponent.swift
//  UNI_PIC
//
//  Created by 조재관 on 4/14/24.
//

import SwiftUI

struct ColorButtonComponent: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .stroke(LinearGradientStyle.colorGradient, lineWidth: 2)
            .frame(width: CGFloat.screenWidth * 0.9,
                   height: 50)
    }
}

struct ColorButtonComponent_Previews: PreviewProvider {
    static var previews: some View {
        ColorButtonComponent()
    }
}
