//
//  GeoShape.swift
//  CubeMotion
//
//  Created by Sebastien ALIBERT on 4/2/19.
//  Copyright © 2019 Sebastien ALIBERT. All rights reserved.
//

import Foundation
import UIKit

class geoShape: UIView {
    init(xPos: CGFloat, yPos: CGFloat) {
        super.init(frame: CGRect(x: xPos, y: yPos, width: 100.0, height: 100.0))
        self.backgroundColor = UIColor(red: CGFloat(drand48()), green: CGFloat(drand48()), blue: CGFloat(drand48()), alpha: CGFloat(drand48() + 0.5))
        self.layer.cornerRadius = arc4random_uniform(10) > arc4random_uniform(10) ? 50.0 : 0;
        self.clipsToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
