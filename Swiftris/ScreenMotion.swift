//
//  ScreenMotion.swift
//  Swiftris
//
//  Created by Robbie Merillat on 11/9/16.
//  Copyright © 2016 Robbie Merillat. All rights reserved.
//

import UIKit
import CoreMotion

class ScreenMotion: UIView {
    
    private var animator: UIDynamicAnimator!
    private let gravityBehavior = UIGravityBehavior()
    private let colliderBehavior = UICollisionBehavior()
    private let elasticBehavior = UIDynamicItemBehavior()
    
    public var elastic = Bool()
    
    // Acceleration due to gravity (only the x,y components). Down is +y. Units of g's.
    private var accelerationVector = (ax: 0.0, ay: 1.0) {
        didSet  {
            gravityBehavior.gravityDirection = CGVector(dx: accelerationVector.ax, dy: accelerationVector.ay)
        }
    }
    
    // Create the motion manager which will get motion data from sensors.
    private let motionManager = CMMotionManager()
    
    var animating = false {
        didSet {
            if animating    {
                startMotionUpdates()
                animator.addBehavior(gravityBehavior)
                animator.addBehavior(colliderBehavior)
                animator.addBehavior(elasticBehavior)
                
            }else {
                stopMotionUpdates()
                animator.removeBehavior(gravityBehavior)
                animator.removeBehavior(colliderBehavior)
                animator.removeBehavior(elasticBehavior)
            }
        }
    }
    
    func initialize()   {
        animator = UIDynamicAnimator(referenceView: self)
        // This includes our view's boundaries as collision boundaries.
        colliderBehavior.translatesReferenceBoundsIntoBoundary = true
        
        // Add a piece to the scene.
        for _ in 0...40 {
            addObject(atPoint: CGPoint(x: 160.0  , y: 130.0))
        }
    }
    
    private func addObject(atPoint point: CGPoint)  {
        let piece = SwiftrisShape(atPoint: point, radius: bounds.width/30)
        addSubview(piece)
        gravityBehavior.addItem(piece)
        colliderBehavior.addItem(piece)
        elasticBehavior.addItem(piece)
        piece.superview?.sendSubview(toBack: piece)
    }
    
    private func startMotionUpdates()   {
        if motionManager.isDeviceMotionAvailable    {
            print("Starting motion updates ...")
            motionManager.deviceMotionUpdateInterval = 0.1
            motionManager.startDeviceMotionUpdates(
                to: OperationQueue.main,
                withHandler: {
                    [unowned self] (deviceMotion, error) in
                    if let gravity = deviceMotion?.gravity  {
                        self.accelerationVector = (ax: gravity.x, ay: -gravity.y)
                        if (self.elastic == true) {
                            self.elasticBehavior.elasticity = 1
                        }
                    }
                } )
            
        }
    }
    
    private func stopMotionUpdates() {
        if motionManager.isDeviceMotionAvailable    {
            print("Stopping motion updates ...")
            motionManager.stopDeviceMotionUpdates()
        }
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
