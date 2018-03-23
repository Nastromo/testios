//
//  ChoseUsersViewController.swift
//  Facelocation
//
//  Created by Nastro Mo on 22.03.2018.
//  Copyright © 2018 Facelocation. All rights reserved.
//

import UIKit
import Alamofire

class ChoseUsersViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpLocalizedUserList()
        let button = UIBarButtonItem(title: "Готово", style: .plain, target: self, action: #selector(createGroupChat))
        self.navigationItem.rightBarButtonItem  = button
        
    }
    
    //Create group chat
    @objc func createGroupChat(){
        
        //Append selected userID only
        for item in ChatUserList.usersIdCollection {
            if item.value {
                ChatUserList.selectedUsersArray.append(item.key)
            }
        }
        
        let requestURL = URLlist.baseURL + URLlist.createChatPOST
        let parameters: Parameters = [
            "title": GroupChat.name!,
            "event": Event.eventID!,
            "type": 2,
            "user": ChatUserList.selectedUsersArray
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
                                    print("СОЗДАНИЕ ГРУППОВОГО ЧАТА ВЫПОЛНЕНО УСПЕШНО")
                                    self.performSegue(withIdentifier: "toGroupChat", sender: self)
                                } else {
                                    print("ОШИБКА СОЗДАНИЯ ГРУППОВОГО ЧАТА")
                                }
                            case .failure(let error):
                                
                                print(error)
                            }
        }
    }
    
    

    //Click on User Cell
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if !ChatUserList.chatUserListCopy[indexPath.item].isSelected {
            collectionView.cellForItem(at: indexPath)?.backgroundColor = Colors.superLight
            ChatUserList.chatUserListCopy[indexPath.item].isSelected = true
            ChatUserList.usersIdCollection[ChatUserList.chatUserListCopy[indexPath.item].userID] = true
            
        } else {
            collectionView.cellForItem(at: indexPath)?.backgroundColor = UIColor.white
            ChatUserList.chatUserListCopy[indexPath.item].isSelected = false
            ChatUserList.usersIdCollection[ChatUserList.chatUserListCopy[indexPath.item].userID] = false
        }
        
        print("РАЗМЕР СЛОВАРЯ = \(ChatUserList.usersIdCollection)")
        
    }
    
    //Localized User List (Collection View)
    private func setUpLocalizedUserList(){
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        layout.minimumLineSpacing = 0
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 80)
        
        let userListFrame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        let myCollectionView = UICollectionView(frame: userListFrame, collectionViewLayout: layout)
        
        myCollectionView.dataSource = self
        myCollectionView.delegate = self
        myCollectionView.register(LocalizedUserCell.self, forCellWithReuseIdentifier: "userCell")
        myCollectionView.backgroundColor = UIColor.white
        self.view.addSubview(myCollectionView)
    }
    
    //Number of Section in User List
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    //Lists' Sizes
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("КОПИЯ - \(ChatUserList.chatUserListCopy.count)")
        return ChatUserList.chatUserListCopy.count
    }
    
    //Cells content here
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "userCell", for: indexPath) as! LocalizedUserCell
        
        cell.userAvatar.layer.cornerRadius = cell.userAvatar.frame.size.width / 2;
        cell.userAvatar.layer.masksToBounds = true;
        let imageURL = URL(string: ChatUserList.chatUserListCopy[indexPath.item].userAvatar)
        let data = try? Data(contentsOf: imageURL!)
        cell.userAvatar.image = UIImage(data: data!)

        cell.userName.text = ChatUserList.chatUserListCopy[indexPath.item].userName
        cell.userEmail.text = ChatUserList.chatUserListCopy[indexPath.item].userEmail
        return cell
    }

}
