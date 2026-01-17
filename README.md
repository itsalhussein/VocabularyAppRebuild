# Vocabulary App - SwiftUI Clone

A beautiful vocabulary learning app inspired by [Vocabulary by Monkey Taps](https://apps.apple.com/us/app/vocabulary-learn-words-daily/id1084540807), rebuilt from scratch using SwiftUI.

![iOS](https://img.shields.io/badge/iOS-17.0+-blue.svg)
![Swift](https://img.shields.io/badge/Swift-5.9-orange.svg)
![SwiftUI](https://img.shields.io/badge/SwiftUI-5.0-purple.svg)

## 📱 Features

### Core Features
- **Complete Onboarding Flow (5 screens)**
  1. Welcome screen with animated preview cards
  2. Level selection (Beginner / Intermediate / Advanced)
  3. Category selection (Emotions, Nature, Business, Beautiful Words, Academic, Everyday)
  4. Theme selection (Midnight, Sunset, Ocean, Forest, Aurora, Minimal)
  5. Feature introduction with instructional hints
  
- **Word Learning Home Screen**
  - Beautiful swipeable word cards
  - 40+ vocabulary words across 6 categories and 3 levels
  - Dynamic gradient backgrounds per word
  - Word category badges
  - Bookmark/save functionality
  - Word, pronunciation (with speaker icon), part of speech, definition, and example sentence

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
  - 6 different theme options
  - 6 word categories to choose from
  - Words filtered by selected categories and level
  - Saved words collection

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

```
VocabularyApp/
├── VocabularyAppApp.swift      # App entry point
├── ContentView.swift            # Main navigation controller
├── Models/
│   └── Word.swift              # Word data model with 40+ vocabulary words
├── ViewModels/
│   └── AppState.swift          # App-wide state (level, categories, theme, saved words)
├── Views/
│   ├── Onboarding/
│   │   ├── OnboardingContainerView.swift
│   │   ├── WelcomeOnboardingView.swift    # Animated welcome
│   │   ├── LevelSelectionView.swift       # Level picker
│   │   ├── CategorySelectionView.swift    # Category selection (NEW)
│   │   ├── ThemeSelectionView.swift       # Theme customization (NEW)
│   │   └── GetStartedView.swift           # Final intro
│   └── Home/
│       ├── HomeView.swift                 # Main screen with theme support
│       └── WordCardPager.swift            # Swipeable cards with save button
└── Utils/
    ├── Color+Extensions.swift   # Hex color support & theme colors
    └── HapticManager.swift      # Squad Busters-style haptic system
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

**Aggressive Premium Upselling & Intrusive Ads**

The current Vocabulary app suffers from constant interruptions that break the learning flow:
- Video ads play frequently and loudly between word swipes
- Premium subscription prompts appear every few interactions
- Users report being "annoyed into making a purchase"
- The free experience is nearly unusable due to ad frequency

**Recommendation**: Implement a less intrusive freemium model:
- Show ads only after completing a learning session (5-10 words)
- Use non-intrusive banner ads instead of full-screen videos
- Limit premium prompts to once per session
- Provide meaningful value in the free tier to build trust

## Missing Feature That Would Add Value

**Spaced Repetition System (SRS)**

The app currently shows random words without any intelligent scheduling. This is a significant missed opportunity because:

1. **Scientific Backing**: Spaced repetition is proven to improve long-term memory retention by 200%+
2. **Passive vs Active**: Users currently browse passively; SRS would encourage active recall
3. **Personalization**: Words you struggle with would appear more frequently
4. **Progress Tracking**: Users would see concrete improvement metrics

**Implementation Concept**:
```
New Word → Review in 1 day → Review in 3 days → Review in 7 days → Mastered
         ↓ (if wrong)
    Review in 1 day (reset interval)
```

This would transform Vocabulary from a "word browser" into a genuine "vocabulary builder" that delivers measurable results.

---

## 📄 License

This project is a coding challenge submission and is not affiliated with Monkey Taps LLC.

## 👤 Author

Built with ❤️ using SwiftUI
