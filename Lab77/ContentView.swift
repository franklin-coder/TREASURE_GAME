//
//  ContentView.swift
//  Lab77
//
//  Created by IMD 224 on 2024-03-01.
//

import SwiftUI



struct ContentView: View {
    
    
    
    
    /// @StateObject means that everytime that a published property change is going to notify that change to the gamesettings
    @StateObject var gameSettings = GameSettings()
       
    
    
    /// tableView allows to have diferentes view using a bar on the botton of the screen
    var body: some View {
        TabView {
            /// call my view and pass as parameter the variable that have my gamesettings
            SettingsView(gameSettings: gameSettings)
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
            /// call my view and pass as parameter the variable that have my gamesettings
            GameView(gameSettings: gameSettings) // aca le paso a cada una de las vistas mi clase gamesetting que es observable y por eso uso el stateObject para que me refle los cambios echos en cualquier vista
                .tabItem {
                    Label("Settings", systemImage: "house")
                }
        }
    }
}

//#Preview {
//    ContentView( board: board)
//}
