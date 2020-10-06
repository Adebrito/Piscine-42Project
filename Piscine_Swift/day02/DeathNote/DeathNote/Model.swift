//
//  Model.swift
//  DeathNote
//
//  Created by Sebastien ALIBERT on 3/26/19.
//  Copyright © 2019 Sebastien ALIBERT. All rights reserved.
//

import Foundation

struct Dead {
    var name : String!
    var describeDeath: String!
    var date: String!
    
    init(n: String!, dD: String!, date: String!) {
        self.name = n
        self.describeDeath = dD
        self.date = date
    }
}
