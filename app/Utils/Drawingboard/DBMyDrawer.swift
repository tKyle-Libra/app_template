//
//  DBMyDrawer.swift
//  app
//
//  Created by harry on 2019/11/5.
//  Copyright © 2019 harry. All rights reserved.
//

import UIKit

class DBMyDrawer: UIView {
    
    
    func clearScreen(){
        
        if lines == nil || lines.count <= 0 {
            return
        }
        for line in lines {
            let layer:CALayer = line as! CALayer
            layer.removeFromSuperlayer()
        }
        lines.removeAllObjects()
        canceledLines.removeAllObjects()
    }
    
    func undo(){
        if lines == nil || lines.count <= 0 {
            return
        }
        canceledLines.add(lines.lastObject as Any)
        (lines.lastObject as! CALayer).removeFromSuperlayer()
        lines.removeLastObject()
    }
    
    func redo(){
        if canceledLines == nil || canceledLines.count <= 0 {
                   return
               }
        lines.add(canceledLines.lastObject as Any)
        (canceledLines.lastObject as! CALayer).removeFromSuperlayer()
        drawLine()
    }
    
    var width:CGFloat = 2.0
    var canceledLines:NSMutableArray! = NSMutableArray()
    var lines:NSMutableArray! = NSMutableArray()
    private var _path:DBPaintPath?
    private var _slayer:CAShapeLayer?
}


fileprivate extension DBMyDrawer{
    func pointWithTouches(touches:Set<UITouch>) -> CGPoint {
        let touch:UITouch = NSSet(set: touches).anyObject() as! UITouch
        return touch.location(in: self)
    }
    
    func drawLine(){
        self.layer.addSublayer(lines!.lastObject as! CALayer)
    }
}

extension DBMyDrawer{
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let start:CGPoint = pointWithTouches(touches: touches)
        if event?.allTouches?.count == 1{
            let path:DBPaintPath = DBPaintPath(width: width, startPoint: start)
            _path = path
            let slayer:CAShapeLayer = CAShapeLayer()
            slayer.path = path.cgPath
            slayer.backgroundColor = UIColor.clear.cgColor
            slayer.lineCap = .round
            slayer.lineJoin = .round
            slayer.strokeColor = UIColor.black.cgColor
            slayer.lineWidth = path.lineWidth
            self.layer.addSublayer(slayer)
            _slayer = slayer
            self.mutableArrayValue(forKey: "canceledLines").removeAllObjects()
            self.mutableArrayValue(forKey: "lines").add(_slayer as Any)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let start:CGPoint = pointWithTouches(touches: touches)
        if (event?.allTouches!.count)! > 1{
            self.superview?.touchesMoved(touches, with: event)
        }else if event?.allTouches?.count == 1{
            _path?.addLine(to: start)
            _slayer?.path = _path?.cgPath
        }
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (event?.allTouches!.count)! > 1{
            self.superview?.touchesEnded(touches, with: event)
        }
    }
}
