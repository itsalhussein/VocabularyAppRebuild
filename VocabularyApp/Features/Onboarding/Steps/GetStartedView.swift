//
//  GetStartedView.swift
//  VocabularyApp
//

import SwiftUI

struct GetStartedView: View {
    @EnvironmentObject var appState: AppState
    let onComplete: () -> Void
    
    @State private var iconScale = 0.5
    @State private var iconOpacity = 0.0
    @State private var titleOpacity = 0.0
    @State private var featuresOpacity = 0.0
    @State private var buttonOpacity = 0.0
    @State private var pulseAnimation = false
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            
            // Animated icon
            ZStack {
                // Pulse rings
                ForEach(0..<3) { index in
                    Circle()
                        .stroke(
                            LinearGradient(
                                colors: appState.selectedLevel.gradient,
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            lineWidth: 2
                        )
                        .frame(width: 120 + CGFloat(index * 40), height: 120 + CGFloat(index * 40))
                        .opacity(pulseAnimation ? 0 : 0.3)
                        .scaleEffect(pulseAnimation ? 1.3 : 1.0)
                        .animation(
                            .easeOut(duration: 2)
                                .repeatForever(autoreverses: false)
                                .delay(Double(index) * 0.4),
                            value: pulseAnimation
                        )
                }
                
                // Main icon circle
                ZStack {
                    Circle()
                        .fill(
                            LinearGradient(
                                colors: appState.selectedLevel.gradient,
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 100, height: 100)
                        .shadow(color: appState.selectedLevel.gradient.first?.opacity(0.5) ?? .clear, radius: 30, y: 10)
                    
                    Image(systemName: "text.book.closed.fill")
                        .font(.system(size: 44, weight: .medium))
                        .foregroundColor(.white)
                }
                .scaleEffect(iconScale)
            }
            .opacity(iconOpacity)
            
            Spacer()
                .frame(height: 50)
            
            // Title
            VStack(spacing: 12) {
                Text("You're All Set!")
                    .font(.system(size: 34, weight: .bold, design: .serif))
                    .foregroundColor(.white)
                
                Text("Ready to discover \(appState.selectedLevel.rawValue.lowercased())\nlevel vocabulary")
                    .font(.system(size: 17, weight: .regular, design: .rounded))
                    .foregroundColor(.white.opacity(0.7))
                    .multilineTextAlignment(.center)
            }
            .opacity(titleOpacity)
            
            Spacer()
                .frame(height: 50)
            
            // Features list
            VStack(spacing: 16) {
                FeatureRow(
                    icon: "hand.draw.fill",
                    title: "Swipe to Learn",
                    description: "Browse words with simple swipes"
                )
                
                FeatureRow(
                    icon: "hand.tap.fill",
                    title: "Long Press to Master",
                    description: "Hold on a word to mark it as learned"
                )
                
                FeatureRow(
                    icon: "sparkles",
                    title: "Beautiful Design",
                    description: "Enjoy stunning visual experiences"
                )
            }
            .padding(.horizontal, 32)
            .opacity(featuresOpacity)
            
            Spacer()
            
            // Start button
            Button(action: onComplete) {
                HStack(spacing: 12) {
                    Text("Start Learning")
                        .font(.system(size: 18, weight: .semibold, design: .rounded))
                    
                    Image(systemName: "sparkles")
                        .font(.system(size: 16, weight: .semibold))
                }
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 58)
                .background(
                    LinearGradient(
                        colors: appState.selectedLevel.gradient,
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                .shadow(color: appState.selectedLevel.gradient.first?.opacity(0.4) ?? .clear, radius: 20, y: 10)
            }
            .hapticButton()
            .padding(.horizontal, 32)
            .opacity(buttonOpacity)
            
            Spacer()
                .frame(height: 20)
        }
        .onAppear {
            startAnimations()
        }
    }
    
    private func startAnimations() {
        withAnimation(.spring(response: 0.8, dampingFraction: 0.6).delay(0.1)) {
            iconScale = 1.0
            iconOpacity = 1.0
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            pulseAnimation = true
        }
        
        withAnimation(.easeOut(duration: 0.6).delay(0.4)) {
            titleOpacity = 1.0
        }
        
        withAnimation(.easeOut(duration: 0.6).delay(0.6)) {
            featuresOpacity = 1.0
        }
        
        withAnimation(.easeOut(duration: 0.6).delay(0.8)) {
            buttonOpacity = 1.0
        }
    }
}

// MARK: - Feature Row

struct FeatureRow: View {
    let icon: String
    let title: String
    let description: String
    
    var body: some View {
        HStack(spacing: 16) {
            ZStack {
                Circle()
                    .fill(Color.white.opacity(0.1))
                    .frame(width: 44, height: 44)
                
                Image(systemName: icon)
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(.white.opacity(0.9))
            }
            
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.system(size: 16, weight: .semibold, design: .rounded))
                    .foregroundColor(.white)
                
                Text(description)
                    .font(.system(size: 13, weight: .regular, design: .rounded))
                    .foregroundColor(.white.opacity(0.6))
            }
            
            Spacer()
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    ZStack {
        AnimatedGradientBackground()
            .ignoresSafeArea()
        
        GetStartedView(onComplete: {})
            .environmentObject(AppState())
    }
}
