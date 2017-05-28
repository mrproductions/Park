//
//  MainVC.swift
//  avionicus
//
//  Created by Фамил Гаджиев on 20.12.16.
//  Copyright © 2016 Фамил Гаджиев. All rights reserved.
//

import UIKit
import BTNavigationDropdownMenu
import SideMenu

class  MainViewController: UIViewController, UIGestureRecognizerDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var MenuBarItem: UIBarButtonItem!
    var menuView: BTNavigationDropdownMenu!
    @IBOutlet weak var dashboardView: UICollectionView!
    
    var items = [DashboardItem]()
    var itemsIndexMap = [String: Int]()
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        configureDashboard()
        
        dashboardView?.delegate = self
        dashboardView?.dataSource = self
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 15, bottom: 10, right: 15)
        layout.minimumInteritemSpacing = 2
        layout.minimumLineSpacing = 10
        layout.itemSize = CGSize(width: 180, height: 120)
        dashboardView?.collectionViewLayout = layout
        dashboardView?.alwaysBounceVertical = true
        
        UIApplication.shared.statusBarStyle = .lightContent
        let imageForNavBar = UIImage(named: "StatusBar")
        navigationController?.navigationBar.setBackgroundImage(imageForNavBar, for: .default)
        
    }
    
    func configureDashboard() {
        
        RecordSession.sharedSession.delegate = self
        
        items.append(DashboardItem(imageName: "Altitude icon", title: "Altitude", value: "0.0"))
        items.append(DashboardItem(imageName: "Average speed icon", title: "Average speed", value: "0.0"))
        items.append(DashboardItem(imageName: "Distance icon", title: "Distance", value: "0.0"))
        items.append(DashboardItem(imageName: "Max speed icon", title: "Max speed", value: "0.0"))
        items.append(DashboardItem(imageName: "Speed icon", title: "Current speed", value: "0.0"))
        items.append(DashboardItem(imageName: "Time elapsed icon", title: "Time elapsed", value: "0.0"))
        
        itemsIndexMap = [ "altitude" : 0, "avg_speed" : 1, "distance" : 2, "max_speed" : 3, "speed" : 4, "time_elapsed" : 5 ]
        
        dashboardView?.reloadData()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        dropMenuButtonView()
        setupSideMenu()
        
        
        // this will be non-nil if a blur effect is applied
        guard dashboardView?.backgroundView == nil else {
            return
        }
        
        let imageView = UIImageView(image:#imageLiteral(resourceName: "Little bit Black"))
        imageView.contentMode = .scaleAspectFill
        
        dashboardView?.backgroundView = imageView
        
        
    }
    
    @IBAction func MenuBarButton(_ sender: Any) {
        present(SideMenuManager.menuLeftNavigationController!, animated: true, completion: nil)
    }
    
    @IBAction func StartButton(_ sender: Any) {
        print("Start Button")
    }
    
    func setupSideMenu(){
        
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let menuLeftNavigationController = sb.instantiateViewController(withIdentifier: "LeftMenu") as? UISideMenuNavigationController
        
        menuLeftNavigationController?.leftSide = true
        SideMenuManager.menuLeftNavigationController = menuLeftNavigationController
        SideMenuManager.menuAddPanGestureToPresent(toView: self.navigationController!.navigationBar)
        SideMenuManager.menuAddScreenEdgePanGesturesToPresent(toView: self.navigationController!.view)
        setupDifaultSideMenu()
        
    }
    
    func setupDifaultSideMenu (){
        
        SideMenuManager.menuAnimationBackgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "Little bit Black") )
        SideMenuManager.menuWidth = 350.0
        SideMenuManager.menuPresentMode = .menuSlideIn
        SideMenuManager.menuPushStyle = .defaultBehavior
        
        
    }
    
    func dropMenuButtonView(){
        
        let activities = [ActivityKind.aerostat, ActivityKind.airplane, ActivityKind.autogyro, ActivityKind.bike, ActivityKind.car, ActivityKind.dogwalking, ActivityKind.downhillski, ActivityKind.elliptical, ActivityKind.ellipticalTrainer, ActivityKind.excerciseBicycle, ActivityKind.exercycle, ActivityKind.fishingboat, ActivityKind.gliding, ActivityKind.hanggliding, ActivityKind.hangglidingTrike, ActivityKind.helicopter, ActivityKind.hiking, ActivityKind.horseriding, ActivityKind.kitesurfing, ActivityKind.kiting, ActivityKind.kitingWinter, ActivityKind.motorboat, ActivityKind.motorcycle, ActivityKind.nordicwalking, ActivityKind.other, ActivityKind.paragliding, ActivityKind.pokemon, ActivityKind.powerboat, ActivityKind.ppg, ActivityKind.pramwalking, ActivityKind.riding, ActivityKind.rollerSkiing, ActivityKind.rollerski, ActivityKind.rowing, ActivityKind.run, ActivityKind.sailboat, ActivityKind.shorefishing, ActivityKind.skiing, ActivityKind.snowboard, ActivityKind.snowkiting, ActivityKind.swimming, ActivityKind.treadmill, ActivityKind.ultralight, ActivityKind.walk, ActivityKind.waterscooter]
        
        let menuItems = activities.map { $0.description }
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
        
        let title = "Run"
        
        menuView = BTNavigationDropdownMenu(navigationController: self.navigationController, containerView: self.navigationController!.view, title: title, items: menuItems as [AnyObject])
        
        menuView.cellHeight = 50
        menuView.cellBackgroundColor = self.navigationController?.navigationBar.barTintColor
        menuView.cellSelectionColor = UIColor(red: 0.0/255.0, green:160.0/255.0, blue:195.0/255.0, alpha: 1.0)
        menuView.shouldKeepSelectedCellColor = true
        menuView.cellTextLabelColor = UIColor.white
        menuView.cellTextLabelFont = UIFont(name: "AvenirNext-Regular", size: 17)
        menuView.cellTextLabelAlignment = .left // .Center // .Right // .Left
        menuView.arrowPadding = 15
        menuView.animationDuration = 0.1
        menuView.maskBackgroundColor = UIColor.white
        menuView.maskBackgroundOpacity = 0.3
        menuView.didSelectItemAtIndexHandler = { (indexPath: Int) -> () in
            RecordSession.sharedSession.activityKind = activities[indexPath]
        }
        
        
        self.navigationItem.titleView = menuView
        
        
    }
    
    
    
    // MARK: - UICollectionViewDelegate methods
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    // MARK: - UICollectionViewDataSource methods
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Dashboard Cell", for: indexPath) as! DashboardCell
        
        let item = items[indexPath.row]
        
        cell.descriptionLabel.text = item.title
        cell.valueLabel.text = item.value
        cell.iconImageView.image = UIImage(named: item.imageName)?.withRenderingMode(.alwaysTemplate)
        cell.iconImageView.tintColor = .white
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
}


