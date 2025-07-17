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
    @State private var gearButtonAnchor: NSView?
    @State private var dotCount: Int = 0
    @State private var hasAppeared: Bool = false

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(.ultraThinMaterial)
                .overlay(
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .stroke(Color.gray.opacity(0.15), lineWidth: 0.5)
                )

            VStack(spacing: 16) {
                // Top row with gear icon
                HStack {
                    Spacer()
                    Button(action: {
                        if let anchor = gearButtonAnchor {
                            SettingsPopoverController.shared.toggle(
                                relativeTo: anchor.bounds,
                                of: anchor
                            )
                        }
                    }) {
                        Image(systemName: "gearshape")
                            .font(.system(size: 14, weight: .regular))
                            .padding(6)
                            .background(
                                RoundedRectangle(cornerRadius: 6)
                                    .fill(Color.secondary.opacity(0.1))
                            )
                            .background(
                                ViewAnchorReader { nsView in
                                    gearButtonAnchor = nsView.superview
                                }
                            )
                    }
                    .buttonStyle(.plain)
                    .accessibilityIdentifier("SettingsGearButton")
                }

                // Icon
                Image(systemName: keyboardManager.keyboardEnabled ? "keyboard.fill" : "keyboard")
                    .font(.system(size: 48, weight: .semibold))
                    .symbolRenderingMode(.hierarchical)
                    .foregroundStyle(keyboardManager.keyboardEnabled ? .blue : .secondary)
                    .accessibilityIdentifier("KeyboardIcon")
                    .padding(.top, -3)

                // Title
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
            .scaleEffect(hasAppeared ? 1 : 0.92)
            .opacity(hasAppeared ? 1 : 0)
            .offset(y: hasAppeared ? 0 : 30)
            .animation(.interpolatingSpring(stiffness: 160, damping: 18).delay(0.05), value: hasAppeared)
            .onAppear {
                NotificationCenter.default.post(name: .swishPopoverAppeared, object: nil)
            }
            .onReceive(NotificationCenter.default.publisher(for: .swishPopoverAppeared)) { _ in
                hasAppeared = false
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                    hasAppeared = true
                }
            }
        }
        .frame(width: 260, height: 260)
    }
}

extension Notification.Name {
    static let swishPopoverAppeared = Notification.Name("swishPopoverAppeared")
}

#Preview {
    ContentView()
}
