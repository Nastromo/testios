//
//  Registration.swift
//  Facelocation
//
//  Created by Nastro Mo on 18.03.2018.
//  Copyright © 2018 Facelocation. All rights reserved.
//

import UIKit

class Registration: NSObject {

    static var email: String?
    
    class func setEmail(email: String){
        self.email = email
    }
    
    class func getEmail() -> String{
        return self.email!
    }
    
    
}
