//
//  EmojiMemoryGame.swift
//  Remember
//
//  Created by Redwan Khan on 10/11/2023.
//

import SwiftUI //viewmodel has to know what the UI looks like

class EmojiMemoryGame: ObservableObject {
    //@Published private var model: MemoryGame<String>
    private(set) var currentTheme: CardTheme = .face
    // static menas make emojis global but namespace it inside of my class.
    // private is only for us to use
    private static let halloweenEmojis = ["😈","👻","💀","🎃","👿","☠️", "🧙", "🍫","🍬","🙀","🕸", "🕷", "🍭"]
       private static let faceEmojis = ["😂","😘","🥰","😇","😎","🤯","🤬","🤪","🙄","🥵"]
       private static let foodEmojis = ["🍔","🌭","🍕","🍤","🍗","🍿", "🥪","🥓","🥞","🍟"]
    
    private static func createMemoryGame() -> MemoryGame<String>{
        return MemoryGame(numberOfPairsOfCards: 16) { pairIndex in
//            if halloweenEmojis.indices.contains(pairIndex) {
//                return halloweenEmojis[pairIndex]
//            }
//            else 
            if faceEmojis.indices.contains(pairIndex){
                return faceEmojis[pairIndex]
            }
//            else if foodEmojis.indices.contains(pairIndex){
//                return foodEmojis[pairIndex]
//            }
                else{
                return "oops"
            }
            //return emojis[pairIndex]
        }
    }
    
    //var objectWillChange: ObservableObjectPublisher
    
    //@Published is the Reactive UI part, meaning if something changes here, it'll show
    @Published private var model = createMemoryGame()
        
        var cards: Array <MemoryGame<String>.Card> {
            return model.cards
        } //view has to go thru the viewModel to get thru things,
    
    //MARK: - Intents
    func shuffle() {
        model.shuffle() 
    }

    
    func newGame(theme: CardTheme) {
          var emojis: [String]
          switch theme {
          case .halloween:
              emojis = EmojiMemoryGame.halloweenEmojis
              currentTheme = .halloween
                 
          case .face:
              emojis = EmojiMemoryGame.faceEmojis
              currentTheme = .face
              
          case .food:
              emojis = EmojiMemoryGame.foodEmojis
              currentTheme = .food
          }
          model = MemoryGame<String>(numberOfPairsOfCards: emojis.count) { pairIndex in
              emojis[pairIndex]
          }
          model.shuffle()
      }
        
        func choose(_ card: MemoryGame<String>.Card){ //intent func //_ cuz its clearly
            model.choose(card)
        }
    
    
        
    var themeColor: Color {
        switch currentTheme {
        case .halloween:
            return .orange
        case .face:
            return .yellow
        case .food:
            return .red
        }
    }

    }

