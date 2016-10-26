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
let startingRow = 0

let PrieviewColumn = 12
let PrieviewRow = 1

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
            nextShape = Shape.random(startingColumn: PrieviewColumn, startingRow: PrieviewRow)
        }
    }
    
    func newShape() -> (fallingShape:Shape?, nextShape:Shape?) {
        fallingShape = nextShape
        nextShape = Shape.random(startingColumn: PrieviewColumn, startingRow: PrieviewRow)
        fallingShape?.moveTo(column: StartingColumn, row: startingRow)
        return (fallingShape, nextShape)
    }
}
