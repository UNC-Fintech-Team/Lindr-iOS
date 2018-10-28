//
//  CardContainerViewDataSource.swift
//  Lender
//
//  Created by Atomo on 10/27/18.
//  Copyright © 2018 Atomo. All rights reserved.
//

import Foundation
import UIKit

protocol CardContainerViewDataSource: class {
    func numberOfCards() -> Int
    
    func cardAtIndex(index: Int) -> Card
    
    func emptyState() -> UIView?
}
