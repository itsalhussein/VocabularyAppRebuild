# Vocabulary App - SwiftUI Clone

A beautiful vocabulary learning app inspired by [Vocabulary by Monkey Taps](https://apps.apple.com/us/app/vocabulary-learn-words-daily/id1084540807), rebuilt from scratch using SwiftUI.

![iOS](https://img.shields.io/badge/iOS-17.0+-blue.svg)
![Swift](https://img.shields.io/badge/Swift-5.9-orange.svg)
![SwiftUI](https://img.shields.io/badge/SwiftUI-5.0-purple.svg)

## 📱 Features

### Core Features
- **Streamlined Two-Phase Onboarding (5 screens)**
  1. Welcome screen with gradient button
  2. Name + Age input (combined, optional, with skip)
  3. Level selection (Beginner / Intermediate / Advanced, with skip)
  4. Category selection (Emotions, Nature, Business, Beautiful Words, Academic, Everyday, with skip)
  5. Get Started confirmation

- **Word Learning Home Screen**
  - Beautiful swipeable word cards (max 5 words per session)
  - 150 vocabulary words across 6 categories and 3 levels
  - Dynamic themed gradient backgrounds
  - Word category badges
  - Mastered words tracking with golden badge
  - Word, pronunciation (with speaker icon), part of speech, definition, and example sentence
  - Progress badge showing mastered count

### UX Enhancements
- **Squad Busters-Inspired Haptics**
  - Light taps on card swipes
  - Medium impacts on card snaps
  - Multi-stage celebration haptics for word mastery
  - Progressive feedback during long press
  
- **Smooth Animations**
  - Spring-based transitions throughout
  - Staggered entrance animations
  - Animated gradient backgrounds
  - Floating card previews in onboarding

- **Personalization**
  - 6 beautiful themes (Midnight, Sunset, Ocean, Forest, Violet, Minimal)
  - 6 word categories to choose from
  - Words filtered by selected categories and level (max 5 per session)
  - Mastered words collection with review screen
  - Animated gradient background (onboarding) / Static gradient (home)
  - Theme switcher accessible from home screen

### 🌟 Personal Touch Feature: Word Mastery Celebration

**Long-press any word card to mark it as "mastered"!**

This unique feature adds gamification without complexity:
- **Visual feedback**: Progress ring fills around the card
- **Haptic journey**: Progressive vibrations building to a celebration
- **Confetti explosion**: Colorful particles celebrate your achievement
- **Persistent tracking**: Mastered words are saved and displayed with a golden badge
- **Progress indicator**: See how many words you've mastered at a glance

This transforms passive browsing into active learning engagement, giving users a satisfying sense of accomplishment.

## 🏗 Architecture

Clean MVVM architecture with feature-based organization:

```
VocabularyApp/
├── App/
│   ├── VocabularyApp.swift              # App entry point
│   ├── ContentView.swift                # Main navigation controller
│   └── AppState.swift                   # App-wide state management
├── Core/
│   ├── Models/
│   │   ├── AppModels.swift              # Level, Category, Theme enums
│   │   └── Word.swift                   # 150 vocabulary words
│   ├── Haptics/
│   │   └── HapticManager.swift          # Squad Busters-style haptic feedback
│   └── Utilities/
│       └── Color+Extensions.swift       # Hex color support
├── Features/
│   ├── Onboarding/
│   │   ├── Steps/
│   │   │   ├── WelcomeOnboardingView.swift
│   │   │   ├── NameAgeInputView.swift         # Combined input (NEW)
│   │   │   ├── LevelSelectionView.swift
│   │   │   ├── CategorySelectionView.swift
│   │   │   └── GetStartedView.swift
│   │   ├── UIComponents/
│   │   │   ├── OnboardingContainerView.swift  # Main container
│   │   │   └── OnboardingButton.swift         # Reusable button
│   │   └── ViewModels/
│   │       └── OnboardingViewModel.swift
│   └── WordDeck/
│       ├── Views/
│       │   ├── HomeView.swift                 # Main screen
│       │   └── WordCardPager.swift            # Card pager (max 5 words)
│       ├── UIComponents/
│       │   ├── WordCardView.swift             # Refactored card (11 components)
│       │   └── ThemeSelectionView.swift       # Theme picker components
│       └── ViewModels/
│           └── WordDeckViewModel.swift
└── Resources/
    └── Assets.xcassets/                       # App icons & assets
```

## 🎨 Design Decisions

1. **Dark Theme First**: Optimized for OLED screens and reduced eye strain during learning sessions
2. **Gradient-Heavy Aesthetic**: Each word and theme has unique gradient colors for visual variety
3. **Glassmorphism Cards**: Ultra-thin material backgrounds with subtle borders
4. **Typography Hierarchy**: Serif fonts for words (elegance), rounded fonts for UI (friendliness)
5. **Category System**: Words organized by category with visual badges for easy identification
6. **Theme Customization**: 6 beautiful themes to match user preferences

## 🔧 Technical Highlights

- **Pure SwiftUI**: No UIKit dependencies in views
- **iOS 17+**: Leverages latest SwiftUI features including `onChange` with two parameters
- **Combine**: Reactive state management via `@StateObject` and `@EnvironmentObject`
- **UserDefaults**: Persistent storage for onboarding state, mastered words, saved words, theme, and categories
- **Haptic Engine**: Full `UIFeedbackGenerator` suite for rich tactile feedback

## 📦 Building the Project

1. Clone the repository
2. Open `VocabularyApp.xcodeproj` in Xcode 15+
3. Select your target device or simulator (iOS 17+)
4. Build and run (⌘+R)

### For Diawi Distribution
1. Archive the project (Product → Archive)
2. Export with Ad Hoc distribution
3. Include the provided UDIDs in provisioning profile

---

# Task 2: UX Analysis

## Feature Spoiling User Experience

**The Complex, Overwhelming Onboarding Flow**

The original Vocabulary app had an exhausting 17-screen onboarding process that spoiled the user experience:
- Too many screens created decision fatigue and high abandonment rates
- Users had to commit too much time upfront before seeing any value
- No skip options - forcing users through every single step
- Included unnecessary preferences like gender selection and granular topic choices
- Users never reached the actual vocabulary learning because they dropped off during onboarding

**Impact:** High abandonment rate, poor first impression, users felt overwhelmed before even starting

**Our Solution (Implemented):**
- ✅ Reduced from 17 screens to 5 screens (70% reduction)
- ✅ Made fields optional with skip buttons on all customization screens
- ✅ Combined related inputs (Name + Age on one screen)
- ✅ Removed unnecessary steps (gender, theme moved to in-app settings)
- ✅ Two-phase approach: core onboarding now, customization available later in-app

## Missing Feature That Would Add Value

**No Visual Feedback or Celebration for Progress**

The original app likely had minimal feedback when users mastered words:
- Just a simple checkmark or state change
- No haptic feedback or satisfying interactions
- No confetti, animations, or celebrations
- Learning felt mechanical and unrewarding
- No gamification or dopamine hit for achievements

**Impact:** Low user engagement, no motivation to continue learning, feels like homework rather than an enjoyable experience

**Our Solution (Implemented):**
- ✅ Long-press mastery with animated progress ring
- ✅ Multi-stage haptic feedback journey (progressive vibrations building to celebration)
- ✅ Confetti explosion with colorful particles
- ✅ Golden "Mastered" badge that persists on cards
- ✅ Progress counter showing mastered words count
- ✅ Smooth animations and transitions throughout

This transforms passive word browsing into an engaging, rewarding learning experience that users want to return to.

---

## 📄 License

This project is a coding challenge submission and is not affiliated with Monkey Taps LLC.

## 👤 Author

Built with ❤️ using SwiftUI
