//
//  FilesCell.swift
//  Facelocation
//
//  Created by Nastro Mo on 14.03.2018.
//  Copyright © 2018 Facelocation. All rights reserved.
//

import UIKit

class FilesCell: UICollectionViewCell{
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        addSubview(chatNameTitle)
    }
    
    
    let chatNameTitle: UILabel = {
        let un = UILabel()
        un.frame = CGRect(x: 85, y: 30, width: 200, height: 20)
        un.textColor = Colors.purpleText
        un.font = UIFont.boldSystemFont(ofSize: 14)
        return un
    }()
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
