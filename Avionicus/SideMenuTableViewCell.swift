//
//  SideMenuTableViewCell.swift
//  Avionicus
//
//  Created by Фамил Гаджиев on 09.03.17.
//  Copyright © 2017 Фамил Гаджиев. All rights reserved.
//

import UIKit

class SideMenuTableViewCell: UITableViewCell {

    
    @IBOutlet weak var imLabel: UIImageView!
    @IBOutlet weak var lb: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }

}
