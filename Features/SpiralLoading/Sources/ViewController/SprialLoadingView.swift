//
//  SprialLoadingView.swift
//  Animation
//
//  Created by sangmin han on 2023/01/29.
//

import Foundation
import UIKit


class SpiralLoadingView : UIViewController {
    
    var shapeLayers : [CAShapeLayer] = []
    var sprialPath : UIBezierPath!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        sprialPath = setSprialPath(radius: 100, steps: 200, loopCount: 11)
        setShapeLayer()
        animate()
    }
    
    func setSprialPath(radius: CGFloat, steps: CGFloat, loopCount: CGFloat) -> UIBezierPath {
        let away = radius / steps
        let around = loopCount / steps  *  (-.pi / 2)
        
        
        var points : [CGPoint] = []
        
        for step in stride(from: steps, to: 1, by: -1) {
            let x = self.view.center.x + cos(CGFloat(step) * around) * CGFloat(step) * away
            let y = self.view.center.y + sin(CGFloat(step) * around) * CGFloat(step) * away
            points.append(CGPoint(x: x, y: y))
        }
        
        let path = UIBezierPath()
        path.move(to: points[0])
        let _ = points.dropFirst()
        for point in points {
            path.addLine(to: point)
        }
        path.addLine(to: self.view.center)
        return path
    }
    
    
    func setShapeLayer(){
        for _ in 0...19 {
            let shapeLayer = CAShapeLayer()
            shapeLayer.frame = CGRect(origin: .zero, size: CGSize(width: 10, height: 10))
            shapeLayer.path = UIBezierPath(ovalIn: CGRect(origin: .zero, size: CGSize(width: 10, height: 10))).cgPath
            shapeLayer.backgroundColor = UIColor.clear.cgColor
            shapeLayer.fillColor = UIColor.white.cgColor
            
            self.view.layer.addSublayer(shapeLayer)
            shapeLayers.append(shapeLayer)
        }
    }
    
    func animate(){
        for i in 0...19 {
            
            let animation = CAKeyframeAnimation(keyPath: #keyPath(CALayer.position))
            animation.path = sprialPath.cgPath
            animation.duration = 5
            animation.calculationMode = .cubicPaced
            animation.timingFunction = CAMediaTimingFunction(name: .easeOut)
            animation.beginTime = CACurrentMediaTime() + 0.2 * Double( i)
            animation.delegate = self
            animation.isRemovedOnCompletion = false
            shapeLayers[i].add(animation, forKey: "animation\(i)")
        }
    }
    
    
}
extension SpiralLoadingView : CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if anim == shapeLayers[17].animation(forKey: "animation17") {
            animate()
        }
        

    }
}
