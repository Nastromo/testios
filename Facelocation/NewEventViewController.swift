//
//  NewEventViewController.swift
//  Facelocation
//
//  Created by Nastro Mo on 19.03.2018.
//  Copyright © 2018 Facelocation. All rights reserved.
//

import UIKit

class NewEventViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
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
        Event.type = row
    }

}
