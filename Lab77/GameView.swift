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
        let rowCount = board.boardSize // mismo size of
        var positions = [(Int, Int)]()
        for row in 0..<rowCount {
            for column in 0..<rowCount {
                positions.append((row, column))
            }
        }
        
        var flatImages: [GameImage] = []
        let selections = [("cat", gameSettings.numberOfCats), ("dog", gameSettings.numberOfDogs), ("circle", gameSettings.numberOfCircles)]
        for (type, count) in selections {
            for _ in 0..<count {
                flatImages.append(GameImage(name: type))
            }
        }
        
        // Mezcla las imágenes planas para asegurar aleatoriedad en la selección de imágenes
        flatImages.shuffle()

        // Inicializa gameImages con espacios vacíos o placeholders
        gameImages = Array(repeating: Array(repeating: GameImage(name: "placeholder"), count: rowCount), count: rowCount)
        
        // Asigna imágenes a posiciones aleatorias
        for image in flatImages {
            if let randomIndex = positions.indices.randomElement() {
                let position = positions.remove(at: randomIndex)
                gameImages[position.0][position.1] = image
            }
        }
    }
 
    
    func revealImage(atRow row: Int, column: Int) {
        let image = gameImages[row][column]
        if !image.isRevealed {
            // Revela la imagen
            gameImages[row][column].isRevealed = true
            gameSettings.attempts += 1

            // Verifica si es la primera imagen de este tipo en ser revelada
            if gameSettings.revealDirection[image.name] == nil {
                // Decide una dirección. Ejemplo: siempre a la derecha
                gameSettings.setRevealDirection(for: image.name, direction: .right)

                // Aplica la lógica para revelar imágenes del mismo tipo en la dirección determinada
               // revealSameTypeImages(fromRow: row, column: column, type: image.name)
            }

           checkGameOver()
        }
    }
    
    
    func revealSameTypeImages(fromRow row: Int, column: Int, type: String) {
        guard let direction = gameSettings.revealDirection[type] else { return }

        let offsets: [(row: Int, column: Int)] = directionOffsets(for: direction)
        for offset in offsets {
            let newRow = row + offset.row
            let newColumn = column + offset.column

            // Asegúrate de que la nueva posición esté dentro de los límites de la cuadrícula
            if newRow >= 0, newRow < board.boardSize, newColumn >= 0, newColumn < board.boardSize,
               gameImages[newRow][newColumn].name == type, !gameImages[newRow][newColumn].isRevealed {
                gameImages[newRow][newColumn].isRevealed = true
                // Opcionalmente, repite el proceso recursivamente para revelar en cadena
                // revealSameTypeImages(fromRow: newRow, column: newColumn, type: type)
            }
        }
    }
    
    func directionOffsets(for direction: GameSettings.Direction) -> [(row: Int, column: Int)] {
        switch direction {
        case .right:
            return [(0, 1)]
        case .left:
            return [(0, -1)]
        case .up:
            return [(-1, 0)]
        case .down:
            return [(1, 0)]
        }
    }

    func isFirstOfTypeRevealed(type: String) -> Bool {
        return gameImages.flatMap { $0 }.contains(where: { $0.name == type && $0.isFirstRevealed })
    }

    func updateDirectionForAll(ofType type: String, direction: String) {
        for row in 0..<gameImages.count {
            for column in 0..<gameImages[row].count {
                if gameImages[row][column].name == type {
                    // Aquí, en lugar de "direction", podrías ajustar una propiedad real que afecte la UI
                    // Por ejemplo, ajustar la alineación de las imágenes o su rotación
                }
            }
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

        // No necesitamos dividir por 2 ya que estamos interesados en la cantidad total revelada, no en pares
       // matchesFound = counts.values.reduce(0, +)

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
