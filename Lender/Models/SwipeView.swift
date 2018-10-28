//
//  SwipeView.swift
//  Lender
//
//  Created by Atomo on 10/27/18.
//  Copyright © 2018 Atomo. All rights reserved.
//

import UIKit
import pop

class SwipeView: UIView {
    
    var delegate: SwipeViewDelegate?
    
    private var panGestureRecognizer: UIPanGestureRecognizer?
    
    private var panGestureTranslation: CGPoint = .zero
    
    private var tapGestureRecognizer: UITapGestureRecognizer?
    
    static var maximumRotation: CGFloat = 1.0
    
    static var rotationAngle: CGFloat = CGFloat(Double.pi) / 10.0
    
    static var animationDirectionY: CGFloat = 1.0
    
    static var swipePercentageMargin: CGFloat = 0.6
    
    static var finalizeSwipeActionAnimationDuration: TimeInterval = 0.8

    static var cardViewResetAnimationSpringBounciness: CGFloat = 10.0
    
    static var cardViewResetAnimationSpringSpeed: CGFloat = 20.0
    
    static var cardViewResetAnimationDuration: TimeInterval = 0.2
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupGestureRecognizers()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupGestureRecognizers()
    }
    
    deinit {
        if let panGestureRecognizer = panGestureRecognizer {
            removeGestureRecognizer(panGestureRecognizer)
        }
        if let tapGestureRecognizer = tapGestureRecognizer {
            removeGestureRecognizer(tapGestureRecognizer)
        }
    }
    
    private func setupGestureRecognizers() {
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(SwipeView.panGestureRecognized(_:)))
        self.panGestureRecognizer = panGestureRecognizer
        addGestureRecognizer(panGestureRecognizer)
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapRecognized(_:)))
        self.tapGestureRecognizer = tapGestureRecognizer
        addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc private func panGestureRecognized(_ gestureRecognizer: UIPanGestureRecognizer) {
        panGestureTranslation = gestureRecognizer.translation(in: self)
        switch gestureRecognizer.state {
        case .began:
            let initialTouchPoint = gestureRecognizer.location(in: self)
            let newAnchorPoint = CGPoint(x: initialTouchPoint.x / bounds.width, y: initialTouchPoint.y / bounds.height)
            let oldPosition = CGPoint(x: bounds.size.width * layer.anchorPoint.x, y: bounds.size.height * layer.anchorPoint.y)
            let newPosition = CGPoint(x: bounds.size.width * newAnchorPoint.x, y: bounds.size.height * newAnchorPoint.y)
            layer.anchorPoint = newAnchorPoint
            layer.position = CGPoint(x: layer.position.x - oldPosition.x + newPosition.x, y: layer.position.y - oldPosition.y + newPosition.y)
            removeAnimations()
            layer.rasterizationScale = UIScreen.main.scale
            layer.shouldRasterize = true
        case .changed:
            let rotationStrength = min(panGestureTranslation.x / frame.width, SwipeView.maximumRotation)
            let rotationAngle = SwipeView.animationDirectionY * SwipeView.rotationAngle * rotationStrength
            var transform = CATransform3DIdentity
            transform = CATransform3DRotate(transform, rotationAngle, 0, 0, 1)
            transform = CATransform3DTranslate(transform, panGestureTranslation.x, panGestureTranslation.y, 0)
            layer.transform = transform
        case .ended:
            endedPanAnimation()
            layer.shouldRasterize = false
        default:
            resetCardViewPosition()
            layer.shouldRasterize = false
        }
    }
    
    private var dragDirection: Swipe? {
        let normalizedDragPoint = panGestureTranslation.normalizedDistanceForSize(bounds.size)
        return Swipe.allDirections.reduce((distance: CGFloat.infinity, direction: nil), { closest, direction -> (CGFloat, Swipe?) in
            let distance = direction.point.distanceTo(normalizedDragPoint)
            if distance < closest.distance {
                return (distance, direction)
            }
            return closest
        }).direction
    }
    
    private var dragPercentage: CGFloat {
        guard let dragDirection = dragDirection else { return 0.0 }
        
        let normalizedDragPoint = panGestureTranslation.normalizedDistanceForSize(frame.size)
        let swipePoint = normalizedDragPoint.scalarProjectionPointWith(dragDirection.point)
        
        let rect = Swipe.boundsRect
        
        if !rect.contains(swipePoint) {
            return 1.0
        } else {
            let centerDistance = swipePoint.distanceTo(.zero)
            let targetLine = (swipePoint, CGPoint.zero)
            
            return rect.perimeterLines
                .flatMap { CGPoint.intersectionBetweenLines(targetLine, line2: $0) }
                .map { centerDistance / $0.distanceTo(.zero) }
                .min() ?? 0.0
        }
    }
    
    private func endedPanAnimation() {
        if let dragDirection = dragDirection, dragPercentage >= SwipeView.swipePercentageMargin {
            let translationAnimation = POPBasicAnimation(propertyNamed: kPOPLayerTranslationXY)
            translationAnimation?.duration = SwipeView.finalizeSwipeActionAnimationDuration
            translationAnimation?.fromValue = NSValue(cgPoint: POPLayerGetTranslationXY(layer))
            translationAnimation?.toValue = NSValue(cgPoint: animationPointForDirection(dragDirection))
            layer.pop_add(translationAnimation, forKey: "swipeTranslationAnimation")
            self.delegate?.didEndSwipe(onView: self)
        } else {
            resetCardViewPosition()
        }
    }
    
    private func animationPointForDirection(_ direction: Swipe) -> CGPoint {
        let point = direction.point
        let animatePoint = CGPoint(x: point.x * 4, y: point.y * 4)
        let retPoint = animatePoint.screenPointForSize(UIScreen.main.bounds.size)
        return retPoint
    }
    
    private func resetCardViewPosition() {
        removeAnimations()
        
        // Reset Translation
        let resetPositionAnimation = POPSpringAnimation(propertyNamed: kPOPLayerTranslationXY)
        resetPositionAnimation?.fromValue = NSValue(cgPoint:POPLayerGetTranslationXY(layer))
        resetPositionAnimation?.toValue = NSValue(cgPoint: CGPoint.zero)
        resetPositionAnimation?.springBounciness = SwipeView.cardViewResetAnimationSpringBounciness
        resetPositionAnimation?.springSpeed = SwipeView.cardViewResetAnimationSpringSpeed
        resetPositionAnimation?.completionBlock = { _, _ in
            self.layer.transform = CATransform3DIdentity
        }
        layer.pop_add(resetPositionAnimation, forKey: "resetPositionAnimation")
        let resetRotationAnimation = POPBasicAnimation(propertyNamed: kPOPLayerRotation)
        resetRotationAnimation?.fromValue = POPLayerGetRotationZ(layer)
        resetRotationAnimation?.toValue = CGFloat(0.0)
        resetRotationAnimation?.duration = SwipeView.cardViewResetAnimationDuration
        layer.pop_add(resetRotationAnimation, forKey: "resetRotationAnimation")
    }
    
    private func removeAnimations() {
        pop_removeAllAnimations()
        layer.pop_removeAllAnimations()
    }

    @objc private func tapRecognized(_ recognizer: UITapGestureRecognizer) {
        delegate?.didTap(view: self)
    }
    
}
