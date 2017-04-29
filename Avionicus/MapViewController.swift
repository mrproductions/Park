//
//  MapVC.swift
//  avionicus
//
//  Created by Фамил Гаджиев on 22.01.17.
//  Copyright © 2017 Park Team. All rights reserved.
//

import UIKit
import GoogleMaps
import SideMenu

class MapViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var toggleButton: RoundButton!
    
    let locationManager = CLLocationManager()
    let session = RecordSession.sharedSession
    let currentPath = GMSMutablePath()
    
    @IBAction func toggleRecording(_ sender: RoundButton) {
        session.recordInProgress = !(session.recordInProgress)
        updateButtonState()
        if !session.recordInProgress {
            askForSendConfirmation()
        }
    }
    
    func updateButtonState() {
        if session.recordInProgress {
            toggleButton.setTitle("Stop", for:[])
            locationManager.startUpdatingLocation()
        } else {
            toggleButton.setTitle("Start", for:[])
            locationManager.stopUpdatingLocation()
        }
    }
    
    func askForSendConfirmation() {
        
        let alert = UIAlertController(title: "Would you like to save the track?", message: nil, preferredStyle: .alert)
        
        alert.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter track comment here..."
        }
        
        let saveAction = UIAlertAction(title: "Save", style: .default ) { _ in
            let commentField = alert.textFields![0] as UITextField
            print("Yay! Comment: \(commentField.text)")
            
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(cancelAction)
        alert.addAction(saveAction)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    
    
//    @IBAction func MenuBarItem(_ sender: Any) {present(SideMenuManager.menuLeftNavigationController!, animated: true, completion: nil)}
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateButtonState()
        
        //self.mapView.delegate = self
        self.locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.distanceFilter = 100

        mapView.accessibilityElementsHidden = false
        mapView.isMyLocationEnabled = true
        
        
       
        
    }
    override func viewWillAppear(_ animated: Bool) {

    }
    
    // MARK: - Location manager delegate methods
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            self.locationManager.distanceFilter = 100
            mapView.isMyLocationEnabled = true
            mapView.settings.myLocationButton = true
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.last {
            
            print("Updating location: \(location)")
            
            mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
            
            session.updateLocation(location: location)
            
            currentPath.add(location.coordinate)
            let path = GMSPolyline(path: currentPath)
            path.strokeColor = .tracksBlue
            path.strokeWidth = 5.0
            path.map = mapView
            
        }
        
        
    }
    
}
