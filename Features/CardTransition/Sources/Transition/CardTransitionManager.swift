//
//  CardTransitionManager.swift
//  Animation
//
//  Created by sangmin han on 2023/01/31.
//

import Foundation
import UIKit


enum CardTransitionType {
    case presentation
    case dismiss
    
    var blurAlpha : CGFloat { return self == .presentation ? 1 : 0 }
    var cornerRadius : CGFloat { return self == .presentation ? 20 : 0}
    var dimAlpha : CGFloat { return self == .presentation ? 0.2 : 0}
    var nextType : CardTransitionType { return self == .presentation ? .dismiss : .presentation }
}

class CardTransitionManager : NSObject {
    
    private let transitionDuration : Double = 1
    private var transition : CardTransitionType = .presentation
    private let shrinkDuration : Double = 0.2
    
    lazy var blurEffectView : UIVisualEffectView = {
        let blur = UIBlurEffect(style: .light)
        let visualEffectView = UIVisualEffectView(effect: blur)
        return visualEffectView
    }()
    
    lazy var dimmingView : UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    lazy var whiteView : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.shadowColor = UIColor.blue.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowRadius = 8
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        return view
    }()
    
    private func addBackgroundViews(to containerView : UIView){
        blurEffectView.frame = containerView.frame
        blurEffectView.alpha = transition.nextType.blurAlpha
        containerView.addSubview(blurEffectView)
        
        dimmingView.frame = containerView.frame
        dimmingView.alpha = transition.nextType.dimAlpha
        containerView.addSubview(dimmingView)
    }
    
    private func makeCardViewCopy(cardView : CardView) -> CardView {
        let cardViewModel = cardView.getViewModel()!
        let copyView = CardView()
        copyView.setViewModel(viewModel: cardViewModel)
        return copyView
    }
    
    private func fetchMainCardListViewController(viewController : UIViewController) -> MainCardListViewController? {
        guard let nav = viewController as? UINavigationController,
              let topViewController = nav.topViewController,
              let mainCardListViewController = topViewController as? MainCardListViewController else { return nil }
        return mainCardListViewController
    }
    
}
extension CardTransitionManager : UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return transitionDuration
        
    }
    
    func animationEnded(_ transitionCompleted: Bool) {
        if transitionCompleted {
            whiteView.removeFromSuperview()
        }
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let containerView = transitionContext.containerView
        containerView.subviews.forEach({ $0.removeFromSuperview() })

        addBackgroundViews(to: containerView)

        let fromViewController = transitionContext.viewController(forKey: .from)
        let toViewController = transitionContext.viewController(forKey: .to)
        
        guard let mainCardListViewController = fetchMainCardListViewController(viewController: transition == .presentation ? fromViewController! : toViewController!),
              let cardView = mainCardListViewController.selectedCardView() else { return }
        
        var listCardViewFrame = cardView.convert(cardView.frame, to: nil)
        //CardView가 cell의 top left bottom right 10, 20, 10, 20의 패딩 있어서 조정을 해줘야 함
        listCardViewFrame.origin.x -= 20
        listCardViewFrame.origin.y -= 10
       
        if transition == .presentation {
            containerView.addSubview(whiteView)
            whiteView.frame = transition == .presentation ? listCardViewFrame : containerView.frame
            whiteView.layer.cornerRadius = transition.cornerRadius
            whiteView.layoutIfNeeded()
            
            let cardViewCopy = makeCardViewCopy(cardView: cardView)
            containerView.addSubview(cardViewCopy)
            cardViewCopy.frame = listCardViewFrame
            cardViewCopy.layoutIfNeeded()
            
           
            
            let detailView = toViewController as! CardDetailViewController
            cardView.isHidden = true
            
            moveAndConvertToDetailCardView(cardView: cardViewCopy, containerView: containerView, yOrigin: detailView.view.frame.origin.y + mainCardListViewController.view.safeAreaInsets.top) {
                containerView.addSubview(detailView.view)
                cardViewCopy.removeFromSuperview()
                cardView.isHidden = false
                detailView.createSnapShot()
                transitionContext.completeTransition(true)
            }
        }
        else {
            let detailView = fromViewController as! CardDetailViewController
            let snapShotCopy = detailView.getSnapShopCopy()
            containerView.addSubview(snapShotCopy)
            snapShotCopy.frame = detailView.getSnapShotFrame()
            snapShotCopy.layoutIfNeeded()
            
            moveAndConvertToListCardView(for: snapShotCopy, frame: listCardViewFrame, containerView: containerView, yOrigin: listCardViewFrame.origin.y, completion: {
                transitionContext.completeTransition(true)
            })
        }
        
    }
    
    private func shrinkAnimator(for cardView : CardView) -> UIViewPropertyAnimator {
        return UIViewPropertyAnimator(duration: shrinkDuration, curve: .easeOut) {
            cardView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            self.whiteView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            self.dimmingView.alpha = self.transition.dimAlpha
        }
    }
    
    private func expandToDetailAnimator(for cardView : CardView, in containerView : UIView, yOrigin : CGFloat) -> UIViewPropertyAnimator {
        let springTiming = UISpringTimingParameters(dampingRatio: 0.75, initialVelocity: CGVector(dx: 0, dy: 3))
        let animator =  UIViewPropertyAnimator(duration: transitionDuration - shrinkDuration, timingParameters: springTiming)
        
        animator.addAnimations {
            cardView.transform = .identity
            self.blurEffectView.alpha = self.transition.blurAlpha
            self.dimmingView.alpha = self.transition.dimAlpha
            cardView.layer.cornerRadius = self.transition.nextType.cornerRadius
            self.whiteView.layer.cornerRadius = self.transition.nextType.cornerRadius
            self.whiteView.frame = containerView.frame
            cardView.frame = CGRect(x: 0, y: yOrigin, width: UIScreen.main.bounds.width, height: 300)
            cardView.layoutIfNeeded()
            containerView.layoutIfNeeded()
        }
        
        return animator
    }
    
    private func shrinkToListAnimator(for snapShot : UIView ,frame ListCardViewFrame : CGRect, in containerView : UIView, yOrigin : CGFloat) -> UIViewPropertyAnimator {
        let springTiming = UISpringTimingParameters(dampingRatio: 0.75, initialVelocity: CGVector(dx: 0, dy: 0))
        let animator =  UIViewPropertyAnimator(duration: transitionDuration - shrinkDuration, timingParameters: springTiming)
        
        animator.addAnimations {
            
            self.blurEffectView.alpha = self.transition.blurAlpha
            self.dimmingView.alpha = self.transition.dimAlpha
            
            self.whiteView.layer.cornerRadius = self.transition.nextType.cornerRadius
            self.whiteView.frame = ListCardViewFrame
            snapShot.frame = ListCardViewFrame
            
            snapShot.layoutIfNeeded()
            containerView.layoutIfNeeded()
        }
        
        return animator
        
    }
    
    private func moveAndConvertToListCardView(for snapShot : UIView,frame ListCardViewFrame : CGRect, containerView : UIView, yOrigin : CGFloat, completion : @escaping() -> ()) {
        let shrinkAnimator2 = self.shrinkToListAnimator(for: snapShot, frame: ListCardViewFrame, in: containerView, yOrigin: yOrigin)

        
        
        shrinkAnimator2.addCompletion { _ in
            completion()
        }
        shrinkAnimator2.startAnimation()
        
    }
    
    
    
    private func moveAndConvertToDetailCardView(cardView : CardView, containerView : UIView, yOrigin : CGFloat, completion : @escaping() -> ()){
        let shrinkAnimator = self.shrinkAnimator(for: cardView)
        let expandAnimator = self.expandToDetailAnimator(for: cardView, in: containerView, yOrigin: yOrigin)
        shrinkAnimator.addAnimations {
            expandAnimator.startAnimation()
        }
        
        expandAnimator.addCompletion { _ in
            completion()
        }
        
        shrinkAnimator.startAnimation()
    }
    
    
    
}
extension CardTransitionManager : UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition = .presentation
        return self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition = .dismiss
        return self
    }
    
}
