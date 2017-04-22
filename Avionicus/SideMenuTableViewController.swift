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
    @IBOutlet weak var sex: UIImageView!
    
    
    
    struct StoryboardConstants {
        static let goToLoginSegueIdentifier = "goToLogin"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //name.text = (UserDefaults.standard.value(forKey: "login") as! String)
        
        
        let profileRequest = Avionicus.getProfile.request
        print(profileRequest.url!)
        apiManager.getProfile() { result in
            switch result{
            case .success(let UserProfile):
                DispatchQueue.main.async {
                    print(UserProfile.login!)
                    
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
        
        //apiManager.getProfile(completion: )
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == StoryboardConstants.goToLoginSegueIdentifier {
            if let loginVC = segue.destination as? LoginViewController {
                loginVC.presentedModally = true
            }
        }
        
    }
    
}
