import UIKit
import Alamofire

class LoginViewController: UIViewController {

    @IBOutlet weak var login: UITextField!
    @IBOutlet weak var password: UITextField!
    
    
    let requestURL = URLlist.baseURL + URLlist.loginPOST
    let headers: HTTPHeaders = [
        "Content-Type": "application/json"
    ]

    @IBAction func toseg(_ sender: Any) {
        self.performSegue(withIdentifier: "drrrr", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBarSetup()
    }
    
    //Login Button presed
    @IBAction func logIn(_ sender: Any) {
        doLogin(email: login.text!, pass: password.text!)
    }
    
    //User Login Logic
    func doLogin(email: String, pass: String){
        let parameters: Parameters = [
            "email": email,
            "password": pass
        ]
        Alamofire.request(requestURL,
                          method: .post,
                          parameters: parameters,
                          encoding: JSONEncoding.default,
                          headers: headers).responseJSON {response in
                            
                    switch response.result {
                    case .success:
                        print(response)
                        if response.response?.statusCode == 200{
                            let responseJSON =  response.result.value
                            let loginOBJ: Dictionary = responseJSON as! Dictionary<String, Any>
                            let userToken: String = loginOBJ["token"] as! String
                            
                            let userOBJ: Dictionary = loginOBJ["user"] as! Dictionary<String, Any>
                            let userID: String = userOBJ["_id"] as! String
                            let userAvatar: String = userOBJ["avatar_mob"] as! String
                            let userEmail: String = userOBJ["email"] as! String

                            self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
                            self.navigationController?.navigationBar.shadowImage = nil
                            
                            self.navigationController?.navigationBar.barTintColor = Colors.mainColor
                            self.navigationController?.navigationBar.isTranslucent = false
                            
                            self.performSegue(withIdentifier: "toMainMap", sender: self)
                        }
                    case .failure(let error):
                                
                        print(error)
                    }
        }
    }
    
    //Navigation Bar Setup
    func navigationBarSetup(){
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Назад", style: .plain, target: nil, action: nil)
    }
}
