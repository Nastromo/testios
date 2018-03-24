//
//  GroupChat.swift
//  Facelocation
//
//  Created by Nastro Mo on 22.03.2018.
//  Copyright © 2018 Facelocation. All rights reserved.
//

import Foundation

class GroupChat: NSObject{
    
    static var name: String?
    let chatTitle: String
    let chatID: String
    
    
    init(chatTitle: String, chatID: String) {
        self.chatTitle = chatTitle
        self.chatID = chatID
    }
}
