//
//  CleaningOverlayWindow.swift
//  Swish
//
//  Created by Radhesh Goel on 17/7/2025.
//

import SwiftUI
import AppKit
import Combine

final class CleaningOverlayWindow {
    static let shared = CleaningOverlayWindow()

    private var window: NSWindow?
    private var isVisibleBinding = CurrentValueSubject<Bool, Never>(true)

    func show() {
        guard window == nil, let screenFrame = NSScreen.main?.frame else { return }

        let binding = Binding<Bool>(
            get: { self.isVisibleBinding.value },
            set: { self.isVisibleBinding.send($0) }
        )

        let view = CleaningOverlayView(isVisible: binding)
        let hosting = NSHostingView(rootView: view)

        let overlay = NSWindow(
            contentRect: screenFrame,
            styleMask: [.borderless],
            backing: .buffered,
            defer: false
        )

        overlay.level = .floating
        overlay.isOpaque = false
        overlay.backgroundColor = .clear
        overlay.ignoresMouseEvents = true
        overlay.collectionBehavior = [.canJoinAllSpaces, .fullScreenAuxiliary]
        overlay.contentView = hosting
        overlay.alphaValue = 0
        overlay.makeKeyAndOrderFront(nil)

        // Fade in
        NSAnimationContext.runAnimationGroup { ctx in
            ctx.duration = 0.3
            overlay.animator().alphaValue = 1
        }

        self.window = overlay
        self.isVisibleBinding.send(true)
    }

    func hide() {
        guard let overlay = self.window else { return }

        // Animate contents out first
        self.isVisibleBinding.send(false)

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            NSAnimationContext.runAnimationGroup({ ctx in
                ctx.duration = 0.3
                overlay.animator().alphaValue = 0
            }, completionHandler: {
                overlay.orderOut(nil)
                overlay.contentView = nil
                self.window = nil
            })
        }
    }
}
