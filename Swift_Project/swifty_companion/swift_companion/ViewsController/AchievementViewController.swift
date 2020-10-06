//
//  AchievementViewController.swift
//  swift_companion
//
//  Created by Sebastien ALIBERT on 4/9/19.
//  Copyright © 2019 Sebastien ALIBERT. All rights reserved.
//

import UIKit

class AchievementViewController: UIViewController,  UITableViewDelegate, UITableViewDataSource {
    
    var listAchievement: [Achievements] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listAchievement.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AchievementCell") as! AchievementTableViewCell
        cell.achievement = listAchievement[indexPath.row]
        return cell
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        if let achievements = User.selected?.achievements {
            listAchievement = achievements
            print(achievements)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
