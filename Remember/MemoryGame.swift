//
//  MemorizeGame.swift
//  Remember
//
//  Created by Redwan Khan on 10/11/2023.
//

//this is our model
import Foundation
//models r ui independent, shouldnt import swiftui

struct MemoryGame <CardContent> where CardContent: Equatable /*dont care CardContent, can put anything u want on the cards BUT NOW WITH "where CardContent: Equatable", we do care a little bit now saying "u can be anything u want card, but it better be equatable" */ {
    
    private(set) var cards: Array<Card> //private set means other code can look at it, meaning only setting the var is private, looking at the var is allowed others can look at it
    
    //passing function cardContentFactory as types and parameters
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent){
        //cards = Array<Card>()
        cards = []
        // add a numberOfPairsOfCards x 2 cards
        for pairIndex in 0..<max(2,numberOfPairsOfCards) {
            let content:CardContent = cardContentFactory(pairIndex)
            
            //twice cuz we need two of each card to match cards
            cards.append(Card(content: content, id:"\(pairIndex+1)a"))
            cards.append(Card(content: content, id: "\(pairIndex+1)b"))
        }
        shuffle()
    }
    
    var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get {
            cards.indices.filter{ index in cards[index].isFaceUp }.only
            
        } set{
            cards.indices.forEach{ cards[$0].isFaceUp = (newValue == $0)}
        }
        
    }
    
    private(set) var score = 0
    
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }),
           !cards[chosenIndex].isFaceUp,
           !cards[chosenIndex].isMatched {
            
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    // Match found
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    score += 2
                } else {
                    // Mismatch
                    // if cards[chosenIndex].hasBeenSeen { score -= 1 } dead code line
                    
                    if cards[potentialMatchIndex].hasBeenSeen { score -= 1 }
                }
                cards[chosenIndex].isFaceUp = true
            } else {
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
            cards[chosenIndex].hasBeenSeen = true
        }
    }
    
    
    
    mutating func shuffle(){
        cards.shuffle()
        print(cards)
    }
    
    
    struct Card: Equatable, Identifiable, CustomDebugStringConvertible {
        
        
        var isFaceUp = false
        var isMatched = false
        let content: CardContent //let cuz content stays same on card no matter what
        var hasBeenSeen = false
        
        var id: String //dont care as long as its hashable
        
        var debugDescription: String {
            return "\(id): \(content) \(isFaceUp ? "up" : "down")\(isMatched ? "matched" : "")"
        }
    }
    
}

extension Array {
    var only: Element? {
        //Element? is the dont care for Array
        count == 1 ? first : nil //if count ==1 then first otherwise nil
    }
}
