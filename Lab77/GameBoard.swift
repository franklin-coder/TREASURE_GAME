//
//  GameBoard.swift
//  Lab77
//
//  Created by IMD 224 on 2024-03-01.
//

import Foundation
import SwiftData


class Tile: Identifiable {
    var id = UUID()
    var item: String?
    var isRevealed: Bool = false


    init(item: String?) {
        self.item = item
    }
}

class Board {
    let boardSize: Int
    var tiles: [[Tile]]

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

