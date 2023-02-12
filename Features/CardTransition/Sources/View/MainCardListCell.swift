//
//  MainCardListCell.swift
//  Animation
//
//  Created by sangmin han on 2023/01/31.
//

import Foundation
import UIKit


class MainCardListCell : UITableViewCell {
    
    static let cellId = "MainCardListCellId"
    
    let cardView = CardView()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        makeCardView()
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
}
extension MainCardListCell {
    private func makeCardView(){
        self.addSubview(cardView)
        cardView.translatesAutoresizingMaskIntoConstraints = false
        cardView.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 20).isActive = true
        cardView.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -20).isActive = true
        cardView.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: -10).isActive = true
        cardView.topAnchor.constraint(equalTo: self.topAnchor,constant: 10).isActive = true
        
    }
}
