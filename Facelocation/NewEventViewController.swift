//
//  NewEventViewController.swift
//  Facelocation
//
//  Created by Nastro Mo on 19.03.2018.
//  Copyright © 2018 Facelocation. All rights reserved.
//

import UIKit

class NewEventViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var typePicker: UIPickerView!
    @IBOutlet weak var eventTitle: UITextField!
    
    let eventTypes = [
        "концерт",
        "бізнес",
        "розваги",
        "акції",
        "спорт",
        "зустріч",
        "кафе",
        "семінар",
        "конференція",
        "тренінг"
    ]

    var selectedType: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        typePicker.delegate = self
        eventTitle.delegate = self
    }
    
    //Hide keyboard by clickin anywhere (UITextFieldDelegate)
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //Hide keyboard by clicking return btn
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        eventTitle.resignFirstResponder()
        return true
    }
    
    @IBAction func goNext(_ sender: Any) {
        Event.title = eventTitle.text
        self.performSegue(withIdentifier: "toAboutEvent", sender: self)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return eventTypes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return eventTypes[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedType = eventTypes[row]
        Event.type = 0
        Event.type = row
    }

}
