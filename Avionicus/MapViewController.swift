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

class MapViewController: UIViewController, CLLocationManagerDelegate{
    
    
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    let locationManager = CLLocationManager()
    
    
    @IBAction func MenuBarItem(_ sender: Any) {
        present(SideMenuManager.menuLeftNavigationController!, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let camera = GMSCameraPosition.camera(withLatitude: 55.754911, longitude: 37.613674, zoom: 10)
        mapView.camera = camera
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        mapView.addObserver(self, forKeyPath: "myLocation", options: NSKeyValueObservingOptions.new, context: nil)
        
    }
    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == CLAuthorizationStatus.authorizedWhenInUse {
            mapView.isMyLocationEnabled = true
        }
    }
}














