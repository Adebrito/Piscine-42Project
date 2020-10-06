//
//  APIController.swift
//  Tweets
//
//  Created by Sebastien ALIBERT on 3/28/19.
//  Copyright © 2019 Sebastien ALIBERT. All rights reserved.
//

import Foundation
import UIKit

extension Data {
    var string: String { return String(data: self, encoding: .utf8) ?? "" }
}

enum UrlTwitter : String {
    case AUTH = "https://api.twitter.com/oauth2/token"
    case SEARCH = "https://api.twitter.com/1.1/search/tweets.json"
}

enum httpMethod : String {
    case POST, GET, DELETE, PATH
}

class APIController {
    weak var delegate: APITwitterDelegate?
    let token: String
    let decoder = JSONDecoder()
    let dateFormatterGet = DateFormatter()
    let dateFormatterPrint = DateFormatter()
    
    init(delegate: APITwitterDelegate?, token: String) {
        self.delegate = delegate
        self.token = token
        dateFormatterPrint.dateFormat = "dd-MM-yyyy HH:mm"
        dateFormatterGet.dateFormat = "E MMM dd HH:mm:ss Z yyyy"
    }
    
    func Alert(_ url: String!) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: "Not found", message:
                "subject: \(url!) is not found", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: .default))
            UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
        }
    }
    
    func Alert(_ error: NSError) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: "Error", message:
                "sorry ", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: .default))
            self.delegate?.ErrorTweet(error: error)
            UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
        }
    }
    
    func getLastHundredTweetBySubject(subject: String) {
        let subjectEncoded = subject.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        var request = URLRequest(url: URL(string: "\(UrlTwitter.SEARCH.rawValue)?q=\(subjectEncoded!)&count=100&result_type=recent&tweet_mode=extended&lang=fr")! as URL)
        request.httpMethod = httpMethod.GET.rawValue
        request.setValue("Bearer \(self.token)", forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: request as URLRequest) {
            (data, res, error) in
            if let err = error {
                DispatchQueue.main.async(execute: {
                    self.delegate!.ErrorTweet(error: err as NSError)
                })
            } else if let data = data {
                do {

                    if let dic = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                        if let statuses: [NSDictionary] = dic["statuses"] as? [NSDictionary] {
                            var tweets: [Tweet] = []
                            for status in statuses {
                                guard let name = (status["user"] as? NSDictionary)?["name"] as? String,
                                let date = (status["user"] as? NSDictionary)?["created_at"] as? String,
                                let text = status["full_text"] as? String
                                else { continue }
                                tweets.append(Tweet(name: name,
                                                    text: text,
                                                    date: self.dateFormatterPrint.string(from: self.dateFormatterGet.date(from: date)!)
                                    )
                                )
                            }
                            if tweets.count == 0 {
                                self.Alert(subject)
                            }
                            self.delegate?.scheduleTweet(tweets: tweets)
                        } else {
                            self.Alert(subject)
                        }
                    }
                } catch (let err) {
                    print("mdr \(err)")
                }
            }
            }.resume()
        
    
    }
    
}
