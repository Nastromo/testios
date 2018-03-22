//
//  EventViewController.swift
//  Facelocation
//
//  Created by Nastro Mo on 21.03.2018.
//  Copyright © 2018 Facelocation. All rights reserved.
//

import UIKit
import Alamofire

class EventViewController: UIViewController {
    
    @IBOutlet weak var eventTitle: UILabel!
    @IBOutlet weak var eventAddress: UILabel!
    @IBOutlet weak var eventDate: UILabel!
    
    @IBOutlet weak var eventLocationTitle: UILabel!
    @IBOutlet weak var eventImage: UIImageView!
    @IBOutlet weak var eventCreator: UIImageView!
    @IBOutlet weak var userQuantity: UILabel!
    
    @IBOutlet weak var eventDescription: UITextView!
    
    var requestURL: String?
    var eventTitleText: String?
    var locationTitle: String?
    var eventCoverURL: String?
    var eventDesc: String?
    var eventCreatorURL: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    func getEvent(){
        Alamofire.request(requestURL!,
                          method: .get,
                          encoding: URLEncoding.default,
                          headers: URLlist.headers).responseJSON {response in

                            switch response.result {
                            case .success:
                                if response.response?.statusCode == 200{
                                    let response =  response.result.value as! Dictionary<String, Any>
                                    self.eventTitleText = response["title"] as! String
                                    let locations = response["locations"] as! Array<Any>
                                    for location in locations{
                                        let data = location as! Dictionary<String, Any>
                                        self.locationTitle = data["title"] as! String
                                    }
                                    let cover = response["cover"] as! Dictionary<String, Any>
                                    self.eventCoverURL = cover["location_mob"] as! String
                                    self.eventDesc = response["text"] as! String
                                    let userObj = response["user"] as! Dictionary<String, Any>
                                    
                                    let subscribers = response["subscribers"] as! Array<Any>
                                    self.userQuantity.text = String(subscribers.count)
                                    for subscriber in subscribers{
                                        let subData = subscriber as? Dictionary<String, Any>
                                        let userData = subData!["user"] as? Dictionary<String, Any>
                                        
                                        let subName = userData!["username"] as? String ?? "Ім'я не вказано"
                                        let subID = userData!["_id"] as! String
                                        let subEmail = userData!["email"] as! String
                                        let avatar_mob = userData!["avatar_mob"] as! String
                                        
                                        let chatUser = ChatUser(userName: subName, userID: subID, userEmail: subEmail, userAvatar: avatar_mob)
                                        ChatUserList.chatUserList.append(chatUser)
                                    }
                                    
                                    self.eventCreatorURL = userObj["avatar_mob"] as! String
                                    
                                    self.eventTitle.text = self.eventTitleText
                                    self.eventLocationTitle.text = self.locationTitle
                                    self.eventDescription.text = self.eventDesc
                                    
                                    let date = Date()
                                    let calendar = Calendar.current
                                    let day = calendar.component(.day, from: date)
                                    let month = calendar.component(.month, from: date)
                                    let year = calendar.component(.year, from: date)
                                    self.eventDate.text = "\(day).\(month).\(year)"
                                    
                                    //Set Avatar for event creator
                                    let avatarURL = URL(string: self.eventCreatorURL!)
                                    let data = try? Data(contentsOf: avatarURL!)
                                    self.eventCreator.image = UIImage(data: data!)
                                    self.eventCreator.layer.cornerRadius = 17.5;
                                    self.eventCreator.layer.masksToBounds = true;
                                    
                                    //Set Event Cover
                                    let eventCoverURL = URL(string: self.eventCoverURL!)
                                    let dataCover = try? Data(contentsOf: eventCoverURL!)
                                    self.eventImage.image = UIImage(data: dataCover!)
                                    self.eventImage.contentMode = .scaleAspectFill
                                    self.eventImage.layer.masksToBounds = true
                                    
                                }
                            case .failure(let error):
                                print("ОШИБКА ПОЛУЧЕНИЯ ДАННЫХ ИВЕНТА")
                                print(error)
                            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationBarSetup()
        requestURL = "\(URLlist.baseURL)api/events/\(Event.eventID!)"
        getEvent()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        ChatUserList.chatUserListCopy = ChatUserList.chatUserList
        ChatUserList.chatUserList.removeAll()
    }
    
    //Localize on the event
    @IBAction func localize(_ sender: Any) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Назад", style: .plain, target: nil, action: nil)
        self.performSegue(withIdentifier: "toLocalized", sender: self)
    }
    

    
    //Navigation Bar Setup
    func navigationBarSetup(){
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = Colors.mainColor
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Назад", style: .plain, target: nil, action: nil)
    }


}
