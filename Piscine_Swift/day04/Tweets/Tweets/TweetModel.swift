//
//  TweetModel.swift
//  Tweets
//
//  Created by Sebastien ALIBERT on 3/28/19.
//  Copyright © 2019 Sebastien ALIBERT. All rights reserved.
//

import Foundation

struct Tweet : Codable, CustomStringConvertible {
    let name : String
    let text : String
    let date : String
    var description: String { return "name: \(name)\ntext: \(text)\ndate: \(date)\n" }
    
    enum CodingKeys: String, CodingKey{
        case name, date, text = "full_text"
    }
    
    init(name: String? = nil, text: String? = nil, date: String? = nil) {
        self.name = name ?? ""
        self.text = text ?? ""
        self.date = date ?? ""
    }
}
