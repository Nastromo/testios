import UIKit

class SupportViewController: UIViewController {

    @IBOutlet weak var problemTextField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let myColor = UIColor(red: 146/255, green: 150/255, blue: 248/255, alpha: 1)
        problemTextField.layer.borderColor = myColor.cgColor
        problemTextField.layer.borderWidth = 4
    }

}
