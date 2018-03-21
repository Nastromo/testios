import UIKit

class AddNewLocationMapViewController: UIViewController {

    @IBOutlet weak var locationTitle: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func goNext(_ sender: Any) {
        Location.title = locationTitle.text
    }
}
