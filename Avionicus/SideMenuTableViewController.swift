//
//  SideMenuTableViewController.swift
//  Avionicus
//
//  Created by Фамил Гаджиев on 09.03.17.
//  Copyright © 2017 Фамил Гаджиев. All rights reserved.
//

import UIKit
import SDWebImage
import SideMenu

class SideMenuTableViewController: UITableViewController {

    @IBOutlet weak var age: UILabel!
    @IBOutlet weak var weight: UILabel!
    @IBOutlet weak var size: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var avatarIm: UIImageView!
    
    var menuNameArray: Array = [String]()
    var menuImageArray: Array = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        ///вопросы по поводу реалма, нужен ли он?
        ///как реализовать офлайн подкачку данных в приложение 
        //как ошибки в коде?
        
        age.text = (UserDefaults.standard.value(forKey: "id") as! String)
        name.text = (UserDefaults.standard.value(forKey: "login") as! String)
        
        avatarIm.layer.borderColor = UIColor.white.cgColor
        avatarIm.layer.borderWidth = 0.5
        avatarIm.layer.cornerRadius = 65.0
        avatarIm.layer.masksToBounds = true
        avatarIm.clipsToBounds = true
        
        
        
        let profileRequest = Avionicus.getProfile.request
        print(profileRequest.url!)
        apiManager.getProfile() { result in
            switch result{
            case .success(let userProfile):
                break
                
            case .failure(let error):
                
                print("error \(error)")
                
            }
            
        }
        
    }


    func download()  {
        
        //apiManager.getProfile(completion: )
        
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
