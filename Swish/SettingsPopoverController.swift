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
    private var popover: NSPopover?
    
    func toggle() {
        if let popover = popover, popover.isShown {
            popover.performClose(nil)
        } else {
            show()
        }
    }
    
    private func show() {
        guard let statusItemButton = AppDelegate.shared?.statusItem.button else { return }
        
        let popover = NSPopover()
        popover.contentSize = NSSize(width: 260, height: 140)
        popover.behavior = .transient
        popover.contentViewController = NSHostingController(rootView: SettingsView())
        popover.show(relativeTo: statusItemButton.bounds, of: statusItemButton, preferredEdge: .minX)
    }
    
}
