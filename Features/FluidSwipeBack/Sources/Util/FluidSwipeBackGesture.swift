//
//  FluidSwipeBackGestureView.swift
//  FluidSwipeBack
//
//  Created by sangmin han on 2023/03/06.
//  Copyright © 2023 HSMProducts. All rights reserved.
//

import Foundation
import UIKit

class FluidSwipeBackGesture : NSObject {
    
    private let imageView = UIImageView()
    
    private let panGesture = UIPanGestureRecognizer()
    
    private let shapeLayer = CAShapeLayer()
    private let initialPath = UIBezierPath()
    private let completePath = UIBezierPath()
    private let animatePath = UIBezierPath()
    
    private var topPoint : CGPoint = .zero
    private var bottomPoint : CGPoint = CGPoint(x: 0, y: UIScreen.main.bounds.height)

    private var curveStartPoint : CGPoint = .zero
    private var curveControlPoint : CGPoint = .zero
    private var curveEndPoint : CGPoint = .zero
    
    private var oldPanY : CGFloat = 0
    private var oldPanX : CGFloat = 0
    
    private(set) var isInteractive : Bool = false
    
    private var superView : UIViewController!
    
    private var transitionContext : UIViewControllerContextTransitioning?
    
    enum AnimationType {
        case backToInitial
        case forwardingToComplete
        case none
    }
    
    private var currentAnimationStatus : AnimationType = .none
    
    
    
    
    init(superView : UIViewController, backgroundImage : UIImage){
        super.init()
        self.imageView.image = backgroundImage
        self.superView = superView
        let panGesture = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        panGesture.edges = .left
        self.superView.view.addGestureRecognizer(panGesture)
        
        setShapeLayer()
        setAnimatePath()
        makeImageView()
    }
    
    required init?(coder : NSCoder){
        fatalError("molang")
    }
    
    func setShapeLayer(){
        imageView.layer.mask = shapeLayer
    }
    
    func setTransitionContext(transitionContent : UIViewControllerContextTransitioning){
        self.transitionContext = transitionContent
    }
    
    @objc func handlePanGesture(_ gesture: UIScreenEdgePanGestureRecognizer) {
        let point = gesture.location(in: self.superView.view)
        
        
        switch gesture.state {
        case.began:
            curveStartPoint.y = point.y
            curveEndPoint.y = point.y
            curveControlPoint.y = point.y
            oldPanY = point.y
            oldPanX = point.x
            currentAnimationStatus = .none
            isInteractive = true
            superView.navigationController?.popViewController(animated: true)
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
            if point.x >= (UIScreen.main.bounds.width * 2) / 3 || gesture.velocity(in: self.superView.view).x > 500 {
                animateForwadingToComplete()
            }
            else {
                animateBackToInitial()
            }
            isInteractive = false
        default:
            break
        }
    }
    
    
    
}
extension FluidSwipeBackGesture {
    private func makeImageView(){
        self.superView.view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: self.superView.view.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: self.superView.view.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: self.superView.view.trailingAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: self.superView.view.bottomAnchor).isActive = true
        imageView.isUserInteractionEnabled = false
        
    }
    
}
//MARK: - PathMaker
extension FluidSwipeBackGesture {
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
extension FluidSwipeBackGesture : CAAnimationDelegate {
    private func animateBackToInitial(){
        setInitialPath()
        currentAnimationStatus = .backToInitial
        let myAnimation = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.path))
        myAnimation.delegate = self
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
        currentAnimationStatus = .forwardingToComplete
        let myAnimation = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.path))
        myAnimation.delegate = self
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
    
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        guard let transitionContext = transitionContext else {
            return
        }
        
        if currentAnimationStatus == .forwardingToComplete {
            transitionContext.finishInteractiveTransition()
            transitionContext.completeTransition(true)
        }
        else if currentAnimationStatus == .backToInitial {
            transitionContext.cancelInteractiveTransition()
            transitionContext.completeTransition(false)
            
        }
       
        self.transitionContext = nil
    }
}
