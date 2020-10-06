//
//  AchievementTableViewCell.swift
//  swift_companion
//
//  Created by Sebastien ALIBERT on 4/9/19.
//  Copyright © 2019 Sebastien ALIBERT. All rights reserved.
//

import UIKit

class AchievementTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titreLabel: UILabel!
    @IBOutlet weak var describeLabel: UILabel!
    
    var achievement : Achievements? {
        didSet {
            if achievement != nil {
                titreLabel.text = achievement?.name!
                describeLabel.text = achievement?.description!
            }
        }
    }
}
