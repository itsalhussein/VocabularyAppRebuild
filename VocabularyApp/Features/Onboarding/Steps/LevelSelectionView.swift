//
//  LevelSelectionView.swift
//  VocabularyApp
//

import SwiftUI

struct LevelSelectionView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    let onContinue: () -> Void

    @State private var headerOpacity = 0.0
    @State private var cardsOpacity = 0.0
    @State private var buttonOpacity = 0.0
    @State private var selectedScale: CGFloat = 1.0

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
                .frame(height: 20)

            // Header
            VStack(spacing: 12) {
                Text("Choose Your Level")
                    .font(.system(size: 34, weight: .bold, design: .serif))
                    .foregroundColor(.white)

                Text("We'll personalize words to match your skill")
                    .font(.system(size: 16, weight: .regular, design: .rounded))
                    .foregroundColor(.white.opacity(0.7))
            }
            .opacity(headerOpacity)

            Spacer()
                .frame(height: 50)

            // Level cards
            VStack(spacing: 16) {
                ForEach(VocabularyLevel.allCases) { level in
                    LevelCard(
                        level: level,
                        isSelected: viewModel.selectedLevel == level,
                        onSelect: {
                            selectLevel(level)
                        }
                    )
                }
            }
            .padding(.horizontal, 24)
            .opacity(cardsOpacity)

            Spacer()

            // Continue button
            OnboardingButton(
                theme: viewModel.selectedTheme,
                action: onContinue
            )
            .opacity(buttonOpacity)
            .padding(.bottom, 0)  // Remove default bottom padding
            
            Spacer()
                .frame(height: 20)
        }
        .onAppear {
            startAnimations()
        }
    }
    
    private func selectLevel(_ level: VocabularyLevel) {
        HapticManager.shared.levelSelect()
        withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
            viewModel.selectLevel(level)
        }
    }
    
    private func startAnimations() {
        withAnimation(.easeOut(duration: 0.6).delay(0.1)) {
            headerOpacity = 1.0
        }
        
        withAnimation(.easeOut(duration: 0.6).delay(0.3)) {
            cardsOpacity = 1.0
        }
        
        withAnimation(.easeOut(duration: 0.6).delay(0.5)) {
            buttonOpacity = 1.0
        }
    }
}

// MARK: - Level Card

struct LevelCard: View {
    let level: VocabularyLevel
    let isSelected: Bool
    let onSelect: () -> Void
    
    @State private var isPressed = false
    
    var body: some View {
        Button(action: onSelect) {
            HStack(spacing: 16) {
                // Icon
                ZStack {
                    Circle()
                        .fill(
                            LinearGradient(
                                colors: level.gradient,
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 50, height: 50)
                    
                    Image(systemName: level.icon)
                        .font(.system(size: 22, weight: .semibold))
                        .foregroundColor(.white)
                }
                
                // Text content
                VStack(alignment: .leading, spacing: 4) {
                    Text(level.rawValue)
                        .font(.system(size: 18, weight: .semibold, design: .rounded))
                        .foregroundColor(.white)
                    
                    Text(level.description)
                        .font(.system(size: 13, weight: .regular, design: .rounded))
                        .foregroundColor(.white.opacity(0.6))
                        .lineLimit(2)
                }
                
                Spacer()
                
                // Selection indicator
                ZStack {
                    Circle()
                        .stroke(isSelected ? Color.clear : Color.white.opacity(0.3), lineWidth: 2)
                        .frame(width: 24, height: 24)
                    
                    if isSelected {
                        Circle()
                            .fill(
                                LinearGradient(
                                    colors: level.gradient,
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .frame(width: 24, height: 24)
                        
                        Image(systemName: "checkmark")
                            .font(.system(size: 12, weight: .bold))
                            .foregroundColor(.white)
                    }
                }
            }
            .padding(20)
            .background(
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .fill(Color.white.opacity(isSelected ? 0.15 : 0.08))
                    .overlay(
                        RoundedRectangle(cornerRadius: 20, style: .continuous)
                            .stroke(
                                isSelected ?
                                    LinearGradient(
                                        colors: level.gradient,
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    ) :
                                    LinearGradient(
                                        colors: [Color.white.opacity(0.1)],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    ),
                                lineWidth: isSelected ? 2 : 1
                            )
                    )
            )
            .scaleEffect(isPressed ? 0.97 : 1.0)
            .animation(.spring(response: 0.3, dampingFraction: 0.7), value: isPressed)
            .animation(.spring(response: 0.4, dampingFraction: 0.7), value: isSelected)
        }
        .buttonStyle(PlainButtonStyle())
        .simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .onChanged { _ in isPressed = true }
                .onEnded { _ in isPressed = false }
        )
    }
}

#Preview {
    let appState = AppState()
    ZStack {
        AnimatedGradientBackground()
            .ignoresSafeArea()

        LevelSelectionView(
            viewModel: OnboardingViewModel(appState: appState),
            onContinue: {}
        )
    }
}
