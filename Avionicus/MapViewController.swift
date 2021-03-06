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
    
    @IBAction func myPlace(_ sender: RoundButton) {
        locationManager.startUpdatingLocation()
        locationManager.stopUpdatingLocation()
    }
    
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
            toggleButton.backgroundColor = .stopRed
            locationManager.startUpdatingLocation()
        } else {
            toggleButton.backgroundColor = .startGreen
            toggleButton.setTitle("Start", for:[])
            locationManager.stopUpdatingLocation()
        }
    }
    
    
    func toggleButton (button: UIButton, onImage: UIImage, ofImage: UIImage){
        
        
    }
    
    func askForSendConfirmation() {
        
        let alert = UIAlertController(title: "Would you like to save the track?", message: nil, preferredStyle: .alert)
        
        alert.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter track comment here..."
        }
        
        let saveAction = UIAlertAction(title: "Save", style: .default ) { [weak welf = self] _ in
            let commentField = alert.textFields![0] as UITextField
            welf?.session.comment = commentField.text ?? ""
            welf?.session.saveCSVToDisk(completion: { (error, path) in
                if error == nil && path != nil {
                    RecordSession.sharedSession.clear()
                    welf?.mapView.clear()
                    welf?.currentPath.removeAllCoordinates()
                    print("Save success")
                    apiManager.postTrack(fileUrl: path!, completion: { (responseState) in
                        switch responseState.state {
                        case .success:
                            print("Success! Track successfully uploaded.")
                            let fm = FileManager.default
                            do {
                                try fm.removeItem(at: path!)
                            } catch {
                                print("Couldn't remove file")
                            }
                        case .error:
                            print("Error. Failed to upload track.")
                        }
                    })
                } else {
                    print("Error: \(error?.localizedDescription ?? "unknown")")
                }
            })
            
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { [weak welf = self] _ in
            RecordSession.sharedSession.clear()
            welf?.mapView.clear()
            welf?.currentPath.removeAllCoordinates()
        }
        
        alert.addAction(cancelAction)
        alert.addAction(saveAction)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    
    
    //    @IBAction func MenuBarItem(_ sender: Any) {present(SideMenuManager.menuLeftNavigationController!, animated: true, completion: nil)}
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateButtonState()
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
        
        self.locationManager.delegate = self
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.distanceFilter = 100
        
        mapView.accessibilityElementsHidden = false
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true

        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
       
        

    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        toggleButton.center.y += view.bounds.height
        
        UIView.animate(withDuration: 0.4 , delay: 0.2 , options: [], animations: {
            
            self.toggleButton.center.y -= self.view.bounds.height
        }, completion: nil)
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
