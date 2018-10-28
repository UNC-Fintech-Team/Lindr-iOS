//
//  Card.swift
//  Lender
//
//  Created by Atomo on 10/27/18.
//  Copyright © 2018 Atomo. All rights reserved.
//

import UIKit

class Card: SwipeView, NibView {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
}
