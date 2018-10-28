//
//  SwipeView.swift
//  Lender
//
//  Created by Atomo on 10/27/18.
//  Copyright © 2018 Atomo. All rights reserved.
//

import UIKit

class SampleCard: Card {

    @IBOutlet private weak var quantityLabel: UILabel!
    @IBOutlet private weak var scoreLabel: UILabel!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var descriptionView: UITextView!
    @IBOutlet private weak var interestLabel: UILabel!
    @IBOutlet private weak var imageBackgroundColorView: UIView!
    @IBOutlet private weak var backgroundContainerView: UIView!

    private weak var shadowView: UIView?
    private static let kInnerMargin: CGFloat = 20.0

    var viewModel: LoanCard? {
        didSet {
            configure(forViewModel: viewModel)
        }
    }

    private func configure(forViewModel viewModel: LoanCard?) {
        if let viewModel = viewModel {
            nameLabel.text = viewModel.name
            descriptionView.text = "\"\(viewModel.purpose)\""
            quantityLabel.text = String(format: "$%.2f", viewModel.quantity)
            interestLabel.text = "\(viewModel.interestRate)%"
            scoreLabel.text = "\(viewModel.rating)/100"
            backgroundContainerView.layer.cornerRadius = 14.0
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        configureShadow()
    }

    private func configureShadow() {
        self.shadowView?.removeFromSuperview()
        let shadowView = UIView(frame: CGRect(x: SampleCard.kInnerMargin,
                                              y: SampleCard.kInnerMargin,
                                              width: bounds.width - (2 * SampleCard.kInnerMargin),
                                              height: bounds.height - (2 * SampleCard.kInnerMargin)))
        insertSubview(shadowView, at: 0)
        self.shadowView = shadowView
        self.applyShadow(width: CGFloat(0.0), height: CGFloat(0.0))
    }

    private func applyShadow(width: CGFloat, height: CGFloat) {
        if let shadowView = shadowView {
            let shadowPath = UIBezierPath(roundedRect: shadowView.bounds, cornerRadius: 14.0)
            shadowView.layer.masksToBounds = false
            shadowView.layer.shadowRadius = 8.0
            shadowView.layer.shadowColor = UIColor.black.cgColor
            shadowView.layer.shadowOffset = CGSize(width: width, height: height)
            shadowView.layer.shadowOpacity = 0.15
            shadowView.layer.shadowPath = shadowPath.cgPath
        }
    }

}
