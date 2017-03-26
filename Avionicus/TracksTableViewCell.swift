//
//  TracksTableViewCell.swift
//  Avionicus
//
//  Created by David Zukhbaia on 26.03.17.
//  Copyright © 2017 Park Team. All rights reserved.
//

import UIKit

class TracksTableViewCell: UITableViewCell {
    
    @IBOutlet weak var activityKindImageView: UIImageView!
    @IBOutlet weak var routeLengthLabel: UILabel!
    @IBOutlet weak var totalTimeLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    
    var item: TrackerItem? {
        didSet {
            configureCell()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        configureCell()
    }
    
    func configureCell() {
        
        guard let item = self.item else {
            return
        }
        
        routeLengthLabel.text = String(format: "%.2f", item.routeLength)
        routeLengthLabel.textColor = UIColor.white
        
        totalTimeLabel.text = item.formattedTime
        totalTimeLabel.textColor = UIColor.white
        
        speedLabel.text = String(format: "%.2f", item.speed)
        speedLabel.textColor = UIColor.white
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
