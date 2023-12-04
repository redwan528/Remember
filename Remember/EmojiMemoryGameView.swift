//
//  ContentView.swift
//  Remember
//
//  Created by Redwan Khan on 29/10/2023.
//

import SwiftUI

enum CardTheme {
    case halloween, face, food
}


struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame

    var body: some View {
        VStack {
            ScrollView {
                Text("Memorize!").font(.largeTitle)
                themeCards
            }
            .animation(.default, value: viewModel.cards)

            Button("Shuffle") {
                viewModel.shuffle()
            }
            Spacer()
            themeChooser
        }
        .padding()
    }

    var themeCards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 85), spacing: 0)], spacing: 0) {
            ForEach(viewModel.cards) { card in
                CardView(card: card)
                    .aspectRatio(2/3, contentMode: .fit)
                    .padding(4)
                    .onTapGesture {
                        viewModel.choose(card)
                    }
            }
        }
        .foregroundColor(viewModel.themeColor)
    }
    
    var themeChooser: some View {
        VStack {
            Text("Themes")
            HStack {
                ThemeButton(emoji: "🕷", theme: .halloween)
                Spacer()
                ThemeButton(emoji: "😊", theme: .face)
                Spacer()
                ThemeButton(emoji: "🍔", theme: .food)
            }
        }
    }

    func ThemeButton(emoji: String, theme: CardTheme) -> some View {
        VStack {
            Button {
                changeTheme(to: theme)
            } label: {
                Text(emoji).font(.largeTitle)
                    
            }
        }
    }

    func changeTheme(to theme: CardTheme) {
        withAnimation {
            viewModel.newGame(theme: theme)
        }
    }

    func themeDescription(theme: CardTheme) -> String {
        switch theme {
        case .halloween:
            return "Halloween"
        case .face:
            return "Faces"
        case .food:
            return "Food"
        }
    }
}

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
