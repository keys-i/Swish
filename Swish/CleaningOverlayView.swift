//
//  CleaningOverlayView.swift
//  Swish
//
//  Created by Radhesh Goel on 17/7/2025.
//

import SwiftUI

struct CleaningOverlayView: View {
    @Environment(\.colorScheme) var colorScheme
    @Binding var isVisible: Bool
    @State private var animateIn = false
    @State private var breathing = false

    var body: some View {
        ZStack {
            Color(nsColor: NSColor.windowBackgroundColor)
                .opacity(colorScheme == .dark ? 0.85 : 0.92)
                .ignoresSafeArea()

            VStack(spacing: 12) {
                Image(systemName: "sparkles")
                    .font(.system(size: 80))
                    .foregroundColor(.white)
                    .scaleEffect(breathing ? 1.05 : 0.9)
                    .shadow(color: .white.opacity(breathing ? 0.3 : 0), radius: breathing ? 10 : 0)
                    .opacity(animateIn ? 1 : 0)
                    .offset(y: animateIn ? 0 : -20)
                    .animation(.interpolatingSpring(stiffness: 120, damping: 12).delay(0.05), value: animateIn)
                    .animation(.easeInOut(duration: 1.6).repeatForever(autoreverses: true), value: breathing)
                    .onAppear {
                        animateIn = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            breathing = true
                        }
                    }

                Text("Cleaning Mode")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
                    .opacity(animateIn ? 1 : 0)
                    .offset(y: animateIn ? 0 : 10)
                    .animation(.easeInOut(duration: 0.4).delay(0.1), value: animateIn)

                Text("Press ⌘Q to exit")
                    .font(.title3)
                    .foregroundColor(.secondary)
                    .opacity(animateIn ? 1 : 0)
                    .offset(y: animateIn ? 0 : 10)
                    .animation(.easeInOut(duration: 0.4).delay(0.2), value: animateIn)
            }
        }
        .onAppear {
            animateIn = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                breathing = true
            }
        }
        .onChange(of: isVisible) { _, visible in
            if !visible {
                breathing = false
                animateIn = false
            }
        }
    }
}

#Preview {
    CleaningOverlayView(isVisible: .constant(true))
}

