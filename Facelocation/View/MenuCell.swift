//
//  MenuCell.swift
//  Facelocation
//
//  Created by Nastro Mo on 12.03.2018.
//  Copyright © 2018 Facelocation. All rights reserved.
//

import UIKit

class MenuCell: UICollectionViewCell {
    let tabLabel: UILabel = {
        let tl = UILabel()
        tl.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width/5, height: 50)
        tl.textAlignment = .center
        tl.textColor = Colors.purpleSuperLight
        tl.font = UIFont.boldSystemFont(ofSize: 14)
        tl.tintColor = UIColor.black
        tl.text = "tabLabel"
        return tl
    }()
    
    //    let tabButton: UIButton = {
    //        let tb = UIButton()
    //        tb.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width/5, height: 50)
    //        tb.setTitleColor(Colors.purpleSuperLight, for: .normal)
    //        tb.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
    //        tb.tintColor = UIColor.black
    //        tb.setTitle("tabTitle", for: .normal)
    //        return tb
    //    }()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        setUpTabs()
    }
    
    func setUpTabs(){
        backgroundColor = UIColor.white
        addSubview(tabLabel)
        //        addSubview(tabButton)
    }
    
    override var isHighlighted: Bool{
        didSet{
            print("Menu Tab Cell Was Clicked")
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
