//
//  NewEventAboutViewController.swift
//  Facelocation
//
//  Created by Nastro Mo on 19.03.2018.
//  Copyright © 2018 Facelocation. All rights reserved.
//

import UIKit

class NewEventAboutViewController: UIViewController {

    @IBOutlet weak var desc: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let myColor = UIColor(red: 146/255, green: 150/255, blue: 248/255, alpha: 1)
        desc.layer.borderColor = myColor.cgColor
        desc.layer.borderWidth = 4
    }
    
    @IBAction func goNext(_ sender: Any) {
        Event.text = "Опис події"
        Event.text = desc.text
        self.performSegue(withIdentifier: "toPrivacy", sender: self)
    }
}
