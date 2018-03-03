import UIKit
import GoogleMaps

class MainMapViewController: UIViewController {
    @IBOutlet weak var mapView: GMSMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadMap()
        
        let imageView = UIImageView()
        let image = UIImage(named: "facelogo.png")
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        navigationItem.titleView = imageView
    }
    
    func loadMap() {
        let camera = GMSCameraPosition.camera(withLatitude: 51.50, longitude: -0.076, zoom: 10.0)
        mapView.camera = camera
    }
}
