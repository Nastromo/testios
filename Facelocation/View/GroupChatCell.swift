//
//  TestCell.swift
//  Facelocation
//
//  Created by Nastro Mo on 14.03.2018.
//  Copyright © 2018 Facelocation. All rights reserved.
//

import UIKit

class GroupChatCell: UICollectionViewCell{
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        addSubview(chatNameTitle)
        addSubview(groupAvatar)
        addSubview(subTitle)
        addSubview(chatNameTint)
    }
    
    let chatNameTint: UILabel = {
        let un = UILabel()
        un.frame = CGRect(x: 34, y: 36, width: 30, height: 20)
        un.text = "GC"
        un.textColor = UIColor.white
        un.font = UIFont.boldSystemFont(ofSize: 16)
        return un
    }()
    
    let groupAvatar: UIImageView = {
        let ga = UIImageView()
        ga.frame = CGRect(x: 20, y: 20, width: 50, height: 50)
        ga.layer.cornerRadius = 25
        ga.layer.masksToBounds = true
        ga.backgroundColor = Colors.malina
        return ga
    }()
    
    let chatNameTitle: UILabel = {
        let un = UILabel()
        un.frame = CGRect(x: 85, y: 30, width: 200, height: 20)
        un.text = "Чат без назви"
        un.textColor = Colors.purpleText
        un.font = UIFont.boldSystemFont(ofSize: 14)
        return un
    }()
    
    let subTitle: UILabel = {
        let ue = UILabel()
        ue.frame = CGRect(x: 85, y: 47, width: 200, height: 20)
        ue.text = "груповий чат"
        ue.textColor = Colors.greyText
        ue.font = UIFont.systemFont(ofSize: 12.0)
        return ue
    }()

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
