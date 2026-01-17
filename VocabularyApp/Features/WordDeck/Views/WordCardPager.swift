//
//  WordCardPager.swift
//  VocabularyApp
//

import SwiftUI

struct WordCardPager: View {
    let words: [Word]
    @Binding var currentIndex: Int
    let viewModel: WordDeckViewModel

    var body: some View {
        TabView(selection: $currentIndex) {
            ForEach(Array(words.enumerated()), id: \.element.id) { index, word in
                WordCardView(
                    word: word,
                    viewModel: viewModel
                )
                .tag(index)
                .padding(.horizontal, 20)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .frame(height: 520)
        .onChange(of: currentIndex) { oldValue, newValue in
            // Loop around when reaching the end
            if newValue >= words.count {
                currentIndex = 0
            }
            HapticManager.shared.cardSwipe()
        }
    }
}

