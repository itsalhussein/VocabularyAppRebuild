//
//  HomeView.swift
//  VocabularyApp
//
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var appState: AppState
    @StateObject private var viewModel: WordDeckViewModel

    @State private var headerOpacity = 0.0
    @State private var cardsOpacity = 0.0
    @State private var showMasteredSheet = false
    @State private var showThemePicker = false

    init(appState: AppState) {
        _viewModel = StateObject(wrappedValue: WordDeckViewModel(appState: appState))
    }

    var body: some View {
        ZStack {
            // Static dark gradient background
            AnimatedGradientBackground(animated: false)
                .ignoresSafeArea()

            VStack(spacing: 0) {
                // Header with action buttons
                HomeHeader(
                    level: appState.selectedLevel,
                    categoryCount: appState.selectedCategories.count,
                    masteredCount: viewModel.masteredCount,
                    totalCount: viewModel.words.count,
                    onMasteredTap: { showMasteredSheet = true },
                    onThemeTap: { showThemePicker = true }
                )
                .opacity(headerOpacity)
                .padding(.top, 8)

                Spacer()

                // Word cards
                if !viewModel.words.isEmpty {
                    WordCardPager(
                        words: viewModel.words,
                        currentIndex: $viewModel.currentIndex,
                        viewModel: viewModel
                    )
                    .opacity(cardsOpacity)
                } else {
                    // Empty state
                    EmptyWordsView()
                        .opacity(cardsOpacity)
                }

                Spacer()

                // Bottom indicator
                if !viewModel.words.isEmpty {
                    WordProgressIndicator(
                        currentIndex: viewModel.currentIndex,
                        totalCount: viewModel.words.count,
                        masteredCount: viewModel.masteredCount
                    )
                    .padding(.bottom, 40)
                    .opacity(cardsOpacity)
                }
            }
        }
        .onAppear {
            startAnimations()
        }
        .sheet(isPresented: $showMasteredSheet) {
            MasteredWordsSheet(viewModel: viewModel)
        }
        .sheet(isPresented: $showThemePicker) {
            ThemePickerSheet(appState: appState)
        }
    }

    private func startAnimations() {
        withAnimation(.easeOut(duration: 0.6).delay(0.2)) {
            headerOpacity = 1.0
        }

        withAnimation(.easeOut(duration: 0.8).delay(0.4)) {
            cardsOpacity = 1.0
        }
    }
}


// MARK: - Home Header

struct HomeHeader: View {
    let level: VocabularyLevel
    let categoryCount: Int
    let masteredCount: Int
    let totalCount: Int
    let onMasteredTap: () -> Void
    let onThemeTap: () -> Void

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text("Today's Words")
                    .font(.system(size: 28, weight: .bold, design: .serif))
                    .foregroundColor(.white)

                HStack(spacing: 12) {
                    // Level badge
                    HStack(spacing: 5) {
                        Image(systemName: level.icon)
                            .font(.system(size: 11, weight: .semibold))

                        Text(level.rawValue)
                            .font(.system(size: 13, weight: .medium, design: .rounded))
                    }
                    .foregroundColor(.white.opacity(0.7))

                    // Category count
                    HStack(spacing: 4) {
                        Image(systemName: "folder.fill")
                            .font(.system(size: 10, weight: .semibold))

                        Text("\(categoryCount) categories")
                            .font(.system(size: 12, weight: .medium, design: .rounded))
                    }
                    .foregroundColor(.white.opacity(0.5))
                }
            }

            Spacer()

            // Action buttons
            HStack(spacing: 12) {
                // Progress badge button
                Button(action: onMasteredTap) {
                    HStack(spacing: 6) {
                        Image(systemName: "star.fill")
                            .font(.system(size: 12, weight: .bold))

                        Text("\(masteredCount)/\(totalCount)")
                            .font(.system(size: 14, weight: .semibold, design: .rounded))
                    }
                    .foregroundColor(Color(hex: "fbbf24"))
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background(
                        Capsule()
                            .fill(Color(hex: "fbbf24").opacity(0.2))
                            .overlay(
                                Capsule()
                                    .stroke(Color(hex: "fbbf24").opacity(0.3), lineWidth: 1)
                            )
                    )
                }
                .hapticButton()

                // Theme switcher button
                Button(action: onThemeTap) {
                    Image(systemName: "paintpalette.fill")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundColor(.white.opacity(0.7))
                        .frame(width: 44, height: 44)
                        .background(
                            Circle()
                                .fill(Color.white.opacity(0.1))
                        )
                }
                .hapticButton()
            }
        }
        .padding(.horizontal, 24)
    }
}

// MARK: - Word Progress Indicator

struct WordProgressIndicator: View {
    let currentIndex: Int
    let totalCount: Int
    let masteredCount: Int

