//
//  EmojiMemoryGame.swift
//  Remember
//
//  Created by Redwan Khan on 10/11/2023.
//

import SwiftUI //viewmodel has to know what the UI looks like

class EmojiMemoryGame: ObservableObject {
    typealias Card = MemoryGame<String>.Card
    
    @Published private var model: MemoryGame<String>
    //@Published var resetAnimations = false

    private(set) var currentTheme: Theme
    
    var themeName: String {
        currentTheme.name
    }
    
    var isGameCompleted: Bool {
        cards.allSatisfy {$0.isMatched}
    }
    
    var score: Int {
        model.score
    }
    
    struct Theme {
        let name: String
        let emojis: [String]
        let numberOfPairs: Int
        let color: String
    }
        

    //initialize with a random theme
    init(){

        
        let randomTheme = ThemeManager.shared.themes.randomElement()!
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
        var cards: Array <Card> {
            return model.cards
        } //view has to go thru the viewModel to get thru things,
    
    //MARK: - Intents
    func shuffle() {
        model.shuffle() 
    }

    
    //this func will randomize theme when clicked but may be repeated current theme
    func newGame() {
 
        var newTheme: Theme
            repeat {
                newTheme = ThemeManager.shared.getRandomTheme()
            } while newTheme.name == currentTheme.name

        //resetAnimations = true
            currentTheme = newTheme
        
            model = EmojiMemoryGame.createMemoryGame(theme: newTheme)
            model.resetCardAnimations()
      
        

      }

        
        func choose(_ card: Card){ //intent func //_ cuz its clearly
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
        case "Indigo": return .indigo
        default: return .gray
        }
    }
    
    

    }

