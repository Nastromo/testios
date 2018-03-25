//
//  MyEventsViewController.swift
//  Facelocation
//
//  Created by Nastro Mo on 25.03.2018.
//  Copyright © 2018 Facelocation. All rights reserved.
//

import UIKit

class MyEventsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Назад", style: .plain, target: nil, action: nil)
    }
}
