//
//  ViewAnchorReader.swift
//  Swish
//
//  Created by Radhesh Goel on 17/7/2025.
//

import SwiftUI

struct ViewAnchorReader: NSViewRepresentable {
    var onResolve: (NSView) -> Void

    func makeNSView(context: Context) -> NSView {
        let nsView = NSView()
        DispatchQueue.main.async {
            onResolve(nsView)
        }
        return nsView
    }

    func updateNSView(_ nsView: NSView, context: Context) {}
}
