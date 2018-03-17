//
//  ChatViewController.swift
//  Facelocation
//
//  Created by Nastro Mo on 16.03.2018.
//  Copyright © 2018 Facelocation. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let myID = "myStringID"
    var myCollectionView: UICollectionView?
    
    var messages: [String] = {
        var ms: [String] = []
        
        ms.append("Creating an Ar")
        
        ms.append("Alternatively, if the context already provides type information, such as a function argument or an already typed variable or constant, you can create an empty array with an empty array literal, which is written as [] (an empty pair of square brackets). Alternatively, if the context already provides type information, such as a function argument or an already typed variable or constant, you can create an empty array with an empty array literal, which is written as [] (an empty pair of square brackets). empty array literal, which is written as")
        
        ms.append("Swift’s Array type also provides")
        
        ms.append("You can also initialize an array with an array literal")
        
        ms.append("In this case, the array literal contains two String values and nothing else. This matches the type of the shoppingList variable’s declaration (an array that can only contain String values), and so the assignment of the array literal is permitted as a way to initialize shoppingList with two initial items.")
        ms.append("You can also initialize an array with an array literal")
        
        ms.append("In this case, the array literal contains two String values and nothing else. This matches the type of the shoppingList variable’s declaration (an array that can only contain String values), and so the assignment of the array literal is permitted as a way to initialize shoppingList with two initial items.")
        
        return ms
    }()
    
    var chatUsers = [User]()
    
    func createUsers(){
        for (index, message) in messages.enumerated() {
            
            
            let user = User()
            switch index {
            case 0:
                user.userID = String(index)
                user.message = message
                chatUsers.append(user)
            case 1:
                user.userID = String(index)
                user.message = message
                chatUsers.append(user)
            case 2:
                user.userID = myID
                user.message = message
                chatUsers.append(user)
            case 3:
                user.userID = String(index)
                user.message = message
                chatUsers.append(user)
            case 4:
                user.userID = myID
                user.message = message
                chatUsers.append(user)
            case 5:
                user.userID = myID
                user.message = message
                chatUsers.append(user)
            case 6:
                user.userID = myID
                user.message = message
                chatUsers.append(user)
            default:
                print("Default")
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpChatLogCollection()
        setupMyCollectionConstarints()
        setupBottomMyCollectionConstaraint()
        scrollToLastMessage()
        
        view.addSubview(backRectangl)
        setupBackRectanglConstarints()
        setupBottomBackRectangleConstaraint()

        backRectangl.addSubview(messegeField)
        setupMessegeFieldConstarints()

        backRectangl.addSubview(sendButton)
        setupSendButtonConstarints()
        
        createUsers()
        
        //Listen when keyboard appears
        NotificationCenter.default.addObserver(self, selector: #selector(hundleKeyboardShowing), name: .UIKeyboardWillShow, object: nil)
        
        //Listen when keyboard hide
        NotificationCenter.default.addObserver(self, selector: #selector(hundleKeyboardHiding), name: .UIKeyboardWillHide, object: nil)
    }
    
    //Scroll to the last bottom message in collection
    func scrollToLastMessage(){
        let indexPath = IndexPath(item: self.messages.count - 1, section: 0)
        self.myCollectionView?.contentInsetAdjustmentBehavior = .never
        bottomMyCollectionConstraint?.constant = -54
        self.myCollectionView!.scrollToItem(at: indexPath, at: .bottom, animated: true)
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
            messages.append(chatMessage)
            let insertionIndex = messages.count - 1
            let indexPath = IndexPath(item: insertionIndex, section: 0)
            var indexPathArray = [IndexPath]()
            indexPathArray.append(indexPath)
            myCollectionView?.insertItems(at: indexPathArray)
            
            let newChatUser = User()
            newChatUser.userID = myID
            newChatUser.message = chatMessage
            chatUsers.append(newChatUser)
            
            self.myCollectionView?.scrollToItem(at: indexPath, at: .bottom, animated: true)
        }
    }
    
    func setupSendButtonConstarints(){
        let descHorizontal = "H:[sendButton(24)]-18-|"
        let descVertical = "V:|-15-[sendButton(20)]"
        
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
                let indexPath = IndexPath(item: self.messages.count - 1, section: 0)
                self.myCollectionView?.scrollToItem(at: indexPath, at: .bottom, animated: true)
            
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
        return messages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let messageText = messages[indexPath.item]
        let size = CGSize(width: 250, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let estimatedMessageBubbleFrame = NSString(string: messageText).boundingRect(with: size, options: options, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 16)], context: nil)
        return CGSize(width: view.frame.width, height: estimatedMessageBubbleFrame.height + 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "chatMessage", for: indexPath) as! ChatMessageCell
        
        
        let messageText = messages[indexPath.item]
        let size = CGSize(width: 250, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let estimatedTextSize = NSString(string: messageText).boundingRect(with: size, options: options, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 16)], context: nil)
        
        
        if chatUsers[indexPath.item].userID != myID {
            cell.messageText.text = chatUsers[indexPath.item].message
            cell.messageText.frame = CGRect(x: 60, y: 0, width: estimatedTextSize.width, height: estimatedTextSize.height + 20)
            cell.messageBubble.frame = CGRect(x: 48, y: 0, width: estimatedTextSize.width + 24, height: estimatedTextSize.height + 20)
        } else {
            cell.messageText.text = chatUsers[indexPath.item].message
            cell.messageText.frame = CGRect(x: view.frame.width - estimatedTextSize.width - 14, y: 0, width: estimatedTextSize.width, height: estimatedTextSize.height + 20)
            cell.messageBubble.frame = CGRect(x: view.frame.width - estimatedTextSize.width - 26, y: 0, width: estimatedTextSize.width + 22, height: estimatedTextSize.height + 20)
            cell.messageBubble.backgroundColor = Colors.grey
            cell.messageText.textColor = UIColor.black
            cell.userAvatar.isHidden = true
        }
        return cell
    }
}
