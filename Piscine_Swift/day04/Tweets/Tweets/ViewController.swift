//
//  ViewController.swift
//  Tweets
//
//  Created by Sebastien ALIBERT on 3/28/19.
//  Copyright © 2019 Sebastien ALIBERT. All rights reserved.
//

import UIKit

let UrlAuthTwitter = "https://api.twitter.com/oauth2/token"
let KEY = "E2opCU9TSd9HurVeLYVF8wIBV"
let SECRET = "2iB5RUG9QeBFdv2DK0F54xC37ymuzxC59OTdvWv18T3TVkFAx4"
let BEARED = ("\(KEY):\(SECRET)").data(using: String.Encoding.utf8)!.base64EncodedString(options: [])

class ViewController: UIViewController, APITwitterDelegate, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var controller : APIController!
    var listTweet : [Tweet] = []

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listTweet.count
    }
        
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if let text = inputTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) {
            if text != "" {
                self.controller.getLastHundredTweetBySubject(subject: text)
            }
        }
        return true
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell") as? TweetTableViewCell {
            cell.tweet = listTweet[indexPath.row]
            cell.layer.cornerRadius = 20
            cell.layer.borderWidth = 5
            cell.layer.borderColor = UIColor.white.cgColor
            return cell
        }
        return UITableViewCell()
    }

    func scheduleTweet(tweets : [Tweet]) {
        DispatchQueue.main.async {
            self.listTweet = tweets
            self.tableView.reloadData()
        }
    }

    
    func ErrorTweet(error: NSError) {
        print(error)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        let request = NSMutableURLRequest(url: NSURL(string: UrlTwitter.AUTH.rawValue)! as URL)
        request.httpMethod = httpMethod.POST.rawValue
        request.setValue("Basic \(BEARED)", forHTTPHeaderField: "Authorization")
        request.setValue("application/x-www-form-urlencoded;charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = "grant_type=client_credentials".data(using: String.Encoding.utf8)
        URLSession.shared.dataTask(with: request as URLRequest) {
            (data, res, error) in
            if let err = error {
                print(err)
            } else if let d = data {
                do {
                    if let json = try JSONSerialization.jsonObject(with: d, options: .mutableContainers) as? [String: Any] {
                        let token = json["access_token"] as? String ?? ""
                        self.controller = APIController(delegate: self, token: token)
                        self.controller.getLastHundredTweetBySubject(subject: "ecole42")
                    }
                } catch (let err) {
                    print(err)
                }
            }
        }.resume()

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

