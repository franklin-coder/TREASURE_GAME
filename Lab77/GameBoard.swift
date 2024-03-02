//
//  GameBoard.swift
//  Lab77
//
//  Created by IMD 224 on 2024-03-01.
//

import Foundation

class Tile: Identifiable {
    var id = UUID()
    var item: String?
    var isRevealed: Bool = false
    var revealDirection: Direction? = nil

    enum Direction {
        case up, down, left, right
    }

    init(item: String?) {
        self.item = item
    }
}

class Board {
    let boardSize: Int
    var tiles: [[Tile]]

    init(boardSize: Int) {
        self.boardSize = boardSize
        self.tiles = Array(repeating: Array(repeating: Tile(item: nil), count: boardSize), count: boardSize)
    }

    func setup(with items: [(String, Int)]) {
        var flatItems: [Tile] = []
        items.forEach { item, count in
            flatItems += Array(repeating: Tile(item: item), count: count)
        }
        flatItems.shuffle()

        var index = 0
        for row in 0..<boardSize {
            for column in 0..<boardSize {
                if index < flatItems.count {
                    tiles[row][column] = flatItems[index]
                    index += 1
                }
            }
        }
    }
}
