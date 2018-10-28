//
//  HomeViewController.swift
//  Lender
//
//  Created by Atomo on 10/27/18.
//  Copyright © 2018 Atomo. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, CardContainerViewDataSource {
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var matchesButton: UIButton!
    @IBOutlet weak var containerView: CardContainerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        containerView.dataSource = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfCards() -> Int {
        return loanModels.count
    }
    
    func cardAtIndex(index: Int) -> Card {
        let viewModel = loanModels[index]
        let cardView = SampleCard()
        cardView.viewModel = viewModel
        return cardView
    }
    
    func emptyState() -> UIView? {
        return nil
    }
    

    
}
