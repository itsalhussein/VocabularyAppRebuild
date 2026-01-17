//
//  Word.swift
//  VocabularyApp
//

import SwiftUI

struct Word: Identifiable, Equatable {
    let id = UUID()
    let word: String
    let pronunciation: String
    let partOfSpeech: String
    let definition: String
    let example: String
    let level: VocabularyLevel
    let category: WordCategory
    let gradient: [Color]
    
    static func == (lhs: Word, rhs: Word) -> Bool {
        lhs.word == rhs.word
    }
}

// MARK: - Sample Vocabulary Data
extension Word {
    
    // Beautiful gradient presets
    static let gradients: [[Color]] = [
        [Color(hex: "ff6b6b"), Color(hex: "feca57")],
        [Color(hex: "667eea"), Color(hex: "764ba2")],
        [Color(hex: "a8edea"), Color(hex: "fed6e3")],
        [Color(hex: "2c3e50"), Color(hex: "4ca1af")],
        [Color(hex: "ee9ca7"), Color(hex: "ffdde1")],
        [Color(hex: "1a1a2e"), Color(hex: "16213e")],
        [Color(hex: "fc466b"), Color(hex: "3f5efb")],
        [Color(hex: "134e5e"), Color(hex: "71b280")],
        [Color(hex: "f7971e"), Color(hex: "ffd200")],
        [Color(hex: "8e2de2"), Color(hex: "4a00e0")],
        [Color(hex: "11998e"), Color(hex: "38ef7d")],
        [Color(hex: "ee0979"), Color(hex: "ff6a00")],
    ]
    
    // MARK: - All Words Database
    
