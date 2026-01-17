//
//  WelcomeOnboardingView.swift
//  VocabularyApp
//

import SwiftUI

struct WelcomeOnboardingView: View {
    let onContinue: () -> Void
    
    @State private var titleOpacity = 0.0
    @State private var subtitleOpacity = 0.0
    @State private var cardsOpacity = 0.0
    @State private var buttonOpacity = 1.0
    @State private var titleOffset: CGFloat = 30
    @State private var floatingOffset: CGFloat = 0
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            
            // Floating word cards preview
            ZStack {
                // Background decorative card
                WordPreviewCard(
                    word: "Wonder",
                    color: Color(hex: "ec4899")
                )
                .rotationEffect(.degrees(-8))
                .offset(x: -30, y: floatingOffset + 20)
                .scaleEffect(0.85)
                
                // Middle card
                WordPreviewCard(
                    word: "Inspire",
                    color: Color(hex: "8b5cf6")
                )
                .rotationEffect(.degrees(5))
                .offset(x: 25, y: floatingOffset - 10)
                .scaleEffect(0.9)
                
                // Front card
                WordPreviewCard(
                    word: "Flourish",
                    color: Color(hex: "3b82f6")
                )
                .offset(y: floatingOffset)
            }
            .opacity(cardsOpacity)
            .padding(.horizontal, 40)
            .frame(height: 280)
            
            Spacer()
                .frame(height: 60)
            
            // Title
            VStack(spacing: 16) {
                Text("Expand Your")
                    .font(.system(size: 38, weight: .light, design: .serif))
                    .foregroundColor(.white.opacity(0.9))
                
                Text("Vocabulary")
                    .font(.system(size: 52, weight: .bold, design: .serif))
                    .foregroundStyle(
                        LinearGradient(
                            colors: [Color(hex: "f472b6"), Color(hex: "818cf8")],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
            }
            .opacity(titleOpacity)
            .offset(y: titleOffset)
            
            Spacer()
                .frame(height: 20)
            
            // Subtitle
            Text("Learn beautiful new words every day\nand express yourself with confidence")
                .font(.system(size: 17, weight: .regular, design: .rounded))
                .foregroundColor(.white.opacity(0.7))
                .multilineTextAlignment(.center)
                .lineSpacing(4)
                .opacity(subtitleOpacity)
            
            Spacer()
            
            // Continue button
            OnboardingButton(
                title: "Get Started",
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
    
    private func startAnimations() {
        // Floating animation
        withAnimation(.easeInOut(duration: 3).repeatForever(autoreverses: true)) {
            floatingOffset = -15
        }
        
        // Staggered entrance animations
        withAnimation(.easeOut(duration: 0.8).delay(0.2)) {
            cardsOpacity = 1.0
        }
        
        withAnimation(.easeOut(duration: 0.8).delay(0.5)) {
            titleOpacity = 1.0
            titleOffset = 0
        }
        
        withAnimation(.easeOut(duration: 0.6).delay(0.8)) {
            subtitleOpacity = 1.0
        }
        
    }
}

// MARK: - Word Preview Card

struct WordPreviewCard: View {
    let word: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 8) {
            Text(word)
                .font(.system(size: 28, weight: .bold, design: .serif))
                .foregroundColor(.white)
        }
        .frame(width: 180, height: 120)
        .background(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(color.opacity(0.3))
                .background(
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .fill(.ultraThinMaterial)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .stroke(color.opacity(0.5), lineWidth: 1)
                )
        )
        .shadow(color: color.opacity(0.3), radius: 15, y: 8)
    }
}

#Preview {
    ZStack {
        AnimatedGradientBackground()
            .ignoresSafeArea()
        
        WelcomeOnboardingView(onContinue: {})
    }
}
