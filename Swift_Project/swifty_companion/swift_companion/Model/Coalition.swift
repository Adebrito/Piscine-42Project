//
//  Coalition.swift
//  swift_companion
//
//  Created by Sebastien ALIBERT on 4/9/19.
//  Copyright © 2019 Sebastien ALIBERT. All rights reserved.
//

import Foundation

enum BackgroundCoalition : String {
    case TheAlliance = "the-alliance"
    case TheOrder = "the-order"
    case TheAssembly = "the-assembly"
    case TheFederation = "the-federation"
}


struct Coalition : Codable {
    let id : Int?
    let name : String?
    let slug : String?
    let image_url : String?
    let color : String?
    let score : Int?
    let user_id : Int?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case slug = "slug"
        case image_url = "image_url"
        case color = "color"
        case score = "score"
        case user_id = "user_id"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        slug = try values.decodeIfPresent(String.self, forKey: .slug)
        image_url = try values.decodeIfPresent(String.self, forKey: .image_url)
        color = try values.decodeIfPresent(String.self, forKey: .color)
        score = try values.decodeIfPresent(Int.self, forKey: .score)
        user_id = try values.decodeIfPresent(Int.self, forKey: .user_id)
    }
}
