//
//  DataUser.swift
//  swift_companion
//
//  Created by Sebastien ALIBERT on 4/9/19.
//  Copyright © 2019 Sebastien ALIBERT. All rights reserved.
//

import Foundation
import UIKit

struct User {
    static var selected: DataUser?
    static var background: UIImage?
}

struct DataUser : Codable {
    let id : Int?
    let email : String?
    let phone : String?
    let displayname : String?
    let image_url : String?
    let correction_point : Int?
    let location : String?
    let wallet : Int?
    let cursus_users : [Cursus_users]?
    let projects_users : [Projects_users]?
    let achievements : [Achievements]?
    let campus_users : [Campus_users]?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case email = "email"
        case phone = "phone"
        case displayname = "displayname"
        case image_url = "image_url"
        case correction_point = "correction_point"
        case location = "location"
        case wallet = "wallet"
        case cursus_users = "cursus_users"
        case projects_users = "projects_users"
        case achievements = "achievements"
        case campus_users = "campus_users"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        phone = try values.decodeIfPresent(String.self, forKey: .phone)
        displayname = try values.decodeIfPresent(String.self, forKey: .displayname)
        image_url = try values.decodeIfPresent(String.self, forKey: .image_url)
        correction_point = try values.decodeIfPresent(Int.self, forKey: .correction_point)
        location = try values.decodeIfPresent(String.self, forKey: .location)
        wallet = try values.decodeIfPresent(Int.self, forKey: .wallet)
        cursus_users = try values.decodeIfPresent([Cursus_users].self, forKey: .cursus_users)
        projects_users = try values.decodeIfPresent([Projects_users].self, forKey: .projects_users)
        achievements = try values.decodeIfPresent([Achievements].self, forKey: .achievements)
        campus_users = try values.decodeIfPresent([Campus_users].self, forKey: .campus_users)
    }
}
