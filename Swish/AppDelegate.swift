//
//  AppDelegate.swift
//  Swish
//
//  Created by Radhesh Goel on 17/7/2025.
//

import Cocoa
import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate {
    static var shared: AppDelegate!

    var statusItem: NSStatusItem!
    var popover: NSPopover!

    func applicationDidFinishLaunching(_ notification: Notification) {
        AppDelegate.shared = self

        // Create main popover
        let popover = NSPopover()
        popover.contentSize = NSSize(width: 300, height: 200)
        popover.behavior = .transient // Closes when clicking outside
        popover.contentViewController = NSHostingController(rootView: ContentView())
        self.popover = popover

        // Create status bar item
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        if let button = statusItem.button {
            button.image = NSImage(systemSymbolName: "sparkles", accessibilityDescription: "Swish")
            button.action = #selector(togglePopover(_:))
        }

        // Close both popovers when app resigns active and keyboard lock is enabled
        NotificationCenter.default.addObserver(
            forName: NSApplication.didResignActiveNotification,
            object: nil,
            queue: .main
        ) { [weak self] _ in
            if KeyboardManager.shared.keyboardEnabled {
                self?.popover.performClose(nil)
                SettingsPopoverController.shared.close()
            }
        }
    }

    @objc func togglePopover(_ sender: Any?) {
        if let button = statusItem.button {
            if popover.isShown {
                popover.performClose(sender)
            } else {
                popover.show(relativeTo: button.bounds, of: button, preferredEdge: .minY)
                NotificationCenter.default.post(name: .swishPopoverAppeared, object: nil)
            }
        }
    }
}
