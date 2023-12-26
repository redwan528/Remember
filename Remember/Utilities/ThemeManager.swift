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
    
    var dessertsEmojis =  ["🍰", "🧁", "🍩", "🍪", "🍫", "🍬", "🍭", "🍮", "🍨", "🍧", "🍦", "🥧", "🍡", "🍢", "🍠"]
    var halloweenEmojis = ["😈", "👻", "🎃", "☠️", "🧙", "🍫", "🍬", "🙀", "🕸", "🕷", "🍭", "🦇", "🪦", "🧛", "🧟‍♂️"]
    var faceEmojis = ["😂", "😘", "🥰", "😇", "😎", "🤯", "🤪", "🙄", "🥵", "😏", "😒", "😜", "😡", "🥺", "😉"]
    var mealEmojis = ["🥞", "🧇", "🍳", "🥓", "🥐", "🍔", "🍟", "🌭", "🍕", "🥪", "🍱", "🍲", "🥘", "🍝", "🥗"]
    var animalEmojis = ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐨", "🦁", "🐯", "🐮", "🐷", "🐸", "🐵"]
    var sportsEmojis = ["⚽", "🏀", "🏈", "⚾", "🎾", "🏐", "🏉", "🏏", "🏑", "🏒", "🏓", "🏸", "🥊", "🛹", "🏹"]
    var travelEmojis = ["✈️", "🚂", "🚗", "🚢", "🛸", "🚀", "🚁", "🚲", "🏍", "🚜", "⛵", "🚇", "🛶", "🛴", "🚡"]
    var christmasEmojis = ["🎄", "🎅", "🦌", "🎁", "⛄", "❄️", "🔔", "🧦", "🍪", "🥛", "🌟", "☃️", "🕊️", "🍬", "🛷"]


    private init() {
        // Initialize with default themes
        themes = [
            
            createTheme(name: "Halloween", emojis: halloweenEmojis, color: "Orange"),
                     createTheme(name: "Faces", emojis: faceEmojis, color: "Yellow"),
                     createTheme(name: "Desserts", emojis: dessertsEmojis, color: "Pink"),
                     createTheme(name: "Meals", emojis: mealEmojis, color: "Red"),
                     createTheme(name: "Animals", emojis: animalEmojis, color: "Green"),
                     createTheme(name: "Sports", emojis: sportsEmojis, color: "Blue"),
                     createTheme(name: "Travel", emojis: travelEmojis, color: "Indigo"),
                     createTheme(name: "Christmas", emojis: christmasEmojis, color: "Green")
            
        ]
    }
    
    private func createTheme(name: String, emojis: [String], color: String) -> EmojiMemoryGame.Theme {
        return EmojiMemoryGame.Theme(name: name, emojis: emojis, numberOfPairs: emojis.count, color: color)
    }

    func addTheme(_ theme: EmojiMemoryGame.Theme) {
        themes.append(theme)
    }
    
    
        func getRandomTheme() -> EmojiMemoryGame.Theme {
            themes.randomElement() ?? EmojiMemoryGame.Theme(name: "Default", emojis: ["🔆"], numberOfPairs: 2, color: "Gray")

        }
    
}
