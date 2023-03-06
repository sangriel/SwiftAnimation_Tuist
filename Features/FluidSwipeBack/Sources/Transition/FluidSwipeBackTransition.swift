//
//  FluidSwipeBackTransition.swift
//  FluidSwipeBack
//
//  Created by sangmin han on 2023/03/06.
//  Copyright © 2023 HSMProducts. All rights reserved.
//

import Foundation
import UIKit
import CommonUI


class FluidSwipeBackTransitionManager : NSObject {
    
    var panGesture : FluidSwipeBackGesture?
    
}
extension FluidSwipeBackTransitionManager : UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return self
    }
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == .pop {
            //팬제스쳐 일때는 애니메이션 ㅇㅇ
            if let panGesture = panGesture, panGesture.isInteractive  {
                return self
            }
            else { //btn눌렀을때는 애니메이션 ㄴㄴ
                return nil
            }
            
        }
        else {
            if let snapShot = fromVC.view.createSnapshot(withFrame: nil, size: nil,afterScreenUpdate: false) {
                panGesture = FluidSwipeBackGesture(superView: toVC, backgroundImage: snapShot)
            }
            return nil
        }
    }
}
extension FluidSwipeBackTransitionManager : UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    }
}
extension FluidSwipeBackTransitionManager : UIViewControllerInteractiveTransitioning {
    func startInteractiveTransition(_ transitionContext: UIViewControllerContextTransitioning) {
        guard let panGesture = panGesture else {
            transitionContext.cancelInteractiveTransition()
            transitionContext.completeTransition(true)
            return
        }
        panGesture.setTransitionContext(transitionContent: transitionContext)
        transitionContext.containerView.addSubview(transitionContext.view(forKey: .to)!)
        transitionContext.containerView.addSubview(transitionContext.view(forKey: .from)!)
    }
}
