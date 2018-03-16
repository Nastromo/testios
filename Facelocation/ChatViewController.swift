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
            default:
                print("Default")
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpChatLogCollection()
        
        view.addSubview(backRectangl)
        
        backRectangl.addSubview(messegeField)
        setupMessegeFieldConstarints()
        
        backRectangl.addSubview(sendButton)
        setupSendButtonConstarints()
        
        createUsers()
    }
    
    let sendButton: UIButton = {
        let image = UIImage(named: "sendBtn")
        let button   = UIButton(type: UIButtonType.custom)
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(sendBtnTouched), for:.touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc func sendBtnTouched(){
        print("btnTouched")
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
        br.frame = CGRect(x: 0, y: UIScreen.main.bounds.height - 50, width: UIScreen.main.bounds.width, height: 50)
        br.backgroundColor = Colors.superLight
        return br
    }()

    
    
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
        
        let collectionSize = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 50)
        myCollectionView = UICollectionView(frame: collectionSize, collectionViewLayout: layout)
        
        myCollectionView!.dataSource = self
        myCollectionView!.delegate = self
        
        myCollectionView!.register(ChatMessageCell.self, forCellWithReuseIdentifier: "chatMessage")
        myCollectionView!.backgroundColor = UIColor.white

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
