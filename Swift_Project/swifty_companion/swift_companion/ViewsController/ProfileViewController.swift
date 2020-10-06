//
//  ProfileViewController.swift
//  swift_companion
//
//  Created by Sebastien ALIBERT on 4/9/19.
//  Copyright © 2019 Sebastien ALIBERT. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var displayNameLabel: UILabel!
    @IBOutlet weak var levelProgressBar: UIProgressView!
    @IBOutlet weak var walletLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var mobileLabel: UILabel!
    @IBOutlet weak var correctionPointLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var dataView: UIView!
    @IBOutlet weak var lvlLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    func setProgressBar(_ user: DataUser?)
    {
        if let lvl = user?.cursus_users?.first?.level {
            lvlLabel.text = String(lvl)
            progressBar.setProgress( Float(lvl.truncatingRemainder(dividingBy: 1)) , animated: true)
            progressBar.transform = CGAffineTransform(scaleX: 1, y: 5)
        } else {
            lvlLabel.text = "Unavailable"
            progressBar.setProgress( 0 , animated: true)
            progressBar.transform = CGAffineTransform(scaleX: 1, y: 5)
        }
    }
    
    func setTextSize() {
        var size = 0
        let width = UIScreen.main.bounds.size.width
        switch width {
        case _ where width < 330:
            size = 10
        case _ where width < 380:
            size = 14
        case _ where width < 420:
            size = 24
        case _ where width < 770:
            size = 25
        default:
            size = 28
        }
        self.displayNameLabel.font = self.displayNameLabel.font.withSize(CGFloat(size))
        self.walletLabel.font = self.walletLabel.font.withSize(CGFloat(size))
        self.emailLabel.font = self.emailLabel.font.withSize(CGFloat(size))
        self.mobileLabel.font = self.mobileLabel.font.withSize(CGFloat(size))
        self.correctionPointLabel.font = self.correctionPointLabel.font.withSize(CGFloat(size))
        self.locationLabel.font = self.locationLabel.font.withSize(CGFloat(size))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let wallet = User.selected?.wallet ?? 0
        let correction_point = User.selected?.correction_point ?? 0
        self.displayNameLabel.text = User.selected?.displayname
        self.walletLabel.text = String(wallet)
        self.emailLabel.text = User.selected?.email ?? ""
        self.mobileLabel.text = User.selected?.phone ?? ""
        self.correctionPointLabel.text = String(correction_point)
        self.locationLabel.text = User.selected?.location ?? "Unavailable"
        setTextSize()
        setProgressBar(User.selected)
        self.dataView.layer.cornerRadius = 50
        APIManager.call.uploadImage(url: User.selected?.image_url) {
            (data, error) in
            if let err = error {
                print(err)
            } else if let image = data {
                DispatchQueue.main.async() {
                    self.profileImageView.image = UIImage(data: image)!
                    self.profileImageView.layer.cornerRadius = self.profileImageView.frame.width / 2
                    self.profileImageView.clipsToBounds = true
                }
            }
        }
        APIManager.call.getCoalition(id: User.selected?.id) {
            (url, error) in
            if let err = error {
                print(err)
            } else if let background = url {
                APIManager.call.uploadImage(url: background) {
                    (data, error) in
                    if let err = error {
                        print(err)
                    } else if let image = data {
                        DispatchQueue.main.async() {
                            self.backgroundView.backgroundColor = UIColor(patternImage:UIImage(data: image)!)
                        }
                    }
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
