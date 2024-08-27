//
//  ColorSmallButtonComponent.swift
//  UNI_PIC
//
//  Created by 조재관 on 4/15/24.
//

import SwiftUI

struct SmallColorButtonComponent: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .stroke(LinearGradientStyle.colorGradient, lineWidth: 2)
            .frame(width: CGFloat.screenWidth * 0.4,
                   height: 50)
    }
}

struct SmallColorButtonComponent_Previews: PreviewProvider {
    static var previews: some View {
        SmallColorButtonComponent()
    }
}
