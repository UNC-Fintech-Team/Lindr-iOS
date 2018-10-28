//
//  CardContainerView.swift
//  Lender
//
//  Created by Atomo on 10/27/18.
//  Copyright © 2018 Atomo. All rights reserved.
//

import UIKit

class CardContainerView: UIView, SwipeViewDelegate {

    static let horizontalInset: CGFloat = 12.0
    
    static let verticalInset: CGFloat = 12.0
    
    var dataSource: CardContainerViewDataSource? {
        didSet {
            reloadData()
        }
    }
    
    var delegate: CardContainerViewDelegate?
    
    private var cardViews: [Card] = []
    
    private var visibleCardViews: [Card] {
        return subviews as? [Card] ?? []
    }
    
    fileprivate var remainingCards: Int = 0
    
    static let numberOfVisibleCards: Int = 3
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = .clear
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func reloadData() {
        removeAllCardViews()
        guard let dataSource = dataSource else {
            return
        }
        
        let numberOfCards = dataSource.numberOfCards()
        remainingCards = numberOfCards
        
        for index in 0..<min(numberOfCards, CardContainerView.numberOfVisibleCards) {
            addCardView(cardView: dataSource.cardAtIndex(index: index), atIndex: index)
        }
        
        if let emptyView = dataSource.emptyState() {
            addEdgeConstrainedSubView(view: emptyView)
        }
        
        setNeedsLayout()
    }
    
    private func addCardView(cardView: Card, atIndex index: Int) {
        cardView.delegate = self
        setFrame(forCardView: cardView, atIndex: index)
        cardViews.append(cardView)
        insertSubview(cardView, at: 0)
        remainingCards -= 1
    }
    
    private func removeAllCardViews() {
        for cardView in visibleCardViews {
            cardView.removeFromSuperview()
        }
        cardViews = []
    }
    
    private func setFrame(forCardView cardView: Card, atIndex index: Int) {
        var cardViewFrame = bounds
        let horizontalInset = (CGFloat(index) * CardContainerView.horizontalInset)
        let verticalInset = CGFloat(index) * CardContainerView.verticalInset
        
        cardViewFrame.size.width -= 2 * horizontalInset
        cardViewFrame.origin.x += horizontalInset
        cardViewFrame.origin.y += verticalInset
        
        cardView.frame = cardViewFrame
    }
    
    func didTap(view: SwipeView) {
        if let cardView = view as? Card,
            let index = cardViews.index(of: cardView) {
            delegate?.didChoose(card: cardView, index: index)
        }
    }
    
    func didEndSwipe(onView view: SwipeView) {
        guard let dataSource = dataSource else {
            return
        }
        
        view.removeFromSuperview()
        
        if remainingCards > 0 {
            
            let newIndex = dataSource.numberOfCards() - remainingCards
            addCardView(cardView: dataSource.cardAtIndex(index: newIndex), atIndex: 2)
            for (cardIndex, cardView) in visibleCardViews.reversed().enumerated() {
                UIView.animate(withDuration: 0.2, animations: {
                    cardView.center = self.center
                    self.setFrame(forCardView: cardView, atIndex: cardIndex)
                    self.layoutIfNeeded()
                })
            }
            
        }
    }

}
