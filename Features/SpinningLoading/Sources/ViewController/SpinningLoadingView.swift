//
//  SpinningLoadingView.swift
//  Animation
//
//  Created by sangmin han on 2023/01/27.
//

import Foundation
import UIKit



class SpinningLoadingView : UIViewController {
    
    
    
    var shapeLayers : [CAShapeLayer] = []
    
    lazy var points : [CGPoint] =  [CGPoint(x: self.view.center.x, y: 0),
                                    CGPoint(x: self.view.center.x, y: self.view.center.y - 100)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = .black
        setShapeLayer()
       
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateFalling()
    }
    
    func setShapeLayer(){
        for i in 0...19 {
            let shapeLayer = CAShapeLayer()
            shapeLayer.path = UIBezierPath(ovalIn: CGRect(origin: .zero, size: CGSize(width: 10, height: 10))).cgPath
            shapeLayer.backgroundColor = UIColor.clear.cgColor
            if i == 19 {
                shapeLayer.fillColor = UIColor.red.cgColor
            }
            else {
                shapeLayer.fillColor = UIColor.white.cgColor
            }
            shapeLayer.position = points[0]
            self.shapeLayers.append(shapeLayer)
            self.view.layer.addSublayer(shapeLayer)
        }
        
    }
    
    func animateFalling(){
        for i in 0...19 {
            let animation = CABasicAnimation(keyPath: #keyPath(CALayer.position))
            animation.fromValue = points[0]
            animation.toValue = points[1]
            animation.duration = 1
            animation.delegate = self
            animation.beginTime = CACurrentMediaTime() + Double(i) * 0.2
            animation.timingFunction = CAMediaTimingFunction(name: .easeIn)
            animation.isRemovedOnCompletion = false
            shapeLayers[i].add(animation, forKey: "fallingAnimation\(i)")
        }
    }
    
    
    
    func animateRotation(index : Int){
        let layer = shapeLayers[index]
        let sc = self.view.center
        let circleRadius : CGFloat = 100
        
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: sc.x, y: sc.y),
                                      radius: circleRadius, startAngle: -(.pi / 2), endAngle: 3 * ( .pi / 2), clockwise: true)
        
        
        
        let animationDuration = 20 * 0.2
        layer.position = CGPoint(x: sc.x, y: sc.y - 100)
        let animation = CAKeyframeAnimation(keyPath: #keyPath(CALayer.position))
        animation.path = circlePath.cgPath
        animation.calculationMode = .paced
        animation.duration = animationDuration
        animation.speed = 1
        animation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        
        
        let animationGroup = CAAnimationGroup()
        animationGroup.animations = [animation]
        animationGroup.duration = animationDuration + 15 * 0.2
        animationGroup.repeatCount = .infinity
        layer.add(animationGroup, forKey: "")
        
    }

    
}
extension SpinningLoadingView : CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        for i in 0...19 {
            let anima = shapeLayers[i].animation(forKey: "fallingAnimation\(i)")
            if anim == anima {
                animateRotation(index: i)
                break
            }
        }
        
    }
    
    
}
