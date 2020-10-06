//
//  TweetTableViewCell.swift
//  Tweets
//
//  Created by Sebastien ALIBERT on 3/29/19.
//  Copyright © 2019 Sebastien ALIBERT. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {
    @IBOutlet weak var myTextLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var tweet : Tweet? {
        didSet {
            if let t = tweet {
                nameLabel?.text = t.name
                myTextLabel?.text = t.text
                dateLabel?.text = t.date
            }
        }
    }
}
