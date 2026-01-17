//
//  WordCardView.swift
//  VocabularyApp
//
//

import SwiftUI

// MARK: - Main Word Card View

struct WordCardView: View {
    let word: Word
    let viewModel: WordDeckViewModel
    @EnvironmentObject var appState: AppState

    @State private var isPressed = false
    @State private var longPressProgress: CGFloat = 0
    @State private var showMasteryAnimation = false
    @State private var pendingLongPressStart: DispatchWorkItem?
    @State private var ringOpacity: Double = 1.0
    @State private var ringScale: CGFloat = 1.0

    private let longPressDuration: Double = 1.0

    var isMastered: Bool {
        viewModel.isWordMastered(word.word)
    }

    var body: some View {
        ZStack {
            // Card background
            CardBackground(theme: appState.selectedTheme)

            // Long press progress ring
            if longPressProgress > 0 && !isMastered {
                LongPressRing(
                    progress: longPressProgress,
                    opacity: ringOpacity,
                    scale: ringScale
                )
            }

            // Card content
            CardContent(
                word: word,
                isMastered: isMastered,
                showMasteryAnimation: showMasteryAnimation
            )

            // Confetti overlay (center of card)
            if showMasteryAnimation {
                ConfettiView()
                    .allowsHitTesting(false)
            }
        }
        .frame(maxWidth: .infinity)
        .scaleEffect(isPressed ? 0.97 : 1.0)
        .animation(.spring(response: 0.3, dampingFraction: 0.7), value: isPressed)
        .onLongPressGesture(
            minimumDuration: longPressDuration,
            maximumDistance: 12,
            pressing: handleLongPress,
            perform: completeLongPress
        )
        .onDisappear {
            cancelLongPress()
        }
    }

    // MARK: - Long Press Handlers

    private func handleLongPress(_ isPressing: Bool) {
        guard !isMastered else {
            if !isPressing { cancelLongPress() }
            return
        }

        if isPressing {
            if !isPressed {
                isPressed = true

                pendingLongPressStart?.cancel()
                let work = DispatchWorkItem {
                    guard isPressed && !isMastered else { return }
                    HapticManager.shared.longPressStart()
                    startLongPress()
                }
                pendingLongPressStart = work
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.12, execute: work)
            }
        } else {
            pendingLongPressStart?.cancel()
            pendingLongPressStart = nil

            if isPressed && longPressProgress < 1.0 {
                cancelLongPress()
            }
        }
    }

    private func startLongPress() {
        guard isPressed && !isMastered else { return }

        ringOpacity = 1.0
        ringScale = 1.0
        longPressProgress = 0

        withAnimation(.linear(duration: longPressDuration)) {
            longPressProgress = 1.0
        }

        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            if longPressProgress >= 1.0 || !isPressed {
                timer.invalidate()
            } else {
                HapticManager.shared.longPressProgress(intensity: longPressProgress)
            }
        }
    }

    private func completeLongPress() {
        guard !isMastered else { return }
        pendingLongPressStart?.cancel()
        pendingLongPressStart = nil

        isPressed = false
        longPressProgress = 1.0

        withAnimation(.easeOut(duration: 0.18)) {
            ringOpacity = 0.0
            ringScale = 0.92
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.18) {
            longPressProgress = 0
            ringOpacity = 1.0
            ringScale = 1.0
        }

        withAnimation(.spring(response: 0.4, dampingFraction: 0.6)) {
            showMasteryAnimation = true
        }

        viewModel.markWordAsMastered(word)

        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            showMasteryAnimation = false
        }
    }

    private func cancelLongPress() {
        pendingLongPressStart?.cancel()
        pendingLongPressStart = nil
        isPressed = false

        withAnimation(.easeOut(duration: 0.12)) {
            ringOpacity = 0.0
            ringScale = 0.92
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.12) {
            withAnimation(.easeOut(duration: 0.15)) {
                longPressProgress = 0
            }
            ringOpacity = 1.0
            ringScale = 1.0
        }
    }
}

// MARK: - Card Background

struct CardBackground: View {
    let theme: AppTheme

