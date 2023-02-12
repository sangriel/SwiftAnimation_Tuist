//
//  MainTableViewCell.swift
//  SwiftAnimation
//
//  Created by sangmin han on 2023/02/11.
//  Copyright © 2023 HSMProducts. All rights reserved.
//

import Foundation
import UIKit

class MainTableViewCell : UITableViewCell {
    
    static let cellId = "cellId"
  
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.accessoryType = .disclosureIndicator
        self.selectionStyle = .none
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
