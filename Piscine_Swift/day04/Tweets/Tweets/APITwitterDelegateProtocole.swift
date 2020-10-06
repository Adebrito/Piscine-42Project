//
//  APITwitterDelegateProtocole.swift
//  Tweets
//
//  Created by Sebastien ALIBERT on 3/28/19.
//  Copyright © 2019 Sebastien ALIBERT. All rights reserved.
//

import Foundation

protocol APITwitterDelegate: NSObjectProtocol {
    func scheduleTweet(tweets: [Tweet])
    func ErrorTweet(error: NSError)
}
