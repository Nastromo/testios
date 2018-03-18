//
//  RegSecondViewController.swift
//  Facelocation
//
//  Created by Nastro Mo on 18.03.2018.
//  Copyright © 2018 Facelocation. All rights reserved.
//

import UIKit
import Alamofire

class RegSecondViewController: UIViewController {

    @IBOutlet weak var passField: UITextField!
    
    let requestURL = URLlist.baseURL + URLlist.registrationPOST
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func registerUser(_ sender: Any) {
        if (!(passField.text?.isEmpty)!){
            doRegistration(email: Registration.getEmail(), pass: passField.text!)
        }
    }
    
    //User Registration Logic
    func doRegistration(email: String, pass: String){
        let parameters: Parameters = [
            "email": email,
            "password": pass
        ]
        Alamofire.request(requestURL,
                          method: .post,
                          parameters: parameters,
                          encoding: JSONEncoding.default,
                          headers: URLlist.simpleHeaders).responseJSON {response in
                            
                            switch response.result {
                            case .success:
                                print(response)
                                if response.response?.statusCode == 200{
                                    let responseJSON =  response.result.value
                                    let registrationOBJ: Dictionary = responseJSON as! Dictionary<String, Any>
                                    let userToken: String = registrationOBJ["token"] as! String

                                    let userOBJ: Dictionary = registrationOBJ["user"] as! Dictionary<String, Any>
                                    let userID: String = userOBJ["_id"] as! String
                                    let userAvatar: String = userOBJ["avatar_mob"] as! String
                                    let userEmail: String = userOBJ["email"] as! String

                                    self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
                                    self.navigationController?.navigationBar.shadowImage = nil

                                    self.navigationController?.navigationBar.barTintColor = Colors.mainColor
                                    self.navigationController?.navigationBar.isTranslucent = false

                                    self.performSegue(withIdentifier: "toMainMapScreen", sender: self)
                                }
                            case .failure(let error):
                                
                                print(error)
                            }
        }
    }
}
