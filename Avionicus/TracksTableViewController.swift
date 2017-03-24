//
//  TracksVC.swift
//  avionicus
//
//  Created by Фамил Гаджиев on 22.01.17.
//  Copyright © 2017 Фамил Гаджиев. All rights reserved.
//

import UIKit
import ObjectMapper
import SideMenu

class TracksTableViewController: UITableViewController {
    
    @IBAction func MenuBarItem(_ sender: Any) {
        present(SideMenuManager.menuLeftNavigationController!, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
   
        
    }
    
    func setBacground(){
       
        
        
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

}
    

    