    var body: some View {
        RoundedRectangle(cornerRadius: 32, style: .continuous)
            .fill(.ultraThinMaterial)
            .overlay(
                RoundedRectangle(cornerRadius: 32, style: .continuous)
                    .fill(
                        LinearGradient(
                            colors: theme.gradient.map { $0.opacity(0.5) },
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
            )
            .overlay(
                RoundedRectangle(cornerRadius: 32, style: .continuous)
                    .stroke(
                        LinearGradient(
                            colors: [Color.white.opacity(0.3), Color.white.opacity(0.1)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: 1
                    )
            )
    }
}

// MARK: - Long Press Ring

struct LongPressRing: View {
    let progress: CGFloat
    let opacity: Double
    let scale: CGFloat

    var body: some View {
        VStack {
            Spacer()

            ZStack {
                // Track
                Circle()
                    .stroke(Color.white.opacity(0.12), lineWidth: 3)

                // Progress
                Circle()
                    .trim(from: 0, to: progress)
                    .stroke(
                        LinearGradient(
                            colors: [Color(hex: "fbbf24"), Color(hex: "f59e0b")],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        style: StrokeStyle(lineWidth: 3, lineCap: .round)
                    )
                    .rotationEffect(.degrees(-90))
            }
            .frame(width: 56, height: 56)
            .opacity(opacity)
            .scaleEffect(scale)
            .padding(.bottom, 62)
        }
        .allowsHitTesting(false)
    }
}

// MARK: - Card Content

struct CardContent: View {
    let word: Word
    let isMastered: Bool
    let showMasteryAnimation: Bool

    var body: some View {
        VStack(spacing: 0) {
            // Top badges bar
            TopBadgesBar(
                word: word,
                isMastered: isMastered,
                showMasteryAnimation: showMasteryAnimation
            )
            .padding(.horizontal, 20)
            .padding(.top, 20)

            Spacer()

            // Word title
            WordTitle(word: word.word, showAnimation: showMasteryAnimation)

            Spacer()
                .frame(height: 8)

            // Pronunciation & part of speech
            PronunciationBar(
                pronunciation: word.pronunciation,
                partOfSpeech: word.partOfSpeech
            )

            Spacer()
                .frame(height: 24)

            // Divider
            GradientDivider()
                .padding(.horizontal, 40)

            Spacer()
                .frame(height: 24)

            // Definition & example
            DefinitionSection(
                definition: word.definition,
                example: word.example
            )

            Spacer()

            // Hint text
            HintText(isMastered: isMastered)
        }
    }
}

// MARK: - Top Badges Bar

struct TopBadgesBar: View {
    let word: Word
    let isMastered: Bool
    let showMasteryAnimation: Bool

    var body: some View {
        HStack {
            // Category badge
            CategoryBadge(category: word.category)

            Spacer()

            // Mastery badge
            if isMastered {
                MasteryBadge()
                    .transition(.scale.combined(with: .opacity))
            }
        }
    }
}

// MARK: - Category Badge

struct CategoryBadge: View {
    let category: WordCategory

    var body: some View {
        HStack(spacing: 5) {
            Image(systemName: category.icon)
                .font(.system(size: 10, weight: .semibold))

            Text(category.rawValue)
                .font(.system(size: 11, weight: .semibold, design: .rounded))
        }
        .foregroundColor(category.color)
        .padding(.horizontal, 10)
        .padding(.vertical, 6)
        .background(
            Capsule()
                .fill(category.color.opacity(0.25))
        )
    }
}

// MARK: - Mastery Badge

struct MasteryBadge: View {
    var body: some View {
        HStack(spacing: 5) {
            Image(systemName: "checkmark.seal.fill")
                .font(.system(size: 12, weight: .semibold))

            Text("Mastered")
                .font(.system(size: 11, weight: .semibold, design: .rounded))
        }
        .foregroundColor(Color(hex: "fbbf24"))
        .padding(.horizontal, 10)
        .padding(.vertical, 6)
        .background(
            Capsule()
                .fill(Color(hex: "fbbf24").opacity(0.2))
        )
    }
}

// MARK: - Word Title

struct WordTitle: View {
    let word: String
    let showAnimation: Bool

    var body: some View {
        Text(word)
            .font(.system(size: 42, weight: .bold, design: .serif))
            .foregroundColor(.white)
            .scaleEffect(showAnimation ? 1.1 : 1.0)
            .animation(.spring(response: 0.3, dampingFraction: 0.5), value: showAnimation)
    }
}

// MARK: - Pronunciation Bar

struct PronunciationBar: View {
    let pronunciation: String
    let partOfSpeech: String

    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: "speaker.wave.2.fill")
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.white.opacity(0.5))

            Text(pronunciation)
                .font(.system(size: 16, weight: .medium, design: .monospaced))
                .foregroundColor(.white.opacity(0.7))

            Text("•")
                .foregroundColor(.white.opacity(0.4))

            Text(partOfSpeech)
                .font(.system(size: 15, weight: .medium, design: .rounded))
                .foregroundColor(.white.opacity(0.6))
                .italic()
        }
    }
}

// MARK: - Gradient Divider

struct GradientDivider: View {
    var body: some View {
        Rectangle()
            .fill(
                LinearGradient(
                    colors: [Color.clear, Color.white.opacity(0.2), Color.clear],
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .frame(height: 1)
    }
}

// MARK: - Definition Section

struct DefinitionSection: View {
    let definition: String
    let example: String

    var body: some View {
        VStack(spacing: 14) {
            Text(definition)
                .font(.system(size: 17, weight: .regular, design: .rounded))
                .foregroundColor(.white.opacity(0.9))
                .multilineTextAlignment(.center)
                .lineSpacing(4)
                .padding(.horizontal, 20)

            Text("\"\(example)\"")
                .font(.system(size: 14, weight: .regular, design: .serif))
                .foregroundColor(.white.opacity(0.6))
                .italic()
                .multilineTextAlignment(.center)
                .lineSpacing(3)
                .padding(.horizontal, 24)
        }
    }
}

// MARK: - Hint Text

struct HintText: View {
    let isMastered: Bool

    var body: some View {
        if !isMastered {
            Text("Long press to mark as mastered")
                .font(.system(size: 12, weight: .medium, design: .rounded))
                .foregroundColor(.white.opacity(0.4))
                .padding(.bottom, 20)
        } else {
            Spacer()
                .frame(height: 32)
        }
    }
}

// MARK: - Confetti View

struct ConfettiView: View {
    @State private var particles: [ConfettiParticle] = []

    var body: some View {
        ZStack {
            ForEach(particles) { particle in
                Circle()
                    .fill(particle.color)
                    .frame(width: particle.size, height: particle.size)
                    .position(particle.position)
                    .opacity(particle.opacity)
            }
        }
        .onAppear {
            createParticles()
        }
    }

    private func createParticles() {
        let colors: [Color] = [
            Color(hex: "fbbf24"),
            Color(hex: "f59e0b"),
            Color(hex: "ec4899"),
            Color(hex: "8b5cf6"),
            Color(hex: "3b82f6"),
            Color(hex: "10b981")
        ]

        for _ in 0..<30 {
            let particle = ConfettiParticle(
                color: colors.randomElement()!,
                size: CGFloat.random(in: 4...10),
                position: CGPoint(
                    x: CGFloat.random(in: 50...300),
                    y: CGFloat.random(in: 100...200)
                ),
                opacity: 1.0
            )
            particles.append(particle)
        }

        // Animate particles falling
        withAnimation(.easeOut(duration: 1.5)) {
            for index in particles.indices {
                particles[index].position.y += CGFloat.random(in: 150...300)
                particles[index].position.x += CGFloat.random(in: -50...50)
                particles[index].opacity = 0
            }
        }
    }
}

struct ConfettiParticle: Identifiable {
    let id = UUID()
    let color: Color
    let size: CGFloat
    var position: CGPoint
    var opacity: Double
}

// MARK: - Preview

#Preview {
    let appState = AppState()
    ZStack {
        Color.black.ignoresSafeArea()

        WordCardView(
            word: Word.allWords[5],
            viewModel: WordDeckViewModel(appState: appState)
        )
        .padding()
        .environmentObject(appState)
    }
}
