//
//  TabBarC.swift
//  avionicus
//
//  Created by Фамил Гаджиев on 25.01.17.
//  Copyright © 2017 Фамил Гаджиев. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    let apiManager = APIManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        self.tabBar.tintColor = UIColor(colorLiteralRed: 240.0 , green: 251.0 , blue: 255.0 , alpha: 100.0)
        self.tabBar.unselectedItemTintColor =  UIColor.lightGray
        self.tabBar.backgroundImage = UIImage(named:"Rectangle 38.png")
    
    }

        

    
    
}
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        //print(item.title!)
    
}
    var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        return [.portrait, .landscapeRight]
    
}

