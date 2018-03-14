import UIKit

class LocalizedViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    //Was testind downloading image from the URL
    var data: Data? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpLocalizedUserList()
        setUpTitleBar()
        setUpMenuBar()
        setUpGroupChatBtn()
//        setUpHorizontalScreens()
        
        //Was testind downloading image from the URL
        data = downloadImg()
    }
    
//    func setUpHorizontalScreens(){
//        let layout = UICollectionViewFlowLayout()
//        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//        layout.minimumInteritemSpacing = 0
//        layout.minimumLineSpacing = 0
//        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 160)
//        
//        let tabSize = CGRect(x: 0, y: 160, width: Int(UIScreen.main.bounds.width), height: Int(UIScreen.main.bounds.height) - 160)
//        let myCollectionView = UICollectionView(frame: tabSize, collectionViewLayout: layout)
//        
//        myCollectionView.dataSource = self
//        myCollectionView.delegate = self
//        myCollectionView.register(UserListCell.self, forCellWithReuseIdentifier: "userListCell")
//        myCollectionView.register(ChatCell.self, forCellWithReuseIdentifier: "chatCell")
//        myCollectionView.register(AttentionCell.self, forCellWithReuseIdentifier: "attentionCell")
//        myCollectionView.register(FilesCell.self, forCellWithReuseIdentifier: "filesCell")
//        myCollectionView.backgroundColor = UIColor.white
//        
//        self.view.addSubview(myCollectionView)
//    }
    
    
    
    func setUpGroupChatBtn(){
        let image = UIImage(named: "groupChat.png") as UIImage?
        let button   = UIButton(type: UIButtonType.system) as UIButton
        button.frame = CGRect(x: 0, y: 0, width: 65, height: 65)
        button .setBackgroundImage(image, for: .normal)
        button.addTarget(self, action: #selector(createGroupChat), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        
        let descHorizontal = "H:[button(65)]-25-|"
        let descVertical = "V:[button(65)]-20-|"
        let viewsDict = ["button": button]
        
        let horizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: descHorizontal,
                                                                   options: NSLayoutFormatOptions(rawValue: 0),
                                                                   metrics: nil,
                                                                   views: viewsDict)
        
        let verticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: descVertical,
                                                                 options: NSLayoutFormatOptions(rawValue: 0),
                                                                 metrics: nil,
                                                                 views: viewsDict)
        
        self.view.addConstraints(horizontalConstraints)
        self.view.addConstraints(verticalConstraints)
    }
    
    @objc func createGroupChat(){
        print("Btn touched")
    }
    
    //Localized User List (Collection View)
    private func setUpLocalizedUserList(){
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 80)
        
        let userListFrame = CGRect(x: 0, y: 160, width: Int(UIScreen.main.bounds.width), height: Int(UIScreen.main.bounds.height) - 160)
        let myCollectionView:UICollectionView = UICollectionView(frame: userListFrame, collectionViewLayout: layout)
        
        myCollectionView.dataSource = self
        myCollectionView.delegate = self
        myCollectionView.register(LocalizedUserCell.self, forCellWithReuseIdentifier: "userCell")
        myCollectionView.register(GroupChatCell.self, forCellWithReuseIdentifier: "groupChatCell")
        myCollectionView.backgroundColor = UIColor.white
        
        self.view.addSubview(myCollectionView)
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //Lists' Sizes
        return (section == 0) ? 5 : 4
    }
    
    //Downloading Image from URL
    func downloadImg() -> Data{
        let imageURL = URL(string: "https://tinder.com/static/tinder.png")
        let data = try? Data(contentsOf: imageURL!)
        return data!
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
    
    let menuBar: MenuBar = {
        let mb = MenuBar()
        return mb
    }()
    
    let descHorizontal = "H:|[menuBar]|"
    let descVertical = "V:|-110-[menuBar(50)]"
    
    private func setUpMenuBar(){
        view.addSubview(menuBar)
        let viewDictionary = ["menuBar": menuBar]
        
        let horizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: descHorizontal,
                                                                   options: NSLayoutFormatOptions(rawValue: 0),
                                                                   metrics: nil,
                                                                   views: viewDictionary)
        
        let verticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: descVertical,
                                                                 options: NSLayoutFormatOptions(rawValue: 0),
                                                                 metrics: nil,
                                                                 views: viewDictionary)
        
        self.view.addConstraints(horizontalConstraints)
        self.view.addConstraints(verticalConstraints)
        
        menuBar.layer.shadowOpacity = 0.15
        menuBar.layer.shadowRadius = 2
        menuBar.layer.shadowOffset = CGSize(width: 0, height: 3)
    }
    
    
    private func setUpTitleBar(){
        let titleBar = UIView()
        titleBar.frame = CGRect(x: 0, y: 60, width: UIScreen.main.bounds.width, height: 50)
        titleBar.setBackgroundGradient(colorOne: Colors.purpleDark, colorTwo: Colors.purpleLight)
        view.addSubview(titleBar)
        
        let titleBarLabel = UILabel()
        titleBarLabel.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: titleBar.bounds.height)
        titleBarLabel.text = "eventTitle"
        titleBarLabel.textAlignment = .center
        titleBarLabel.textColor = Colors.purpleSuperDark
        titleBarLabel.font = UIFont.boldSystemFont(ofSize: 14)
        titleBarLabel.text = titleBarLabel.text?.uppercased()
        titleBar.addSubview(titleBarLabel)
    }
}
