//
//  LinearGradientStyle.swift
//  UNI_PIC
//
//  Created by 조재관 on 4/13/24.
//

import Foundation
import SwiftUI

struct LinearGradientStyle {
    static let colorGradient = LinearGradient(gradient: Gradient(colors: [Color("gradientColorS"), Color("gradientColorE")]), startPoint: .leading, endPoint: .trailing)
    static let grayGradient =  LinearGradient(colors: [Color("NeutralColor_400")], startPoint: .leading, endPoint: .trailing)
    static let blackGradient =  LinearGradient(colors: [Color.black], startPoint: .leading, endPoint: .trailing)
}
