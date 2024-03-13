//
//  GameView.swift
//  Lab77
//
//  Created by IMD 224 on 2024-03-01.
//

import SwiftUI

struct GameView: View {
    @ObservedObject var gameSettings: GameSettings
    @State private var board: Board
    
    @State private var gameImages: [[GameImage]] = []
    
    init(gameSettings: GameSettings) {
            self.gameSettings = gameSettings
            // Asumiendo que tienes una manera de determinar el tamaño del tablero basado en gameSettings
            let boardSize = gameSettings.gridSize // Determina el tamaño del tablero aquí
            self._board = State(initialValue: Board(boardSize: boardSize))
           
        }
        
    
    var body: some View {
        GeometryReader{ geometry in
            
            ScrollView{
                VStack {
                    Text("Attempts: \(gameSettings.attempts)")
                    Text("Matches Found: \(gameSettings.remains)")
                    if gameSettings.isGameOver {
                        Text("Game Over!").font(.headline)
                    }
                }
                // Crear la cuadrícula de imágenes
                ForEach(0..<board.boardSize, id: \.self) { row in
                    HStack {
                        ForEach(0..<board.boardSize, id: \.self) { column in
                            if row < gameImages.count && column < gameImages[row].count {
                                let gameImage = gameImages[row][column]
                                Image(systemName: gameImage.isRevealed ? "\(gameImage.name).fill" : "questionmark.circle")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: geometry.size.width / CGFloat(board.boardSize), height: geometry.size.width / CGFloat(board.boardSize))
                                    .onTapGesture {
                                        revealImage(atRow: row, column: column)
                                    }
                            }
                        }
                    }
                }
                
            }
            .onAppear(){
                setupGame()
            }
        }
    }
    
    
    func setupGame() {
        let rowCount = board.boardSize
        // Inicializa gameImages con placeholders
        gameImages = Array(repeating: Array(repeating: GameImage(name: "house"), count: rowCount), count: rowCount)

        // Prepara las imágenes por tipo
        let selections = [("cat", gameSettings.numberOfCats), ("dog", gameSettings.numberOfDogs), ("circle", gameSettings.numberOfCircles)]
        for (type, count) in selections {
            placeImagesOfType(type, count: count, in: rowCount)
        }
    }

    func placeImagesOfType(_ type: String, count: Int, in rowCount: Int) {
        var placed = false
        while !placed {
            // Decide si el grupo estará en una fila o columna de manera aleatoria
            let inRow = Bool.random()
            let lineIndex = Int.random(in: 0..<rowCount)

            // Encuentra espacios disponibles
            var availableSpots: [Int] = Array(0..<rowCount)
            for i in 0..<rowCount {
                let image = inRow ? gameImages[lineIndex][i] : gameImages[i][lineIndex]
                if image.name != "house" {
                    availableSpots.removeAll { $0 == i }
                }
            }

            // Verifica si hay espacio suficiente en la fila/columna elegida
            if availableSpots.count >= count {
                let start = availableSpots.randomElement()!
                let end = start + count <= rowCount ? start + count : start
                if end > start {
                    for i in start..<end {
                        if inRow {
                            gameImages[lineIndex][i] = GameImage(name: type)
                        } else {
                            gameImages[i][lineIndex] = GameImage(name: type)
                        }
                    }
                    placed = true
                }
            }
        }
    }


    
    
    func revealImage(atRow row: Int, column: Int) {
        let image = gameImages[row][column]
        if !image.isRevealed {
            gameImages[row][column].isRevealed = true
            gameSettings.attempts += 1
            //
            
            checkGameOver()
        }
    }
     
    
    
    
    func checkGameOver() {
        var counts = [String: Int]()
        
        // Itera sobre cada fila y luego sobre cada columna del array bidimensional
        for row in gameImages {
            for image in row {
                if image.isRevealed {
                    counts[image.name, default: 0] += 1
                }
            }
        }
        
        
        // Verifica si se han encontrado las cantidades necesarias de cada tipo
        let catsFound = counts["cat", default: 0] >= gameSettings.numberOfCats
        let dogsFound = counts["dog", default: 0] >= gameSettings.numberOfDogs
        let circlesFound = counts["circle", default: 0] >= gameSettings.numberOfCircles
        
        // El juego termina solo si se han encontrado las cantidades necesarias de cada tipo seleccionado
        gameSettings.isGameOver = catsFound && dogsFound && circlesFound
        
        // Esto actualizará la interfaz de usuario automáticamente para mostrar "Game Over" si la condición es verdadera
    }
    
    
    
}//final body


//#Preview {
//    GameView(gameSettings: gameSettings)
//}
