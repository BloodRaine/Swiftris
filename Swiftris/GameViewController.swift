//
//  GameViewController.swift
//  Swiftris
//
//  Created by Robbie Merillat on 10/25/16.
//  Copyright © 2016 Robbie Merillat. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    var scene: GameScene!
    var swiftris:Swiftris!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // configure the view
        let skView = view as! SKView
        skView.isMultipleTouchEnabled = false
        
        // create the config scene
        scene = GameScene(size: skView.bounds.size)
        scene.scaleMode = .aspectFill
        
        scene.tick = didTick
        
        swiftris = Swiftris()
        swiftris.beginGame()
        
        // Present the scene
        skView.presentScene(scene)
        
        scene.addPreviewShapeToScene(shape: swiftris.nextShape!) {
            self.swiftris.nextShape?.moveTo(column: StartingColumn, row: startingRow)
            self.scene.movePreviewShape(shape: self.swiftris.nextShape!) {
                let nextShapes = self.swiftris.newShape()
                self.scene.startTicking()
                self.scene.addPreviewShapeToScene(shape: nextShapes.nextShape!) {}
            }
        }
        
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func didTick() {
        swiftris.fallingShape?.lowerShapeByOneRow()
        scene.redrawShape(shape: swiftris.fallingShape!, completion: {})
    }
}
