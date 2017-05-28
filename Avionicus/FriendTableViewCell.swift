//
//  FriendTableViewCell.swift
//  Avionicus
//
//  Created by Фамил Гаджиев on 01.05.17.
//  Copyright © 2017 Park Team. All rights reserved.
//

import UIKit
import SDWebImage

class FriendTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var avatarFriend: UIImageView!
    @IBOutlet weak var statusFriend: UIImageView!
    @IBOutlet weak var loginFriend: UILabel!
    //@IBOutlet weak var sportClubFriend: UILabel!
    
    var f: UserFriend?{
        didSet{
            configureCell()
        }
    }
    

    
    override func awakeFromNib() {
        super.awakeFromNib()
        //configureCell()
    }

    
    func configureCell () {
        
        avatarFriend.layer.borderColor = UIColor.white.cgColor
        avatarFriend.layer.borderWidth = 0
        avatarFriend.layer.cornerRadius = 17.5
        avatarFriend.layer.masksToBounds = true
        avatarFriend.clipsToBounds = true
        
        
        avatarFriend.sd_setImage(with: URL(string: (f?.avatarUrl) ?? ""))
        loginFriend.text = f?.login
        
        let status = f?.statusFriend
        if status == "friend"{
            statusFriend.image = UIImage(named: "On")
        }else{
            statusFriend.image = UIImage(named: "Of")
        }
        
        
    }

    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
