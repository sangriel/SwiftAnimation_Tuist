//
//  PanTestViewController.swift
//  FluidSwipeBack
//
//  Created by sangmin han on 2023/03/03.
//  Copyright © 2023 HSMProducts. All rights reserved.
//

import Foundation
import UIKit
import CommonUI



class PanGestureTestViewController : UIViewController {
    
    let backView = UIImageView()
    
    let panGesture = UIPanGestureRecognizer()
    
    let shapeLayer = CAShapeLayer()
    let initialPath = UIBezierPath()
    let path = UIBezierPath()
    
    var topPoint : CGPoint = .zero
    var bottomPoint : CGPoint = CGPoint(x: 0, y: UIScreen.main.bounds.height)

    var curveStartPoint : CGPoint = .zero
    var curveControlPoint : CGPoint = .zero
    var curveEndPoint : CGPoint = .zero
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        makebackView()
        
        let panGesture = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        panGesture.edges = .left
        view.addGestureRecognizer(panGesture)
        
        
        setShapeLayer()
        setLiquidPath()
    }
    
    func animateBackToInitial(){
        setInitialPath()
        
        let myAnimation = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.path))
        myAnimation.duration = 0.4
        myAnimation.fromValue = path.cgPath
        myAnimation.toValue = initialPath.cgPath
        myAnimation.fillMode = .forwards
        myAnimation.isRemovedOnCompletion = true
        
        shapeLayer.add(myAnimation, forKey: "animatePath")
       
        topPoint.x = 0
        bottomPoint.x = 0
        curveStartPoint.x = 0
        curveEndPoint.x = 0
        curveControlPoint.x = 0
        curveStartPoint.y = 0
        curveEndPoint.y = 0
        curveControlPoint.y = 0
        setLiquidPath()
    }
    
    func setInitialPath(){
        initialPath.removeAllPoints()
        initialPath.move(to: .init(x: 0, y: 0))
        initialPath.addLine(to: .init(x: 0, y: 0))
        initialPath.addLine(to: .init(x: 0, y: UIScreen.main.bounds.height))
        initialPath.addLine(to: .init(x: 0, y: UIScreen.main.bounds.height))
        
        initialPath.close()
        
        initialPath.move(to: .init(x: 0, y: curveStartPoint.y))
        initialPath.addCurve(to: .init(x: 0, y: curveEndPoint.y),
                      controlPoint1: .init(x: 0, y: curveControlPoint.y),
                      controlPoint2: .init(x: 0, y: curveControlPoint.y))
    }
    
    
    func setLiquidPath() {
        
        path.removeAllPoints()
        
        path.move(to: .zero)
        path.addLine(to: topPoint)
        path.addLine(to: bottomPoint)
        path.addLine(to: .init(x: 0, y: UIScreen.main.bounds.height))
        path.addLine(to: .zero)
        path.close()
        
        
        path.move(to: curveStartPoint)
        
        path.addCurve(to: curveEndPoint,
                      controlPoint1: curveControlPoint,
                      controlPoint2: curveControlPoint)
        
        
        
        shapeLayer.path = path.cgPath
    }
    
    func setShapeLayer(){
        shapeLayer.lineWidth = 1
        backView.layer.mask = shapeLayer
    }
    
    
    
    
    
    @objc func handlePanGesture(_ gesture: UIScreenEdgePanGestureRecognizer) {
        let point = gesture.location(in: view)
        
        switch gesture.state {
        case .changed, .began:
            let xpos = min(point.x,100)
            topPoint.x = xpos
            bottomPoint.x = xpos
            
            curveStartPoint.x = xpos
            curveEndPoint.x = xpos
            curveControlPoint.x = xpos + 50
            
            
            curveStartPoint.y = point.y - 90
            curveEndPoint.y = point.y + 90
            curveControlPoint.y = point.y
            
            setLiquidPath()
        case .ended:
            animateBackToInitial()
        default:
            break
        }
        
    }
}
extension PanGestureTestViewController {
    private func makebackView(){
        self.view.addSubview(backView)
        backView.translatesAutoresizingMaskIntoConstraints = false
        backView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        backView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        backView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        backView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        backView.backgroundColor = .yellow
        backView.image = CommonUIAsset.backgroundImage1.image
    }
    
}
