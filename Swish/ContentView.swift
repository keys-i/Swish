//
//  ContentView.swift
//  Swish
//
//  Created by Radhesh Goel on 16/7/2025.
//

import SwiftUI

private let timer = Timer.publish(every: 0.4, on: .main, in: .common).autoconnect()


struct ContentView: View {
    @ObservedObject var keyboardManager = KeyboardManager.shared
    @State private var dotCount: Int = 0

    var body: some View {
        VStack(spacing: 16) {
            // Icon
            Image(systemName: keyboardManager.keyboardEnabled ? "keyboard.fill" : "keyboard")
                .font(.system(size: 36, weight: .semibold))
                .symbolRenderingMode(.hierarchical)
                .foregroundStyle(keyboardManager.keyboardEnabled ? .blue : .secondary)
                .accessibilityIdentifier("KeyboardIcon")

            // Titleee
            Text(keyboardManager.keyboardEnabled ? "Keyboard Locked" : "Keyboard Active")
                .font(.title3)
                .fontWeight(.medium)
                .accessibilityIdentifier("StatusLabel")

            // Toggle
            Toggle("Enable Keyboard Lock", isOn: $keyboardManager.keyboardEnabled)
                .toggleStyle(SwitchToggleStyle())
                .labelsHidden()
                .accessibilityIdentifier("KeyboardToggle")

            // Info
            Text("Press ⌘Q to quit" + String(repeating: ".", count: dotCount))
                .font(.footnote)
                .foregroundStyle(.secondary)
                .onReceive(timer) { _ in
                    dotCount = (dotCount + 1) % 4
                }
                .accessibilityIdentifier("QuitHint")
            
            // Settings Button
            Button("Settings") {
                SettingsPopoverController.shared.toggle()
            }
            .controlSize(.small)
            .buttonStyle(.bordered)
            .accessibilityIdentifier( "SettingsButton" )
            
            // Quit button
            Button("Quit") {
                NSApplication.shared.terminate(nil)
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.small)
            .padding(.horizontal)
            .accessibilityIdentifier("QuitButton")

        }
        .padding(20)
        .frame(width: 260, height: 200)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .stroke(Color.gray.opacity(0.15), lineWidth: 0.5)
        )
    }
}

#Preview {
    ContentView()
}
