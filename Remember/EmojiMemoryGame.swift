//
//  EmojiMemoryGame.swift
//  Remember
//
//  Created by Redwan Khan on 10/11/2023.
//

import SwiftUI //viewmodel has to know what the UI looks like


class EmojiMemoryGame: ObservableObject {
    
    // static menas make emojis global but namespace it inside of my class.
    // private is only for us to use
    private static let emojis =
    ["😈","👻","💀","🎃","👿","☠️", "🧙", "🍫","🍬","🙀","🕸", "🕷", "🍭"]
    
    private static func createMemoryGame() -> MemoryGame<String>{
        return MemoryGame(numberOfPairsOfCards: 16) { pairIndex in
            if emojis.indices.contains(pairIndex) {
                return emojis[pairIndex]
            } else{
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
        //objectWillChange.send()
    }
        
        func choose(_ card: MemoryGame<String>.Card){ //intent func //_ cuz its clearly
            model.choose(card)
        }
        
        
    }

