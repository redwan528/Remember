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
                    cards[chosenIndex].animateRotation = true
                    cards[potentialMatchIndex].animateRotation = true
                    score += 6 + cards[chosenIndex].bonus + cards[potentialMatchIndex].bonus
                } else {
                    // Mismatch
                     if cards[chosenIndex].hasBeenSeen { score -= 1 }
                    
                    //if cards[potentialMatchIndex].hasBeenSeen { score = 0 + score }
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
    
    mutating func resetCardAnimations(){
        for index in cards.indices {
            cards[index].animateRotation = false
        }
    }
    
    
    struct Card: Equatable, Identifiable, CustomDebugStringConvertible {
        var animateRotation = false
        
        
        var isFaceUp = false {
            didSet {
                if isFaceUp {startUsingBonusTime()}
                else{stopUsingBonusTime()}
                
                if oldValue && !isFaceUp {hasBeenSeen = true}
            }
        }
        
        var isMatched = false {
            didSet {
                if isMatched {
                    stopUsingBonusTime()
                }
            }
            
        }
        let content: CardContent //let cuz content stays same on card no matter what
        var hasBeenSeen = false
        
        var id: String //dont care as long as its hashable
        
        var debugDescription: String {
            return "\(id): \(content) \(isFaceUp ? "up" : "down")\(isMatched ? "matched" : "")"
        }
        
        // MARK: - Bonus Time
        
        //call when card transitions to face up state
        private mutating func startUsingBonusTime(){
            if isFaceUp, //&&
                !isMatched, //&&
                bonusPercentRemaining > 0,
                lastFaceUpDate == nil {
                    lastFaceUpDate = Date()
            }
        }
        
        //call when card goes back face down or gets matched
        private mutating func stopUsingBonusTime(){
            pastFaceUpTime = faceUpTime
            lastFaceUpDate = nil
        }
        
        //bonus points one point for every second bonusTimeLimit that was not used
        // this gets smaller and smaller longer card remains face up without matching
        var bonus: Int {
            Int(bonusTimeLimit * bonusPercentRemaining)
        }
        
        var bonusPercentRemaining: Double {
            bonusTimeLimit > 0 ? max(0, bonusTimeLimit - faceUpTime)/bonusTimeLimit : 0
        }
        
        var faceUpTime: TimeInterval {
            if let lastFaceUpDate {
                return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
            } else {return pastFaceUpTime}
        }
        
        
        var pastFaceUpTime: TimeInterval = 0
        
        //bonus points till time reaches 0
        var bonusTimeLimit: TimeInterval = 6
        
            //last time card was flipped up
        var lastFaceUpDate: Date?
        
        
       
    }
    
}

extension Array {
    var only: Element? {
        //Element? is the dont care for Array
        count == 1 ? first : nil //if count ==1 then first otherwise nil
    }
}
