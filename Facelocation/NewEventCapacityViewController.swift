//
//  NewEventCapacityViewController.swift
//  Facelocation
//
//  Created by Nastro Mo on 20.03.2018.
//  Copyright © 2018 Facelocation. All rights reserved.
//

import UIKit

class NewEventCapacityViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var periodPicker: UIPickerView!
    @IBOutlet weak var capacity: UITextField!
    
    let periodTypes = [
        "Одноразова",
        "Щотижнева",
        "Без кінця"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        periodPicker.delegate = self
        
    }

    @IBAction func goNext(_ sender: Any) {
        self.performSegue(withIdentifier: "toEventDate", sender: self)
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return periodTypes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return periodTypes[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
    }
}
