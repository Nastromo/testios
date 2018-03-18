//
//  RegFirstViewController.swift
//  Facelocation
//
//  Created by Nastro Mo on 18.03.2018.
//  Copyright © 2018 Facelocation. All rights reserved.
//

import UIKit

class RegFirstViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBarSetup()
        
    }

    @IBAction func nextStep(_ sender: Any) {
        if (!(emailField.text?.isEmpty)!) {
            Registration.setEmail(email: emailField.text!)
            self.performSegue(withIdentifier: "nextStep", sender: self)
        }
    }
    
    //Navigation Bar Setup
    func navigationBarSetup(){
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Назад", style: .plain, target: nil, action: nil)
    }
}
