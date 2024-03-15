//
//  GameBoard.swift
//  Lab77
//
//  Created by IMD 224 on 2024-03-01.
//

import Foundation
import SwiftData



/// this sub class is the each  tile in the board it should identifabvle
class Tile: Identifiable {
    /// this id allows to identify each tile as unique so we can add custom features for each tile
    var id = UUID()
    /// this  allows to put a label or a name for each tile
    var item: String?
    
    /// My initializator allows to access to the property
    /// - Parameter item: this parameter is basically the label o the name of each Tile
    init(item: String?) {
        self.item = item
    }
}



/// this class allows to manage the way that we want to show the Tiles it basically a template
class Board {
    /// this varibale determine de size of my grid
    let boardSize: Int
    /// this bidimencional array have as data type  my sub class tile
    var tiles: [[Tile]]
    
    /// mi initializator allows to pass mi size and iterate over that int to fill the array.
    /// - Parameter boardSize: it would be the size indeed of my grid
    init(boardSize: Int) {
        self.boardSize = boardSize
        tiles = [[Tile]]()
        
        for _ in 0...boardSize {
            var tileRow = [Tile]()
            for _ in 0...boardSize {
                tileRow.append(Tile(item: nil))
            }
            tiles.append(tileRow)
        }
    }
}

