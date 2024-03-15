//
//  GameView.swift
//  Lab77
//
//  Created by IMD 224 on 2024-03-01.
//

import SwiftUI


/// thie view shows and control de game grid images game over, attempts and matches
struct GameView: View {
    
    /// here it is getting all the data from Gamesetting and storaging in this variable to be able to access to the properties and funtionality
    @ObservedObject var gameSettings: GameSettings
    /// here it is getting all the data from Board Class and storaging in this variable to be able to access to the properties and funtionality
    @State private var board: Board
    /// this is a bidimentional array starting empty and using as a datatype my struct GameImage with all the properties
    @State private var gameImages: [[GameImage]] = []
    
    /// here I create a new initializer passing as parametre my GameSettings with the idea to include my board and the variable gridsize from my gamesettings and assign to the boardsize in my instance of the clase
    /// - Parameter gameSettings: GameSetting has the total items thats why i need to pass as parameter
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
                /// here it is painting the grid using the variable BoardSize that contain all my items
                ForEach(0..<board.boardSize, id: \.self) { row in
                    HStack {
                        ForEach(0..<board.boardSize, id: \.self) { column in
                            ///here it is avoiding to be ourt of the range
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
    
    
    /// this function allows to put all my images andy the empty array gameImages to fill it up
    func setupGame() {
        /// here im reseting the game on appears every time
        gameSettings.resetGame()
        
        
        let rowCount = board.boardSize
        /// Initialize gameImages with placeholders.
        gameImages = Array(repeating: Array(repeating: GameImage(name: "house"), count: rowCount), count: rowCount)

        /// Prepare the images by type.
        let selections = [("cat", gameSettings.numberOfCats), ("dog", gameSettings.numberOfDogs), ("circle", gameSettings.numberOfCircles)]
        for (type, count) in selections {
            placeImagesOfType(type, count: count, in: rowCount)
        }
    }

    
    
    
    
    func placeImagesOfType(_ type: String, count: Int, in rowCount: Int) {
        var placed = false
        
        // Asegúrate de que rowCount sea al menos 2 para evitar un rango inválido
        guard rowCount >= 2 else { return }
        
        while !placed {
            let inRow = Bool.random()
            let lineIndex = Int.random(in: 0..<rowCount) // Ahora rowCount es al menos 2
            
            var availableSpots: [Int] = Array(0..<rowCount)
            for i in 0..<rowCount {
                let image = inRow ? gameImages[lineIndex][i] : gameImages[i][lineIndex]
                if image.name != "house" {
                    availableSpots.removeAll { $0 == i }
                }
            }
            
            // Verifica si hay espacio suficiente para colocar las imágenes
            if availableSpots.count >= count {
                if let start = availableSpots.randomElement(), start + count <= rowCount {
                    for i in start..<start + count {
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



    
    
    /// this fuction allows to change to true the variable isRevealed that mean it will show the image
    /// - Parameters:
    ///   - row: the current row that has the image has this is coming from tapGesture passing the same row that the image has
    ///   - column: the current column that has the image has this is coming from tapGesture passing the same column that the image has
    ///   also this function increasi the number of attempt every tapGesture and call the funcion game over every time to check is the game has ended, addictionally is checking is the image is different to the default it will increase the matches found
    func revealImage(atRow row: Int, column: Int) {
        let image = gameImages[row][column]
        if !image.isRevealed {
            gameImages[row][column].isRevealed = true
            gameSettings.attempts += 1
            //
            // Si la imagen revelada no es la default, aumenta remains
                  if image.name != "house" {
                      gameSettings.remains += 1
                  }
                  
            checkGameOver()
        }
    }
     
    
    
    
    /// esta funcion me permite crear un diccionario y luego iterar por cada fila y cada columna para checkear las imagenes que han sido reveladas luego valido si las cantidfades de cada type son iguales a las que temngo en mi gamesettings que toma los valores totales de mis steeper por type  y valido si la cantidad es igual en cada type quiere decir que ya encontro todos los tesoros
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



