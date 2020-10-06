//
//  CustomPinTableViewCell.swift
//  Kanto
//
//  Created by Sebastien ALIBERT on 4/1/19.
//  Copyright © 2019 Sebastien ALIBERT. All rights reserved.
//

import UIKit

class CustomPinTableViewCell: UITableViewCell {

    @IBOutlet weak var lieuLabel: UILabel!
    
    var pin : customPin? {
        didSet {
            guard let pin = pin, let text = pin.title else { return }
            lieuLabel.text! = text
        }
    }
}
