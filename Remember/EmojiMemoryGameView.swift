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
struct EmojiCard: Identifiable {
    let id = UUID() // this provides a unqiue identifier
    let emoji: String
}
struct EmojiMemoryGameView: View { //:View means like it behaves like a view.
    
    @ObservedObject var viewModel: EmojiMemoryGame // our butler fyi u never call a var a viewmodel
    
    
    @State private var halloweenEmojis:[EmojiCard] =
        Array(repeating: ["😈","👻","💀","🎃","👿","☠️", "🧙", "🍫","🍬","🙀","🕸", "🕷", "🍭"], count: 2)
        .joined()
        .map{ EmojiCard(emoji: $0)}
        .shuffled()
    
    @State private var faceEmojis:[EmojiCard] =
        Array(repeating: ["😂","😘","🥰","😇","😎","🤯","🤬","🤪","🙄","🥵"], count: 2)
        .joined()
        .map{EmojiCard(emoji: $0)}
        .shuffled()
    
    @State private var foodEmojis:[EmojiCard] =
        Array(repeating: ["🍔","🌭","🍕","🍤","🍗","🍿", "🥪","🥓","🥞","🍟"], count: 2)
        .joined()
        .map{EmojiCard(emoji: $0)}
        .shuffled()
    
    
    @State private var currentTheme: CardTheme = .face
     var cardsOnScreen: Int {
        switch currentTheme{
        case .halloween:
            return halloweenEmojis.count
            
        
        case .face:
            return faceEmojis.count
        case .food:
            return foodEmojis.count
        }
    }
    
    
    func changeTheme(to theme: CardTheme){
        withAnimation{
            currentTheme = theme
            //suffle the emojis for the new theme
            
            switch theme {
            case .halloween:
                halloweenEmojis.shuffle()
                //cardsOnScreen = min(cardsOnScreen, halloweenEmojis.count)
            case .face:
                faceEmojis.shuffle()
                //cardsOnScreen = min(cardsOnScreen, faceEmojis.count)
            case .food:
                foodEmojis.shuffle()
               // cardsOnScreen = min(cardsOnScreen, foodEmojis.count)
            }
        }
    }
    
    
    
    var body: some View {
        //VStack{
            ScrollView{
                Text("Memorize!").font(.largeTitle)
                themeCards
            }
        
        Button("Shuffle") {
            viewModel.shuffle()
        }
            
            Spacer()
            //cardCountAdjusters
            themeChooser
        //}
        
        .padding()
        
    }
    
    
    var themeCards: some View {
        switch currentTheme {
        case .halloween:
            return AnyView(cardGrid(for: halloweenEmojis, color: .orange))
        case .face:
            return AnyView(cardGrid(for: faceEmojis, color: .yellow))
        case .food:
            return AnyView(cardGrid(for: foodEmojis, color: .red))
        
        }
    }

    
    func cardGrid(for emojiCards: [EmojiCard], color: Color) -> some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 85), spacing: 0)], spacing: 0){
            ForEach(viewModel.cards.indices, id: \.self) { index in
                CardView(viewModel.cards[index])
                    .aspectRatio(2/3, contentMode: .fit)
                    .padding(4)
            }
        }
        .foregroundColor(color)
    }
    
    
    var themeChooser: some View {
        VStack{
            Text("Themes").font(.caption)
            HStack{
                VStack{
                    Button ("🕷") {
                        changeTheme(to: .halloween)
                    }.font(.largeTitle)
                    
                    Text("Halloween").font(.caption)
                }
                Spacer()
                
                VStack{
                    Button("😊"){
                        changeTheme(to: .face)
                    }.font(.largeTitle)
                    
                    Text("Faces").font(.caption)
                }
                
                Spacer()
                
                VStack{
                    Button("🍔"){
                        changeTheme(to: .food)
                    }.font(.largeTitle)
                    Text("Food").font(.caption)
                }
              
             
            }
        }
    }
    
    
    func themeEmojiCount() -> Int {
        switch currentTheme {
        case .halloween:
            return halloweenEmojis.count
        case .face:
            return faceEmojis.count
        case .food:
            return foodEmojis.count
        }
    }
    
    
}
    
    
    
struct CardView: View {
    
    let card: MemoryGame<String>.Card
    
    init(_ card: MemoryGame<String>.Card) {
        self.card = card
    }
    
    var body: some View { //views r read only, therefore mostly we always use let
        ZStack /*(alignment: .center, content:*/ {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(card.content).font(.system(size: 120)).minimumScaleFactor(0.01)
                    .aspectRatio(1, contentMode: .fit)
            }
            .opacity(card.isFaceUp ? 1 : 0)
            base.fill().opacity(card.isFaceUp ? 0 : 1)
            
            //                        }.onTapGesture {
            //                            card.isFaceUp.toggle()
            //                        }
        }
    }
    
    struct EmojiMemoryGameView_Previews: PreviewProvider {
        static var previews: some View {
            EmojiMemoryGameView(viewModel: EmojiMemoryGame())
        }
    }
}
