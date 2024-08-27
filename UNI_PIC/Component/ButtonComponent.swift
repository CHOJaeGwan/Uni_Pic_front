//
//  ButtonComponent.swift
//  UNI_PIC
//
//  Created by 조재관 on 2024/04/08.
//

import SwiftUI

struct ButtonComponent: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .stroke(Color("NeutralColor_800"), lineWidth: 2)
            .frame(width: CGFloat.screenWidth * 0.9,
                   height: 50)
    }
}

struct ButtonComponent_Previews: PreviewProvider {
    static var previews: some View {
        ButtonComponent()
    }
}
