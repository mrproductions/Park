//
//  TracksDetailViewController.swift
//  Avionicus
//
//  Created by David Zukhbaya on 21.04.17.
//  Copyright © 2017 Park Team. All rights reserved.
//

import UIKit
import GoogleMaps
import Charts

class TracksDetailViewController: UITableViewController, ChartViewDelegate {
    
    var trackID: Int?
    
    @IBOutlet weak var mapView: GMSMapView!
    
    //var chart
    
    
    private struct StoryboardConstants {
        static let InfoCellIdentifier = "Info Cell"
        static let BarChartCellIdentifier = "Bar Chart Cell"
        static let LineChartCellIdentifier = "Line Chart Cell"
    }
    
    struct InfoItem {
        let title: String
        let value: String
    }
    
    var infoItems: [InfoItem] = []
    
    
    override func viewDidLoad() {
        
        tableView.rowHeight = UITableViewAutomaticDimension
        
        super.viewDidLoad()
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        navigationItem.title = "Track details"
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        loadDetails()
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func loadDetails () {
        DispatchQueue.global (qos: .userInitiated).async { [weak welf = self] in
            if welf != nil {
                apiManager.getTrack(trackID: welf!.trackID!, completion: { (result) in
                    switch result {
                    case .success (let value):
                        welf?.configureData(details: value)
                    case .failure (_):
                        print("Error: couldn't load data")
                    }
                })
            }
        }
        
        
    }
    
    func configureData(details: TrackDetails) {
        
        let df = DateFormatter()
        df.dateStyle = .long
        df.timeStyle = .medium
        infoItems.append(InfoItem(title: "Start", value: df.string(from: details.startDate!)))
        infoItems.append(InfoItem(title: "End", value: df.string(from: details.startDate!)))
        infoItems.append(InfoItem(title: "Activity", value: details.activityKind.description))
        
        var seconds: Int = Int(details.duration!)
        let hours: Int = seconds / 3600
        let minutes: Int = (seconds % 3600) / 60
        seconds = seconds % 60
        
        infoItems.append(InfoItem(title: "Time", value: String(format: "%02d:%02d:%02d", hours, minutes, seconds)))
        infoItems.append(InfoItem(title: "Distance, km", value: String(format: "%.2f", details.distance!)))
        infoItems.append(InfoItem(title: "Avg speed, km/h", value: String(format: "%.2f", details.averageSpeed!)))
        infoItems.append(InfoItem(title: "Max speed, km/h", value: String(format: "%.2f", details.maxSpeed!)))
        
        
        DispatchQueue.main.async { [weak welf = self] in
            
            if let points = details.points {
                
                guard points.count > 0 else {
                    return
                }
                
                let currentPath = GMSMutablePath()
                
                for point in points {
                    currentPath.add(CLLocationCoordinate2D(latitude: point.latitude, longitude: point.longitude))
                }
                
                welf?.mapView.camera = GMSCameraPosition(target: CLLocationCoordinate2D(latitude: points[0].latitude, longitude: points[0].longitude), zoom: 16, bearing: 0, viewingAngle: 0)
                
                let path = GMSPolyline(path: currentPath)
                path.strokeColor = .tracksBlue
                path.strokeWidth = 5.0
                path.map = welf?.mapView
                
            }
            
            welf?.tableView.reloadData()
        }
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return infoItems.count
        case 1:
            return 1
        case 2:
            return 1
        default:
            return 0
        }
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        var identifier = ""
        
        switch indexPath.section {
        case 0:
            identifier = StoryboardConstants.InfoCellIdentifier
        case 1:
            identifier = StoryboardConstants.LineChartCellIdentifier
        case 2:
            identifier = StoryboardConstants.BarChartCellIdentifier
        default:
            break
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        
        switch indexPath.section {
        case 0:
            cell.textLabel?.text = infoItems[indexPath.row].title
            cell.detailTextLabel?.text = infoItems[indexPath.row].value
        case 1:
            let lineChartCell = cell as! LineChartCell
            
        // set up lineChartView
        case 2:
            let barChartCell = cell as! BarChartCell
        // set up barChartView
        default:
            break
        }
        
        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // this will be non-nil if a blur effect is applied
        guard tableView.backgroundView == nil else {
            return
        }
        
        let imageView = UIImageView(image:#imageLiteral(resourceName: "Little bit Black"))
        imageView.contentMode = .scaleAspectFill
        
        
        tableView.backgroundView = imageView
        
    }
}



