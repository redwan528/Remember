//
//  ContentView.swift
//  Remember
//
//  Created by Redwan Khan on 29/10/2023.
//

import SwiftUI //we dont always import swiftui like when working on backend,

//structs are the heart of swiftUI, they can have vars and funcs, NOT A CLASS THO so no inhereitance and stuff.
struct ContentView: View { //:View means like it behaves like a view.
    
    let emojis = ["😈","👻","💀","🎃","👿","☠️", "🧙", "🍫","🍬","🙀","🕸", "🕷", "🍭"]

    @State var cardsOnScreen: Int = 4
    
    
    var body: some View {
        VStack{
            ScrollView{
              cards
            }
            
            Spacer()
          cardCountAdjusters
        }
    
        .padding()

    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))]){
            ForEach(0..<cardsOnScreen, id: \.self){index in
                CardView(content: emojis[index])
                    .aspectRatio(2/3,contentMode: .fit)
            }
        } .foregroundColor(.orange)
    }
    
    var cardCountAdjusters: some View {
        HStack{
            
        cardRemover
            
            Spacer()
           
           cardAdder
            
        }.imageScale(.medium)
            .font(.largeTitle)
    }
    
    func cardCountAdjuster(by offset: Int, symbol: String) -> some View{
        Button(action:{
                cardsOnScreen += offset
            
        }, label: {
                Image(systemName: symbol)
        })
        .disabled(cardsOnScreen + offset < 1 || cardsOnScreen + offset > emojis.count)
    }
    
    var cardRemover: some View {
         cardCountAdjuster(by: -1, symbol: "rectangle.stack.badge.minus.fill")
    }
    
    var cardAdder: some View {
        cardCountAdjuster(by: +1, symbol: "rectangle.stack.badge.plus.fill")
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
