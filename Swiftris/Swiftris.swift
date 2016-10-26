//
//  Swiftris.swift
//  Swiftris
//
//  Created by Robbie Merillat on 10/25/16.
//  Copyright © 2016 Robbie Merillat. All rights reserved.
//

let NumColumns = 10
let NumRows = 20

let StartingColumn = 4
let StartingRow = 0

let PreviewColumn = 12
let PreviewRow = 1

protocol SwiftrisDelegate {
    // Invoked when the current round of Swiftris ends
    
    func gameDidEnd(swiftris: Swiftris)
    
    // invoked after game has begun
    func gameDidBegin(swiftris: Swiftris)
    
    // invoked when falling shape has become part of the game board
    func gameShapeDidLand(swiftris: Swiftris)
    
    // Invoked when falling shape has changed location
    func gameShapeDidMove(swiftris: Swiftris)
    
    // Invoked when the falling shape has changed location after being dropped
    func gameShapeDidDrop(swiftris: Swiftris)
    
    // Invoked when the game has reached a new level
    func gameDidLevelUp(swiftris: Swiftris)
}

class Swiftris {
    var blockArray:Array2D<Block>
    var nextShape:Shape?
    var fallingShape:Shape?
    
    init() {
        fallingShape = nil
        nextShape = nil
        blockArray = Array2D<Block>(columns: NumColumns, rows: NumRows)
    }
    
    func beginGame() {
        if (nextShape == nil) {
            nextShape = Shape.random(startingColumn: PreviewColumn, startingRow: PreviewRow)
        }
    }
    
    func newShape() -> (fallingShape:Shape?, nextShape:Shape?) {
        fallingShape = nextShape
        nextShape = Shape.random(startingColumn: PreviewColumn, startingRow: PreviewRow)
        fallingShape?.moveTo(column: StartingColumn, row: StartingRow)
        return (fallingShape, nextShape)
    }
}
