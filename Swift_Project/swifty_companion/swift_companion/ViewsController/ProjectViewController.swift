//
//  ProjectViewController.swift
//  swift_companion
//
//  Created by Sebastien ALIBERT on 4/9/19.
//  Copyright © 2019 Sebastien ALIBERT. All rights reserved.
//

import UIKit

class ProjectViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    var listProject: [Projects_users] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listProject.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProjectCell") as! ProjectTableViewCell
        cell.project = listProject[indexPath.row]
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        if let user = User.selected {
            listProject = (user.projects_users?.filter({ ($0.project!.parent_id == nil && ($0.cursus_ids![0] == 1 || $0.cursus_ids![0] == 10)) }).sorted(by: { $0.final_mark == nil && $1.final_mark != nil }))!
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
