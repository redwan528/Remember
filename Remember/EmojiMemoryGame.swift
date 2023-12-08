//
//  EmojiMemoryGame.swift
//  Remember
//
//  Created by Redwan Khan on 10/11/2023.
//

import SwiftUI //viewmodel has to know what the UI looks like

class EmojiMemoryGame: ObservableObject {
    @Published private var model: MemoryGame<String>
    
    //@Published is the Reactive UI part, meaning if something changes here, it'll show
    //@Published private var model = createMemoryGame(theme: <#EmojiMemoryGame.Theme#>)
    private(set) var currentTheme: Theme
    
    struct Theme {
        let name: String
        let emojis: [String]
        let numberOfPairs: Int
        let color: String
    }
        
    //initialize themes
    // Initialize themes
    private static let halloweenTheme = Theme(name: "Halloween", emojis: ["😈","👻","💀","🎃","👿","☠️", "🧙", "🍫","🍬","🙀","🕸", "🕷", "🍭"], numberOfPairs: 10, color: "Orange")

    private static let faceTheme = Theme(name: "Faces", emojis: ["😂","😘","🥰","😇","😎","🤯","🤬","🤪","🙄","🥵"], numberOfPairs: 10, color: "Yellow")

    
    private static let dessertsTheme = Theme(name: "Desserts", emojis: ["🍰", "🧁", "🍩", "🍪", "🍫", "🍬", "🍭", "🍮", "🍨", "🍧", "🍦", "🥧", "🍡", "🍢", "🍠"], numberOfPairs: 10, color: "Pink")

    private static let mealsTheme = Theme(name: "Meals", emojis: ["🥞", "🧇", "🍳", "🥓", "🥐", "🍔", "🍟", "🌭", "🍕", "🥪", "🍱", "🍲", "🥘", "🍝", "🥗"], numberOfPairs: 10, color: "Red")
    
    private static let animalsTheme = Theme(name: "Animals", emojis: ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐨", "🦁", "🐯", "🐮", "🐷", "🐸", "🐵"], numberOfPairs: 10, color: "Green")

    private static let sportsTheme = Theme(name: "Sports", emojis: ["⚽", "🏀", "🏈", "⚾", "🎾", "🏐", "🏉", "🏏", "🏑", "🏒", "🏓", "🏸", "🥊", "🛹", "🏹"], numberOfPairs: 10, color: "Blue")

    private static let travelTheme = Theme(name: "Travel", emojis: ["✈️", "🚂", "🚗", "🚢", "🛸", "🚀", "🚁", "🚲", "🏍", "🚜", "⛵", "🚇", "🛶", "🛴", "🚡"], numberOfPairs: 10, color: "Purple")

    // Nature, Vehicles, and Music themes can be expanded similarly



    // static menas make emojis global but namespace it inside of my class.
    
    
    //initialize with a random theme
    init(){
        let allThemes = [EmojiMemoryGame.halloweenTheme,
                         EmojiMemoryGame.faceTheme,
                         EmojiMemoryGame.mealsTheme,
                         EmojiMemoryGame.animalsTheme,
                         EmojiMemoryGame.dessertsTheme,
                         EmojiMemoryGame.sportsTheme,
                         EmojiMemoryGame.travelTheme]
        
        let randomTheme = allThemes.randomElement()!
        self.currentTheme = randomTheme
        self.model = EmojiMemoryGame.createMemoryGame(theme: randomTheme)
    }

    //create memory game with a theme
    private static func createMemoryGame(theme: Theme) -> MemoryGame<String>{
        
        let emojis = theme.emojis.shuffled()
        return MemoryGame<String>(numberOfPairsOfCards: theme.numberOfPairs){
            pairIndex in emojis[pairIndex]
            
            
        }
    }
    
        //access to the cards
        var cards: Array <MemoryGame<String>.Card> {
            return model.cards
        } //view has to go thru the viewModel to get thru things,
    
    //MARK: - Intents
    func shuffle() {
        model.shuffle() 
    }

    
    //this func will randomize theme when clicked but may be repeated current theme
    func newGame() {
        
        let allThemes = [EmojiMemoryGame.halloweenTheme,
                         EmojiMemoryGame.faceTheme,
                         EmojiMemoryGame.mealsTheme,
                         EmojiMemoryGame.animalsTheme,
                         EmojiMemoryGame.dessertsTheme,
                         EmojiMemoryGame.sportsTheme,
                         EmojiMemoryGame.travelTheme]
        
        let randomTheme = allThemes.randomElement()!
        currentTheme = randomTheme
        model = EmojiMemoryGame.createMemoryGame(theme: randomTheme)

      }
    
    func newGameWithRandomCyclingThemes(){

        var allThemes = [EmojiMemoryGame.halloweenTheme,
                         EmojiMemoryGame.faceTheme,
                         EmojiMemoryGame.mealsTheme,
                         EmojiMemoryGame.animalsTheme,
                         EmojiMemoryGame.dessertsTheme,
                         EmojiMemoryGame.sportsTheme,
                         EmojiMemoryGame.travelTheme]

           // Shuffle the themes
           allThemes.shuffle()

           // Find the first theme that is not the current theme
           if let newTheme = allThemes.first(where: { $0.name != currentTheme.name }) {
               currentTheme = newTheme
               model = EmojiMemoryGame.createMemoryGame(theme: newTheme)
//               print("New Theme: \(newTheme.name)") // Debug print
           } else {
               // In the unlikely event that all themes are the same as the current theme,
               // you can choose to restart the current theme or handle this case differently.
//               print("Fallback to current theme") // Debug print
               model = EmojiMemoryGame.createMemoryGame(theme: currentTheme)
           }
        

    }
        
        func choose(_ card: MemoryGame<String>.Card){ //intent func //_ cuz its clearly
            model.choose(card)
        }
    
    
        
    //convert theme color string to Color
    var themeColor: Color {
        switch currentTheme.color {
        case "Orange": return .orange
        case "Yellow": return .yellow
        case "Red": return .red
        case "Blue": return .blue
        case "Green": return .green
        case "Pink": return .pink
        default: return .gray
        }
    }
    
    

    }

