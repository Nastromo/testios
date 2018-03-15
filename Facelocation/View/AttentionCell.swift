//
//  AttentionCell.swift
//  Facelocation
//
//  Created by Nastro Mo on 14.03.2018.
//  Copyright © 2018 Facelocation. All rights reserved.
//

import UIKit

class AttentionCell: UICollectionViewCell{
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        addSubview(chatNameTitle)
        backgroundColor = UIColor.blue
    }
    
    
    let chatNameTitle: UILabel = {
        let un = UILabel()
        un.frame = CGRect(x: 85, y: 30, width: 200, height: 20)
        un.text = "11111111111"
        un.textColor = Colors.purpleText
        un.font = UIFont.boldSystemFont(ofSize: 14)
        return un
    }()
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
