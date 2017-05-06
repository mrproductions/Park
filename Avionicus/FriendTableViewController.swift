//
//  FriendTableViewController.swift
//
//
//  Created by Фамил Гаджиев on 30.04.17.
//
//

import UIKit

class FriendTableViewController: UITableViewController {
    
    private enum SelectedSection: Int {
        case friends
        case requests
    }
    
    private var selectedSection: SelectedSection = .friends
    
    @IBAction func closeTableView(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    var friendsList: [UserFriend]?
    var displayedFriends: [UserFriend]?
    
    @IBOutlet weak var sectionSwitcher: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadFriend()
        let imageForNavBar = UIImage(named: "StatusBar")
        navigationController?.navigationBar.setBackgroundImage(imageForNavBar, for: .default)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
    }
    
    struct StoryboardConstants {
        static let cellIdentifier = "Cell"
        static let headerIdentifier = "TracksTableHeader"
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return displayedFriends?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: StoryboardConstants.cellIdentifier, for: indexPath) as! FriendTableViewCell
        cell.f =  displayedFriends?[indexPath.row]
        return cell
    }
    
    
    @IBAction func sectionSwitched(_ sender: UISegmentedControl) {
        
        selectedSection = SelectedSection(rawValue: sender.selectedSegmentIndex)!
        filterFriendsList()
        tableView.reloadData()
    }
    
    
    func loadFriend() {
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        DispatchQueue.global(qos: .userInitiated).async { [weak welf = self] in
            
            apiManager.getFriends{ result in
                welf?.refreshControl?.endRefreshing()
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                switch result {
                case.success( let friend):
                    welf?.friendsList = friend.arrayFriend
                    welf?.filterFriendsList()
                    DispatchQueue.main.async {
                        welf?.tableView.reloadData()
                    }
                case.failure( _):
                    print("error load friend")
                    break
                }
            }
        }
    }
    
    func filterFriendsList() {
        
        let filterKey: String
        
        switch selectedSection {
        case .friends:
            filterKey = "friend"
        case .requests:
            filterKey = "not_yet_accepted"
        }
        
        displayedFriends = friendsList?.filter { $0.statusFriend! == filterKey }
        
    }
    
    func setUpTable(){
        //friendItem.append(contentsOf: )
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
