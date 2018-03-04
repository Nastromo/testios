import UIKit

class LocalizedViewController: UIViewController {
    
    @IBOutlet weak var gradientView: UIView!
    var gl:CAGradientLayer!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Make Gradient
        let gradientColor = GradientColor()        
        gradientView.backgroundColor = UIColor.clear
        let backLayer = gradientColor.gl
        backLayer?.frame = gradientView.frame
        view.layer.insertSublayer(backLayer!, at: 0)
    }
}
