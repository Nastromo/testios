//
//  Message.swift
//  Facelocation
//
//  Created by Nastro Mo on 24.03.2018.
//  Copyright © 2018 Facelocation. All rights reserved.
//

import Foundation

class Message: NSObject{
    
    let userID: String
    let userName: String
    let userEmail: String
    let userAvatar: String
    let userText: String
    
    init(userName: String, userID: String, userEmail: String, userAvatar: String, userText: String){
        self.userName = userName
        self.userID = userID
        self.userEmail = userEmail
        self.userAvatar = userAvatar
        self.userText = userText
    }
    
}
