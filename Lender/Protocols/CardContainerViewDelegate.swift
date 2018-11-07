//
//  CardContainerViewDelegate.swift
//  Lender
//
//  Created by Atomo on 10/27/18.
//  Copyright © 2018 Atomo. All rights reserved.
//

import Foundation

protocol CardContainerViewDelegate: class {
    func didChoose(card: Card, index: Int)
}
