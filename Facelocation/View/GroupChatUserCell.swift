//
//  GroupChatUserCell.swift
//  Facelocation
//
//  Created by Nastro Mo on 23.03.2018.
//  Copyright © 2018 Facelocation. All rights reserved.
//

import UIKit

class GroupChatUserCell: UICollectionViewCell{
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        addSubview(userName)
        addSubview(userEmail)
        addSubview(userAvatar)
        addSubview(switcher)
    }
    
    let switcher: UISwitch = {
        let sw = UISwitch()
        sw.frame = CGRect(x: 300, y: 30, width: 35, height: 24)
        return sw
    }()
    
    
    
    let userAvatar: UIImageView = {
        let ua = UIImageView()
        ua.image = UIImage(named: "uAvatar")
        ua.contentMode = .scaleAspectFill
        ua.frame = CGRect(x: 20, y: 20, width: 50, height: 50)
        return ua
    }()
    
    let userName: UILabel = {
        let un = UILabel()
        un.frame = CGRect(x: 85, y: 30, width: 200, height: 20)
        un.text = "Ім'я не вказано"
        un.textColor = Colors.purpleText
        un.font = UIFont.boldSystemFont(ofSize: 14)
        return un
    }()
    
    let userEmail: UILabel = {
        let ue = UILabel()
        ue.frame = CGRect(x: 85, y: 47, width: 200, height: 20)
        ue.text = "var userEmail"
        ue.textColor = Colors.greyText
        ue.font = UIFont.systemFont(ofSize: 12.0)
        return ue
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
