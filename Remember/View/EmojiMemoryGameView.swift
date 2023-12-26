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
            
            if viewModel.isGameCompleted {
                Color.black.opacity(0.5).edgesIgnoringSafeArea(.all)
                VStack{
                    Text("You Win!")
                        .font(.largeTitle)
                        //.foregroundStyle(.secondary)
                    Text("Score: \(viewModel.score)")
                        .font(.title)
                        //.foregroundStyle(.secondary)
                    Button("New Game") {
                        dealt = Set<Card.ID>()
                        viewModel.newGame()
                    }.padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
                 }
             }
    
//    private var gameCompletedView: some View {
//
//    }

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
    
    @State private var isNewGameButtonPressed = false
    private var newGameButton: some View {
        Button("New Game") {
            isNewGameButtonPressed = true
            withAnimation {
                dealt = [] // clear dealt set
                viewModel.newGame()
            }
            isNewGameButtonPressed = false
            cardsFlippedAfterDeckTap = false
            
        }.foregroundColor(.accentColor)
    }
    
    private var title: some View {
        Text("Theme: "+viewModel.themeName)
            .font(.system(size: themeTitleSize, weight: .bold, design: .rounded)) // Adjust size, weight, and design
            .italic()
            .foregroundColor(viewModel.themeColor)
    }

    
    @State private var resetRotationEffect = false
    
    private var themeCards: some View {
        AspectVGrid(viewModel.cards, aspectRatio: cardAspectRatio) { card in
           
            if isDealt(card)/*, !isNewGameButtonPressed*/ {
                CardView(card)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .transition(.asymmetric(insertion: .identity, removal: .identity))
                    .padding(spacing)
               
                    .overlay(
                      cardsFlippedAfterDeckTap ? FlyingNumber(number: scoreChange(causedBy: card)) : nil
                        
                    )
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
    @State private var isDeckTapped = false
    private var deck: some View {
        ZStack {
            ForEach(undealtCards) {card in
            CardView(card)

                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .transition(.asymmetric(insertion: .identity, removal: .identity))

                
            }
        }.frame(width: deckWidth, height: 70)
            .onTapGesture{
                isDeckTapped = true
                deal()
                isDeckTapped = false
                cardsFlippedAfterDeckTap = false
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
    
   
    @State private var cardsFlippedAfterDeckTap = false
    
    
    private func flip(_ card: Card) {
        withAnimation {
        
                    let scoreBeforeChoosing = viewModel.score
                    viewModel.choose(card)
                    let scoreChange = viewModel.score - scoreBeforeChoosing
                lastScoreChange = (scoreChange, causedByCardId: card.id)
            cardsFlippedAfterDeckTap = true

                
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
   
