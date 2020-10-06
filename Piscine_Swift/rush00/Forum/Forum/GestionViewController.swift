//
//  GestionViewController.swift
//  Forum
//
//  Created by Kai LIN on 3/31/19.
//  Copyright © 2019 Sebastien ALIBERT. All rights reserved.
//

import UIKit

class GestionViewController: UIViewController {
    
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var navTitle: UINavigationItem!
    
    var isAdd = true
    var isTopic = true
    var oldTopic : Topic?
    var oldMessage : TopicMessage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.layer.borderColor = UIColor.blue.cgColor
        textView.layer.borderWidth = 0.5
        
        if !isAdd || !isTopic {
            titleField.isEnabled = false
            titleField.isHidden = false
        }
        if isTopic {
            navTitle.title = "Add topic"
            if !isAdd {
            titleField.text = oldTopic?.name
            textView.text = oldTopic?.message?.content?.markdown
            }
        }
        else {
            navTitle.title = "Add message"
            if !isAdd {
                textView.text = oldMessage?.content
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "doneSegue" {
            print("done")
        }
    }
    
    @IBAction func buttonTap(_ sender: UIBarButtonItem) {
        let title = titleField?.text
        let contentText = textView?.text
        
        if isTopic {
            if !(title?.isEmpty)! && !(contentText?.isEmpty)! {
            
                let message = Messages_attributes(
                    author_id : "\(APIController.credential.user!.id!)",
                    content : contentText
                )
                
                let topic = MutatingTopic(
                    author_id: "\(APIController.credential.user!.id!)",
                    kind: "normal",
                    language_id: "1",
                    messages_attributes: [message],
                    name: title!,
                    tag_ids: ["9"],
                    cursus_ids: ["1"]
                )
                
                if isAdd {
                    print("add topic:  \(topic)")
                    APIController.call.createTopic(topic: topic){
                          DispatchQueue.main.async(execute: {self.performSegue(withIdentifier: "doneSegue", sender: "")})
                        }
                }
                else {
                    print("mod topic:  \(topic)")
                    APIController.call.updateTopic(topic: topic, id: oldTopic!.id!)
                    performSegue(withIdentifier: "doneSegue", sender: "")
                }
            }
        }
        else {
            if !(contentText?.isEmpty)! {
                let message = MutatingMessage(
                    author_id : "\(APIController.credential.user!.id!)",
                    content : contentText,
                    messageable_id : "7",
                    messageable_type: "Topic")
                if isAdd {
                    APIController.call.createMessage(message: message, topicId: oldTopic?.id, messageId: nil){
                        DispatchQueue.main.async(execute: {self.performSegue(withIdentifier: "doneSegue", sender: "")})
                    }
                }
                else {
                    print("id id :: \(oldMessage?.id) \n")
                    APIController.call.updateMessage(message: message, messageId: oldMessage?.id){
                        DispatchQueue.main.async(execute: {self.performSegue(withIdentifier: "doneSegue", sender: "")})
                    }
                }
            }
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
