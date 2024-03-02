//
//  ContentView.swift
//  Lab77
//
//  Created by IMD 224 on 2024-03-01.
//

import SwiftUI



struct ContentView: View {
    
    @StateObject var gameSettings = GameSettings()
    //Al marcar el objeto observable con @StateObject, le dices a SwiftUI que observe este objeto y actualice la vista cada vez que cambie alguna de sus propiedades @Published. Esto asegura que tu interfaz de usuario refleje siempre el estado actual de tus datos.
  
    var body: some View {
        TabView {
            SettingsView(gameSettings: gameSettings) // aca le paso a cada una de las vistas mi clase gamesetting que es observable y por eso uso el stateObject para que me refle los cambios echos en cualquier vista
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
            
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
