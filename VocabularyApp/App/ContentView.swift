//
//  ContentView.swift
//  VocabularyApp
//
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
        ZStack {
            Color.appBackground
                .ignoresSafeArea()

            switch appState.currentScreen {
            case .onboarding:
                OnboardingContainerView(appState: appState)
                    .transition(.asymmetric(
                        insertion: .opacity,
                        removal: .move(edge: .leading).combined(with: .opacity)
                    ))

            case .home:
                HomeView(appState: appState)
                    .transition(.asymmetric(
                        insertion: .move(edge: .trailing).combined(with: .opacity),
                        removal: .opacity
                    ))
            }
        }
        .animation(.spring(response: 0.6, dampingFraction: 0.85), value: appState.currentScreen)
    }
}

#Preview {
    ContentView()
        .environmentObject(AppState())
}
