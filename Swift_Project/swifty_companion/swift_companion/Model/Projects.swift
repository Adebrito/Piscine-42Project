//
//  Projects.swift
//  swift_companion
//
//  Created by Sebastien ALIBERT on 4/9/19.
//  Copyright © 2019 Sebastien ALIBERT. All rights reserved.
//

import Foundation

struct Project : Codable {
    let name : String?
    let parent_id : Int?
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case parent_id = "parent_id"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        parent_id = try values.decodeIfPresent(Int.self, forKey: .parent_id)
    }
}

struct Projects_users : Codable {
    let final_mark : Int?
    let status : String?
    let validated : Bool?
    let project : Project?
    let cursus_ids : [Int]?
    let marked_at : String?
    
    enum CodingKeys: String, CodingKey {
        case final_mark = "final_mark"
        case status = "status"
        case validated = "validated?"
        case project = "project"
        case cursus_ids = "cursus_ids"
        case marked_at = "marked_at"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        final_mark = try values.decodeIfPresent(Int.self, forKey: .final_mark)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        validated = try values.decodeIfPresent(Bool.self, forKey: .validated)
        project = try values.decodeIfPresent(Project.self, forKey: .project)
        cursus_ids = try values.decodeIfPresent([Int].self, forKey: .cursus_ids)
        marked_at = try values.decodeIfPresent(String.self, forKey: .marked_at)
    }
}
