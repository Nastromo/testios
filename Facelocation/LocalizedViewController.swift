import UIKit

class LocalizedViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpLocalizedUserList()
        setUpTitleBar()
        setUpMenuBar()
    }
    
    //Localized User List (Collection View)
    private func setUpLocalizedUserList(){
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
//        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 80)
        
        let myCollectionView:UICollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        myCollectionView.dataSource = self
        myCollectionView.delegate = self
        myCollectionView.register(LocalizedUserCell.self, forCellWithReuseIdentifier: "MyCell")
        myCollectionView.backgroundColor = UIColor.white
        self.view.addSubview(myCollectionView)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath)
        myCell.backgroundColor = UIColor.red
        return myCell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
    {
        print("User tapped on item \(indexPath.row)")
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
