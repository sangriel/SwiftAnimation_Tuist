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
    let completePath = UIBezierPath()
    let animatePath = UIBezierPath()
    
    var topPoint : CGPoint = .zero
    var bottomPoint : CGPoint = CGPoint(x: 0, y: UIScreen.main.bounds.height)

    var curveStartPoint : CGPoint = .zero
    var curveControlPoint : CGPoint = .zero
    var curveEndPoint : CGPoint = .zero
    
    var oldPanY : CGFloat = 0
    var oldPanX : CGFloat = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        makebackView()
        
        let panGesture = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        panGesture.edges = .left
        view.addGestureRecognizer(panGesture)
        
        
        setShapeLayer()
        setAnimatePath()
    }
    
    func setShapeLayer(){
        shapeLayer.lineWidth = 1
        backView.layer.mask = shapeLayer
    }
    
    
    
    
    @objc func handlePanGesture(_ gesture: UIScreenEdgePanGestureRecognizer) {
        let point = gesture.location(in: view)
        
        switch gesture.state {
        case.began:
            curveStartPoint.y = point.y
            curveEndPoint.y = point.y
            curveControlPoint.y = point.y
            oldPanY = point.y
            oldPanX = point.x
        case .changed:
            let xpos = min(point.x,50)
            topPoint.x = xpos
            bottomPoint.x = xpos
            
            curveStartPoint.x = xpos
            curveEndPoint.x = xpos
            curveControlPoint.x = point.x
            
            curveStartPoint.y -= ( (oldPanX - point.x) * 1.2  )
            curveEndPoint.y += ( (oldPanX - point.x) * 1.2 )
            curveControlPoint.y -= oldPanY - point.y
            oldPanY = point.y
            oldPanX = point.x

            setAnimatePath()
        case .ended:
            if point.x >= (UIScreen.main.bounds.width * 2) / 3 || gesture.velocity(in: self.view).x > 500 {
                animateForwadingToComplete()
            }
            else {
                animateBackToInitial()
            }
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
//MARK: - PathMaker
extension PanGestureTestViewController {
    private func setInitialPath(){
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
    
    private func setCompletePath(){
        completePath.removeAllPoints()
        completePath.move(to: .init(x: 0, y: 0))
        
        let mainBound = UIScreen.main.bounds
        completePath.addLine(to: .init(x: mainBound.width, y: 0))
        completePath.addLine(to: .init(x: mainBound.width, y: mainBound.height))
        completePath.addLine(to: .init(x: 0, y: mainBound.height))
        
        completePath.close()
        
        completePath.move(to: .init(x: mainBound.width, y: curveStartPoint.y))
        completePath.addCurve(to: .init(x: mainBound.width, y: curveEndPoint.y),
                             controlPoint1: .init(x: mainBound.width, y: curveControlPoint.y),
                             controlPoint2: .init(x: mainBound.width, y: curveControlPoint.y))
    }
    
    
    private func setAnimatePath() {
        
        animatePath.removeAllPoints()
        
        animatePath.move(to: .zero)
        animatePath.addLine(to: topPoint)
        animatePath.addLine(to: bottomPoint)
        animatePath.addLine(to: .init(x: 0, y: UIScreen.main.bounds.height))
        animatePath.addLine(to: .zero)
        animatePath.close()
        
        
        animatePath.move(to: curveStartPoint)
        
        animatePath.addCurve(to: curveEndPoint,
                      controlPoint1: curveControlPoint,
                      controlPoint2: curveControlPoint)
        
        
        
        shapeLayer.path = animatePath.cgPath
    }
}
//MARK: -Animations
extension PanGestureTestViewController {
    private func animateBackToInitial(){
        setInitialPath()
        
        let myAnimation = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.path))
        myAnimation.duration = 0.4
        myAnimation.fromValue = animatePath.cgPath
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
        setAnimatePath()
    }
    
    private func animateForwadingToComplete(){
        setCompletePath()
        
        let myAnimation = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.path))
        myAnimation.duration = 0.4
        myAnimation.fromValue = animatePath.cgPath
        myAnimation.toValue = completePath.cgPath
        myAnimation.fillMode = .forwards
        myAnimation.isRemovedOnCompletion = true
        
        shapeLayer.add(myAnimation, forKey: "animatePath2")
        
        let mainBound = UIScreen.main.bounds
        topPoint.x = mainBound.width
        bottomPoint.x = mainBound.width
        curveStartPoint.x = mainBound.width
        curveEndPoint.x = mainBound.width
        curveControlPoint.x = mainBound.width
        
        curveStartPoint.y = 0
        curveEndPoint.y = mainBound.height
        
        setAnimatePath()
    }
    
}
