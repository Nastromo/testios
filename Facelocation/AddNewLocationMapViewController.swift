import UIKit

class AddNewLocationMapViewController: UIViewController {

    @IBOutlet weak var locationTitle: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Location.title = locationTitle.text
    }
}
