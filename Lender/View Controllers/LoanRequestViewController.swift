//
//  LoanRequestViewController.swift
//  Lender
//
//  Created by Atomo on 11/7/18.
//  Copyright © 2018 Atomo. All rights reserved.
//

import UIKit

class LoanRequestViewController: UIViewController {

    @IBOutlet weak var incrementField: UITextField!
    @IBOutlet weak var paymentField: UITextField!
    @IBOutlet weak var interestField: UITextField!
    @IBOutlet weak var quantField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func submitAction(_ sender: Any) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func backAction(_ sender: Any) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
