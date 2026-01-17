//
//  OnboardingContainerView.swift
//  VocabularyApp
//
//

import SwiftUI

struct OnboardingContainerView: View {
    @EnvironmentObject var appState: AppState
    @StateObject private var viewModel: OnboardingViewModel

    @State private var currentPage = 0

    private let totalPages = 5  // Two-Phase Onboarding: Welcome + NameAge + Level + Category + GetStarted

    init(appState: AppState) {
        _viewModel = StateObject(wrappedValue: OnboardingViewModel(appState: appState))
    }

    var body: some View {
        ZStack {
            // Animated gradient background
            AnimatedGradientBackground()
                .ignoresSafeArea()

            VStack(spacing: 0) {
                // Page content
                TabView(selection: $currentPage) {
                    // Page 0: Welcome
                    WelcomeOnboardingView(onContinue: nextPage)
                        .tag(0)

                    // Page 1: Name + Age (Combined)
                    NameAgeInputView(
                        viewModel: viewModel,
                        onContinue: nextPage
                    )
                    .tag(1)

                    // Page 2: Level Selection
                    LevelSelectionView(
                        viewModel: viewModel,
                        onContinue: nextPage
                    )
                    .tag(2)

                    // Page 3: Category Selection
                    CategorySelectionView(
                        viewModel: viewModel,
                        onContinue: nextPage
                    )
                    .tag(3)

                    // Page 4: Get Started
                    GetStartedView(onComplete: completeOnboarding)
                        .tag(4)
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .animation(.spring(response: 0.5, dampingFraction: 0.8), value: currentPage)

                // Page indicator
                PageIndicator(currentPage: currentPage, totalPages: totalPages)
                    .padding(.bottom, 40)
            }
        }
    }

    private func nextPage() {
        HapticManager.shared.onboardingProgress()
        withAnimation(.spring(response: 0.5, dampingFraction: 0.8)) {
            currentPage += 1
        }
    }

    private func completeOnboarding() {
        HapticManager.shared.success()
        viewModel.completeOnboarding()
    }
}

// MARK: - Animated Gradient Background

struct AnimatedGradientBackground: View {
    let animated: Bool

    @State private var animateGradient = false

    init(animated: Bool = true) {
        self.animated = animated
    }

    var body: some View {
        LinearGradient(
            colors: [
                Color(hex: "0a0a0f"),  // Almost black
                Color(hex: "1a1a2e"),  // Very dark blue-gray
                Color(hex: "16213e")   // Dark blue-gray
            ],
            startPoint: animateGradient ? .topLeading : .bottomLeading,
            endPoint: animateGradient ? .bottomTrailing : .topTrailing
        )
        .onAppear {
            if animated {
                withAnimation(.easeInOut(duration: 5).repeatForever(autoreverses: true)) {
                    animateGradient.toggle()
                }
            }
        }
    }
}

// MARK: - Page Indicator

struct PageIndicator: View {
    let currentPage: Int
    let totalPages: Int

    var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<totalPages, id: \.self) { index in
                Capsule()
                    .fill(index == currentPage ? Color.white : Color.white.opacity(0.3))
                    .frame(width: index == currentPage ? 24 : 8, height: 8)
                    .animation(.spring(response: 0.3, dampingFraction: 0.7), value: currentPage)
            }
        }
    }
}

#Preview {
    let appState = AppState()
    OnboardingContainerView(appState: appState)
        .environmentObject(appState)
}
