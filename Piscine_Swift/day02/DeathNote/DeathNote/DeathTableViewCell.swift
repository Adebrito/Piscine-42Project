//
//  DeathTableViewCell.swift
//  DeathNote
//
//  Created by Sebastien ALIBERT on 3/27/19.
//  Copyright © 2019 Sebastien ALIBERT. All rights reserved.
//

import UIKit

class DeathTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var describeDeathLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var dead : Dead? {
        didSet {
            if let d = dead {
                nameLabel?.text = d.name
                describeDeathLabel?.text = d.describeDeath
                dateLabel?.text = d.date
            }
        }
    }

    
}
