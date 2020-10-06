//
//  ProjectTableViewCell.swift
//  swift_companion
//
//  Created by Sebastien ALIBERT on 4/9/19.
//  Copyright © 2019 Sebastien ALIBERT. All rights reserved.
//

import UIKit

class ProjectTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var noteLabel: UILabel!
    
    var project : Projects_users? {
        didSet {
            if let data = project {
                titleLabel.text = data.project?.name
                if let final_mark = data.final_mark {
                    noteLabel.text =  String(describing: final_mark)
                    noteLabel.textColor = project?.validated == true ? UIColor(hue: 0.3194, saturation: 1, brightness: 0.98, alpha: 1.0) : UIColor(hue: 0, saturation: 1, brightness: 1, alpha: 1.0)
                    
                } else {
                    noteLabel.text = data.status
                    noteLabel.textColor = UIColor(hue: 0.5083, saturation: 1, brightness: 1, alpha: 1.0)
                }
            }
        }
    }
}
