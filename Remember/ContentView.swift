//
//  ContentView.swift
//  Remember
//
//  Created by Redwan Khan on 29/10/2023.
//

import SwiftUI //we dont always import swiftui like when working on backend,

//structs are the heart of swiftUI, they can have vars and funcs, NOT A CLASS THO so no inhereitance and stuff.
struct ContentView: View { //:View means like it behaves like a view.
    
    let emojis = ["😈","👻","💀","🎃","👿","☠️"]

    @State var cardsOnScreen: Int = 6
    
    var body: some View {
        VStack{
            HStack{
                ForEach(0..<cardsOnScreen, id: \.self){index in
                    CardView(content: emojis[index])
                }
                
                
                
            }
        }
       
        .foregroundColor(.orange)
        .padding()

    }
}

struct CardView: View {
//if u have a var in any struct, that has no value, thats not allowed. therefore u need default values for vars in struct
    let content: String
    @State var isFaceUp = true
    
    var body: some View { //views r read only, therefore mostly we always use let
        ZStack /*(alignment: .center, content:*/ {
            let base = RoundedRectangle(cornerRadius: 12)
            if isFaceUp {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            } else {
                base.fill()
            }
            
        }.onTapGesture {
            print("tapped")
        }
    }
}

















struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
