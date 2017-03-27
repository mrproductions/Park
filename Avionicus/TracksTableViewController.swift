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
    
    var items: [[TrackerItem]] = []
    var tracksMap: [String:TrackListItem]?
    
    struct StoryboardConstants {
        static let cellIdentifier = "TrackCell"
        static let detailSegueIdentifier = ""
        static let headerIdentifier = "TracksTableHeader"
    }
    
    @IBAction func MenuBarItem(_ sender: Any) {
        present(SideMenuManager.menuLeftNavigationController!, animated: true, completion: nil)
    }
    
    // MARK : - UIViewController lifecycle methods
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        loadTracks()
        navigationController?.navigationBar.barStyle = .black
        navigationItem.title  = "Мои треки"
        navigationController?.navigationBar.backgroundColor = UIColor.tracksBlue
        let headerNib = UINib(nibName: "TracksTableHeader", bundle: nil)
        tableView.register(headerNib, forHeaderFooterViewReuseIdentifier: StoryboardConstants.headerIdentifier)
        
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

    
    // MARK: - UITableView delegate methods
    
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let date = items[section][0].formattedDate
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: StoryboardConstants.headerIdentifier) as! TracksTableHeaderView
        header.dateLabel.text = date
        return header
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(25)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(44)
    }
    
    // MARK: - Storyboard related methods
    
    
    // MARK: - Data loading and processing
    
    @IBAction func refreshTriggered() {
        loadTracks()
    }
    
    
    func loadTracks() {
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        DispatchQueue.global (qos: .userInitiated).async { [weak welf = self] in
            apiManager.getTracks(count: 50, offset: 0) { result in
                welf?.refreshControl?.endRefreshing()
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                switch result {
                case .success (let tracksList):
                    if let tracksMap = tracksList.tracks {
                        welf?.tracksMap = tracksMap
                        welf?.processRawData(tracksMap: tracksMap)
                    }
                    break
                case .failure(let error):
                    print("An error has occurred: \(error)")
                    break
                }
            }
        }
        
    }
    
    func processRawData(tracksMap: [String:TrackListItem]) {
        
        var dates: [String:Int] = [:]
        var result: [[TrackerItem]] = []
        
        let rawItems = tracksMap.values.map { $0.viewModel }
        for item in rawItems {
            let ind = dates[item.formattedDate] ?? result.count
            dates[item.formattedDate] = ind
            if ind == result.count {
                result.append([])
            }
            result[ind].append(item)
        }
        
        result.sort { $0[0].date < $1[0].date }
        
        DispatchQueue.main.async { [weak welf = self] in
            welf?.items = result
            welf?.tableView.reloadData()
        }
    }
    


}
    

    

