//
//  ChatUserList.swift
//  Facelocation
//
//  Created by Nastro Mo on 21.03.2018.
//  Copyright © 2018 Facelocation. All rights reserved.
//

import Foundation

class ChatUserList: NSObject{
    
    static var chatUserList = [ChatUser]()
    static var chatUserListCopy = [ChatUser]()
    
    static var usersIdCollection = [String: Bool]()
    static var selectedUsersArray = [String]()
    
}


class ChatUser: NSObject{
    
    let userName: String
    let userID: String
    let userEmail: String
    let userAvatar: String
    var isSelected = false
    
    init(userName: String, userID: String, userEmail: String, userAvatar: String){
        self.userName = userName
        self.userID = userID
        self.userEmail = userEmail
        self.userAvatar = userAvatar
    }
}
