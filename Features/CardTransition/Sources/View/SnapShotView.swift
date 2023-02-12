//
//  SnapShotView.swift
//  Animation
//
//  Created by sangmin han on 2023/02/01.
//

import Foundation
import UIKit


class SnapShotView : UIView {
    
    private var shadowView = UIView()
    
    private var containerView = UIView()
    
    private var imageView = UIImageView()
    
    
    
    override init(frame : CGRect){
        super.init(frame: frame)
        makeshadowView()
        makecontainerView()
        makeimageView()
    }
    
    required init?(coder :NSCoder){
        fatalError()
    }
    
    func setCornerRadius(radius:CGFloat){
        self.shadowView.layer.cornerRadius = radius
        self.containerView.layer.cornerRadius = radius
    }
    
    func setimage(image : UIImage?){
        self.imageView.image = image
        self.imageView.heightAnchor.constraint(equalToConstant: image!.size.height).isActive = true
    }
    
    func getimage() -> UIImage {
        return self.imageView.image!
    }
    
    
    
}
extension SnapShotView {
    private func makeshadowView(){
        self.addSubview(shadowView)
        shadowView.translatesAutoresizingMaskIntoConstraints = false
        shadowView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        shadowView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        shadowView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        shadowView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        shadowView.backgroundColor = .red
        shadowView.layer.shadowColor = UIColor.red.cgColor
        shadowView.layer.shadowOpacity = 0.5
        shadowView.layer.shadowRadius = 8
        shadowView.layer.shadowOffset = CGSize(width: 0, height: 0)
    }
    private func makecontainerView(){
        self.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        containerView.clipsToBounds = true
    }
    private func makeimageView(){
        containerView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
//        imageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        imageView.clipsToBounds = true
    }
}
