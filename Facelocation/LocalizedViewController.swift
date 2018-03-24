import UIKit
import Alamofire

class LocalizedViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, ShowChat, UIAlertViewDelegate {
    
    lazy var menuBar: MenuBar = {
        let mb = MenuBar()
        mb.localizedViewController = self
        return mb
    }()
    
    var myCollectionView: UICollectionView?
    var requestURL: String?
    var titleBarLabel: UILabel?
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpHorizontalScreens()
        setUpTitleBar()
        setUpMenuBar()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        requestURL = "\(URLlist.baseURL)api/events/\(Event.eventID!)"
        getEventTitle()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Назад", style: .plain, target: nil, action: nil)
    }
    
    
    //Move Line Indicator While Sliding
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(scrollView.contentOffset)
        menuBar.indicatorPositinX?.constant = scrollView.contentOffset.x / 4
    }
    
    //Scroll Screens By Clicking Menu Tab Item
    func moveTabScreen(menuIndex: Int){
        let indexPath = IndexPath(item: menuIndex, section: 0)
        myCollectionView!.scrollToItem(at: indexPath, at: .left, animated: true)
    }
    
    
    //Horizontal Screens wich slids to left/right on Menu Tab Press
    func setUpHorizontalScreens(){
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)

        let tabSize = CGRect(x: 0, y: 100, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        myCollectionView = UICollectionView(frame: tabSize, collectionViewLayout: layout)

        myCollectionView!.dataSource = self
        myCollectionView!.delegate = self
        myCollectionView!.register(UserListCell.self, forCellWithReuseIdentifier: "userListCell")
        myCollectionView!.register(ChatCell.self, forCellWithReuseIdentifier: "chatCell")
        myCollectionView!.register(AttentionCell.self, forCellWithReuseIdentifier: "attentionCell")
        myCollectionView!.register(FilesCell.self, forCellWithReuseIdentifier: "filesCell")
        myCollectionView!.backgroundColor = UIColor.white
        myCollectionView!.showsHorizontalScrollIndicator = false
        myCollectionView!.isPagingEnabled = true

        self.view.addSubview(myCollectionView!)
    }
    
    
    //Number Of Horizontal Screens
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toChatOneOnOne" {
            let chatVC = segue.destination as! ChatViewController
            chatVC.userID = sender as? String
            
        } else if segue.identifier == "toGroupChat" {
            let chatVC = segue.destination as! ChatViewController
            chatVC.groupChatID = sender as? String
            
        } else if segue.identifier == "toChatUserChose" {
            segue.destination as? ChoseUsersViewController
        }
    }
    
    
    //Start Chat One on One
    func showChatScreen(cellIndex: Int){
        let userID = ChatUserList.chatUserListCopy[cellIndex].userID
        self.performSegue(withIdentifier: "toChatOneOnOne", sender: userID)
    }
    
    
    //Start Group Chat
    func showGroupChatScreen(cellIndex: Int){
        let groupChatID = GroupChatList.groupChatsListCopy[cellIndex].chatID
        self.performSegue(withIdentifier: "toGroupChat", sender: groupChatID)
    }
    
    
    //Show Popup Create Group Chat
    func showPopup(){
        
        let alertController = UIAlertController(title: "Назва чату", message: "вкажіть назву чату", preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: "Готово", style: .default) { (_) in
            if let field = alertController.textFields![0] as? UITextField {
                
                GroupChat.name = field.text
                self.performSegue(withIdentifier: "toChatUserChose", sender: self)
            }
        }
        
        let cancelAction = UIAlertAction(title: "Назад", style: .cancel) { (_) in
            
            //do somthing if cancel
            
        }
        
        alertController.addTextField { (textField) in
            textField.placeholder = "Назва чату"
        }
        
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    //Cells for each horizontal Screen
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.item {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "userListCell", for: indexPath) as! UserListCell
            cell.delegate = self
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "chatCell", for: indexPath) as! ChatCell
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "attentionCell", for: indexPath) as! AttentionCell
            return cell
        case 3:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "filesCell", for: indexPath) as! FilesCell
            return cell
        default:
            print("СРАБОТАЛ ДЕФОЛТ В СВИЧЕ НА ЯЧЕЙКАХ")
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "groupChatCell", for: indexPath) as! UserListCell
            return cell
        }
    }
    
    
    //Bar with Menu Tabs (Locals, Chat etc)
    private func setUpMenuBar(){
        
        let descHorizontal = "H:|[menuBar]|"
        let descVertical = "V:|-50-[menuBar(50)]"
        
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
    
    //Bar With Event Title
    private func setUpTitleBar(){
        let titleBar = UIView()
        titleBar.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50)
        titleBar.setBackgroundGradient(colorOne: Colors.purpleDark, colorTwo: Colors.purpleLight)
        view.addSubview(titleBar)
        
        titleBarLabel = UILabel()
        titleBarLabel?.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: titleBar.bounds.height)
        titleBarLabel?.textAlignment = .center
        titleBarLabel?.textColor = Colors.purpleSuperDark
        titleBarLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        titleBarLabel?.text = titleBarLabel?.text?.uppercased()
        titleBar.addSubview(titleBarLabel!)
    }
    
    func getEventTitle(){
        Alamofire.request(requestURL!,
                          method: .get,
                          encoding: URLEncoding.default,
                          headers: URLlist.headers).responseJSON {response in
                            
                            switch response.result {
                            case .success:
                                if response.response?.statusCode == 200{
                                    let response =  response.result.value as! Dictionary<String, Any>
                                    self.titleBarLabel?.text = response["title"] as? String
                                }
                            case .failure(let error):
                                print("ОШИБКА ПОЛУЧЕНИЯ ЗАГОЛОВКА ИВЕНТА")
                                print(error)
                            }
        }
    }
}
