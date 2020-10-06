//
//  KillViewController.swift
//  DeathNote
//
//  Created by Sebastien ALIBERT on 3/26/19.
//  Copyright © 2019 Sebastien ALIBERT. All rights reserved.
//

import UIKit

class KillViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var describeDeathTextField: UITextView!
    @IBOutlet weak var Picker: UIDatePicker!
    let dateFormatter = DateFormatter()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        Picker.minimumDate = Date()
        describeDeathTextField.delegate = self
        nameTextField.delegate = self
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("SEGUE \(String(describing: segue.identifier))")
        if segue.identifier == "DoneSegue" {
            if let vc = segue.destination as? ViewController {
                if var name = nameTextField.text {
                    name = name.trimmingCharacters(in: .whitespacesAndNewlines)
                    if  name != "" {
                        print("Create new Dead \(nameTextField.text!) \(describeDeathTextField.text!)")
                        vc.newDead = Dead(n: name,
                                      dD: describeDeathTextField.text != nil ? describeDeathTextField.text.trimmingCharacters(in: .whitespacesAndNewlines) : "",
                                      date: dateFormatter.string(from: Picker.date))
                        return
                    }
                    vc.newDead = nil
                }
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        textView.resignFirstResponder()
        return true
    }
}
