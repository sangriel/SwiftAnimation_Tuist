//
//  OverLappingCardView.swift
//  Animation
//
//  Created by sangmin han on 2023/02/01.
//

import Foundation
import UIKit

class OverLappingCardView : UIView {
    
    private var imageView = UIImageView()
    
    private var titleLabel = UILabel()
    
    private var subTitleLabel = UILabel()
    
    private var viewModel : OverLappingCardViewModel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        makeimageView()
        maketitleLabel()
        makesubTitleLabel()
    }
    
    required init?(coder : NSCoder){
        fatalError()
    }
    
    func setViewModel(viewModel : OverLappingCardViewModel){
        self.viewModel = viewModel
        self.imageView.image = viewModel.image
        self.titleLabel.text = viewModel.titleLabel
        self.subTitleLabel.text = viewModel.subTitleLabel
    }
    
    func showImage(){
        self.imageView.isHidden = false
    }
    
    func hideImage(){
        self.imageView.isHidden = true
    }
    private let animDuration : Double = 0.1
    
    lazy private var animator : UIViewPropertyAnimator = {
        let anim = UIViewPropertyAnimator(duration: self.animDuration, dampingRatio: 1)
        anim.isInterruptible = true
        return anim
    }()
    
    
    
    func animateOnScroll(scrollOffset : CGFloat){
        if animator.isRunning {
            animator.stopAnimation(true)
        }
        animator.addAnimations { [weak self] in
            self?.subTitleLabel.transform =  CGAffineTransform(translationX: scrollOffset * 2, y: 0)
            self?.titleLabel.transform = CGAffineTransform(translationX: scrollOffset * 1.5, y: 0)
        }
        animator.startAnimation()
       
    }
    
    
    
}
extension OverLappingCardView {
    private func makeimageView(){
        self.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
    }
    private func maketitleLabel(){
        self.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 20).isActive = true
        titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor, constant: -20).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 23, weight: .bold)
    }
    private func makesubTitleLabel(){
        self.addSubview(subTitleLabel)
        subTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,constant: 10).isActive = true
        subTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 20).isActive = true
        subTitleLabel.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor, constant: -20).isActive = true
        subTitleLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        subTitleLabel.textColor = .white
        subTitleLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
    }
}
