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
        
        
    //
        for pairIndex in 0..<max(2,numberOfPairsOfCards) {
            let content:CardContent = cardContentFactory(pairIndex)
            
            //twice cuz we need two of each card to match cards
            cards.append(Card(content: content, id:"\(pairIndex+1)a"))
            cards.append(Card(content: content, id: "\(pairIndex+1)b"))
        }
    }
    
    mutating func choose(_ card: Card){
       // print("chose \(card)")
        let chosenIndex = index(of: card)
        cards[chosenIndex].isFaceUp.toggle()
    }
    
    func index(of card: Card) -> Int {
        for index in cards.indices {
            if cards[index].id == card.id {
                return index
            }
        }
        return 0 // FIXME: bogus!!!
    }
    
    mutating func shuffle(){
        cards.shuffle()
        print(cards)
    }
    
    
    struct Card: Equatable, Identifiable, CustomDebugStringConvertible {
        //dont need this anymore since
        //lhs: left hand side
//        static func == (lhs: MemoryGame<CardContent>.Card, rhs: MemoryGame<CardContent>.Card) -> Bool {
//            return lhs.isFaceUp == rhs.isFaceUp &&
//            lhs.isMatched == rhs.isMatched &&
//            lhs.content == rhs.content
//        }
        
        var isFaceUp = true
        var isMatched = false
        let content: CardContent //let cuz content stays same on card no matter what
        
        
        var id: String //dont care as long as its hashable
        
        var debugDescription: String {
            return "\(id): \(content) \(isFaceUp ? "up" : "down")\(isMatched ? "matched" : "")"
        }
    }
    
     
    
    
    
}
