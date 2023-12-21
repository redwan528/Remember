//
//  CardView.swift
//  Remember
//
//  Created by Redwan Khan on 12/18/23.
//

import SwiftUI

struct CardView: View {
    typealias Card = MemoryGame<String>.Card
    let card: Card
    
    
    init(_ card: MemoryGame<String>.Card) {
        self.card = card
    }
    
    var body: some View {
        //        ZStack {
        //            let base = RoundedRectangle(cornerRadius: Constants.cornerRadius)
        //            Group {
        //                base.fill(.white)
        //                base.strokeBorder(lineWidth: Constants.lineWidth)
        Pie(endAngle: .degrees(240))
            .opacity(Constants.Pie.opacity)
        
            .overlay (
                Text(card.content)
                    .font(.system(size: Constants.FontSize.largest))
                    .minimumScaleFactor(Constants.FontSize.scaleFactor)
                    .multilineTextAlignment(.center)
                    .aspectRatio(1, contentMode: .fit)
                    .padding(Constants.Pie.inset)
                
            )
            .padding(Constants.inset)
            .rotationEffect(.degrees(card.isMatched ? 360 : 0))
            .animation(.spin(duration: 1),
                value: card.isMatched)
        //            }
        //           .opacity(card.isFaceUp ? 1 : 0)
        //            base.fill()
        //                .opacity(card.isFaceUp ? 0 : 1)
        //        }
            .cardify(isFaceUp: card.isFaceUp)
            .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
        //}
    }
    
    
    
    private struct Constants {
        
        static let inset: CGFloat = 5
        
        struct FontSize {
            static let largest: CGFloat = 200
            static let smallest: CGFloat = 10
            static let scaleFactor = smallest / largest
        }
        
        struct Pie {
            static let opacity: CGFloat = 0.3
            static let inset: CGFloat = 10
        }
    }
}
    
    extension Animation {
        static func spin(duration: TimeInterval) -> Animation {
            .linear(duration: 1)
            .repeatForever(autoreverses: false)
        }
    }
    
    struct CardView_Previews: PreviewProvider{
        
        typealias Card = CardView.Card
        static var previews: some View {
            VStack{
                HStack {
                    CardView(Card(isFaceUp: true, content: "X", id: "test1"))
                        .aspectRatio(4/3, contentMode: .fit)
                    CardView(Card(content: "X", id: "test1"))
                }
                
                HStack {
                    CardView(Card(isFaceUp: true, content: "this is a very long string and i hope this fits ", id: "test1"))
                    CardView(Card(isMatched: true, content: "X", id: "test1"))
                }
            }
            
            .padding()
            .foregroundColor(.pink)
        }
        
    }

