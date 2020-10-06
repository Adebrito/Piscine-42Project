//
//  SkillTableViewCell.swift
//  swift_companion
//
//  Created by Sebastien ALIBERT on 4/10/19.
//  Copyright © 2019 Sebastien ALIBERT. All rights reserved.
//

import UIKit

class SkillTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var NoteLabel: UILabel!

    var skills : Skills? {
        didSet {
            if skills != nil {
                guard let level = skills?.level else { return }
                titleLabel.text = skills?.name!
                NoteLabel.text = String(describing: level)
            }
        }
    }
}
