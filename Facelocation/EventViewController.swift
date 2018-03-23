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
    var urlRequest: String?
    var eventTitleText: String?
    var locationTitle: String?
    var eventCoverURL: String?
    var eventDesc: String?
    var eventCreatorURL: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    func getEvent(){
        
        ChatUserList.chatUserList = [ChatUser]()
        ChatUserList.chatUserListCopy = [ChatUser]()
        
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
        urlRequest = URLlist.baseURL + URLlist.getAllChatsGET
        getEvent()
        getChats()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        GroupChatList.groupChatsListCopy = GroupChatList.groupChatsList
        GroupChatList.groupChatsList.removeAll()
        
        ChatUserList.chatUserListCopy = ChatUserList.chatUserList
        ChatUserList.chatUserList.removeAll()
    }
    
    
    //Localize on the event
    @IBAction func localize(_ sender: Any) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Назад", style: .plain, target: nil, action: nil)
        localize()
    }
    
    
    //Localize user on event
    func localize(){
        let requestURL = URLlist.baseURL + URLlist.localizeUserPOST
        let parameters: Parameters = [
            "latitude": Coordinates.latitude!,
            "longitude": Coordinates.longitude!
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
                                    print("ЛОКАЛИЗАЦИЯ ВЫПОЛНЕНА УСПЕШНО")
                                    self.performSegue(withIdentifier: "toLocalized", sender: self)
                                } else {
                                    print("НУЖНО БЫТЬ в РАДИУСЕ ЛОКАЦИИ")
                                }
                            case .failure(let error):
                                
                                print(error)
                            }
            }
    }
    
    //Navigation Bar Setup
    func navigationBarSetup(){
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = Colors.mainColor
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Назад", style: .plain, target: nil, action: nil)
    }
    
    //Get all event's chats
    func getChats(){
        
        GroupChatList.groupChatsList = [GroupChat]()
        GroupChatList.groupChatsListCopy = [GroupChat]()
        print("ГРУПОВЫЕ ЧАТЫ ДЛЯ ИВЕНТА ID: \(Event.eventID!)")
        
        let parameters: Parameters = [
            "event": Event.eventID!,
        ]
        
        Alamofire.request(urlRequest!,
                          method: .get,
                          parameters: parameters,
                          encoding: URLEncoding.default,
                          headers: URLlist.headers).responseJSON {response in
                            
                            switch response.result {
                            case .success:
                                if response.response?.statusCode == 200{
                                    let array = response.result.value as! Array<Any>
                                    for item in array {
                                        let chat = item as! Dictionary<String, Any>
                                        let chatType = chat["type"] as! Int
                                        if chatType == 2 {
                                            let groupChatTitle = chat["title"] as! String
                                            let groupChat = GroupChat(chatTitle: groupChatTitle)
                                            GroupChatList.groupChatsList.append(groupChat)
                                        }
                                    }
                                    
                                    print("ЧАТЫ ПОЛУЧЕНЫ УСПЕШНО! - EVENT ID \(Event.eventID!) + \(GroupChatList.groupChatsList.count)")
                                }
                            case .failure(let error):
                                print("ОШИБКА ПОЛУЧЕНИЯ ЧАТОВ")
                                print(error)
                            }
        }
    }
}
