//
//  Achievement.swift
//  swift_companion
//
//  Created by Sebastien ALIBERT on 4/9/19.
//  Copyright © 2019 Sebastien ALIBERT. All rights reserved.
//

import Foundation

struct Achievements : Codable {
    let name : String?
    let description : String?
    let visible : Bool?
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case description = "description"
        case visible = "visible"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        visible = try values.decodeIfPresent(Bool.self, forKey: .visible)
    }
}
