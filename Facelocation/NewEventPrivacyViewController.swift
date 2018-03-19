//
//  NewEventPrivacyViewController.swift
//  Facelocation
//
//  Created by Nastro Mo on 19.03.2018.
//  Copyright © 2018 Facelocation. All rights reserved.
//

import UIKit

class NewEventPrivacyViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    

    @IBOutlet weak var privacyPicker: UIPickerView!
    
    let privacyTypes = [
        "Відкрита",
        "По запрошенню"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        privacyPicker.delegate = self
        Event.isPrivate = false
    }
    
    
    //
    //Have to implement a separate method for Photo uploading
    //
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return privacyTypes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return privacyTypes[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
    }

}
