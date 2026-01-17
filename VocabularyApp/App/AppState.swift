//
//  AppState.swift
//  VocabularyApp
//
//

import SwiftUI
import Combine

/// App-level state manager
/// Responsibilities:
/// - Navigation between main screens
/// - Persisting user preferences
/// - Providing shared state to features
class AppState: ObservableObject {
    // MARK: - Published Properties

    @Published var currentScreen: AppScreen = .onboarding
    @Published var hasCompletedOnboarding: Bool = false

    // User preferences (shared across features)
    @Published var selectedLevel: VocabularyLevel = .intermediate
    @Published var selectedCategories: Set<WordCategory> = [.beautiful, .emotions]
    @Published var selectedTheme: AppTheme = .midnight

    // MARK: - Private Properties

    private let onboardingKey = "hasCompletedOnboarding"

    // MARK: - Initialization

    init() {
        loadState()
    }

    // MARK: - Public Methods

    func completeOnboarding(
        level: VocabularyLevel,
        categories: Set<WordCategory>,
        theme: AppTheme
    ) {
        // Update state
        selectedLevel = level
        selectedCategories = categories
        selectedTheme = theme
        hasCompletedOnboarding = true

        // Persist to storage
        UserDefaults.standard.set(true, forKey: onboardingKey)

        // Navigate to home with animation
        withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
            currentScreen = .home
        }
    }

    func resetOnboarding() {
        hasCompletedOnboarding = false
        UserDefaults.standard.set(false, forKey: onboardingKey)

        withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
            currentScreen = .onboarding
        }
    }

    // MARK: - Private Methods

    private func loadState() {
        hasCompletedOnboarding = UserDefaults.standard.bool(forKey: onboardingKey)

        // Load saved preferences
        if let levelString = UserDefaults.standard.string(forKey: "selectedLevel"),
           let level = VocabularyLevel(rawValue: levelString) {
            selectedLevel = level
        }

        if let categoryStrings = UserDefaults.standard.array(forKey: "selectedCategories") as? [String] {
            selectedCategories = Set(categoryStrings.compactMap { WordCategory(rawValue: $0) })
        }

        if let themeString = UserDefaults.standard.string(forKey: "selectedTheme"),
           let theme = AppTheme(rawValue: themeString) {
            selectedTheme = theme
        }

        // Set initial screen based on onboarding status
        currentScreen = hasCompletedOnboarding ? .home : .onboarding
    }
}
