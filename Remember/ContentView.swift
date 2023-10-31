//
//  ContentView.swift
//  Remember
//
//  Created by Redwan Khan on 29/10/2023.
//

import SwiftUI //we dont always import swiftui like when working on backend,

//structs are the heart of swiftUI, they can have vars and funcs, NOT A CLASS THO so no inhereitance and stuff.
struct ContentView: View { //:View means like it behaves like a view.
    
//    var i: Int // but : Int is of type
//    var s: String
    
    var body: some View {
        
        HStack{
            CardView(isFaceUp: true)
            CardView()
            CardView()
            
            
        }
        .foregroundColor(.orange)
        .padding()

    }
}

struct CardView: View {
    var isFaceUp = false
    
    var body: some View {
        ZStack (content: {
            if isFaceUp{
                RoundedRectangle(cornerRadius: 12).foregroundColor(.white)
                RoundedRectangle(cornerRadius: 12).strokeBorder(lineWidth: 2)
                Text("👻").font(.largeTitle)
            } else {
                RoundedRectangle(cornerRadius: 12)
            }
            
        })
        .padding()
    }
}

















struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
