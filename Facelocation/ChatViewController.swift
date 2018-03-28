//
//  ChatViewController.swift
//  Facelocation
//
//  Created by Nastro Mo on 16.03.2018.
//  Copyright © 2018 Facelocation. All rights reserved.
//

import UIKit
import Alamofire
import SocketIO
import SDWebImage

class ChatViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let myDBid = DataBaseHelper.userDataArray[0]
    var myCollectionView: UICollectionView?
    var userID: String?
    var groupChatID: String?
    var messagesArray: [Message]?
    var chatID: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpChatLogCollection()
        setupMyCollectionConstarints()
        setupBottomMyCollectionConstaraint()
        
        view.addSubview(backRectangl)
        setupBackRectanglConstarints()
        setupBottomBackRectangleConstaraint()

        backRectangl.addSubview(messegeField)
        setupMessegeFieldConstarints()

        backRectangl.addSubview(sendButton)
        setupSendButtonConstarints()
        
        //Listen when keyboard appears
        NotificationCenter.default.addObserver(self, selector: #selector(hundleKeyboardShowing), name: .UIKeyboardWillShow, object: nil)
        
        //Listen when keyboard hide
        NotificationCenter.default.addObserver(self, selector: #selector(hundleKeyboardHiding), name: .UIKeyboardWillHide, object: nil)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("МОЙ АЙДИ - \(myDBid)")
        SocketIOManager.connectSocket()
        if self.userID != nil {
            print("ВЫПОЛНЕНИЕ НАЧАЛОСЬ ОДИН НА ОДИН")
            print("АЙДИ ЮЗЕРА НА КОТОРОГО НАЖАЛИ - \(self.userID!)")
            createChat()
            
            
        } else {
            print("ВЫПОЛНЕНИЕ НАЧАЛОСЬ ГРУППОВОЙ ЧАТ")
            print("АЙДИ ЧАТА НА КОТОРЫЙ НАЖАЛИ - \(self.groupChatID!)")
            getGroupChat()
            
            if ("\(SocketIOManager.socket.status)" == "connected"){
                print("\(SocketIOManager.socket.status) - СТАТУС СОКЕТА НА ЭКРАНЕ ГРУППОВОГО ЧАТА")
                SocketIOManager.connectToChat(chat: self.groupChatID!, user: self.myDBid)
            } else {
                print("\(SocketIOManager.socket.status) - СТАТУС СОКЕТА НА ЭКРАНЕ ГРУППОВОГО ЧАТА")
                SocketIOManager.onConnected(chat: self.groupChatID!, user: self.myDBid)
            }

            SocketIOManager.socket.on("new-message-mob", callback: { [weak self] (dataArray, ack) in
                print(dataArray)
                print("ПОЛУЧИЛ ГРУППОВОЕ СООБЩЕНИЕ")
                for data in dataArray{
                    let messageObj = data as! Dictionary<String, Any>
                    let message = messageObj["message"] as! Dictionary<String, Any>
                    let userID = message["user"] as! String
                    let userAvatar = message["avatar_mob"] as! String
                    let userText = message["text"] as! String
                    
                    let newMessage = Message(userName: "myName", userID: userID, userEmail: "myEmail", userAvatar: userAvatar, userText: userText)
                    
                    self?.messagesArray?.append(newMessage)
                    let insertionIndex = (self?.messagesArray!.count)! - 1
                    let indexPath = IndexPath(item: insertionIndex, section: 0)
                    var indexPathArray = [IndexPath]()
                    indexPathArray.append(indexPath)
                    self?.myCollectionView?.insertItems(at: indexPathArray)
                    self?.myCollectionView?.scrollToItem(at: indexPath, at: .bottom, animated: true)
                }
            })
        }
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        SocketIOManager.disconnectSocket()
        SocketIOManager.removeListener()
    }
    
    
    //Create chat if not exist else get messages from returned chat
    func createChat(){
        
        self.messagesArray = [Message]()
        let requestURL = URLlist.baseURL + URLlist.createChatPOST
        let parameters: Parameters = [
            "event": Event.eventID!,
            "type": 1,
            "user": [self.myDBid, self.userID]
        ]
        
        Alamofire.request(requestURL,
                          method: .post,
                          parameters: parameters,
                          encoding: JSONEncoding.default,
                          headers: URLlist.headers).responseJSON {response in
                            
                            switch response.result {
                            case .success:
                                if response.response?.statusCode == 200{
                                    let chatObj = response.result.value as! Dictionary<String, Any>
                                    self.chatID = chatObj["_id"] as! String
                                    let messages = chatObj["messages"] as! Array<Any>
                                    for message in messages {
                                        let messageObj = message as! Dictionary<String, Any>
                                        
                                        let userText = messageObj["text"] as! String
                                        
                                        let user = messageObj["user"] as! Dictionary<String, Any>
                                        
                                        let userID = user["_id"] as! String
                                        let userEmail = user["email"] as! String
                                        let userName = user["username"] as? String
                                        let userAvatar = user["avatar_mob"] as! String
                                        
                                        let message = Message(userName: userName ?? "Имя не указано", userID: userID, userEmail: userEmail, userAvatar: userAvatar, userText: userText)
                                        
                                        self.messagesArray?.append(message)
                                        self.myCollectionView?.reloadData()
                                        
                                    }
                                    
                                    if ("\(SocketIOManager.socket.status)" == "connected"){
                                        print("\(SocketIOManager.socket.status) - СТАТУС СОКЕТА НА ЭКРАНЕ ЧАТА ОДИН НА ОДИН")
                                        SocketIOManager.connectToChat(chat: self.chatID!, user: self.myDBid)
                                    } else {
                                        print("\(SocketIOManager.socket.status) - СТАТУС СОКЕТА НА ЭКРАНЕ ЧАТА ОДИН НА ОДИН")
                                        SocketIOManager.onConnected(chat: self.chatID!, user: self.myDBid)
                                    }
                                    
                                    SocketIOManager.socket.on("new-message-mob", callback: { [weak self] (dataArray, ack) in
                                        print(dataArray)
                                        print("ПОЛУЧИЛ ЛИЧНОЕ СООБЩЕНИЕ")
                                        
                                        for data in dataArray{
                                            let messageObj = data as! Dictionary<String, Any>
                                            let message = messageObj["message"] as! Dictionary<String, Any>
                                            let userID = message["user"] as! String
                                            let userAvatar = message["avatar_mob"] as! String
                                            let userText = message["text"] as! String
                                            
                                            let newMessage = Message(userName: "myName", userID: userID, userEmail: "myEmail", userAvatar: userAvatar, userText: userText)
                                            
                                            self?.messagesArray?.append(newMessage)
                                            let insertionIndex = (self?.messagesArray!.count)! - 1
                                            let indexPath = IndexPath(item: insertionIndex, section: 0)
                                            var indexPathArray = [IndexPath]()
                                            indexPathArray.append(indexPath)
                                            self?.myCollectionView?.insertItems(at: indexPathArray)
                                            self?.myCollectionView?.scrollToItem(at: indexPath, at: .bottom, animated: true)
                                        }
                                    })
                                    
                                    self.scrollToLastMessage()
                                    
                                } else {
                                    print("ОШИБКА СОЗДАНИЯ ЧАТА 1 НА 1")
                                }
                            case .failure(let error):
                                print(error)
                            }
        }
    }
    
    //Get group chat by groupChatID
    func getGroupChat(){
        
        self.messagesArray = [Message]()
        let requestURL = URLlist.baseURL + URLlist.getChatGET + self.groupChatID!
        Alamofire.request(requestURL,
                          method: .get,
                          encoding: URLEncoding.default,
                          headers: URLlist.headers).responseJSON {response in
                            
                            switch response.result {
                            case .success:
                                if response.response?.statusCode == 200{
                                    let groupChatObj = response.result.value as! Dictionary<String, Any>
                                    let messages = groupChatObj["messages"] as! Array<Any>
                                    for message in messages {
                                        let messageObj = message as! Dictionary<String, Any>
                                        
                                        let userText = messageObj["text"] as! String
                                        
                                        let user = messageObj["user"] as! Dictionary<String, Any>
                                        
                                        let userID = user["_id"] as! String
                                        let userEmail = user["email"] as! String
                                        let userName = user["username"] as? String
                                        let userAvatar = user["avatar_mob"] as! String
                                        
                                        let message = Message(userName: userName ?? "Имя не указано", userID: userID, userEmail: userEmail, userAvatar: userAvatar, userText: userText)

                                        self.messagesArray?.append(message)
                                        self.myCollectionView?.reloadData()
                                        
                                    }

                                    self.scrollToLastMessage()

                                    
                                } else {
                                    print("ОШИБКА ПОЛУЧЕНИЯ ГРУППОВОГО ЧАТА - \(Event.eventID!)")
                                }
                            case .failure(let error):
                                print(error)
                            }
        }
    }
    
    //Scroll to the last bottom message in collection
    func scrollToLastMessage(){
        let item = self.messagesArray!.count - 1
        let indexPath = IndexPath(item: item, section: 0)
        self.myCollectionView?.contentInsetAdjustmentBehavior = .never
        bottomMyCollectionConstraint?.constant = -54

        if !(item < 0){
            self.myCollectionView!.scrollToItem(at: indexPath, at: .bottom, animated: true)
        }
    }
    
    //Send message button
    let sendButton: UIButton = {
        let image = UIImage(named: "sendBtn")
        let button   = UIButton(type: UIButtonType.custom)
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(sendBtnTouched), for:.touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //Send message action
    @objc func sendBtnTouched(){
        if let chatMessage = messegeField.text {
            
            let newMessage = Message(userName: "myName", userID: myDBid, userEmail: "myEmail", userAvatar: "myAvatar", userText: chatMessage)
            
            
            var messageData = [String: Any]()
            
            
            if self.userID != nil {
                messageData = [
                    "chat": self.chatID!,
                    "user": myDBid,
                    "message": [
                        "user": myDBid,
                        "text": chatMessage
                    ]
                ]
            } else {
                messageData = [
                    "chat": self.groupChatID!,
                    "user": myDBid,
                    "message": [
                        "user": myDBid,
                        "text": chatMessage
                    ]
                ]
            }

            SocketIOManager.socket.emit("save-message", messageData);
            
            messagesArray?.append(newMessage)
            let insertionIndex = messagesArray!.count - 1
            let indexPath = IndexPath(item: insertionIndex, section: 0)
            var indexPathArray = [IndexPath]()
            indexPathArray.append(indexPath)
            myCollectionView?.insertItems(at: indexPathArray)
            
            self.myCollectionView?.scrollToItem(at: indexPath, at: .bottom, animated: true)
        }
        messegeField.text = ""
    }
    
    func setupSendButtonConstarints(){
        let descHorizontal = "H:[sendButton(59)]-2-|"
        let descVertical = "V:|-6-[sendButton(39)]"
        
        let viewDictionary = ["sendButton": sendButton]
        
        let horizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: descHorizontal,
                                                                   options: NSLayoutFormatOptions(rawValue: 0),
                                                                   metrics: nil,
                                                                   views: viewDictionary)
        
        let verticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: descVertical,
                                                                 options: NSLayoutFormatOptions(rawValue: 0),
                                                                 metrics: nil,
                                                                 views: viewDictionary)
        
        view.addConstraints(horizontalConstraints)
        view.addConstraints(verticalConstraints)
    }
    
    let backRectangl: UIView = {
        let br = UIView()
        br.backgroundColor = Colors.superLight
        br.translatesAutoresizingMaskIntoConstraints = false
        return br
    }()
    
    func setupBackRectanglConstarints(){
        let descHorizontal = "H:|[backRectangl]|"
        let descVertical = "V:[backRectangl(50)]"
        
        let viewDictionary = ["backRectangl": backRectangl]
        
        let horizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: descHorizontal,
                                                                   options: NSLayoutFormatOptions(rawValue: 0),
                                                                   metrics: nil,
                                                                   views: viewDictionary)
        
        let verticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: descVertical,
                                                                 options: NSLayoutFormatOptions(rawValue: 0),
                                                                 metrics: nil,
                                                                 views: viewDictionary)
        
        view.addConstraints(horizontalConstraints)
        view.addConstraints(verticalConstraints)
    }
    
    
    //Grab the bottom constraint of a backRectangl
    var bottomBackRectanglConstraint: NSLayoutConstraint?
    
    func setupBottomBackRectangleConstaraint(){
        bottomBackRectanglConstraint = NSLayoutConstraint(item: backRectangl, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
        view.addConstraint(bottomBackRectanglConstraint!)
    }
    
    
    //Grab the bottom constraint of a myCollectionView
    var bottomMyCollectionConstraint: NSLayoutConstraint?
    
    func setupBottomMyCollectionConstaraint(){
        bottomMyCollectionConstraint = NSLayoutConstraint(item: myCollectionView!, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
        view.addConstraint(bottomMyCollectionConstraint!)
    }
    
    
    //Get Keyboard Top Height edge coordinat and pin backRectangl and MyCollection to the top Keyboard edge when it's showed
    @objc func hundleKeyboardShowing(notification: NSNotification){
        if let userInfo = notification.userInfo {
            let keyboardSize = userInfo[UIKeyboardFrameEndUserInfoKey] as? CGRect
            bottomBackRectanglConstraint?.constant = -keyboardSize!.height
            bottomMyCollectionConstraint?.constant = -keyboardSize!.height - 54
            
            UIView.animate(withDuration: 0, delay: 0, options: .curveEaseOut, animations: {
                self.view.layoutIfNeeded()
            }, completion: { (complited) in
                
                //Animate the last cell bottom edge to top backRectangl edge
                let indexPath = IndexPath(item: self.messagesArray!.count - 1, section: 0)
                if ((self.messagesArray!.count - 1) > 0){
                   self.myCollectionView?.scrollToItem(at: indexPath, at: .bottom, animated: true)
                }
            })
        }
    }
    
    
    func setupMyCollectionConstarints(){
        let descHorizontal = "H:|[myCollection]|"
        let descVertical = "V:|[myCollection]"
        
        let viewDictionary = ["myCollection": myCollectionView]
        
        let horizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: descHorizontal,
                                                                   options: NSLayoutFormatOptions(rawValue: 0),
                                                                   metrics: nil,
                                                                   views: viewDictionary)
        
        let verticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: descVertical,
                                                                 options: NSLayoutFormatOptions(rawValue: 0),
                                                                 metrics: nil,
                                                                 views: viewDictionary)
        
        view.addConstraints(horizontalConstraints)
        view.addConstraints(verticalConstraints)
    }
    
    
    //Hide keyboard if any of cells are touched
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        messegeField.endEditing(true)
    }
    
    //Get Keyboard Top Height edge coordinat and pin backRectangl to the top Keyboard edge when it's hided
    @objc func hundleKeyboardHiding(notification: NSNotification){
        bottomBackRectanglConstraint?.constant = 0
        bottomMyCollectionConstraint?.constant = -54
        UIView.animate(withDuration: 0, delay: 0, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }


    let messegeField: UITextField = {
        let mf = UITextField()
        mf.backgroundColor = UIColor.white
        mf.placeholder = "Ваше повідомлення..."
        mf.translatesAutoresizingMaskIntoConstraints = false
        return mf
    }()
    
    func setupMessegeFieldConstarints(){
        let descHorizontal = "H:|-10-[messegeField]-60-|"
        let descVertical = "V:|-10-[messegeField(30)]|"
        
        let viewDictionary = ["messegeField": messegeField]
        
        let horizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: descHorizontal,
                                                                   options: NSLayoutFormatOptions(rawValue: 0),
                                                                   metrics: nil,
                                                                   views: viewDictionary)
        
        let verticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: descVertical,
                                                                 options: NSLayoutFormatOptions(rawValue: 0),
                                                                 metrics: nil,
                                                                 views: viewDictionary)
        
        view.addConstraints(horizontalConstraints)
        view.addConstraints(verticalConstraints)
    }
        
    
    //Edges around the Cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(8, 0, 8, 0)
    }
    
    func setUpChatLogCollection(){
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 20
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 80) //Not nessesary because of cellForItemAt indexPath func
        
        let collectionSize = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 54)
        myCollectionView = UICollectionView(frame: collectionSize, collectionViewLayout: layout)
        
        myCollectionView!.dataSource = self
        myCollectionView!.delegate = self
        
        myCollectionView!.register(ChatMessageCell.self, forCellWithReuseIdentifier: "chatMessage")
        myCollectionView!.backgroundColor = UIColor.white
        myCollectionView?.translatesAutoresizingMaskIntoConstraints = false

        self.view.addSubview(myCollectionView!)
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messagesArray!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let messageObj = messagesArray![indexPath.item]
        let messageText = messageObj.userText
        let size = CGSize(width: 250, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let estimatedMessageBubbleFrame = NSString(string: messageText).boundingRect(with: size, options: options, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 16)], context: nil)
        return CGSize(width: view.frame.width, height: estimatedMessageBubbleFrame.height + 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "chatMessage", for: indexPath) as! ChatMessageCell
        
        
        let messageObj = messagesArray![indexPath.item]
        let messageText = messageObj.userText
        let size = CGSize(width: 250, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let estimatedTextSize = NSString(string: messageText).boundingRect(with: size, options: options, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 16)], context: nil)
        
        
        if messagesArray![indexPath.item].userID != myDBid {
            
            let imageURL = URL(string: messagesArray![indexPath.item].userAvatar)
            cell.userAvatar.sd_setImage(with: imageURL, completed: nil)
            
            cell.messageText.text = messagesArray![indexPath.item].userText
            cell.messageText.frame = CGRect(x: 60, y: 0, width: estimatedTextSize.width, height: estimatedTextSize.height + 20)
            cell.messageBubble.frame = CGRect(x: 48, y: 0, width: estimatedTextSize.width + 24, height: estimatedTextSize.height + 20)
            cell.messageBubble.backgroundColor = Colors.purpleSuperLight
            cell.messageText.textColor = UIColor.white
            cell.userAvatar.isHidden = false

        } else {
            cell.messageText.text = messagesArray![indexPath.item].userText
            cell.messageText.frame = CGRect(x: view.frame.width - estimatedTextSize.width - 14, y: 0, width: estimatedTextSize.width, height: estimatedTextSize.height + 20)
            cell.messageBubble.frame = CGRect(x: view.frame.width - estimatedTextSize.width - 26, y: 0, width: estimatedTextSize.width + 22, height: estimatedTextSize.height + 20)
            cell.messageBubble.backgroundColor = Colors.grey
            cell.messageText.textColor = UIColor.black
            cell.userAvatar.isHidden = true
        }
        
        return cell
    }
    
    deinit {
        print("ЭКРАН ЧАТА УДАЛЕН ИЗ ПАМЯТИ")
    }
}
