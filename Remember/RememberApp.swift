//
//  RememberApp.swift
//  Remember
//
//  Created by Redwan Khan on 29/10/2023.
//

import SwiftUI

// entry point of the SwiftUI app
@main
struct RememberApp: App {
    //@StateObject = property wrapper for reference type
    //that conforms to the ObservableObject protocol
    //this creates an instance of EmojiMemoryGame which acts as the viewmodel
    @StateObject var game = EmojiMemoryGame()
    
    //body of app protocol; describes content and behavior of app's ui
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(viewModel: game)
        }
    }
}
