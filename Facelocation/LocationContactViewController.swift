//
//  LocationContactViewController.swift
//  Facelocation
//
//  Created by Nastro Mo on 19.03.2018.
//  Copyright © 2018 Facelocation. All rights reserved.
//

import UIKit
import Alamofire

class LocationContactViewController: UIViewController {

    @IBOutlet weak var contact: UITextField!
    
    let requestURL = URLlist.baseURL + URLlist.createLocationPOST
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    @IBAction func getContact(_ sender: Any) {
        Location.contact = contact.text
        addNewLocation()
    }
    
    func addNewLocation(){
        
        let parameters: Parameters = [
            "title": Location.title ?? "nil",
            "text": Location.text ?? "nil",
            "contact": Location.contact ?? 0,
            "longitude": Location.longitude ?? 0,
            "latitude": Location.latitude ?? 0,
            "published": true
        ]
        Alamofire.request(requestURL,
                          method: .post,
                          parameters: parameters,
                          encoding: JSONEncoding.default,
                          headers: URLlist.headers).responseJSON {response in
                            
                            switch response.result {
                            case .success:
                                print(response)
                                if response.response?.statusCode == 200{
                                    let data =  response.result.value as! Dictionary<String, Any>
                                    let locationID = data["_id"] as! String
                                    Event.locationID = locationID
                                    self.performSegue(withIdentifier: "toCreateEventSteps", sender: self)
                                    print("ДОБАВЛЕНИЕ ЛОКАЦИИ ПРОШЛО УСПЕШНО! - \(locationID)")
                                }
                            case .failure(let error):
                                
                                print(error)
                            }
        }
    }
}
