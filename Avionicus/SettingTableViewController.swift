//
//  SettingTableViewController.swift
//  Avionicus
//
//  Created by Фамил Гаджиев on 17.05.17.
//  Copyright © 2017 Park Team. All rights reserved.
//

import UIKit
import GoogleMaps

class SettingTableViewController: UITableViewController {

    let currentPath = GMSMutablePath()

    @IBAction func backButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    /*let path = GMSPolyline(path: currentPath)
     path.strokeColor = .tracksBlue
     path.strokeWidth = 5.0
     path.map = mapView*/
    @IBAction func redPath(_ sender: UIButton) {
        let pathColor = GMSPolyline(path: currentPath)
        pathColor.strokeColor = .tracksBlue
        pathColor.strokeWidth = 5.0
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // this will be non-nil if a blur effect is applied
        guard tableView.backgroundView == nil else {
            return
        }
        
        let imageView = UIImageView(image:#imageLiteral(resourceName: "Little bit Black"))
        imageView.contentMode = .scaleAspectFill
        imageView.alpha = 50
        tableView.backgroundView = imageView
        
    }
    
}
