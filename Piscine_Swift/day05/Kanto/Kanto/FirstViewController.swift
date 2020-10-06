//
//  FirstViewController.swift
//  Kanto
//
//  Created by Sebastien ALIBERT on 4/1/19.
//  Copyright © 2019 Sebastien ALIBERT. All rights reserved.
//

import UIKit
import MapKit

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Data.locationList.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToPin", sender: Data.locationList[indexPath.row])
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToPin" {
            if let vc = segue.destination as? SecondViewController {
                if let sender = sender as? customPin {
                    vc.currentPin = sender
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "locationListCell", for: indexPath) as! CustomPinTableViewCell
        cell.pin = Data.locationList[indexPath.row]
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

