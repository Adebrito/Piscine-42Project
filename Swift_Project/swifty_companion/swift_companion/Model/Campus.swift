//
//  Campus.swift
//  swift_companion
//
//  Created by Sebastien ALIBERT on 4/9/19.
//  Copyright © 2019 Sebastien ALIBERT. All rights reserved.
//

import Foundation

import Foundation
struct Campus_users : Codable {
    let campus_id : Int?
    
    enum CodingKeys: String, CodingKey {
        case campus_id = "campus_id"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        campus_id = try values.decodeIfPresent(Int.self, forKey: .campus_id)
    }
}
