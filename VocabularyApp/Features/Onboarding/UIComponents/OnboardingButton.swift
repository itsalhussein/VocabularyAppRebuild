//
//  OnboardingButton.swift
//  VocabularyApp
//
//  Reusable Continue button for onboarding screens
//

import SwiftUI

struct OnboardingButton: View {
    let title: String
    let isEnabled: Bool
    let gradient: [Color]
    let action: () -> Void

    init(
        title: String = "Continue",
        isEnabled: Bool = true,
        theme: AppTheme? = nil,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.isEnabled = isEnabled
        // Use theme's first 2 gradient colors if provided, otherwise use default
        self.gradient = theme != nil ? Array(theme!.gradient.prefix(2)) : AppTheme.defaultButtonGradient
        self.action = action
    }

    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                Text(title)
                    .font(.system(size: 18, weight: .semibold, design: .rounded))

                Image(systemName: "arrow.right")
                    .font(.system(size: 16, weight: .semibold))
            }
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 58)
            .background(
                LinearGradient(
                    colors: gradient,
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            .shadow(color: gradient.first?.opacity(0.4) ?? .clear, radius: 20, y: 10)
        }
        .hapticButton()
        .padding(.horizontal, 32)
        .padding(.bottom, 40)
        .opacity(isEnabled ? 1.0 : 0.5)
        .disabled(!isEnabled)
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()

        VStack(spacing: 20) {
            OnboardingButton(
                isEnabled: true,
                theme: .midnight,
                action: {}
            )

            OnboardingButton(
                title: "Get Started",
                isEnabled: false,
                theme: .sunset,
                action: {}
            )
        }
    }
}
