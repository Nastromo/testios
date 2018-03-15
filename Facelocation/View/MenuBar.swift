//
//  MenuBar.swift
//  Facelocation
//
//  Created by Nastro Mo on 12.03.2018.
//  Copyright © 2018 Facelocation. All rights reserved.
//

import UIKit

class MenuBar: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var indicatorPositinX: NSLayoutConstraint?
    var localizedViewController: LocalizedViewController?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        tabCollection.register(MenuCell.self, forCellWithReuseIdentifier: celliD)
        addSubview(tabCollection)
        
        //This is a settings for a MenuBar View
        translatesAutoresizingMaskIntoConstraints = false
        
        setUpLineIndicator()
    }
    
    //Purple Line Indicator
    func setUpLineIndicator(){
        let lineIndicator = UIView()
        lineIndicator.backgroundColor = Colors.purple
        lineIndicator.translatesAutoresizingMaskIntoConstraints = false
        addSubview(lineIndicator)
        
        //Indicator position (constraits)
        indicatorPositinX = lineIndicator.leftAnchor.constraintEqualToSystemSpacingAfter(self.leftAnchor, multiplier: 0)
        indicatorPositinX?.isActive = true
        lineIndicator.bottomAnchor.constraintEqualToSystemSpacingBelow(self.bottomAnchor, multiplier: 0).isActive = true
        lineIndicator.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/4).isActive = true
        lineIndicator.heightAnchor.constraint(equalToConstant: 4).isActive = true
    }
    
    //Position of Purple line indicator while Selecting Tabs
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
        let positinX = CGFloat(indexPath.item) * frame.width / 4
        indicatorPositinX?.constant = positinX
        
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.layoutIfNeeded()
        }, completion: nil)
        
        localizedViewController?.moveTabScreen(menuIndex: indexPath.item)
    }

    //This collection is a set of tabs in MenuBar
    lazy var tabCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        let frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50)
        let tb = UICollectionView(frame: frame, collectionViewLayout: layout)
        tb.showsHorizontalScrollIndicator = false
        tb.backgroundColor = UIColor.white
        tb.dataSource = self
        tb.delegate = self
        return tb
    }()
    
    let celliD = "cellid"
    let tabTitles = ["МІСЦЕВІ", "ЧАТ", "УВАГА", "ФАЙЛИ"]
    
    
    //Number of gorizontal cells
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
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
        return CGSize(width: UIScreen.main.bounds.width / 4, height: frame.height)
    }
    
    //Inter Cell Spacing
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}





































