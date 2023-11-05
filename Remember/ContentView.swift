//
//  ContentView.swift
//  Remember
//
//  Created by Redwan Khan on 29/10/2023.
//

import SwiftUI //we dont always import swiftui like when working on backend,

//structs are the heart of swiftUI, they can have vars and funcs, NOT A CLASS THO so no inhereitance and stuff.

enum CardTheme {
    case halloween, face, food
}
struct EmojiCard: Identifiable {
    let id = UUID() // this provides a unqiue identifier
    let emoji: String
}
struct ContentView: View { //:View means like it behaves like a view.
    
    @State private var halloweenEmojis:[EmojiCard] =
    Array(repeating: ["😈","👻","💀","🎃","👿","☠️", "🧙", "🍫","🍬","🙀","🕸", "🕷", "🍭"], count: 2).joined()
        .map{ EmojiCard(emoji: $0)}
        .shuffled()
    
    @State private var faceEmojis = Array(repeating: ["😂","😘","🥰","😇","😎","🤯","🤬","🤪","🙄","🥵"], count: 2)
        .joined()
        .map{EmojiCard(emoji: $0)}
        .shuffled()
    
    @State private var foodEmojis = Array(repeating: ["🍔","🌭","🍕","🍤","🍗","🍿", "🥪","🥓","🥞"], count: 2)
        .joined().map{EmojiCard(emoji: $0)}.shuffled()
    
    
    @State private var currentTheme: CardTheme = .face
    @State var cardsOnScreen: Int = 4
    //@State private var shuffledEmojis:[String] = []
    
    
    func changeTheme(to theme: CardTheme){
        withAnimation{
            currentTheme = theme
            //suffle the emojis for the new theme
            
            switch theme {
            case .halloween:
                halloweenEmojis.shuffle()
                cardsOnScreen = min(cardsOnScreen, halloweenEmojis.count)
            case .face:
                faceEmojis.shuffle()
                cardsOnScreen = min(cardsOnScreen, faceEmojis.count)
            case .food:
                foodEmojis.shuffle()
                cardsOnScreen = min(cardsOnScreen, foodEmojis.count)
            }
        }
    }
    
    
    
    var body: some View {
        VStack{
            ScrollView{
                Text("Memorize!").font(.largeTitle)
                themeCards
            }
            
            Spacer()
            cardCountAdjusters
            themeChooser
        }
        
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
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))]){
            ForEach(emojiCards[0..<cardsOnScreen]) { emojiCard in
                CardView(content: emojiCard.emoji)
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundColor(color)
    }
    
    
    var themeChooser: some View {
        HStack{
            Button("halloween"){
                changeTheme(to: .halloween)
            }
            Button("face"){
                changeTheme(to: .face)
            }
            Button("food"){
                changeTheme(to: .food)
            }
        }
    }
    
    
    var cardCountAdjusters: some View {
        HStack{
            cardRemover
            Spacer()
            cardAdder
        }.imageScale(.medium)
            .font(.largeTitle)
    }
    
    var cardRemover: some View {
        cardCountAdjuster(by: -1, symbol: "rectangle.stack.badge.minus.fill")
    }
    
    var cardAdder: some View {
        cardCountAdjuster(by: +1, symbol: "rectangle.stack.badge.plus.fill")
    }
    
    
    func cardCountAdjuster(by offset: Int, symbol: String) -> some View{
        Button(action:{
            if offset > 0 {
                let themeCount =  themeEmojiCount()
                if cardsOnScreen < themeCount{
                    cardsOnScreen += offset
                }
            } else {
                cardsOnScreen += offset
                
            }
            
            
        }, label: {
            Image(systemName: symbol)
        })
        .disabled(cardsOnScreen + offset < 1 || cardsOnScreen + offset > themeEmojiCount())
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
        //if u have a var in any struct, that has no value, thats not allowed. therefore u need default values for vars in struct
        let content: String
        @State var isFaceUp = true
        
        var body: some View { //views r read only, therefore mostly we always use let
            ZStack /*(alignment: .center, content:*/ {
                let base = RoundedRectangle(cornerRadius: 12)
                Group {
                    base.fill(.white)
                    base.strokeBorder(lineWidth: 2)
                    Text(content).font(.largeTitle)
                }
                .opacity(isFaceUp ? 1 : 0)
                base.fill().opacity(isFaceUp ? 0 : 1)
                
            }.onTapGesture {
                isFaceUp.toggle()
            }
        }
    }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
