//
//  Cursus.swift
//  swift_companion
//
//  Created by Sebastien ALIBERT on 4/9/19.
//  Copyright © 2019 Sebastien ALIBERT. All rights reserved.
//

import Foundation

struct Cursus_users : Codable {
    let skills : [Skills]?
    let cursus_id : Int?
    let level : Double?
    
    enum CodingKeys: String, CodingKey {
        case skills = "skills"
        case cursus_id = "cursus_id"
        case level = "level"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        skills = try values.decodeIfPresent([Skills].self, forKey: .skills)
        cursus_id = try values.decodeIfPresent(Int.self, forKey: .cursus_id)
        level = try values.decodeIfPresent(Double.self, forKey: .level)
    }
}
