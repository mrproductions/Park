//
//  TracksVC.swift
//  avionicus
//
//  Created by David Zukhbaia on 26.03.17.
//  Copyright © 2017 Park Team. All rights reserved.
//

import UIKit
import SideMenu

class TracksTableViewController: UITableViewController {
    
    var items: [[TrackerItem]] = [[TrackerItem(kind: .running, time: TrackerItem.Time(hours: 1, minutes: 2, seconds: 40), date: Date(), speed: 7.8, routeLength: 23.8), TrackerItem(kind: .bike, time: TrackerItem.Time(hours: 0, minutes: 7, seconds: 40), date: Date(), speed: 49.7, routeLength: 6.4)]]
    
    struct StoryboardConstants {
        static let cellIdentifier = "TrackCell"
        static let detailSegueIdentifier = ""
    }
    
    @IBAction func MenuBarItem(_ sender: Any) {
        present(SideMenuManager.menuLeftNavigationController!, animated: true, completion: nil)
    }
    
    // MARK : - UIViewController lifecycle methods
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        navigationController?.navigationBar.barStyle = .black
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // this will be non-nil if a blur effect is applied
        guard tableView.backgroundView == nil else {
            return
        }
        
        // Set up a cool background image for demo purposes
        let imageView = UIImageView(image:#imageLiteral(resourceName: "Little bit Black"))
        imageView.contentMode = .scaleAspectFill
        
        
        //imageView.backgroundColor = UIColor.black.withAlphaComponent(5)
        tableView.backgroundView = imageView
    }
    
    

    
    // MARK: - UITableView data source methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items[section].count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: StoryboardConstants.cellIdentifier, for: indexPath) as! TracksTableViewCell
        cell.item = items[indexPath.section][indexPath.row]
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(44)
    }
    
    


}
    

    

