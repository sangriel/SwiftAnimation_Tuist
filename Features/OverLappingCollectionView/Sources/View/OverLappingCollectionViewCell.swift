//
//  OverLappingCollectionViewCell.swift
//  Animation
//
//  Created by sangmin han on 2023/02/01.
//

import Foundation
import UIKit


class OverLappingCollectionViewCell : UICollectionViewCell {
    
    
    static let cellId = "overlappingCollectionViewCellId"
    
    var cardView = OverLappingCardView()
    
    override init(frame :CGRect){
        super.init(frame: frame)
        self.backgroundColor = .clear
        makeCardView()
        
    }
    
    required init?(coder : NSCoder){
        fatalError()
    }
    
}
extension OverLappingCollectionViewCell {
    private func makeCardView(){
        self.addSubview(cardView)
        cardView.translatesAutoresizingMaskIntoConstraints = false
        cardView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        cardView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        cardView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        cardView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
}