extension MainViewController : RecordSessionDelegate {
    
    func reloadItem (index: Int) {
        UIView.animate(withDuration: 0) { [weak welf = self] in
            welf?.dashboardView?.performBatchUpdates({
                welf?.dashboardView?.reloadItems(at: [IndexPath(item: index, section: 0)])
            }, completion: nil)
        }
    }
    
    func statusDidChange (recording: Bool) {
        
    }
    
    func speedDidChange (speed: Double) {
        let index = itemsIndexMap["speed"]!
        items[index].value =  String(format: "%.2f", speed)
        reloadItem(index: index)
    }
    
    func altitudeDidChange (altitude: Double) {
        let index = itemsIndexMap["altitude"]!
        items[index].value = String(format: "%.2f", altitude)
        reloadItem(index: index)
    }
    
    func distanceDidChange (distance: Double) {
        let index = itemsIndexMap["distance"]!
        items[index].value = String(format: "%.2f", distance)
        reloadItem(index: index)
    }
    
    func maxSpeedDidChange (maxSpeed: Double) {
        let index = itemsIndexMap["max_speed"]!
        items[index].value = String(format: "%.2f", maxSpeed)
        reloadItem(index: index)
    }
    
    func averageSpeedDidChange (averageSpeed: Double) {
        let index = itemsIndexMap["avg_speed"]!
        items[index].value = String(format: "%.2f", averageSpeed)
        reloadItem(index: index)
    }
    
    func courseDidChange (course: Double) {
    }
    
    func timeDidUpdate (timeElapsed: Int) {
        let index = itemsIndexMap["time_elapsed"]!
        items[index].value = String(timeElapsed)
        reloadItem(index: index)
    }
    
}


