import UIKit
import Pulsator

class StartViewController: UIViewController {
    
    @IBOutlet weak var circle: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    
        
        let pulsator = Pulsator()
        pulsator.numPulse = 6
        pulsator.radius = 200
        pulsator.animationDuration = 5
        pulsator.backgroundColor = UIColor(red: 0.678, green: 0.741, blue: 0.941, alpha: 0.8).cgColor
        circle.layer.addSublayer(pulsator)
        pulsator.start()
    }
    
}