    var body: some View {
        VStack(spacing: 12) {
            // Dots indicator
            HStack(spacing: 8) {
                ForEach(0..<totalCount, id: \.self) { index in
                    Circle()
                        .fill(index == currentIndex % totalCount ? Color.white : Color.white.opacity(0.3))
                        .frame(width: index == currentIndex % totalCount ? 10 : 6, height: index == currentIndex % totalCount ? 10 : 6)
                        .animation(.spring(response: 0.3, dampingFraction: 0.7), value: currentIndex)
                }
            }

            // Mastery counter
            if masteredCount > 0 {
                HStack(spacing: 4) {
                    Image(systemName: "checkmark.seal.fill")
                        .font(.system(size: 12, weight: .medium))

                    Text("\(masteredCount) mastered")
                        .font(.system(size: 13, weight: .medium, design: .rounded))
                }
                .foregroundColor(.white.opacity(0.6))
            }
        }
    }
}

// MARK: - Empty Words View

struct EmptyWordsView: View {
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "text.book.closed")
                .font(.system(size: 48, weight: .light))
                .foregroundColor(.white.opacity(0.5))

            Text("No words found")
                .font(.system(size: 18, weight: .medium, design: .rounded))
                .foregroundColor(.white.opacity(0.7))

            Text("Try selecting different categories")
                .font(.system(size: 14, weight: .regular, design: .rounded))
                .foregroundColor(.white.opacity(0.5))
        }
        .frame(maxWidth: .infinity, maxHeight: 400)
    }
}

// MARK: - Mastered Words Sheet

struct MasteredWordsSheet: View {
    @ObservedObject var viewModel: WordDeckViewModel
    @Environment(\.dismiss) var dismiss

    var masteredWords: [Word] {
        viewModel.words.filter { viewModel.isWordMastered($0.word) }
    }

    var body: some View {
        NavigationView {
            ZStack {
                AnimatedGradientBackground(animated: false)
                    .ignoresSafeArea()

                if masteredWords.isEmpty {
                    // Empty state
                    VStack(spacing: 20) {
                        Image(systemName: "star.slash")
                            .font(.system(size: 60, weight: .light))
                            .foregroundColor(.white.opacity(0.4))

                        Text("No mastered words yet")
                            .font(.system(size: 22, weight: .semibold, design: .serif))
                            .foregroundColor(.white)

                        Text("Long-press a word card to mark it as mastered")
                            .font(.system(size: 15, weight: .regular, design: .rounded))
                            .foregroundColor(.white.opacity(0.6))
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 40)
                    }
                } else {
                    // Mastered words list
                    ScrollView {
                        VStack(spacing: 16) {
                            ForEach(masteredWords) { word in
                                MasteredWordCard(word: word)
                            }
                        }
                        .padding(20)
                    }
                }
            }
            .navigationTitle("Mastered Words")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                    .foregroundColor(Color(hex: "fbbf24"))
                }
            }
        }
    }
}

// MARK: - Mastered Word Card

struct MasteredWordCard: View {
    let word: Word

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text(word.word)
                    .font(.system(size: 24, weight: .bold, design: .serif))
                    .foregroundColor(.white)

                Spacer()

                Image(systemName: "checkmark.seal.fill")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(Color(hex: "fbbf24"))
            }

            Text(word.pronunciation)
                .font(.system(size: 14, weight: .medium, design: .monospaced))
                .foregroundColor(.white.opacity(0.6))

            Text(word.definition)
                .font(.system(size: 15, weight: .regular, design: .rounded))
                .foregroundColor(.white.opacity(0.8))
                .lineSpacing(3)
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(.ultraThinMaterial)
                .overlay(
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .stroke(Color(hex: "fbbf24").opacity(0.3), lineWidth: 1)
                )
        )
    }
}

// MARK: - Theme Picker Sheet

struct ThemePickerSheet: View {
    @EnvironmentObject var appState: AppState
    @Environment(\.dismiss) var dismiss

    @State private var selectedTheme: AppTheme

    init(appState: AppState) {
        _selectedTheme = State(initialValue: appState.selectedTheme)
    }

    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]

    var body: some View {
        NavigationView {
            ZStack {
                AnimatedGradientBackground(animated: false)
                    .ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 24) {
                        // Preview card
                        ThemePreviewCard(theme: selectedTheme)
                            .padding(.horizontal, 20)
                            .padding(.top, 20)

                        // Theme grid
                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(AppTheme.allCases) { theme in
                                ThemeOption(
                                    theme: theme,
                                    isSelected: selectedTheme == theme,
                                    onTap: {
                                        HapticManager.shared.selection()
                                        withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                                            selectedTheme = theme
                                        }
                                    }
                                )
                            }
                        }
                        .padding(.horizontal, 24)
                        .padding(.bottom, 40)
                    }
                }
            }
            .navigationTitle("Choose Theme")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .foregroundColor(.white.opacity(0.7))
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Apply") {
                        appState.selectedTheme = selectedTheme
                        UserDefaults.standard.set(selectedTheme.rawValue, forKey: "selectedTheme")
                        HapticManager.shared.success()
                        dismiss()
                    }
                    .foregroundColor(Color(hex: "fbbf24"))
                    .fontWeight(.semibold)
                }
            }
        }
    }
}

#Preview {
    let appState = AppState()
    HomeView(appState: appState)
        .environmentObject(appState)
}
