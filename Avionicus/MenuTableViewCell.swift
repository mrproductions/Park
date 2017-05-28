//
//  MenuTableViewCell.swift
//  avionicus
//
//  Created by Фамил Гаджиев on 25.01.17.
//  Copyright © 2017 Park Team. All rights reserved.
//

import UIKit

class MenuTableViewCell: UITableViewCell {
    
    @IBOutlet weak var iconMenu: UIImageView!
    @IBOutlet weak var labelMenu: UILabel!
    
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
