//
//  ContentView.swift
//  Remember
//
//  Created by Redwan Khan on 29/10/2023.
//
import SwiftUI

enum CardTheme: CaseIterable {
    case halloween, face, food
}

struct EmojiMemoryGameView: View {
    
    typealias Card = MemoryGame<String>.Card
    
    @ObservedObject var viewModel: EmojiMemoryGame
    
    private let cardAspectRatio: CGFloat = 2/3
    private let spacing: CGFloat = 4
    private let themeTitleSize:CGFloat = 24
    private let dealInterval: TimeInterval = 0.1
    private let dealAnimation: Animation = .easeInOut(duration: 1)
    private let deckWidth: CGFloat = 50

    var body: some View {
        ZStack {
            VStack {
                HStack{ title; Spacer(); score }
                Spacer()
                themeCards
                // HStack{
                
                deck.foregroundColor(viewModel.themeColor)
                Spacer()
                newGameButton
                
                //  }
                
                Spacer()
            }
            .padding()
            
            if undealtCards.count == viewModel.cards.count {
                dealCardsText

                     }
                 }
             }

    private var dealCardsText: some View {
        Text("Tap below to deal cards")
            .font(.system(size: 24, weight: .bold, design: .rounded))
            .multilineTextAlignment(.center)
            .padding()
            .background(Color.white.opacity(0))
            .cornerRadius(10)
            //.foregroundColor(.accentColor)
            .scaleEffect(1.2)
            .offset(y: animatedState ? -10 : 10)
            .onAppear {
                withAnimation(Animation.easeInOut(duration: 1.5).repeatForever(autoreverses: true)) {
                    animatedState.toggle()
                }
            }
    }

    @State private var animatedState = false

    
    
    
    
    private var score: some View {
        Text("Score: \(viewModel.score)")
            .font(.headline)
           // .animation(nil)

    }
    private var newGameButton: some View {
        Button("New Game") {
            withAnimation {
                dealt = [] // clear dealt set
                viewModel.newGame()
            }
            
        }.foregroundColor(.accentColor)
    }
    
    private var title: some View {
        Text("Theme: "+viewModel.themeName)
            .font(.system(size: themeTitleSize, weight: .bold, design: .rounded)) // Adjust size, weight, and design
            .italic()
            .foregroundColor(viewModel.themeColor)
    }

    
    private var themeCards: some View {
        AspectVGrid(viewModel.cards, aspectRatio: cardAspectRatio) { card in
           
            if isDealt(card) {
                CardView(card)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .transition(.asymmetric(insertion: .identity, removal: .identity))
                    .padding(spacing)
                    .overlay(FlyingNumber(number: scoreChange(causedBy: card)))
                    .zIndex(scoreChange(causedBy: card) != 0 ? 1 : 0) // prevents score number from going behind card
                    .onTapGesture {
                           flip(card)
                    }.foregroundColor(viewModel.themeColor)

            }
                       
            }
      
        
        }
    
    @State private var dealt = Set<Card.ID>()
    
    private func isDealt(_ card: Card) -> Bool {
        dealt.contains(card.id)
    }
    private var undealtCards: [Card] {
        viewModel.cards.filter{ !isDealt($0)}
    }
    
    @Namespace private var dealingNamespace
    private var deck: some View {
        ZStack {
            ForEach(undealtCards) {card in
            CardView(card)

                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .transition(.asymmetric(insertion: .identity, removal: .identity))

                
            }
        }.frame(width: deckWidth, height: 70)
            .onTapGesture{
                deal()
            }
    }
    
        // @State private var showDealCardsText = true
    
    private func deal() {
        
//        withAnimation {
//            showDealCardsText = false
//        }
//        
        var delayTimer: TimeInterval = 0
        for card in viewModel.cards {
            withAnimation(dealAnimation.delay(delayTimer)) {
               _ = dealt.insert(card.id)
         
        }
            delayTimer += dealInterval
        }
    }
    
   
    
    
    
    private func flip(_ card: Card) {
        withAnimation {
        
                    let scoreBeforeChoosing = viewModel.score
                    viewModel.choose(card)
                    let scoreChange = viewModel.score - scoreBeforeChoosing
                lastScoreChange = (scoreChange, causedByCardId: card.id)

                
        }
    }
    
    //type tuple
    @State private var lastScoreChange = (0, causedByCardId: "")
    
    private func scoreChange(causedBy card: Card) -> Int {
        let (amount, id) = lastScoreChange
        return card.id == id ? amount : 0
    }
    
    }


#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
   
