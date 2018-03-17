import UIKit
import Alamofire

class LoginViewController: UIViewController {

    @IBOutlet weak var login: UITextField!
    @IBOutlet weak var password: UITextField!
    
    
    let requestURL = URLlist.baseURL + URLlist.loginPOST
    let headers: HTTPHeaders = [
        "Content-Type": "application/json"
    ]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Назад", style: .plain, target: nil, action: nil)
        
        print("\(requestURL)")
        
    }
    
    @IBAction func logIn(_ sender: Any) {
        doLogin(email: login.text!, pass: password.text!)
        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        navigationController?.navigationBar.shadowImage = nil
        
        let barColor = UIColor(red:0.34902, green:0.37255, blue:0.90980, alpha:1.00000)
        navigationController?.navigationBar.barTintColor = barColor
        navigationController?.navigationBar.isTranslucent = false
    }
    
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
                        print(response.response?.statusCode)
                        if response.response?.statusCode == 200{
                            self.performSegue(withIdentifier: "toMainMap", sender: self)
                        }
                    case .failure(let error):
                                
                        print(error)
                    }
        }
    }
}
