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

class  MainViewController: UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var MenuBarItem: UIBarButtonItem!
    var menuView: BTNavigationDropdownMenu!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.shared.statusBarStyle = .lightContent
        let imageForNavBar = UIImage(named: "StatusBar")
        navigationController?.navigationBar.setBackgroundImage(imageForNavBar, for: .default)
    
    }
    
    func printSome() {
        print("11111111111")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        dropMenuButtonView()
        setupSideMenu()
    }
    
    @IBAction func MenuBarButton(_ sender: Any) {
        present(SideMenuManager.menuLeftNavigationController!, animated: true, completion: nil)
    }
    
    @IBAction func StartButton(_ sender: Any) {
        print("Start Button")
    }
    
    func setupSideMenu(){
        
        let menuLeftNavigationController = storyboard?.instantiateViewController(withIdentifier: "LeftMenu") as? UISideMenuNavigationController
        
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
    
    
    
}
