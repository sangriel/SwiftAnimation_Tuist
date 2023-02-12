//
//  CardViewModel.swift
//  Animation
//
//  Created by sangmin han on 2023/01/31.
//

import Foundation
import UIKit


struct CardViewModel {
    
    enum CurrentType {
        case card
        case detail
    }
    
    var title : String
    var image : UIImage
    var currentType : CurrentType = .card
    
}
