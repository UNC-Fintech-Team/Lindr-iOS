//
//  SwipeManager.swift
//  Lender
//
//  Created by Atomo on 10/27/18.
//  Copyright © 2018 Atomo. All rights reserved.
//

import Foundation
import CoreGraphics

enum Swipe {
    case left
    case right
    case up
    case down
    case topLeft
    case topRight
    case bottomLeft
    case bottomRight
    
    var horizontalPosition: HorizontalPosition {
        switch self {
        case .left:
            return .left
        case .right:
            return .right
        case .up:
            return .middle
        case .down:
            return .middle
        case .topLeft:
            return .left
        case .topRight:
            return .right
        case .bottomLeft:
            return .left
        case .bottomRight:
            return .right
        }
    }
    
    var verticalPosition: VerticalPosition {
        switch self {
        case .left:
            return .middle
        case .right:
            return .middle
        case .up:
            return .top
        case .down:
            return .bottom
        case .topLeft:
            return .top
        case .topRight:
            return .top
        case .bottomLeft:
            return .bottom
        case .bottomRight:
            return .bottom
        }
    }
    
    static var allDirections: [Swipe] {
        return [.left, .right, .up, .down, .topLeft, .topRight, .bottomLeft, .bottomRight]
    }
    
    var point: CGPoint {
        return CGPoint(x: horizontalPosition.rawValue, y: verticalPosition.rawValue)
    }
    
    enum HorizontalPosition: CGFloat {
        case left = -1
        case middle = 0
        case right = 1
    }
    
    enum VerticalPosition: CGFloat {
        case top = -1
        case middle = 0
        case bottom = 1
    }
    
    static var boundsRect: CGRect {
        let h = VerticalPosition.bottom.rawValue - VerticalPosition.top.rawValue
        let w = HorizontalPosition.right.rawValue - HorizontalPosition.left.rawValue
        return CGRect(x: HorizontalPosition.left.rawValue, y: VerticalPosition.top.rawValue, width: w, height: h)
    }
    
}
