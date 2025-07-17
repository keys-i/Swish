//
//  SettingsPopoverController.swift
//  Swish
//
//  Created by Radhesh Goel on 17/7/2025.
//

import Cocoa
import SwiftUI

final class SettingsPopoverController {
    static let shared = SettingsPopoverController()
    
    init() {
        NotificationCenter.default.addObserver(
            forName: NSApplication.didResignActiveNotification,
            object: nil,
            queue: .main
        ) { [weak self] _ in
            self?.close()
        }
    }

    private var popover: NSPopover = {
        let popover = NSPopover()
        popover.contentSize = NSSize(width: 240, height: 160)
        popover.behavior = .transient
        popover.contentViewController = NSHostingController(rootView: SettingsView())
        return popover
    }()
    
    func toggle(relativeTo rect: NSRect, of view: NSView) {
        if popover.isShown {
            popover.performClose(nil)
        } else {
            popover.show(relativeTo: rect, of: view, preferredEdge: .maxY)
            popover.contentViewController?.view.window?.becomeKey()
        }
    }
    
    func close() {
        if popover.isShown {
            popover.performClose(nil)
        }
    }
}
