//
//  SwiftrisShape.swift
//  Swiftris
//
//  Created by Robbie Merillat on 11/9/16.
//  Copyright © 2016 Robbie Merillat. All rights reserved.
//

import UIKit

class SwiftrisShape: UIImageView {
    
    var shapes = ["Square","IShape", "JShape", "LShape", "TShape", "SShape"]

    init(atPoint point: CGPoint, radius: CGFloat) {
        
        let index = Int(arc4random_uniform(UInt32(shapes.count)))
        let name = shapes[index]
        
        var size = CGSize(width: radius*2, height: radius*2)
        
        switch(name) {
        case "IShape":
            size = CGSize(width: radius, height: radius*3)
        case "JShape":
            size = CGSize(width: radius*2, height: radius*2.5)
        case "LShape":
            size = CGSize(width: radius*2, height: radius*2.5)
        case "TShape":
            size = CGSize(width: radius*2.5, height: radius*2)
        case "SShape":
            size = CGSize(width: radius*2.5, height: radius*2)
        default:
            size = CGSize(width: radius*2, height: radius*2)
        }
        
        let origin = CGPoint(x: point.x-radius, y: point.y-radius)
        let frame = CGRect(origin: origin, size: size)
        super.init(frame: frame)
        
        image = UIImage(named: name)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var collisionBoundsType: UIDynamicItemCollisionBoundsType  {
        return .rectangle
    }

}
