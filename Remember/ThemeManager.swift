//
//  ThemeManager.swift
//  Remember
//
//  Created by Redwan Khan on 12/16/23.
//

import Foundation

class ThemeManager {
    static var shared = ThemeManager()

    private(set) var themes: [EmojiMemoryGame.Theme] = []

    private init() {
        // Initialize with default themes
        themes.append(contentsOf: [
            // Add your default themes here
            EmojiMemoryGame.Theme(name: "Halloween", emojis: ["😈","👻","💀","🎃","👿","☠️", "🧙", "🍫","🍬","🙀","🕸", "🕷", "🍭"], numberOfPairs: 10, color: "Orange"),
            
           

            EmojiMemoryGame.Theme(name: "Faces", emojis: ["😂","😘","🥰","😇","😎","🤯","🤬","🤪","🙄","🥵"], numberOfPairs: 10, color: "Yellow"),

            
            EmojiMemoryGame.Theme(name: "Desserts", emojis: ["🍰", "🧁", "🍩", "🍪", "🍫", "🍬", "🍭", "🍮", "🍨", "🍧", "🍦", "🥧", "🍡", "🍢", "🍠"], numberOfPairs: 10, color: "Pink"),

            EmojiMemoryGame.Theme(name: "Meals", emojis: ["🥞", "🧇", "🍳", "🥓", "🥐", "🍔", "🍟", "🌭", "🍕", "🥪", "🍱", "🍲", "🥘", "🍝", "🥗"], numberOfPairs: 10, color: "Red"),
            
            EmojiMemoryGame.Theme(name: "Animals", emojis: ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐨", "🦁", "🐯", "🐮", "🐷", "🐸", "🐵"], numberOfPairs: 10, color: "Green"),

            EmojiMemoryGame.Theme(name: "Sports", emojis: ["⚽", "🏀", "🏈", "⚾", "🎾", "🏐", "🏉", "🏏", "🏑", "🏒", "🏓", "🏸", "🥊", "🛹", "🏹"], numberOfPairs: 10, color: "Blue"),

            EmojiMemoryGame.Theme(name: "Travel", emojis: ["✈️", "🚂", "🚗", "🚢", "🛸", "🚀", "🚁", "🚲", "🏍", "🚜", "⛵", "🚇", "🛶", "🛴", "🚡"], numberOfPairs: 10, color: "Purple")
            
        ])
    }

    func addTheme(_ theme: EmojiMemoryGame.Theme) {
        themes.append(theme)
    }
    
    
        func getRandomTheme() -> EmojiMemoryGame.Theme {
            themes.randomElement() ?? EmojiMemoryGame.Theme(name: "Default", emojis: ["🔆"], numberOfPairs: 2, color: "Gray")

        }
    
}
