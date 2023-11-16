//
//  MemorizeGame.swift
//  Remember
//
//  Created by Redwan Khan on 10/11/2023.
//

//this is our model
import Foundation
    //models r ui independent, shouldnt import swiftui

struct MemoryGame <CardContent> /*dont care CardContent, can put anything u want on the cards*/ {
    
    private(set) var cards: Array<Card> //private set means other code can look at it, meaning only setting the var is private, looking at the var is allowed others can look at it
    
    //passing function cardContentFactory as types and parameters
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent){
        //cards = Array<Card>()
        cards = []
        // add a numberOfPairsOfCards x 2 cards
        
        
    //
        for pairIndex in 0..<max(2,numberOfPairsOfCards) {
            let content:CardContent = cardContentFactory(pairIndex)
            
            //twice cuz we need two of each card to match cards
            cards.append(Card(content: content))
            cards.append(Card(content: content))
        }
    }
    
    func choose(_ card: Card){
        
    }
    
    mutating func shuffle(){
        cards.shuffle()
        print(cards)
    }
    
    
    struct Card {
        var isFaceUp = true
        var isMatched = false
        let content: CardContent //let cuz content stays same on card no matter what
        
    }
    
     
    
    
    
}
