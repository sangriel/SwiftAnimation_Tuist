//
//  CardView.swift
//  Animation
//
//  Created by sangmin han on 2023/01/31.
//

import Foundation
import UIKit


class CardView : UIView {
    
    
    private let backgroundImageView = UIImageView()
    
    private let titleLabel = UILabel()
    
    private var viewModel : CardViewModel?
    
    
    
    
    override init(frame : CGRect){
        super.init(frame: frame)
        makebackgroundImageView()
        maketitleLabel()
        self.clipsToBounds = true
        
    }
    
    required init?(coder : NSCoder) {
        fatalError()
    }
    
    func setViewModel(viewModel : CardViewModel){
        self.viewModel = viewModel
        backgroundImageView.image = viewModel.image
        titleLabel.text = viewModel.title
        if viewModel.currentType == .card {
            self.layer.cornerRadius = 20
        }
        else {
            self.layer.cornerRadius = 0
        }
    }
    
    func getViewModel() -> CardViewModel? {
        return viewModel
    }
    
    func setLayoutForDetailView(){
       
        
    }
    
    func setLayoutForCell(){
        
    }
    
    
    
    
}
extension CardView {
    private func makebackgroundImageView(){
        self.addSubview(backgroundImageView)
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        backgroundImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        backgroundImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.clipsToBounds = true
    }
    private func maketitleLabel(){
        self.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.bottomAnchor.constraint(equalTo: backgroundImageView.bottomAnchor, constant: -10).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: backgroundImageView.leadingAnchor, constant: 10).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: backgroundImageView.trailingAnchor, constant: -10).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        
    }
}
