import UIKit
import GoogleMaps

class MainMapViewController: UIViewController {
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var leftMenuConstrait: NSLayoutConstraint!
    @IBOutlet weak var menuView: UIView!
    var menuState = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadMap()
        
        let imageView = UIImageView()
        let image = UIImage(named: "facelogo.png")
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        navigationItem.titleView = imageView
        
        menuView.layer.shadowOpacity = 0.5
        menuView.layer.shadowRadius = 6
        
    }
    
    func loadMap() {
        let camera = GMSCameraPosition.camera(withLatitude: 51.50, longitude: -0.076, zoom: 10.0)
        mapView.camera = camera
    }
    
    @IBAction func showMenu(_ sender: Any) {
        if (menuState) {
            leftMenuConstrait.constant = -240;
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
        } else {
            leftMenuConstrait.constant = 0;
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
        }
        menuState = !menuState
    }
}
