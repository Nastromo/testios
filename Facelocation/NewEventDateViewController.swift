//
//  NewEventDateViewController.swift
//  Facelocation
//
//  Created by Nastro Mo on 20.03.2018.
//  Copyright © 2018 Facelocation. All rights reserved.
//

import UIKit
import Alamofire

class NewEventDateViewController: UIViewController {
    
    let requestURL = URLlist.baseURL + URLlist.createEventPOST

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func createEvent(_ sender: Any) {
        let parameters: Parameters = [
            "title": Event.title ?? nil,
            "type": Event.type,
            "text": Event.text ?? nil,
            "start": "2018-01-01T00:00:00.000Z",
            "end": "2018-01-01T00:00:00.000Z",
            "isPrivate": false,
            "locations": [["location":"\(Event.locationID!)"]],
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
                                    let data = response.result.value as! Dictionary<String, Any>
                                    let eventID = data["_id"] as! String
                                    self.uploadImage(eventID: eventID)
                                    
                                    print("ИВЕНТ ДОБАВЛЕН УСПЕШНО! - \(eventID)")
                                    self.performSegue(withIdentifier: "eventCreated", sender: self)
                                }
                            case .failure(let error):
                                
                                print(error)
                            }
        }
    }
    
    func uploadImage(eventID: String){
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                multipartFormData.append(Event.imageURL!, withName: "file")
        },
            usingThreshold:UInt64.init(),
            to: "https://face-location.com/api/events/\(eventID)/upload-cover",
            method:.post,
            headers: URLlist.headers,
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        debugPrint(response)
                    }
                case .failure(let encodingError):
                    print(encodingError)
                }
        }
        )
    }
}
