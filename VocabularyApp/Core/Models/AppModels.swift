//
//  AppModels.swift
//  VocabularyApp
//
//  Core domain models and enums
//

import SwiftUI

// MARK: - App Screen

enum AppScreen {
    case onboarding
    case home
}

// MARK: - Vocabulary Level

enum VocabularyLevel: String, CaseIterable, Identifiable {
    case beginner = "Beginner"
    case intermediate = "Intermediate"
    case advanced = "Advanced"

    var id: String { rawValue }

    var description: String {
        switch self {
        case .beginner:
            return "I'm just starting to expand my vocabulary"
        case .intermediate:
            return "I know common words but want to learn more"
        case .advanced:
            return "I want to master rare and sophisticated words"
        }
    }

    var icon: String {
        switch self {
        case .beginner: return "leaf.fill"
        case .intermediate: return "flame.fill"
        case .advanced: return "star.fill"
        }
    }

    var gradient: [Color] {
        switch self {
        case .beginner:
            return [Color(hex: "56ab2f"), Color(hex: "a8e063")]
        case .intermediate:
            return [Color(hex: "f093fb"), Color(hex: "f5576c")]
        case .advanced:
            return [Color(hex: "4facfe"), Color(hex: "00f2fe")]
        }
    }
}

// MARK: - Word Category

enum WordCategory: String, CaseIterable, Identifiable {
    case emotions = "Emotions"
    case nature = "Nature"
    case business = "Business"
    case beautiful = "Beautiful Words"
    case academic = "Academic"
    case everyday = "Everyday"

    var id: String { rawValue }

    var icon: String {
        switch self {
        case .emotions: return "heart.fill"
        case .nature: return "leaf.fill"
        case .business: return "briefcase.fill"
        case .beautiful: return "sparkles"
        case .academic: return "graduationcap.fill"
        case .everyday: return "sun.max.fill"
        }
    }

    var description: String {
        switch self {
        case .emotions: return "Words to express feelings"
        case .nature: return "Words from the natural world"
        case .business: return "Professional vocabulary"
        case .beautiful: return "Rare and elegant words"
        case .academic: return "Scholarly terminology"
        case .everyday: return "Common useful words"
        }
    }

    var color: Color {
        switch self {
        case .emotions: return Color(hex: "ec4899")
        case .nature: return Color(hex: "22c55e")
        case .business: return Color(hex: "3b82f6")
        case .beautiful: return Color(hex: "a855f7")
        case .academic: return Color(hex: "f59e0b")
        case .everyday: return Color(hex: "06b6d4")
        }
    }
}

// MARK: - App Theme

enum AppTheme: String, CaseIterable, Identifiable {
    case midnight = "Midnight"
    case sunset = "Sunset"
    case ocean = "Ocean"
    case forest = "Forest"
    case violet = "Violet"
    case minimal = "Minimal"

    var id: String { rawValue }

    var gradient: [Color] {
        switch self {
        case .midnight:
            return [Color(hex: "0f0c29"), Color(hex: "302b63"), Color(hex: "24243e")]
        case .sunset:
            return [Color(hex: "ff6b6b"), Color(hex: "feca57"), Color(hex: "ff9ff3")]
        case .ocean:
            return [Color(hex: "667eea"), Color(hex: "764ba2"), Color(hex: "6B8DD6")]
        case .forest:
            return [Color(hex: "134e5e"), Color(hex: "71b280"), Color(hex: "2d5016")]
        case .violet:
            return [Color(hex: "8b5cf6"), Color(hex: "ec4899"), Color(hex: "a855f7")]
        case .minimal:
            return [Color(hex: "1a1a2e"), Color(hex: "16213e"), Color(hex: "0f0f1a")]
        }
    }

    var icon: String {
        switch self {
        case .midnight: return "moon.stars.fill"
        case .sunset: return "sunset.fill"
        case .ocean: return "water.waves"
        case .forest: return "tree.fill"
        case .violet: return "sparkles"
        case .minimal: return "circle.lefthalf.filled"
        }
    }

    var previewColors: [Color] {
        Array(gradient.prefix(2))
    }

    // Default button gradient for onboarding
    static var defaultButtonGradient: [Color] {
        [Color(hex: "8b5cf6"), Color(hex: "ec4899")]
    }
}
