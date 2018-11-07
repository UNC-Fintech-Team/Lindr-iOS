//
//  User.swift
//  Lender
//
//  Created by Atomo on 11/7/18.
//  Copyright © 2018 Atomo. All rights reserved.
//

import Foundation

struct User: Codable {
    let fname: String
    let lname: String
    let email: String
    let pass: String
    let pmode: String
    let bio: String
}
