//
//  Event.swift
//  Facelocation
//
//  Created by Nastro Mo on 19.03.2018.
//  Copyright © 2018 Facelocation. All rights reserved.
//

import Foundation


class Event: NSObject{
    
    static var title: String?
    static var text: String?
    static var start: String?
    static var end: String?
    static var isPrivate: Bool?
    static var seats: Int?
    static var frequency: Int?
    static var type: Int?
//    static var locations: Locations?    // Have to figure out how to send object representatiom in .post method
    static var published: Bool?
    
}
