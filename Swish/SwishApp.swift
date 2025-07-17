//
//  SwishApp.swift
//  Swish
//
//  Created by Radhesh Goel on 16/7/2025.
//
import Cocoa
import SwiftUI

@main
struct SwishApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        Settings {
            EmptyView()
        }
    }
}
