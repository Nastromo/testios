//
//  LocationMapViewController.swift
//  Facelocation
//
//  Created by Nastro Mo on 19.03.2018.
//  Copyright © 2018 Facelocation. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class LocationMapViewController: UIViewController, GMSMapViewDelegate, CLLocationManagerDelegate, GMSAutocompleteViewControllerDelegate {

    @IBOutlet weak var googleMap: GMSMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //Position for new location
    @IBAction func serchLocation(_ sender: Any) {
        //This code shows Google Places autocomplete search dialog window
        let autoCompleteController = GMSAutocompleteViewController()
        autoCompleteController.delegate = self
        self.present(autoCompleteController, animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        let camera = GMSCameraPosition.camera(withLatitude: place.coordinate.latitude, longitude: place.coordinate.longitude, zoom: 16)
        self.googleMap.camera = camera
        
        let markerPosition = CLLocationCoordinate2D(latitude: place.coordinate.latitude, longitude: place.coordinate.longitude)
        let newLocationMarker = GMSMarker(position: markerPosition)
        newLocationMarker.icon = UIImage(named: "myPosition")
        newLocationMarker.map = googleMap
        
        Location.latitude = place.coordinate.latitude
        Location.longitude = place.coordinate.longitude
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print("ОШИБКА АВТОДОПЛЕНИЯ")
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        self.dismiss(animated: true, completion: nil)
    }
}
