//
//  SideMenuTableViewController.swift
//  Avionicus
//
//  Created by Фамил Гаджиев on 09.03.17.
//  Copyright © 2017 Park Team. All rights reserved.
//

import UIKit
import SDWebImage
import SideMenu

class SideMenuTableViewController: UITableViewController {

    @IBOutlet weak var age: UILabel!
    @IBOutlet weak var weight: UILabel!
    @IBOutlet weak var size: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userAvatarImage: UIImageView!
    @IBOutlet weak var userSex: UIImageView!
    
    var userProfile: UserProfile?
    
    
    struct StoryboardConstants {
        static let goToLoginSegueIdentifier = "goToLogin"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //name.text = (UserDefaults.standard.value(forKey: "login") as! String)
        
        
        let profileRequest = Avionicus.getProfile.request
        print(profileRequest.url!)
        apiManager.getProfile{ [weak welf = self]  result in
            switch result{
            case .success(let UserProfile):
                if UserProfile != nil{
                    welf?.userProfile = UserProfile
                    DispatchQueue.main.async {
                        
                        print(UserProfile.login!)
                        welf?.updateUI()
                    
                    }
                }
                
            case .failure(let error):
                
                print("error \(error)")
            }
        }
        
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



    @IBAction func Out(_ sender: Any) {
        if keyChain.get("token") != nil{
            keyChain.delete("token")
            performSegue(withIdentifier: StoryboardConstants.goToLoginSegueIdentifier, sender: nil)
        }
        
    }
    
    
    func updateUI()  {
    
        if  let profile = userProfile {
            
            userAvatarImage.sd_setImage(with: URL(string:profile.avatar_url!))
            userName.text = profile.name
            size.text = String(describing: profile.height!)
            weight.text = String(describing: profile.weight!)
            
            if let birthDay = profile.birthday {
                let calendar = NSCalendar.current
                let ages = calendar.dateComponents([.year], from: birthDay, to: Date())
                age.text = "\(String(describing: ages.year!))"
                
            }

            if profile.sex?.rawValue == "man" {
                userSex.image = UIImage(named: "male")
            }
            if profile.sex?.rawValue == "woman" {
                userSex.image = UIImage(named: "female")

            }
//            if profile.sex?.rawValue = "male"  {
//                    let image: UIImage = UIImage(named: "male")!
//                    userSex = UIImageView(image: image)
//    
//            }else{
//                let image: UIImage = UIImage(named: "male")!
//                userSex = UIImageView(image: image)
//            }
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == StoryboardConstants.goToLoginSegueIdentifier {
            if let loginVC = segue.destination as? LoginViewController {
                loginVC.presentedModally = true
            }
        }
        
    }
    
}
