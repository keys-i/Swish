//
//  KeyboardInterceptor.swift
//  Swish
//
//  Created by Radhesh Goel on 17/7/2025.
//

import Foundation
import Cocoa

class KeyboardInterceptor {
    static let shared = KeyboardInterceptor()
    
    private var eventTap: CFMachPort?
    private var runLoopSource: CFRunLoopSource?
    
    func startIntercepting() {
        guard eventTap == nil else { return }
        
        let eventMask = CGEventMask(1 << CGEventType.keyDown.rawValue)
        
        eventTap = CGEvent.tapCreate(
            tap: .cgSessionEventTap,
            place: .headInsertEventTap,
            options: .defaultTap,
            eventsOfInterest: eventMask,
            callback: {_, type, event, _ in
                let keyCode = event.getIntegerValueField(.keyboardEventKeycode)
                let flags = event.flags
                
                let isCmd = flags.contains(.maskCommand)
                
                // Allow ⌘Q (keyCode 12 is Q)
                if isCmd && keyCode == 12 {
                    return Unmanaged.passRetained(event)
                }
                
                // Block everything else
                return nil
            }, userInfo: nil
        )
        
        if let eventTap = eventTap {
            runLoopSource = CFMachPortCreateRunLoopSource(kCFAllocatorDefault, eventTap, 0)
            CFRunLoopAddSource(CFRunLoopGetCurrent(), runLoopSource, .commonModes)
            CGEvent.tapEnable(tap: eventTap, enable: true)
        }
    }
    
    func stopIntercepting() {
        if let eventTap = eventTap {
            CGEvent.tapEnable(tap: eventTap, enable: false)
            if let source = runLoopSource {
                CFRunLoopRemoveSource(CFRunLoopGetCurrent(), source, .commonModes)
            }
            self.eventTap = nil
            self.runLoopSource = nil
        }
    }
}
