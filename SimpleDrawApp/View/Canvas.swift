//
//  Canva.swift
//  SimpleDrawApp
//
//  Created by CodergirlTM on 01.07.21.
//

import UIKit


class Canvas: UIView {
    
    fileprivate var strokeColor = UIColor.black
    fileprivate var strokeWidth: Float = 1
    //public function
    
    func undo() {
        _ = lines.popLast()
        setNeedsDisplay()
    }
    
    func clear() {
        lines.removeAll()
        setNeedsDisplay()
    }
    
    func setStrokeColor(color: UIColor){
        self.strokeColor = color
    }
    
    func setStrokeWidth(width: Float){
        self.strokeWidth = width
    }
    
    var lines = [Line]()
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else { return }

        
        lines.forEach { (line) in
            for (i, p) in line.points.enumerated() {
                context.setStrokeColor(line.color.cgColor)
                context.setLineWidth(CGFloat(line.strokeWidth))
                context.setLineCap(.round)
                if i == 0 {
                    context.move(to: p)
                } else {
                    context.addLine(to: p)
                }
            }
            context.strokePath()
        }
    }
    
    var line = [CGPoint]()
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lines.append(Line.init(strokeWidth: strokeWidth, color: strokeColor, points: []))
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: nil) else { return }
        print(point)
        
        guard var lastLine = lines.popLast() else { return }
        lastLine.points.append(point)
        
        lines.append(lastLine)
        
        setNeedsDisplay()
    }
}
