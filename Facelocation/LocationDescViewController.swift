import UIKit

class LocationDescViewController: UIViewController {

    @IBOutlet weak var desc: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let myColor = UIColor(red: 146/255, green: 150/255, blue: 248/255, alpha: 1)
        desc.layer.borderColor = myColor.cgColor
        desc.layer.borderWidth = 4
    }
    
    
    @IBAction func nextStep(_ sender: Any) {
        getLocationAboutText()
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        
    }
    
    
    func getLocationAboutText(){
        Location.text = desc.text
    }
}
