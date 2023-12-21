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
    @ObservedObject var viewModel: EmojiMemoryGame
    private let cardAspectRatio: CGFloat = 2/3
    private let spacing: CGFloat = 4
    private let themeTitleSize:CGFloat = 24

    var body: some View {
        VStack {
            HStack{
                Text(viewModel.themeName)
                    .font(.system(size: themeTitleSize, weight: .bold, design: .rounded)) // Adjust size, weight, and design
                    .italic()
                    .foregroundColor(viewModel.themeColor)
                Spacer()
                Text("Score: \(viewModel.score)").font(.headline)
            }

                themeCards
      
            .animation(.default, value: viewModel.cards)

            Button("New Game") {
                viewModel.newGame()
            }.foregroundColor(.accentColor)
            Spacer()
        }
        .padding()
    }

    
    private var themeCards: some View {
        AspectVGrid(viewModel.cards, aspectRatio: cardAspectRatio) { card in
            CardView(card)
                        .padding(spacing)
                        .onTapGesture {
                          //  withAnimation(.easeInOut(duration: 3)){
                                viewModel.choose(card)

                          //  }
                            
                }
                       .foregroundColor(viewModel.themeColor)
            }
            
        }
        
        
    }

// Preview Provider
struct EmojiMemoryGameView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}
