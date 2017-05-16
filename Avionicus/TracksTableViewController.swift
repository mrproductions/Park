//
//  TracksVC.swift
//  avionicus
//
//  Created by David Zukhbaia on 26.03.17.
//  Copyright © 2017 Park Team. All rights reserved.
//

import UIKit
import SideMenu
import RealmSwift

class TracksTableViewController: UITableViewController {
    
    var items: [[TrackerItem]] = []
    var tracks: [TrackListItem]?
    
    struct StoryboardConstants {
        static let cellIdentifier = "TrackCell"
        static let headerIdentifier = "TracksTableHeader"
    }
    
    @IBAction func MenuBarItem(_ sender: Any) {
        present(SideMenuManager.menuLeftNavigationController!, animated: true, completion: nil)
    }
    
    // MARK : - UIViewController lifecycle methods
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        tracks = Array(DatabaseManager.realm.objects(TrackListItem.self))
        processRawData(tracks: tracks!)        
        
        loadTracks()
        let imageForNavBar = UIImage(named: "StatusBar")
        navigationController?.navigationBar.setBackgroundImage(imageForNavBar, for: .default)
        //navigationBlurEffect()
        
        //navigationController?.navigationBar.barStyle = .default
        navigationItem.title  = "Мои треки"
        //navigationController?.navigationBar.backgroundColor = UIColor.lightText
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
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
    
    
    func navigationBlurEffect() {
        // Add blur view
        let bounds = self.navigationController?.navigationBar.bounds as CGRect!
        let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        visualEffectView.frame = bounds!
        visualEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        //here you can choose one
        self.navigationController?.navigationBar.addSubview(visualEffectView)
        // Or
        /*
         If you find that after adding blur effect on navigationBar, navigation buttons are not visible then add below line after adding blurView code.
         */
        self.navigationController?.navigationBar.sendSubview(toBack: visualEffectView)
        
        // Here you can add visual effects to any UIView control.
        // Replace custom view with navigation bar in above code to add effects to custom view.
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = items[indexPath.section][indexPath.row]
        let storyBoard = UIStoryboard(name:"Tracks", bundle: nil)
        let detailVC = storyBoard.instantiateViewController(withIdentifier: "TracksDetailVC") as! TracksDetailViewController
        detailVC.trackID = item.id
        tableView.deselectRow(at: indexPath, animated: true)
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    
    
    // MARK: - Data loading and processing
    
    @IBAction func refreshTriggered() {
        loadTracks()
    }
    
    
    func loadTracks() {
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        DispatchQueue.global (qos: .userInitiated).async { [weak welf = self] in
            apiManager.getTracks(page: 1, perPage: 50) { result in
                welf?.refreshControl?.endRefreshing()
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                switch result {
                case .success (let tracksList):
                    welf?.tracks = tracksList
                    welf?.processRawData(tracks: tracksList)
                    break
                case .failure(let error):
                    print("An error has occurred: \(error)")
                    break
                }
            }
        }
        
    }
    
    func processRawData(tracks: [TrackListItem]) {
        
        var dates: [String:Int] = [:]
        var result: [[TrackerItem]] = []
        
        
        let rawItems = tracks.map { $0.viewModel() }
        for item in rawItems {
            let ind = dates[item.formattedDate] ?? result.count
            dates[item.formattedDate] = ind
            if ind == result.count {
                result.append([])
            }
            result[ind].append(item)
        }
        
        result.sort { $0[0].date > $1[0].date }
        
        DispatchQueue.main.async { [weak self] in
            let realm = DatabaseManager.realm
            try! realm.write {
                realm.add(tracks, update: true)
            }

            self?.items = result
            self?.tableView.reloadData()
        }
    }
    

//    class func readFromBD() -> Person {
//        
//        let realm = DatabaseManager.realm
//        let persons = realm.objects(Person.self)
//        
//        return persons[0]
//    }
//    

}
    

    