    static let allWords: [Word] = [
        // MARK: Emotions - Beginner
        Word(word: "Serene", pronunciation: "suh-REEN", partOfSpeech: "adjective",
             definition: "Calm, peaceful, and untroubled; tranquil",
             example: "The serene lake reflected the mountains like a mirror.",
             level: .beginner, category: .emotions, gradient: gradients[0]),
        
        Word(word: "Joyful", pronunciation: "JOY-fuhl", partOfSpeech: "adjective",
             definition: "Feeling, expressing, or causing great pleasure and happiness",
             example: "The children were joyful when they saw the birthday cake.",
             level: .beginner, category: .emotions, gradient: gradients[1]),
        
        Word(word: "Anxious", pronunciation: "ANK-shuhs", partOfSpeech: "adjective",
             definition: "Experiencing worry, unease, or nervousness",
             example: "She felt anxious before her job interview.",
             level: .beginner, category: .emotions, gradient: gradients[2]),
        
        // MARK: Emotions - Intermediate
        Word(word: "Melancholy", pronunciation: "MEL-uhn-kol-ee", partOfSpeech: "noun",
             definition: "A deep, pensive sadness; a feeling of thoughtful sadness",
             example: "A sense of melancholy washed over him as he read the old letters.",
             level: .intermediate, category: .emotions, gradient: gradients[3]),
        
        Word(word: "Euphoria", pronunciation: "yoo-FOR-ee-uh", partOfSpeech: "noun",
             definition: "A feeling of intense excitement and happiness",
             example: "The team experienced euphoria after winning the championship.",
             level: .intermediate, category: .emotions, gradient: gradients[4]),
        
        Word(word: "Wistful", pronunciation: "WIST-fuhl", partOfSpeech: "adjective",
             definition: "Having a feeling of vague or regretful longing",
             example: "She gave a wistful smile thinking about her childhood home.",
             level: .intermediate, category: .emotions, gradient: gradients[5]),
        
        // MARK: Emotions - Advanced
        Word(word: "Sonder", pronunciation: "SON-der", partOfSpeech: "noun",
             definition: "The realization that each passerby has a life as vivid and complex as your own",
             example: "Watching the crowd, she was struck by a profound sense of sonder.",
             level: .advanced, category: .emotions, gradient: gradients[6]),
        
        Word(word: "Hiraeth", pronunciation: "HEER-eyeth", partOfSpeech: "noun",
             definition: "A deep longing for home; homesickness tinged with grief",
             example: "Living abroad, he often felt hiraeth for his Welsh village.",
             level: .advanced, category: .emotions, gradient: gradients[7]),
        
        // MARK: Nature - Beginner
        Word(word: "Vivid", pronunciation: "VIV-id", partOfSpeech: "adjective",
             definition: "Producing powerful feelings or strong, clear images in the mind",
             example: "The garden was filled with vivid colors.",
             level: .beginner, category: .nature, gradient: gradients[8]),
        
        Word(word: "Gentle", pronunciation: "JEN-tl", partOfSpeech: "adjective",
             definition: "Having a mild, kind, or tender temperament or character",
             example: "A gentle breeze carried the scent of flowers.",
             level: .beginner, category: .nature, gradient: gradients[9]),
        
        Word(word: "Lush", pronunciation: "LUHSH", partOfSpeech: "adjective",
             definition: "Growing luxuriantly; rich and abundant",
             example: "The lush forest was home to countless species.",
             level: .beginner, category: .nature, gradient: gradients[10]),
        
        // MARK: Nature - Intermediate
        Word(word: "Verdant", pronunciation: "VUR-dnt", partOfSpeech: "adjective",
             definition: "Green with grass or rich vegetation",
             example: "The verdant hills stretched as far as the eye could see.",
             level: .intermediate, category: .nature, gradient: gradients[11]),
        
        Word(word: "Ethereal", pronunciation: "ih-THEER-ee-uhl", partOfSpeech: "adjective",
             definition: "Extremely delicate and light in a way that seems too perfect for this world",
             example: "The morning mist gave the forest an ethereal quality.",
             level: .intermediate, category: .nature, gradient: gradients[0]),
        
        // MARK: Nature - Advanced
        Word(word: "Petrichor", pronunciation: "PET-ri-kor", partOfSpeech: "noun",
             definition: "The pleasant earthy smell after rain falls on dry ground",
             example: "The petrichor after the summer storm was intoxicating.",
             level: .advanced, category: .nature, gradient: gradients[1]),
        
        Word(word: "Crepuscular", pronunciation: "krih-PUS-kyoo-ler", partOfSpeech: "adjective",
             definition: "Of, resembling, or relating to twilight",
             example: "Many animals are crepuscular, most active at dawn and dusk.",
             level: .advanced, category: .nature, gradient: gradients[2]),
        
        // MARK: Business - Beginner
        Word(word: "Efficient", pronunciation: "ih-FISH-uhnt", partOfSpeech: "adjective",
             definition: "Achieving maximum productivity with minimum wasted effort",
             example: "The new system made our workflow more efficient.",
             level: .beginner, category: .business, gradient: gradients[3]),
        
        Word(word: "Collaborate", pronunciation: "kuh-LAB-uh-rayt", partOfSpeech: "verb",
             definition: "Work jointly on an activity or project",
             example: "The teams decided to collaborate on the new product launch.",
             level: .beginner, category: .business, gradient: gradients[4]),
        
        // MARK: Business - Intermediate
        Word(word: "Synergy", pronunciation: "SIN-er-jee", partOfSpeech: "noun",
             definition: "The interaction of elements that produces a combined effect greater than the sum of their parts",
             example: "The merger created synergy between the two companies.",
             level: .intermediate, category: .business, gradient: gradients[5]),
        
        Word(word: "Leverage", pronunciation: "LEV-er-ij", partOfSpeech: "verb",
             definition: "Use something to maximum advantage",
             example: "We need to leverage our existing relationships to expand.",
             level: .intermediate, category: .business, gradient: gradients[6]),
        
        Word(word: "Paradigm", pronunciation: "PAIR-uh-dime", partOfSpeech: "noun",
             definition: "A typical example or pattern of something; a model",
             example: "This represents a paradigm shift in how we approach marketing.",
             level: .intermediate, category: .business, gradient: gradients[7]),
        
        // MARK: Business - Advanced
        Word(word: "Disruptive", pronunciation: "dis-RUP-tiv", partOfSpeech: "adjective",
             definition: "Causing radical change to an existing industry or market",
             example: "Their disruptive technology transformed the entire sector.",
             level: .advanced, category: .business, gradient: gradients[8]),
        
        // MARK: Beautiful Words - Beginner
        Word(word: "Harmony", pronunciation: "HAR-muh-nee", partOfSpeech: "noun",
             definition: "A pleasing combination of elements; agreement or accord",
             example: "The orchestra played in perfect harmony.",
             level: .beginner, category: .beautiful, gradient: gradients[9]),
        
        Word(word: "Graceful", pronunciation: "GRAYS-fuhl", partOfSpeech: "adjective",
             definition: "Having elegance or beauty of form, movement, or expression",
             example: "The dancer moved with graceful precision.",
             level: .beginner, category: .beautiful, gradient: gradients[10]),
        
        // MARK: Beautiful Words - Intermediate
        Word(word: "Ephemeral", pronunciation: "ih-FEM-er-uhl", partOfSpeech: "adjective",
             definition: "Lasting for a very short time; transitory",
             example: "The ephemeral beauty of cherry blossoms reminds us to cherish each moment.",
             level: .intermediate, category: .beautiful, gradient: gradients[11]),
        
        Word(word: "Serendipity", pronunciation: "ser-uhn-DIP-ih-tee", partOfSpeech: "noun",
             definition: "The occurrence of events by chance in a happy or beneficial way",
             example: "Finding that rare book was pure serendipity.",
             level: .intermediate, category: .beautiful, gradient: gradients[0]),
        
        Word(word: "Luminous", pronunciation: "LOO-muh-nuhs", partOfSpeech: "adjective",
             definition: "Full of or shedding light; bright or shining",
             example: "The luminous moon cast silver shadows across the garden.",
             level: .intermediate, category: .beautiful, gradient: gradients[1]),
        
        Word(word: "Eloquent", pronunciation: "EL-uh-kwuhnt", partOfSpeech: "adjective",
             definition: "Fluent or persuasive in speaking or writing",
             example: "Her eloquent speech moved the entire audience to tears.",
             level: .intermediate, category: .beautiful, gradient: gradients[2]),
        
        // MARK: Beautiful Words - Advanced
        Word(word: "Ineffable", pronunciation: "in-EF-uh-buhl", partOfSpeech: "adjective",
             definition: "Too great or extreme to be expressed or described in words",
             example: "The ineffable beauty of the aurora left everyone speechless.",
             level: .advanced, category: .beautiful, gradient: gradients[3]),
        
        Word(word: "Mellifluous", pronunciation: "muh-LIF-loo-uhs", partOfSpeech: "adjective",
             definition: "Sweet or musical; pleasant to hear",
             example: "Her mellifluous voice could calm even the most anxious soul.",
             level: .advanced, category: .beautiful, gradient: gradients[4]),
        
        Word(word: "Numinous", pronunciation: "NOO-muh-nuhs", partOfSpeech: "adjective",
             definition: "Having a strong spiritual or religious quality; divine",
             example: "Standing in the ancient temple, he felt a numinous presence.",
             level: .advanced, category: .beautiful, gradient: gradients[5]),
        
        Word(word: "Susurrus", pronunciation: "soo-SUR-uhs", partOfSpeech: "noun",
             definition: "A whispering or rustling sound",
             example: "The susurrus of wind through the wheat field was hypnotic.",
             level: .advanced, category: .beautiful, gradient: gradients[6]),
        
        // MARK: Academic - Beginner
        Word(word: "Curious", pronunciation: "KYOOR-ee-uhs", partOfSpeech: "adjective",
             definition: "Eager to know or learn something; showing curiosity",
             example: "The curious child asked endless questions about the stars.",
             level: .beginner, category: .academic, gradient: gradients[7]),
        
        Word(word: "Analyze", pronunciation: "AN-uh-lyze", partOfSpeech: "verb",
             definition: "Examine methodically and in detail",
             example: "Scientists analyze data to draw conclusions.",
             level: .beginner, category: .academic, gradient: gradients[8]),
        
        // MARK: Academic - Intermediate
        Word(word: "Hypothesis", pronunciation: "hy-POTH-uh-sis", partOfSpeech: "noun",
             definition: "A proposed explanation made on limited evidence as a starting point",
             example: "The scientist tested her hypothesis through experiments.",
             level: .intermediate, category: .academic, gradient: gradients[9]),
        
        Word(word: "Empirical", pronunciation: "em-PEER-ih-kuhl", partOfSpeech: "adjective",
             definition: "Based on observation or experience rather than theory",
             example: "The study provided empirical evidence for the theory.",
             level: .intermediate, category: .academic, gradient: gradients[10]),
        
        // MARK: Academic - Advanced
        Word(word: "Epistemology", pronunciation: "ih-pis-tuh-MOL-uh-jee", partOfSpeech: "noun",
             definition: "The branch of philosophy concerned with the nature of knowledge",
             example: "Her thesis explored epistemology in the digital age.",
             level: .advanced, category: .academic, gradient: gradients[11]),
        
        Word(word: "Ontological", pronunciation: "on-tuh-LOJ-ih-kuhl", partOfSpeech: "adjective",
             definition: "Relating to the branch of metaphysics dealing with the nature of being",
             example: "The debate raised ontological questions about reality.",
             level: .advanced, category: .academic, gradient: gradients[0]),
        
        // MARK: Everyday - Beginner
        Word(word: "Cozy", pronunciation: "KOH-zee", partOfSpeech: "adjective",
             definition: "Giving a feeling of comfort, warmth, and relaxation",
             example: "We spent a cozy evening by the fireplace.",
             level: .beginner, category: .everyday, gradient: gradients[1]),
        
        Word(word: "Reliable", pronunciation: "rih-LY-uh-buhl", partOfSpeech: "adjective",
             definition: "Consistently good in quality or performance; able to be trusted",
             example: "She's the most reliable person on our team.",
             level: .beginner, category: .everyday, gradient: gradients[2]),
        
        Word(word: "Thoughtful", pronunciation: "THAWT-fuhl", partOfSpeech: "adjective",
             definition: "Showing careful consideration or attention",
             example: "It was thoughtful of you to remember my birthday.",
             level: .beginner, category: .everyday, gradient: gradients[3]),
        
        // MARK: Everyday - Intermediate
        Word(word: "Resilient", pronunciation: "rih-ZIL-yuhnt", partOfSpeech: "adjective",
             definition: "Able to recover quickly from difficulties; tough",
             example: "The resilient community rebuilt after the storm.",
             level: .intermediate, category: .everyday, gradient: gradients[4]),
        
        Word(word: "Versatile", pronunciation: "VUR-suh-tl", partOfSpeech: "adjective",
             definition: "Able to adapt or be adapted to many different functions",
             example: "This versatile tool can be used for multiple tasks.",
             level: .intermediate, category: .everyday, gradient: gradients[5]),
        
        // MARK: Everyday - Advanced
        Word(word: "Ubiquitous", pronunciation: "yoo-BIK-wi-tuhs", partOfSpeech: "adjective",
             definition: "Present, appearing, or found everywhere",
             example: "Smartphones have become ubiquitous in modern life.",
             level: .advanced, category: .everyday, gradient: gradients[6]),
    ]
    
    // MARK: - Filtered Words Function
    
    static func words(for level: VocabularyLevel, categories: Set<WordCategory>) -> [Word] {
        allWords.filter { word in
            word.level == level && categories.contains(word.category)
        }
    }
    
    static func words(for level: VocabularyLevel) -> [Word] {
        allWords.filter { $0.level == level }
    }
    
    static func words(for category: WordCategory) -> [Word] {
        allWords.filter { $0.category == category }
    }
}
