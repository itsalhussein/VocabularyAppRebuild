//
//  ThemeSelectionView.swift
//  VocabularyApp
//
//  Theme selection components (used in HomeView's ThemePickerSheet)
//

import SwiftUI

// MARK: - Theme Preview Card

struct ThemePreviewCard: View {
    let theme: AppTheme

    var body: some View {
        VStack(spacing: 16) {
            // Sample word card with theme
            VStack(spacing: 12) {
                Text("Serendipity")
                    .font(.system(size: 28, weight: .bold, design: .serif))
                    .foregroundColor(.white)

                Text("The occurrence of events by chance in a happy way")
                    .font(.system(size: 14, weight: .regular, design: .rounded))
                    .foregroundColor(.white.opacity(0.8))
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
            }
            .frame(maxWidth: .infinity)
            .padding(24)
            .background(
                RoundedRectangle(cornerRadius: 24, style: .continuous)
                    .fill(
                        LinearGradient(
                            colors: theme.gradient,
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
            )
            .shadow(color: theme.gradient.first?.opacity(0.3) ?? .clear, radius: 20, y: 10)

            // Theme name
            Text(theme.rawValue)
                .font(.system(size: 16, weight: .semibold, design: .rounded))
                .foregroundColor(.white)
        }
    }
}

// MARK: - Theme Option

struct ThemeOption: View {
    let theme: AppTheme
    let isSelected: Bool
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            VStack(spacing: 12) {
                // Gradient preview
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(
                        LinearGradient(
                            colors: theme.gradient,
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(height: 80)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .strokeBorder(
                                isSelected ? Color.white : Color.clear,
                                lineWidth: 3
                            )
                    )
                    .shadow(color: theme.gradient.first?.opacity(0.3) ?? .clear, radius: 10, y: 5)

                // Theme name
                Text(theme.rawValue)
                    .font(.system(size: 14, weight: isSelected ? .semibold : .medium, design: .rounded))
                    .foregroundColor(.white)
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview("Theme Preview Card") {
    ZStack {
        Color.black.ignoresSafeArea()

        ThemePreviewCard(theme: .midnight)
            .padding()
    }
}

#Preview("Theme Options Grid") {
    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]

    ZStack {
        Color.black.ignoresSafeArea()

        ScrollView {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(AppTheme.allCases) { theme in
                    ThemeOption(
                        theme: theme,
                        isSelected: theme == .midnight,
                        onTap: {}
                    )
                }
            }
            .padding()
        }
    }
}
