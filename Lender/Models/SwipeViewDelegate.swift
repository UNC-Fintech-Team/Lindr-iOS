//
//  File.swift
//  Lender
//
//  Created by Atomo on 10/27/18.
//  Copyright © 2018 Atomo. All rights reserved.
//

import Foundation

protocol SwipeViewDelegate: class {
    
    func didTap(view: SwipeView)
    
    func didEndSwipe(onView view: SwipeView)
    
}
