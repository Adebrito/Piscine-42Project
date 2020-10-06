//
//  ViewController.swift
//  DeathNote
//
//  Created by Sebastien ALIBERT on 3/26/19.
//  Copyright © 2019 Sebastien ALIBERT. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var listDeath : [Dead] = [
        Dead(n: "Bibi", dD: "mort manger par une fougere", date: "28-03-0001 10:44"),
        Dead(n: "Bobo", dD: "mort apres avoir manger la fougere qui a tue son frere Bibi", date: "28-03-0002 10:44"),
        Dead(n: "Bubu", dD: "mort on sais pas pourquoi, il etait pas tres malin ce c**", date: "28-03-0003 10:44")
    ]
    var newDead : Dead?
    
    @IBAction func unWindSegueToOne(segue: UIStoryboardSegue) {
        print("\(String(describing: segue.identifier))")
        if segue.identifier == "DoneSegue" {
            if let dead = newDead {
                listDeath.append(dead)
                newDead = nil
                self.tableView.reloadData()
                print("\(String(describing: listDeath))")
            }
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listDeath.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "deathCell") as? DeathTableViewCell {
            cell.dead = listDeath[indexPath.row]
            return cell
        }
        return UITableViewCell()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

