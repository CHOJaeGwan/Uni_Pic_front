//
//  RemainingCountStore.swift
//  UNI_PIC
//
//  Created by 조재관 on 7/15/24.
//

import Foundation
import SwiftUI
import Combine

class RemainingCountStore: ObservableObject {
    @Published var remainingCount: Int = 0
}
