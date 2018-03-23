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
    
    
    init(chatTitle: String) {
        self.chatTitle = chatTitle
    }
    
}
