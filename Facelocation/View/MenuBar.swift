//
//  MenuBar.swift
//  Facelocation
//
//  Created by Nastro Mo on 12.03.2018.
//  Copyright © 2018 Facelocation. All rights reserved.
//

import UIKit

class MenuBar: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    //This collection is a set of tabs in MenuBar
    lazy var tabCollection: UICollectionView = {
        let layot = UICollectionViewFlowLayout()
        layot.scrollDirection = .horizontal
        let frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50)
        let tb = UICollectionView(frame: frame, collectionViewLayout: layot)
        tb.showsHorizontalScrollIndicator = false
        tb.backgroundColor = UIColor.white
        tb.dataSource = self
        tb.delegate = self
        return tb
    }()
    
    let celliD = "cellid"
    let tabTitles = ["МІСЦЕВІ", "ЧАТ", "УВАГА!", "ГОЛОСУВАННЯ", "ФАЙЛИ"]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        tabCollection.register(MenuCell.self, forCellWithReuseIdentifier: celliD)
        addSubview(tabCollection)
        
        //This is a settings for a MenuBar View
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    //Number of gorizontal cells
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    //Cell Content
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = tabCollection.dequeueReusableCell(withReuseIdentifier: celliD, for: indexPath) as! MenuCell
        cell.tabLabel.text = tabTitles[indexPath.item]
//        cell.tabButton.setTitle(tabTitles[indexPath.item], for: .normal)
//        cell.tabButton.setTitleColor(UIColor.black, for: .selected)
        return cell
    }
    
    //Cell Width and Height
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: frame.height)
    }
    
    //Inter Cell Spacing
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}





































