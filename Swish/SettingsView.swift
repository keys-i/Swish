//
//  SettingsView.swift
//  Swish
//
//  Created by Radhesh Goel on 17/7/2025.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("autoEnableOnLaunch") private var autoEnableOnLaunch: Bool = false
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Settings")
                .font(.headline)
            Toggle("Auto-enable on startup", isOn: $autoEnableOnLaunch)
                .toggleStyle(SwitchToggleStyle())
                .font(.body)
            Divider()
            Text("Swish v1.0 – Built with ❤️ by Keys")
                .font(.caption2)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding()
        .frame(width: 250)
    }
}

#Preview {
    SettingsView()
}
