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

    @Published var keyboardEnabled: Bool = false

    private var cancellable: AnyCancellable?

    init() {
        cancellable = $keyboardEnabled
            .receive(on: DispatchQueue.main)
            .removeDuplicates()
            .sink { enabled in
                print("🔁 keyboardEnabled changed to \(enabled)")

                if enabled {
                    print("🟢 Showing overlay")
                    CleaningOverlayWindow.shared.show()
                    print("🟢 Starting interceptor")
                    KeyboardInterceptor.shared.startIntercepting()
                } else {
                    print("🔴 Hiding overlay")
                    CleaningOverlayWindow.shared.hide()
                    print("🔴 Stopping interceptor")
                    KeyboardInterceptor.shared.stopIntercepting()
                }
            }
    }

    func toggleKeyboardLock() {
        print("↔️ Toggling lock")
        keyboardEnabled.toggle()
    }
}
