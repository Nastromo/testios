//
//  EventMarker.swift
//  Facelocation
//
//  Created by Nastro Mo on 19.03.2018.
//  Copyright © 2018 Facelocation. All rights reserved.
//

import Foundation

class EventMarker: NSObject{
    var latitude: Double
    var longitude: Double
    
    init(jsonDic: Dictionary<String, Any>) {
        self.latitude = jsonDic["latitude"] as! Double!
        self.longitude = jsonDic["longitude"] as! Double!
    }
}
