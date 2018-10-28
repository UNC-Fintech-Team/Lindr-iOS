//
//  Extensions.swift
//  Lender
//
//  Created by Atomo on 10/27/18.
//  Copyright © 2018 Atomo. All rights reserved.
//

import Foundation
import CoreGraphics
import UIKit

typealias CGLine = (start: CGPoint, end: CGPoint)

extension CGRect {
    
    var topLine: CGLine {
        return (Swipe.topLeft.point, Swipe.topRight.point)
    }
    var leftLine: CGLine {
        return (Swipe.topLeft.point, Swipe.bottomLeft.point)
    }
    var bottomLine: CGLine {
        return (Swipe.bottomLeft.point, Swipe.bottomRight.point)
    }
    var rightLine: CGLine {
        return (Swipe.topRight.point, Swipe.bottomRight.point)
    }
    
    var perimeterLines: [CGLine] {
        return [topLine, leftLine, bottomLine, rightLine]
    }
    
}

extension CGPoint {
    
    func distanceTo(_ point: CGPoint) -> CGFloat {
        return sqrt(pow(point.x - self.x, 2) + pow(point.y - self.y, 2))
    }
    
    func normalizedDistanceForSize(_ size: CGSize) -> CGPoint {
        let x = 2 * (self.x / size.width)
        let y = 2 * (self.y / size.height)
        return CGPoint(x: x, y: y)
    }
    
    func scalarProjectionPointWith(_ point: CGPoint) -> CGPoint {
        let r = scalarProjectionWith(point) / point.modulo
        return CGPoint(x: point.x * r, y: point.y * r)
    }
    
    func scalarProjectionWith(_ point: CGPoint) -> CGFloat {
        return dotProductWith(point) / point.modulo
    }
    
    func dotProductWith(_ point: CGPoint) -> CGFloat {
        return (self.x * point.x) + (self.y * point.y)
    }
    
    var modulo: CGFloat {
        return sqrt(self.x*self.x + self.y*self.y)
    }
    
    static func intersectionBetweenLines(_ line1: CGLine, line2: CGLine) -> CGPoint? {
        let (p1,p2) = line1
        let (p3,p4) = line2
        
        var d = (p4.y - p3.y) * (p2.x - p1.x) - (p4.x - p3.x) * (p2.y - p1.y)
        var ua = (p4.x - p3.x) * (p1.y - p4.y) - (p4.y - p3.y) * (p1.x - p3.x)
        var ub = (p2.x - p1.x) * (p1.y - p3.y) - (p2.y - p1.y) * (p1.x - p3.x)
        if (d < 0) {
            ua = -ua; ub = -ub; d = -d
        }
        
        if d != 0 {
            return CGPoint(x: p1.x + ua / d * (p2.x - p1.x), y: p1.y + ua / d * (p2.y - p1.y))
        }
        return nil
    }
    
    func screenPointForSize(_ screenSize: CGSize) -> CGPoint {
        let x = 0.5 * (1 + self.x) * screenSize.width
        let y = 0.5 * (1 + self.y) * screenSize.height
        return CGPoint(x: x, y: y)
    }
    
}

extension UIView {
    
    internal func addEdgeConstrainedSubView(view: UIView) {
        addSubview(view)
        edgeConstrain(subView: view)
    }
    
    internal func edgeConstrain(subView: UIView) {
        subView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: subView,
                               attribute: .top,
                               relatedBy: .equal,
                               toItem: self,
                               attribute: .top,
                               multiplier: 1.0,
                               constant: 0),
            NSLayoutConstraint(item: subView,
                               attribute: .bottom,
                               relatedBy: .equal,
                               toItem: self,
                               attribute: .bottom,
                               multiplier: 1.0,
                               constant: 0),
            NSLayoutConstraint(item: subView,
                               attribute: .left,
                               relatedBy: .equal,
                               toItem: self,
                               attribute: .left,
                               multiplier: 1.0,
                               constant: 0),
            NSLayoutConstraint(item: subView,
                               attribute: .right,
                               relatedBy: .equal,
                               toItem: self,
                               attribute: .right,
                               multiplier: 1.0,
                               constant: 0)
            ])
    }
    
}

internal protocol NibView where Self: UIView {
    
}

extension NibView {
    
    func xibSetup() {
        backgroundColor = .clear
        let view = loadViewFromNib()
        addEdgeConstrainedSubView(view: view)
    }
    
    fileprivate func loadViewFromNib<T: UIView>() -> T {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? T else {
            fatalError("Cannot instantiate a UIView from the nib for class \(type(of: self))")
        }
        return view
    }
    
}

extension HomeViewController {
    var loanModels: [LoanCard] {
        let andrew = LoanCard(quantity: 15.50, interestRate: 2, purpose: "Refurbish my yard", name: "Andrew M.", rating: 87)
        let angelina = LoanCard(quantity: 30.50, interestRate: 5, purpose: "Pay for dog food", name: "Angelina J.", rating: 50)
        let nicole = LoanCard(quantity: 33.33, interestRate: 3, purpose: "Grow more plants", name: "Nicole M.", rating: 67)
        let bryan = LoanCard(quantity: 44.50, interestRate: 1, purpose: "Purchase groceries", name: "Bryan C.", rating: 34)
        return [andrew,angelina,nicole,bryan]
    }
}

struct LoanCard {
    let quantity: Float
    let interestRate: Int
    let purpose: String
    let name: String
    let rating: Int
}
