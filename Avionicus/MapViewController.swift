//
//  MapVC.swift
//  avionicus
//
//  Created by Фамил Гаджиев on 22.01.17.
//  Copyright © 2017 Фамил Гаджиев. All rights reserved.
//

import UIKit
import GoogleMaps
import SideMenu

class MapViewController: UIViewController{
    
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var startButton: RoundButton!
    
    
    let locationManager = CLLocationManager()
    
    @IBAction func MenuBarItem(_ sender: Any) {present(SideMenuManager.menuLeftNavigationController!, animated: true, completion: nil)}
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.mapView.delegate = self
        self.locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()

        mapView.accessibilityElementsHidden = false
        mapView.isMyLocationEnabled = true

             
        if let mylocation = mapView.myLocation {
            print("User's location: \(mylocation)")
        } else {
            print("User's location is unknown")
        }
        
        self.view = mapView
        
    }
    override func viewWillAppear(_ animated: Bool) {

        
    }
}

extension MapViewController: CLLocationManagerDelegate {

     func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()
            mapView.isMyLocationEnabled = true
            mapView.settings.myLocationButton = true
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            
            mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
            locationManager.stopUpdatingLocation()
            
            if let mylocation = mapView.myLocation {
                print("User's location: \(mylocation)")
            } else {
                print("User's location is unknown")
            }
            
        }
        
        
    }
}













