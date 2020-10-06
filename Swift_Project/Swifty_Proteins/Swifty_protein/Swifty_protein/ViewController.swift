//
//  ViewController.swift
//  Swifty_protein
//
//  Created by Adrien DEBRITO on 4/16/19.
//  Copyright © 2019 Adrien DEBRITO. All rights reserved.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController {

       let context: LAContext = LAContext()
    

    @IBOutlet weak var passLabel: UITextField!
    @IBOutlet weak var loginLabel: UITextField!
    @IBOutlet weak var ConnexionButton: UIButton!
    @IBOutlet weak var TouchIdImg: UIImageView!
    
    @IBAction func ConnexionButtonTouch(_ sender: UIButton) {
        if passLabel.text == "root" && loginLabel.text == "root" {
             self.performSegue(withIdentifier: "LogSucc", sender: self)
        }
        else {
            self.Alert(title: "Wrong ID / PASSWORD" , message: "My friend what are you doing ?!🙀")
        }
    }
    
    func Alert(title: String, message: String)
    {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
            let okbutton = UIAlertAction(title: "HELP ME PLEASE DUDE 😱", style: .default, handler: nil)
            alert.addAction(okbutton)
            UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func unWindSegue(segue: UIStoryboardSegue) {
        print(segue.identifier!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         if self.context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) {
            TouchIdImg.isHidden = false
            self.TouchIdImg.isUserInteractionEnabled = true
             self.TouchIdImg.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageTapped)))
            }
         else {
             TouchIdImg.isHidden = true
            }
    }
    
    
    
    @objc private func imageTapped(_ recognizer: UITapGestureRecognizer) {
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) {
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "LogIn" , reply:
                {(success, error) in
                    if success {
                             DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "LogSucc", sender: self)
                        }
                    }
                    else {
                        print(error)
                        if error?.localizedDescription == "Fallback authentication mechanism selected." {
                            self.performSegue(withIdentifier: "LogSucc", sender: self)
                        }
                    }
            }
                
            )}
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

