//
//  Skills.swift
//  swift_companion
//
//  Created by Sebastien ALIBERT on 4/9/19.
//  Copyright © 2019 Sebastien ALIBERT. All rights reserved.
//

import Foundation

struct Skills : Codable {
    let name : String?
    let level : Double?
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case level = "level"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        level = try values.decodeIfPresent(Double.self, forKey: .level)
    }
}
