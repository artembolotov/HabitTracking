//
//  FilledButton.swift
//  HabitTracking
//
//  Created by artembolotov on 26.01.2023.
//

import SwiftUI

struct FilledButton: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled
    
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity)
            .background(isEnabled ? Color.accentColor.opacity(configuration.isPressed ? 0.8 : 1) : .gray)
            .cornerRadius(8)
            .padding(.horizontal)
    }
}
