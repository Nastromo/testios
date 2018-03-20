import UIKit
import GoogleMaps
import GooglePlaces
import Alamofire

class MainMapViewController: UIViewController, GMSMapViewDelegate, CLLocationManagerDelegate, GMSAutocompleteViewControllerDelegate{

    //OUTLETS
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var leftMenuConstrait: NSLayoutConstraint!
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var userAvatar: UIButton!
    
    
    //VARIABLES
    var menuState = false
    var locationManager = CLLocationManager()
    var currentLocationMarker: GMSMarker?
    let requestURL = URLlist.baseURL + URLlist.nearestEventsGET
    var latitude: Double?
    var longitude: Double?
    var markersArray = [EventMarker]()
    var lastlocation: CLLocation?
    var firstRun = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imageView = UIImageView()
        let image = UIImage(named: "facelogo.png")
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationItem.titleView = imageView
        
        mapView.delegate = self
        mapView.isMyLocationEnabled = true
        
        
        //Location Manager code to fetch current location
        self.locationManager.delegate = self
        self.locationManager.startUpdatingLocation()
        
        menuView.layer.shadowOpacity = 0.5
        menuView.layer.shadowRadius = 6
        
        setUserAvatar()

    }
    
    //Downloading and Set User Avatar from URL
    func setUserAvatar(){
        let imageURL = URL(string: DataBaseHelper.userDataArray[3])
        let data = try? Data(contentsOf: imageURL!)
        let userAvatarImage = UIImage(data: data!)
        userAvatar.setImage(userAvatarImage, for: .normal)
        userAvatar.layer.cornerRadius = 26;
        userAvatar.layer.masksToBounds = true;
    }

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if(!firstRun){
            print("ПОКАЗАТЬ БЛИЖАЙШИЕ ИВЕНТЫ: \(latitude!), \(longitude!)")
            showNearestEvents(latitude: latitude!, longitude: longitude!)
        }
    }
    
    //Create custom marker
    func addCustomCurrentLocationMarker() {
        currentLocationMarker = GMSMarker(position: (lastlocation?.coordinate)!)
        currentLocationMarker?.icon = UIImage(named: "myPosition")
        currentLocationMarker?.map = mapView
    }
    
    
    func moveToUserPosition(){
        let camera = GMSCameraPosition.camera(withLatitude: latitude!, longitude:longitude!, zoom:16)
        mapView.animate(to: camera)
    }
    

    //Show events on map
    func showNearestEvents(latitude: Double, longitude: Double){
        let parameters: Parameters = [
            "latitude": latitude,
            "longitude": longitude,
            "published": "true"
        ]
    
        Alamofire.request(requestURL,
                          method: .get,
                          parameters: parameters,
                          encoding: URLEncoding.default,
                          headers: URLlist.headers).responseJSON {response in
                            
                            switch response.result {
                            case .success:
//                                print("БЛИЖАЙШИЕ ИВЕНТЫ: \(response)")
                                if response.response?.statusCode == 200{
                                    //We know, we have to get an Array of Objects
                                    let response =  response.result.value as! Array<Any>
                                    
                                    //Iterate the gotted Array where each Object = element
                                    for element in response{
                                        
                                        //We know the each element represent an Object without parametr name becouse it starts from "{"
                                        let data = element as! Dictionary<String, Any>
                                        
                                        //In this "data" there is a parameter named "locations" - we get it. And we know the "locations" is an Array
                                        let locations = data["locations"] as! Array<Any>
                                        for location in locations{
                                            let data = location as! Dictionary<String, Any>
                                            let eventID = data["_id"] as! String
                                            let address = data["address"] as! Dictionary<String, Any>
                                            let marker = address["marker"] as! Dictionary<String, Any>
                                            let latitude = marker["latitude"] as! Double
                                            let longitude = marker["longitude"] as! Double
                                            self.markersArray.append(EventMarker(jsonDic: marker))
                                            
                                            // Creates a marker
                                            let eventMarker = GMSMarker()
                                            eventMarker.position = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                                            eventMarker.icon = UIImage(named: "eventMarker")
                                            eventMarker.snippet = eventID
                                            eventMarker.map = self.mapView
                                        }
                                    }
                                }
                            case .failure(let error):
                                print("ОШИБКА ПОЛУЧЕНИЯ КООРДИНАТ БЛИЖАЙШИХ ИВЕНТОВ")
                                print(error)
                            }
        }
    }

    
    //Exit from App by pushing Exit btn in menu app
    @IBAction func clickExit(_ sender: Any) {
        DataBaseHelper.deleteUser(userID: DataBaseHelper.userDataArray[0])
        self.performSegue(withIdentifier: "goExit", sender: self)
    }
    
    //Get last user position coordinates
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        lastlocation = locations.last
        latitude = (lastlocation?.coordinate.latitude)!
        longitude = (lastlocation?.coordinate.longitude)!
        
        currentLocationMarker?.position = CLLocationCoordinate2D(latitude: (lastlocation?.coordinate.latitude)!, longitude: (lastlocation?.coordinate.longitude)!)
        
        if(firstRun){
            let camera = GMSCameraPosition.camera(withLatitude: latitude!, longitude:longitude!, zoom:16)
            mapView.animate(to: camera)
            mapView.isMyLocationEnabled = false
            addCustomCurrentLocationMarker()
            showNearestEvents(latitude: latitude!, longitude: longitude!)
            firstRun = false
        }

        //Finally stop updating location otherwise it will come again and again in this delegate
//        self.locationManager.stopUpdatingLocation()
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
        
        //This vars for viewDidApear method - shows nearest events in chosen place
        latitude = place.coordinate.latitude
        longitude = place.coordinate.longitude
        
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
        //This code shows Google Places autocomplete search dialog window
        let autoCompleteController = GMSAutocompleteViewController()
        autoCompleteController.delegate = self
        self.present(autoCompleteController, animated: true, completion: nil)
    }
    
    //Add New Location
    @IBAction func addNewLocation(_ sender: Any) {
        navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.tintColor = UIColor.white
    }
    

    
    
}
