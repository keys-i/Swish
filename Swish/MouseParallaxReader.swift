//
//  MouseTrackingView.swift
//  Swish
//
//  Created by Radhesh Goel on 17/7/2025.
//

import SwiftUI

struct MouseTrackingView: NSViewRepresentable {
    @Binding var position: CGPoint

    class Coordinator: NSObject {
        var trackingArea: NSTrackingArea?
        let parent: MouseTrackingView

        init(_ parent: MouseTrackingView) {
            self.parent = parent
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeNSView(context: Context) -> NSView {
        let view = NSView()
        view.wantsLayer = true

        let options: NSTrackingArea.Options = [.activeAlways, .mouseMoved, .inVisibleRect]
        context.coordinator.trackingArea = NSTrackingArea(rect: .zero, options: options, owner: context.coordinator, userInfo: nil)
        view.addTrackingArea(context.coordinator.trackingArea!)

        view.window?.acceptsMouseMovedEvents = true

        NSEvent.addLocalMonitorForEvents(matching: [.mouseMoved]) { event in
            DispatchQueue.main.async {
                let loc = event.locationInWindow
                self.position = loc
            }
            return event
        }

        return view
    }

    func updateNSView(_ nsView: NSView, context: Context) {}
}
