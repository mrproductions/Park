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
        static let goToProfileSegueIdentifier = "goToProfile"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        apiManager.getProfile{ [weak welf = self]  result in
            switch result{
            case .success(let UserProfile):
                welf?.userProfile = UserProfile
                DispatchQueue.main.async {
                    
                    print(UserProfile.login!)
                    welf?.updateUI()
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
        
        let imageView = UIImageView(image:#imageLiteral(resourceName: "Little bit Black"))
        imageView.contentMode = .scaleAspectFill
        imageView.alpha = 50
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
            if profile.sex?.rawValue == "other"{
                userSex.image = UIImage(named: "O")
            }
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let identifier = segue.identifier else {
            return
        }
        
        switch identifier {
        case StoryboardConstants.goToLoginSegueIdentifier:
            if let loginVC = segue.destination as? LoginViewController {
                loginVC.presentedModally = true
            }
        case StoryboardConstants.goToProfileSegueIdentifier:
            if let navVC = segue.destination as? UINavigationController {
                if let profileVC = navVC.topViewController as? ProfileTableViewController {
                    profileVC.userProfile = userProfile
                }
            }
        default:
            break
        }
        
    }
    
}
