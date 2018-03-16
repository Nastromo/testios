//
//  UserListCell.swift
//  Facelocation
//
//  Created by Nastro Mo on 14.03.2018.
//  Copyright © 2018 Facelocation. All rights reserved.
//

import UIKit

protocol ShowChat {
    func showChatScreen(cellIndex: Int)
}


class UserListCell: UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var delegate: ShowChat?
    
    //Was testind downloading image from the URL
    var data: Data? = nil
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        setUpLocalizedUserList()
        setUpGroupChatBtn()
        
        data = downloadImg()
    }
    
    
    //Click on User Cell
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Click")
        self.delegate?.showChatScreen(cellIndex: indexPath.item)
    }

    
    //Localized User List (Collection View)
    private func setUpLocalizedUserList(){
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        layout.minimumLineSpacing = 0
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 80)
        
        let userListFrame = CGRect(x: 0, y: 0, width: Int(UIScreen.main.bounds.width), height: Int(UIScreen.main.bounds.height) - 160)
        let myCollectionView:UICollectionView = UICollectionView(frame: userListFrame, collectionViewLayout: layout)
        
        myCollectionView.dataSource = self
        myCollectionView.delegate = self
        myCollectionView.register(LocalizedUserCell.self, forCellWithReuseIdentifier: "userCell")
        myCollectionView.register(GroupChatCell.self, forCellWithReuseIdentifier: "groupChatCell")
        myCollectionView.backgroundColor = UIColor.white
        
        addSubview(myCollectionView)
    }
    
    //Number of Section in User List
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    //Lists' Sizes
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (section == 0) ? 5 : 4
    }
    
    //Cells content here
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "userCell", for: indexPath) as! LocalizedUserCell
            cell.userAvatar.layer.cornerRadius = cell.userAvatar.frame.size.width / 2;
            cell.userAvatar.layer.masksToBounds = true;
            cell.userAvatar.image = UIImage(data: data!)
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "groupChatCell", for: indexPath) as! GroupChatCell
            return cell
        }
    }
    
    //Downloading Image from URL
    func downloadImg() -> Data{
        let imageURL = URL(string: "https://tinder.com/static/tinder.png")
        let data = try? Data(contentsOf: imageURL!)
        return data!
    }
    
    //SetUp Create Group Chat Btn
    func setUpGroupChatBtn(){
        let image = UIImage(named: "groupChat.png") as UIImage?
        let button   = UIButton(type: UIButtonType.system) as UIButton
        button.frame = CGRect(x: 0, y: 0, width: 65, height: 65)
        button .setBackgroundImage(image, for: .normal)
        button.addTarget(self, action: #selector(createGroupChat), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        addSubview(button)
        
        let descHorizontal = "H:[button(65)]-25-|"
        let descVertical = "V:[button(65)]-175-|"
        let viewsDict = ["button": button]
        
        let horizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: descHorizontal,
                                                                   options: NSLayoutFormatOptions(rawValue: 0),
                                                                   metrics: nil,
                                                                   views: viewsDict)
        
        let verticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: descVertical,
                                                                 options: NSLayoutFormatOptions(rawValue: 0),
                                                                 metrics: nil,
                                                                 views: viewsDict)
        
        addConstraints(horizontalConstraints)
        addConstraints(verticalConstraints)
    }
    
    //Action on Create Group Chat Btn
    @objc func createGroupChat(){
        print("Btn touched")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
