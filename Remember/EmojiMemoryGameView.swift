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

    var body: some View {
        VStack {
            HStack{ title; Spacer(); score }
                themeCards
            newGameButton
            Spacer()
        }
        .padding()
    }
    
    private var score: some View {
        Text("Score: \(viewModel.score)")
            .font(.headline)
            .animation(nil)

    }
    private var newGameButton: some View {
        Button("New Game") {
            viewModel.newGame()
        }.foregroundColor(.accentColor)
    }
    
    private var title: some View {
        Text(viewModel.themeName)
            .font(.system(size: themeTitleSize, weight: .bold, design: .rounded)) // Adjust size, weight, and design
            .italic()
            .foregroundColor(viewModel.themeColor)
    }

    
    private var themeCards: some View {
        AspectVGrid(viewModel.cards, aspectRatio: cardAspectRatio) { card in
            CardView(card)
                .padding(spacing)
                .overlay(FlyingNumber(number: scoreChange(causedBy: card)))
                .zIndex(scoreChange(causedBy: card) != 0 ? 1 : 0) // prevents score number from going behind card
                .onTapGesture {
                       flip(card)
                }
                       .foregroundColor(viewModel.themeColor)
            }
        
        //.animation(.default, value: viewModel.cards)
        
       
            
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
   
