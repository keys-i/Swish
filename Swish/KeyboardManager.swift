//
//  KeyboardManager.swift
//  Swish
//
//  Created by Radhesh Goel on 17/7/2025.
//

import Foundation
import Combine

class KeyboardManager: ObservableObject {
    static let shared = KeyboardManager()
    
    @Published var keyboardEnabled: Bool = false {
        didSet {
            if keyboardEnabled {
                KeyboardInterceptor.shared.startIntercepting()
            } else {
                KeyboardInterceptor.shared.stopIntercepting()
            }
        }
    }
    
    // Internal method for test mocking
    func toggleKeyboardLock() {
        keyboardEnabled.toggle()
    }
}
