//
//  ChatMessageCell.swift
//  Facelocation
//
//  Created by Nastro Mo on 16.03.2018.
//  Copyright © 2018 Facelocation. All rights reserved.
//

import UIKit

class ChatMessageCell: UICollectionViewCell{
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        addSubview(messageBubble)
        addSubview(messageText)
        addSubview(userAvatar)
//        setMessageTextConstraints()
    }
    
    let userAvatar: UIImageView = {
        let ua = UIImageView()
        ua.image = UIImage(named: "uAvatar")
        ua.frame = CGRect(x: 5, y: 0, width: 35, height: 35)
        ua.layer.cornerRadius = 18
        ua.layer.masksToBounds = true
        return ua
    }()
    
    let messageBubble: UIView = {
        let mb = UIView()
        mb.backgroundColor = Colors.purpleSuperLight
        mb.layer.cornerRadius = 8
        mb.layer.masksToBounds = true
        return mb
    }()
    
    let messageText: UILabel = {
        let mt = UILabel()
//        mb.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        mt.text = "Это дэфолтное сообщение."
        mt.textColor = UIColor.white
        mt.lineBreakMode = .byWordWrapping
        mt.numberOfLines = 0
        mt.backgroundColor = UIColor.clear
        mt.font = UIFont.systemFont(ofSize: 16)
        mt.translatesAutoresizingMaskIntoConstraints = false
        return mt
    }()
    
    
    private func setMessageTextConstraints(){
        
        let descHorizontal = "H:|-55-[messageText]|"
        let descVertical = "V:|[messageText]"
        
        let viewDictionary = ["messageText": messageText]
        
        let horizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: descHorizontal,
                                                                   options: NSLayoutFormatOptions(rawValue: 0),
                                                                   metrics: nil,
                                                                   views: viewDictionary)
        
        let verticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: descVertical,
                                                                 options: NSLayoutFormatOptions(rawValue: 0),
                                                                 metrics: nil,
                                                                 views: viewDictionary)
        
        addConstraints(horizontalConstraints)
        addConstraints(verticalConstraints)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
