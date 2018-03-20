//
//  NewEventPrivacyViewController.swift
//  Facelocation
//
//  Created by Nastro Mo on 19.03.2018.
//  Copyright © 2018 Facelocation. All rights reserved.
//

import UIKit

class NewEventPrivacyViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {

    

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
    
    
    //Photo choosing
    @IBAction func choseEventPhoto(_ sender: Any) {
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.photoLibrary
        image.allowsEditing = false
        self.present(image, animated: true, completion: nil)
        
    }
    
    //When user has chosen the image
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
            
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func goNext(_ sender: Any) {
        self.performSegue(withIdentifier: "toCapacity", sender: self)
    }
    
    
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
