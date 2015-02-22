//
//  DrawView.swift
//  DrawMe
//
//  Created by Admin on 2/22/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

import UIKit

class DrawView: UIView {
    var lines: [Line] = []
    var lastPoint: CGPoint!
    var lineWidth: Float = 1
    var color: UIColor = UIColor.redColor()
    
    required init(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        lastPoint = touches.anyObject()?.locationInView(self)
    }
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        var newPoint = touches.anyObject()?.locationInView(self)
        lines.append(Line(_s: lastPoint, _e: newPoint!))
        lastPoint = newPoint
        self.setNeedsDisplay()
    }
    
    override func drawRect(rect: CGRect) {
        var context = UIGraphicsGetCurrentContext()
        CGContextBeginPath(context)
        for line in lines {
            CGContextMoveToPoint(context, line.start.x, line.start.y)
            CGContextAddLineToPoint(context, line.end.x, line.end.y)
        }
        CGContextSetLineCap(context, kCGLineCapRound)
        CGContextSetLineWidth(context, CGFloat(lineWidth))
        CGContextSetStrokeColorWithColor(context, color.CGColor)
        CGContextStrokePath(context)
    }
}
