//
//  Color+Extensions.swift
//  VocabularyApp
//

import SwiftUI

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

// MARK: - App Theme Colors
extension Color {
    static let appBackground = Color(hex: "0a0a0f")
    static let cardBackground = Color(hex: "1a1a2e")
    static let textPrimary = Color.white
    static let textSecondary = Color.white.opacity(0.7)
    static let accentPurple = Color(hex: "8b5cf6")
    static let accentPink = Color(hex: "ec4899")
    static let accentBlue = Color(hex: "3b82f6")
    static let accentGold = Color(hex: "fbbf24")
}
