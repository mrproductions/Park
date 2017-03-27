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
        
//        apiManager.auth(login: "famil", pass: "7ca2d617fc3aa9ef13e32c48e02db870") { result in
//            
//            switch result {
//            case .success(let userData):
//                print("Hash is \(userData.hash)")
//               // self.performSegue(withIdentifier: AvionicusSegues.goToTab, sender: self)
//            case .failure(let error):
//                print("ERROR! \(error.localizedDescription)")
//            }
//        }
        
        
        


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

