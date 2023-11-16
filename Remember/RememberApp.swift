//
//  RememberApp.swift
//  Remember
//
//  Created by Redwan Khan on 29/10/2023.
//

import SwiftUI

@main
struct RememberApp: App {
    @StateObject var game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(viewModel: game)
        }
    }
}
