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

    var body: some View {
        VStack {
            HStack{
                Text(viewModel.themeName)
                    .font(.system(size: 24, weight: .bold, design: .rounded)) // Adjust size, weight, and design
                    .italic()
                    .foregroundColor(viewModel.themeColor)
                Spacer()
                Text("Score: \(viewModel.score)").font(.headline)
            }
          //  ScrollView {
             
                
                themeCards
          //  }
            .animation(.default, value: viewModel.cards)

//            Button("Shuffle") {
//                viewModel.shuffle()
//            }
            Button("New Game") {
                viewModel.newGame()
            }.foregroundColor(.accentColor)
            Spacer()
           // themeChooser
        }
        .padding()
    }

    
    private var themeCards: some View {
        AspectVGrid(viewModel.cards, aspectRatio: cardAspectRatio) { card in
            CardView(card: card)
                        .padding(4)
                        .onTapGesture {
                            viewModel.choose(card)
                            
                }
                       .foregroundColor(viewModel.themeColor)
            }
            
        }
        
        
    }


//    func themeDescription(theme: CardTheme) -> String {
//        switch theme {
//        case .halloween:
//            return "Halloween"
//        case .face:
//            return "Faces"
//        case .food:
//            return "Food"
//        }
//    }


struct CardView: View {
    let card: MemoryGame<String>.Card

    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(card.content).font(.system(size: 120)).minimumScaleFactor(0.01)
                    .aspectRatio(1, contentMode: .fit)
            }
            .opacity(card.isFaceUp ? 1 : 0)
            base.fill()
                .opacity(card.isFaceUp ? 0 : 1)
        }
        .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
    }
}

// Preview Provider
struct EmojiMemoryGameView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}
