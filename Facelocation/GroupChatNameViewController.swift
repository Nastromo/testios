//
//  GroupChatNameViewController.swift
//  Facelocation
//
//  Created by Nastro Mo on 22.03.2018.
//  Copyright © 2018 Facelocation. All rights reserved.
//

import UIKit

class GroupChatNameViewController: UIViewController {

    @IBOutlet weak var chatName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func goNext(_ sender: Any) {
        GroupChat.name = chatName.text
        self.performSegue(withIdentifier: "toChatUserChose", sender: self)
        
        
        
    }
    
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true)
    }
    
}
