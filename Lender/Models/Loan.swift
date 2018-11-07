//
//  Loan.swift
//  Lender
//
//  Created by Atomo on 11/7/18.
//  Copyright © 2018 Atomo. All rights reserved.
//

import Foundation

struct LoanCard {
    let quantity: Float
    let interestRate: Int
    let purpose: String
    let name: String
    let rating: Int
}

struct Loan: Codable {
    let email: String
    let pass: String
    let quant: Int
    let interest: Double
    let purpose: String
    let payment: String
    let increments: Int
}

