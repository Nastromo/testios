import UIKit
import Pulsator

class StartViewController: UIViewController {
    
    @IBOutlet weak var circle: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    
        startPulsator()
        
        DataBaseHelper.createDataBase()
        DataBaseHelper.createTable()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    
    func startPulsator(){
        let pulsator = Pulsator()
        pulsator.numPulse = 6
        pulsator.radius = 200
        pulsator.animationDuration = 5
        pulsator.backgroundColor = UIColor(red: 0.678, green: 0.741, blue: 0.941, alpha: 0.8).cgColor
        circle.layer.addSublayer(pulsator)
        pulsator.start()
    }
    
    
    @IBAction func goToApp(_ sender: Any) {
        isLogedUser()
    }
    
    func isLogedUser(){
        let logedUserCount = DataBaseHelper.getLogedUsers()
        if (logedUserCount == 1){
            self.navigationController?.navigationBar.barTintColor = Colors.mainColor
            self.navigationController?.navigationBar.isTranslucent = false
            
            self.performSegue(withIdentifier: "toMainScreen", sender: self)
        } else {
            self.performSegue(withIdentifier: "toLoginScrn", sender: self)
        }
    }
}

