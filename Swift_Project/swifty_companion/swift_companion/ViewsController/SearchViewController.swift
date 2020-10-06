//
//  SearchViewController.swift
//  swift_companion
//
//  Created by Sebastien ALIBERT on 4/9/19.
//  Copyright © 2019 Sebastien ALIBERT. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, ManageUsers {
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var button: UIButton!
    
    func Alert(title: String, message: String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        let okbutton = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okbutton)
        UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
    var requestIsPending: Bool = false
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "getUser" {
            if let user = sender as? DataUser {
                User.selected = user
            }
        }
    }
    
    @IBAction func searchUser(_ sender: Any) {
        let search = searchTextField.text!.replacingOccurrences(of: " ", with: "")
        searchTextField.text! = search
        if (requestIsPending != true) && (search.isEmpty != true) {
            requestIsPending = true
            APIManager.call.searchUser(search: search)
        } else {
            searchTextField.text! = ""
        }
    }
    
    func renderUserProfile(user: DataUser?) {
        requestIsPending = false
        if user != nil {
            performSegue(withIdentifier: "getUser", sender: user)
        } else {
            DispatchQueue.main.async() { self.Alert(title: "NOT FOUND", message: self.searchTextField.text!) }
        }
        DispatchQueue.main.async() { self.searchTextField.text = "" }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        APIManager.call.ManageUsers = self
        self.button.layer.cornerRadius = 0.25
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
