//
//  NameAgeInputView.swift
//  VocabularyApp
//
//  Combined Name + Age input screen for streamlined onboarding
//

import SwiftUI

struct NameAgeInputView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    let onContinue: () -> Void

    @FocusState private var isTextFieldFocused: Bool

    let ageRanges = ["13-17", "18-24", "25-34", "35-44", "45+"]

    var body: some View {
        VStack(spacing: 0) {
            Spacer()
                .frame(height: 60)

            // Skip button
            HStack {
                Spacer()

                Button(action: onContinue) {
                    Text("Skip")
                        .font(.system(size: 16, weight: .medium, design: .rounded))
                        .foregroundColor(.white.opacity(0.6))
                }
                .padding(.trailing, 24)
            }

            Spacer()
                .frame(height: 40)

            // Title
            Text("Tell us about yourself")
                .font(.system(size: 32, weight: .bold, design: .serif))
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)

            Spacer()
                .frame(height: 50)

            // Name input
            VStack(alignment: .leading, spacing: 8) {
                Text("Your Name (Optional)")
                    .font(.system(size: 14, weight: .medium, design: .rounded))
                    .foregroundColor(.white.opacity(0.7))
                    .padding(.leading, 4)

                TextField("", text: $viewModel.userName)
                    .placeholder(when: viewModel.userName.isEmpty) {
                        Text("Enter your name")
                            .foregroundColor(.white.opacity(0.3))
                    }
                    .font(.system(size: 17, weight: .medium, design: .rounded))
                    .foregroundColor(.white)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 14, style: .continuous)
                            .fill(Color.white.opacity(0.1))
                            .overlay(
                                RoundedRectangle(cornerRadius: 14, style: .continuous)
                                    .strokeBorder(
                                        isTextFieldFocused ? Color(hex: "fbbf24").opacity(0.4) : Color.white.opacity(0.2),
                                        lineWidth: 1
                                    )
                            )
                    )
                    .focused($isTextFieldFocused)
                    .submitLabel(.done)
                    .onSubmit {
                        isTextFieldFocused = false
                    }
                    .onChange(of: viewModel.userName) { newValue in
                        viewModel.setUserName(newValue)
                    }
            }
            .padding(.horizontal, 24)

            Spacer()
                .frame(height: 30)

            // Age range selection
            VStack(alignment: .leading, spacing: 8) {
                Text("Your Age Range (Optional)")
                    .font(.system(size: 14, weight: .medium, design: .rounded))
                    .foregroundColor(.white.opacity(0.7))
                    .padding(.leading, 4)

                VStack(spacing: 12) {
                    ForEach(ageRanges, id: \.self) { age in
                        AgeOptionButton(
                            age: age,
                            isSelected: viewModel.selectedAge == age,
                            onSelect: { selectAge(age) }
                        )
                    }
                }
            }
            .padding(.horizontal, 24)

            Spacer()

            // Continue button
            OnboardingButton(
                isEnabled: true,  // Always enabled since both are optional
                theme: viewModel.selectedTheme,
                action: {
                    isTextFieldFocused = false
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        HapticManager.shared.success()
                        onContinue()
                    }
                }
            )
        }
    }

    private func selectAge(_ age: String) {
        HapticManager.shared.selection()
        viewModel.selectAge(age)
    }
}

// MARK: - Text Field Placeholder Extension

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content
    ) -> some View {
        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}

// MARK: - Age Option Button

struct AgeOptionButton: View {
    let age: String
    let isSelected: Bool
    let onSelect: () -> Void

    var body: some View {
        Button(action: onSelect) {
            HStack {
                // Radio button
                ZStack {
                    Circle()
                        .strokeBorder(isSelected ? Color(hex: "fbbf24") : Color.white.opacity(0.3), lineWidth: 2)
                        .frame(width: 24, height: 24)

                    if isSelected {
                        Circle()
                            .fill(Color(hex: "fbbf24"))
                            .frame(width: 12, height: 12)
                    }
                }

                Text(age)
                    .font(.system(size: 17, weight: .medium, design: .rounded))
                    .foregroundColor(.white)

                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 16)
            .background(
                RoundedRectangle(cornerRadius: 14, style: .continuous)
                    .fill(isSelected ? Color.white.opacity(0.15) : Color.white.opacity(0.08))
                    .overlay(
                        RoundedRectangle(cornerRadius: 14, style: .continuous)
                            .strokeBorder(
                                isSelected ? Color(hex: "fbbf24").opacity(0.4) : Color.white.opacity(0.1),
                                lineWidth: 1
                            )
                    )
            )
        }
    }
}

#Preview {
    let appState = AppState()
    ZStack {
        AnimatedGradientBackground()
            .ignoresSafeArea()

        NameAgeInputView(
            viewModel: OnboardingViewModel(appState: appState),
            onContinue: {}
        )
    }
}
