import UIKit
import GoogleMaps

class TestViewController: UIViewController {

    @IBOutlet weak var eeee: UILabel!
    @IBOutlet weak var map: GMSMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        eeee.text = "sdfasdf"
        
       load()
    }
    
    func load() {
        //map
        let camera = GMSCameraPosition.camera(withLatitude: 51.50, longitude: -0.076, zoom: 10.0)
        map.camera = camera
        
        //marker
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: 51.50, longitude: -0.076)
        marker.title = "London"
        marker.snippet = "UK"
        marker.map = map
    }
}
