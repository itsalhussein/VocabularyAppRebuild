//
//  WordDeckViewModel.swift
//  VocabularyApp
//
//  ViewModel for WordDeck (Home) feature
//

import SwiftUI
import Combine

class WordDeckViewModel: ObservableObject {
    // MARK: - Published Properties

    @Published var words: [Word] = []
    @Published var currentIndex: Int = 0
    @Published var masteredWords: Set<String> = []

    // MARK: - Computed Properties

    var currentWord: Word? {
        guard !words.isEmpty else { return nil }
        return words[currentIndex % words.count]
    }

    var currentWordGradient: [Color] {
        currentWord?.gradient ?? []
    }

    var masteredCount: Int {
        words.filter { masteredWords.contains($0.word) }.count
    }

    // MARK: - Dependencies

    private let appState: AppState
    private var cancellables = Set<AnyCancellable>()

    // MARK: - Initialization

    init(appState: AppState) {
        self.appState = appState
        loadPersistedData()
        observeAppStateChanges()
        loadWords()
    }

    // MARK: - Public Methods

    func loadWords() {
        let level = appState.selectedLevel
        let categories = appState.selectedCategories

        let filteredWords = Word.words(for: level, categories: categories)
        words = filteredWords.isEmpty ? Word.words(for: level) : filteredWords

        // Shuffle for variety
        words.shuffle()

        // Limit to 5 words max
        if words.count > 5 {
            words = Array(words.prefix(5))
        }

        currentIndex = 0
    }

    func markWordAsMastered(_ word: Word) {
        masteredWords.insert(word.word)
        saveMasteredWords()
        HapticManager.shared.wordMasteryCelebration()
    }

    func isWordMastered(_ word: String) -> Bool {
        masteredWords.contains(word)
    }

    // MARK: - Private Methods

    private func loadPersistedData() {
        if let mastered = UserDefaults.standard.array(forKey: "masteredWords") as? [String] {
            masteredWords = Set(mastered)
        }
    }

    private func saveMasteredWords() {
        UserDefaults.standard.set(Array(masteredWords), forKey: "masteredWords")
    }

    private func observeAppStateChanges() {
        // Reload words when level or categories change
        appState.$selectedLevel
            .sink { [weak self] _ in
                self?.loadWords()
            }
            .store(in: &cancellables)

        appState.$selectedCategories
            .sink { [weak self] _ in
                self?.loadWords()
            }
            .store(in: &cancellables)
    }
}
