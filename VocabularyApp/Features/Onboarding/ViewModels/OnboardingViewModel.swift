//
//  OnboardingViewModel.swift
//  VocabularyApp
//
//  ViewModel for Onboarding feature
//

import SwiftUI
import Combine

class OnboardingViewModel: ObservableObject {
    // MARK: - Published Properties

    // Row 1: Personal Info
    @Published var selectedAge: String = ""
    @Published var userName: String = ""
    @Published var selectedGender: String = ""

    // Existing properties
    @Published var selectedLevel: VocabularyLevel = .intermediate
    @Published var selectedCategories: Set<WordCategory> = [.emotions]
    @Published var selectedTheme: AppTheme = .midnight

    // MARK: - Dependencies

    private let appState: AppState

    // MARK: - Initialization

    init(appState: AppState) {
        self.appState = appState
        loadSavedPreferences()
    }

    // MARK: - Public Methods

    func selectAge(_ age: String) {
        selectedAge = age
        savePreference(age, forKey: "selectedAge")
    }

    func setUserName(_ name: String) {
        userName = name
        savePreference(name, forKey: "userName")
    }

    func selectGender(_ gender: String) {
        selectedGender = gender
        savePreference(gender, forKey: "selectedGender")
    }

    func selectLevel(_ level: VocabularyLevel) {
        selectedLevel = level
        savePreference(level.rawValue, forKey: "selectedLevel")
    }

    func toggleCategory(_ category: WordCategory) {
        if selectedCategories.contains(category) {
            // Keep at least one category selected
            if selectedCategories.count > 1 {
                selectedCategories.remove(category)
            }
        } else {
            selectedCategories.insert(category)
        }
        saveCategories()
    }

    func selectTheme(_ theme: AppTheme) {
        selectedTheme = theme
        savePreference(theme.rawValue, forKey: "selectedTheme")
    }

    func completeOnboarding() {
        // Save all preferences
        appState.completeOnboarding(
            level: selectedLevel,
            categories: selectedCategories,
            theme: selectedTheme
        )
    }

    // MARK: - Private Methods

    private func loadSavedPreferences() {
        // Load personal info
        if let age = UserDefaults.standard.string(forKey: "selectedAge") {
            selectedAge = age
        }

        if let name = UserDefaults.standard.string(forKey: "userName") {
            userName = name
        }

        if let gender = UserDefaults.standard.string(forKey: "selectedGender") {
            selectedGender = gender
        }

        // Load existing preferences
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
    }

    private func savePreference(_ value: String, forKey key: String) {
        UserDefaults.standard.set(value, forKey: key)
    }

    private func saveCategories() {
        let categoryStrings = selectedCategories.map { $0.rawValue }
        UserDefaults.standard.set(categoryStrings, forKey: "selectedCategories")
    }
}
