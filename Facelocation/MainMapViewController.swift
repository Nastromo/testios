import UIKit
import GoogleMaps
import GooglePlaces

class MainMapViewController: UIViewController, GMSMapViewDelegate, CLLocationManagerDelegate, GMSAutocompleteViewControllerDelegate{

    //OUTLETS
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var leftMenuConstrait: NSLayoutConstraint!
    @IBOutlet weak var menuView: UIView!
    
    //VARIABLES
    var menuState = false
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imageView = UIImageView()
        let image = UIImage(named: "facelogo.png")
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        navigationItem.titleView = imageView
        
        mapView.isMyLocationEnabled = true
        mapView.delegate = self
        
        //Location Manager code to fetch current location
        self.locationManager.delegate = self
        self.locationManager.startUpdatingLocation()
        
        menuView.layer.shadowOpacity = 0.5
        menuView.layer.shadowRadius = 6
    }
    
    //Animate camera on user current position
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
        let camera = GMSCameraPosition.camera(withLatitude: (location?.coordinate.latitude)!, longitude:(location?.coordinate.longitude)!, zoom:16)
        mapView.animate(to: camera)
        
        //Finally stop updating location otherwise it will come again and again in this delegate
        self.locationManager.stopUpdatingLocation()
    }
    
    //App Menu
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
    
    
    //AutoComplete Google Search for Places
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        let camera = GMSCameraPosition.camera(withLatitude: place.coordinate.latitude, longitude: place.coordinate.longitude, zoom: 16)
        self.mapView.camera = camera
        self.dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print("ERROR!!!!!!! \(error)")
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func searchForPlace(_ sender: Any) {
        let autoCompleteController = GMSAutocompleteViewController()
        autoCompleteController.delegate = self
        
        self.locationManager.startUpdatingLocation()
        self.present(autoCompleteController, animated: true, completion: nil)
    }
    
    @IBAction func addNewLocation(_ sender: Any) {
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
