//
//  HapticManager.swift
//  VocabularyApp
//
//  Squad Busters-inspired haptic feedback system
//

import SwiftUI
import UIKit

class HapticManager {
    static let shared = HapticManager()
    
    private let lightGenerator = UIImpactFeedbackGenerator(style: .light)
    private let mediumGenerator = UIImpactFeedbackGenerator(style: .medium)
    private let heavyGenerator = UIImpactFeedbackGenerator(style: .heavy)
    private let softGenerator = UIImpactFeedbackGenerator(style: .soft)
    private let rigidGenerator = UIImpactFeedbackGenerator(style: .rigid)
    private let selectionGenerator = UISelectionFeedbackGenerator()
    private let notificationGenerator = UINotificationFeedbackGenerator()
    
    private init() {
        prepareGenerators()
    }
    
    func prepareGenerators() {
        lightGenerator.prepare()
        mediumGenerator.prepare()
        heavyGenerator.prepare()
        softGenerator.prepare()
        rigidGenerator.prepare()
        selectionGenerator.prepare()
        notificationGenerator.prepare()
    }
    
    // MARK: - Basic Haptics
    
    /// Light tap - for subtle interactions
    func lightTap() {
        lightGenerator.impactOccurred()
    }
    
    /// Medium tap - for standard button presses
    func mediumTap() {
        mediumGenerator.impactOccurred()
    }
    
    /// Heavy tap - for important actions
    func heavyTap() {
        heavyGenerator.impactOccurred()
    }
    
    /// Soft tap - for gentle feedback
    func softTap() {
        softGenerator.impactOccurred()
    }
    
    /// Rigid tap - for precise actions
    func rigidTap() {
        rigidGenerator.impactOccurred()
    }
    
    /// Selection changed
    func selection() {
        selectionGenerator.selectionChanged()
    }
    
    // MARK: - Notification Haptics
    
    func success() {
        notificationGenerator.notificationOccurred(.success)
    }
    
    func warning() {
        notificationGenerator.notificationOccurred(.warning)
    }
    
    func error() {
        notificationGenerator.notificationOccurred(.error)
    }
    
    // MARK: - Custom Patterns (Squad Busters-inspired)
    
    /// Satisfying card swipe haptic
    func cardSwipe() {
        softTap()
    }
    
    /// Card snap into place
    func cardSnap() {
        mediumTap()
    }
    
    /// Button press with bounce feel
    func buttonPress() {
        rigidTap()
    }
    
    /// Level selection haptic
    func levelSelect() {
        mediumTap()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.lightTap()
        }
    }
    
    /// Word mastery celebration - multi-stage haptic pattern
    func wordMasteryCelebration() {
        // Stage 1: Initial heavy tap
        heavyTap()
        
        // Stage 2: Quick succession of lighter taps (like confetti)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
            self.mediumTap()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            self.lightTap()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
            self.lightTap()
        }
        
        // Stage 3: Success notification
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.success()
        }
    }
    
    /// Onboarding progression haptic
    func onboardingProgress() {
        softTap()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.08) {
            self.mediumTap()
        }
    }
    
    /// Long press start
    func longPressStart() {
        softTap()
    }
    
    /// Long press building (call repeatedly during progress)
    func longPressProgress(intensity: CGFloat) {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred(intensity: min(intensity, 1.0))
    }
    
    /// Long press complete
    func longPressComplete() {
        heavyTap()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.success()
        }
    }
}

// MARK: - SwiftUI View Modifier for Easy Haptic Integration

struct HapticButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.96 : 1.0)
            .animation(.spring(response: 0.2, dampingFraction: 0.6), value: configuration.isPressed)
            .onChange(of: configuration.isPressed) { _, isPressed in
                if isPressed {
                    HapticManager.shared.buttonPress()
                }
            }
    }
}

extension View {
    func hapticButton() -> some View {
        self.buttonStyle(HapticButtonStyle())
    }
}
