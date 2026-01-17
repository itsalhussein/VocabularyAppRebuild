//
//  CategorySelectionView.swift
//  VocabularyApp
//

import SwiftUI

struct CategorySelectionView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    let onContinue: () -> Void
    
    @State private var headerOpacity = 0.0
    @State private var gridOpacity = 0.0
    @State private var buttonOpacity = 0.0
    
    let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
                .frame(height: 50)

            // Skip button
            HStack {
                Spacer()

                Button(action: onContinue) {
                    Text("Skip")
                        .font(.system(size: 16, weight: .medium, design: .rounded))
                        .foregroundColor(.white.opacity(0.6))
                }
                .padding(.trailing, 24)
            }

            Spacer()
                .frame(height: 20)

            // Header
            VStack(spacing: 12) {
                Text("What interests you?")
                    .font(.system(size: 32, weight: .bold, design: .serif))
                    .foregroundColor(.white)
                
                Text("Select categories to personalize your words")
                    .font(.system(size: 16, weight: .regular, design: .rounded))
                    .foregroundColor(.white.opacity(0.7))
            }
            .opacity(headerOpacity)
            .padding(.horizontal, 24)
            
            Spacer()
                .frame(height: 40)
            
            // Categories grid
            LazyVGrid(columns: columns, spacing: 12) {
                ForEach(WordCategory.allCases) { category in
                    CategoryCard(
                        category: category,
                        isSelected: viewModel.selectedCategories.contains(category),
                        onTap: {
                            HapticManager.shared.selection()
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                                viewModel.toggleCategory(category)
                            }
                        }
                    )
                }
            }
            .padding(.horizontal, 20)
            .opacity(gridOpacity)
            
            Spacer()
            
            // Selection hint
            Text("Select at least one category")
                .font(.system(size: 13, weight: .medium, design: .rounded))
                .foregroundColor(.white.opacity(0.5))
                .opacity(viewModel.selectedCategories.isEmpty ? 1 : 0)
            
            Spacer()
                .frame(height: 16)
            
            // Continue button
            OnboardingButton(
                isEnabled: !viewModel.selectedCategories.isEmpty,
                theme: viewModel.selectedTheme,
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
        withAnimation(.easeOut(duration: 0.6).delay(0.1)) {
            headerOpacity = 1.0
        }
        
        withAnimation(.easeOut(duration: 0.6).delay(0.3)) {
            gridOpacity = 1.0
        }
        
        withAnimation(.easeOut(duration: 0.6).delay(0.5)) {
            buttonOpacity = 1.0
        }
    }
}

// MARK: - Category Card

struct CategoryCard: View {
    let category: WordCategory
    let isSelected: Bool
    let onTap: () -> Void
    
    @State private var isPressed = false
    
    var body: some View {
        Button(action: onTap) {
            VStack(spacing: 12) {
                // Icon
                ZStack {
                    Circle()
                        .fill(
                            isSelected ?
                            category.color.opacity(0.3) :
                            Color.white.opacity(0.1)
                        )
                        .frame(width: 56, height: 56)
                    
                    Image(systemName: category.icon)
                        .font(.system(size: 24, weight: .semibold))
                        .foregroundColor(isSelected ? category.color : .white.opacity(0.7))
                }
                
                // Text
                VStack(spacing: 4) {
                    Text(category.rawValue)
                        .font(.system(size: 15, weight: .semibold, design: .rounded))
                        .foregroundColor(.white)
                    
                    Text(category.description)
                        .font(.system(size: 11, weight: .regular, design: .rounded))
                        .foregroundColor(.white.opacity(0.5))
                        .lineLimit(1)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 20)
            .padding(.horizontal, 12)
            .background(
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .fill(Color.white.opacity(isSelected ? 0.15 : 0.08))
                    .overlay(
                        RoundedRectangle(cornerRadius: 20, style: .continuous)
                            .stroke(
                                isSelected ? category.color : Color.white.opacity(0.1),
                                lineWidth: isSelected ? 2 : 1
                            )
                    )
            )
            .scaleEffect(isPressed ? 0.95 : 1.0)
        }
        .buttonStyle(PlainButtonStyle())
        .simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .onChanged { _ in
                    withAnimation(.spring(response: 0.2, dampingFraction: 0.7)) {
                        isPressed = true
                    }
                }
                .onEnded { _ in
                    withAnimation(.spring(response: 0.2, dampingFraction: 0.7)) {
                        isPressed = false
                    }
                }
        )
    }
}

#Preview {
    let appState = AppState()
    ZStack {
        AnimatedGradientBackground()
            .ignoresSafeArea()

        CategorySelectionView(
            viewModel: OnboardingViewModel(appState: appState),
            onContinue: {}
        )
    }
}
