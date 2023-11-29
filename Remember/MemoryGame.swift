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
    }
    
   // var indexOfTheOneAndOnlyFaceUpCard: Int? {
//        get {
//            var faceUpCardIndicies = [Int]()
//            for index in cards.indices {
//                if cards[index].isFaceUp {
//                    faceUpCardIndicies.append(index)
//                }
//            }
//            if faceUpCardIndicies.count == 1 {
//                return faceUpCardIndicies.first
//            } else {
//                return nil
//            }
//        } set {
//            for index in cards.indices {
//                if index == newValue {
//                    cards[index].isFaceUp = true
//                    
//                } else{
//                    cards[index].isFaceUp = false
//                }
//            }
//        }
        //look how much code the get and set is, this is because we did not use functional programming here, we just used brute force using for loops and if statements. Let's rewrite the get set code using functinoal programming below:
        
        //FIXME: fix me later
//        get {
//            var faceUpCardIndicies = cards.indices.filter 
//            {
//                index in cards[index].isFaceUp
//                
//            }
//        } set{
//            
//        }
        
        
    //}
    
    mutating func choose(_ card: Card){
        if let chosenIndex = cards.firstIndex(where: {$0.id == card.id}) {
            if !cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatched {
                if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                    if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                        cards[chosenIndex].isMatched = true
                        cards[potentialMatchIndex].isMatched = true
                    }
                    //the two commented out code below is not needed because of the get and set of the indexOfTheOneAndOnlyFaceUpCard var
                    
                   // indexOfTheOneAndOnlyFaceUpCard = nil
                }
                else {
//                        for index in cards.indices {
//                            cards[index].isFaceUp = false
//                        }
                        indexOfTheOneAndOnlyFaceUpCard = chosenIndex
                    }
                    cards[chosenIndex].isFaceUp = true
                    
                
                
            }
            
//cards[chosenIndex].isFaceUp.toggle()
}
        }
                                               
    
    
    //below code is not needed because functions as arguments above
//    private func index(of card: Card) -> Int? {
//        for index in cards.indices {
//            if cads[index].id == card.id {
//                return index
//            }
//        }
//        return nil
//    }
    
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
        
        var isFaceUp = false
        var isMatched = false
        let content: CardContent //let cuz content stays same on card no matter what
        
        
        var id: String //dont care as long as its hashable
        
        var debugDescription: String {
            return "\(id): \(content) \(isFaceUp ? "up" : "down")\(isMatched ? "matched" : "")"
        }
    }
    
     
    
    
    
}
