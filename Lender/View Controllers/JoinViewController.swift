//
//  JoinViewController.swift
//  Lender
//
//  Created by Atomo on 10/27/18.
//  Copyright © 2018 Atomo. All rights reserved.
//

import UIKit

class JoinViewController: UIViewController {

    @IBOutlet weak var fnameField: UITextField!
    @IBOutlet weak var bioField: UITextView!
    @IBOutlet weak var passField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var lnameField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        bioField.layer.cornerRadius = 5
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func backAction(_ sender: Any) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }

}
