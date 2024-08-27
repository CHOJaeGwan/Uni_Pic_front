//
//  ApplicationUtility.swift
//  UNI_PIC
//
//  Created by 조재관 on 4/11/24.
//

import Foundation
import SwiftUI

final class ApplicationUtility {
    
    static var rootViewController: UIViewController {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else{
            return .init()
        }
        
        guard let root = screen.windows.first?.rootViewController else{
            return .init()
        }
        
        return root
    }
}
