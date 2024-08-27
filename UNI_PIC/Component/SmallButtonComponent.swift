//
//  SmallButtonComponent.swift
//  UNI_PIC
//
//  Created by 조재관 on 4/15/24.
//

import SwiftUI

struct SmallButtonComponent: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .stroke(Color("NeutralColor_800"), lineWidth: 2)
            .frame(width: CGFloat.screenWidth * 0.4,
                   height: 50)
    }
}

struct SmallButtonComponent_Previews: PreviewProvider {
    static var previews: some View {
        SmallButtonComponent()
    }
}

