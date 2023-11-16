//
//  MemorizeGame.swift
//  Remember
//
//  Created by Redwan Khan on 10/11/2023.
//

import Foundation
    //models r ui independent, shouldnt import swiftui

struct MemoryGame <CardContent> /*dont care CardContent, can put anything u want on the cards*/ {
    
    var cards: Array<Card>
    
    func choose(card: Card){
        
    }
    
    struct Card {
        var isFaceUp: Bool
        var isMatched: Bool
        var content: CardContent
        
    }
    
    
    
    
    
}
