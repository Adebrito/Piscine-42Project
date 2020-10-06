//
//  ViewController.swift
//  ex01
//
//  Created by Sebastien ALIBERT on 3/25/19.
//  Copyright © 2019 Sebastien ALIBERT. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var HelloWorld: UILabel!
    @IBAction func ActionClickMe(_ sender: Any) {
        HelloWorld.text = "Hello World !"
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

