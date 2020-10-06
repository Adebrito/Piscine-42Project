//
//  MessageViewController.swift
//  Forum
//
//  Created by Kai LIN on 3/30/19.
//  Copyright © 2019 Sebastien ALIBERT. All rights reserved.
//

import UIKit

class MessageViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, ManageMessage {

    @IBOutlet weak var tableView: UITableView!
    var allMessage : [TopicMessage] = []
    var topic : Topic!
    
    @IBAction func buttonTap(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "addMsgSegue", sender: "")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addMsgSegue" {
            if let destitation = segue.destination as? GestionViewController{
                destitation.oldTopic = topic
                destitation.isAdd = true
                destitation.isTopic = false
            }
        }
        
        if segue.identifier == "modMsgSegue" {
            if let destitation = segue.destination as? GestionViewController{
                let data = sender as! TopicMessage
                destitation.oldMessage = data
                destitation.isAdd = false
                destitation.isTopic = false
            }
        }
    }
    
    func renderMessagesByTopic(messages: [TopicMessage]) {
        self.allMessage = messages
        self.tableView.reloadData()
    }
    
    func renderMessageById(message: TopicMessage) {
        print(message)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        APIController.call.ManageMessage = self
        APIController.call.getMessagesByTopic(topicId: topic.id)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allMessage.count
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        if indexPath.row == 0 || self.allMessage[indexPath.row].author?.id != APIController.credential.user?.id {
            return []
        }
        
        let favoriteTitle = NSLocalizedString("Modify", comment: "Modify action")
        let favoriteAction = UITableViewRowAction(style: .normal, title: favoriteTitle) { (action, indexPath) in
            self.performSegue(withIdentifier: "modMsgSegue", sender: self.allMessage[indexPath.row])
        }
        
        let deleteTitle = NSLocalizedString("Delete", comment: "Delete action")
        let deleteAction = UITableViewRowAction(style: .destructive, title: deleteTitle) { (action, indexPath) in
            APIController.call.delete(id: self.allMessage[indexPath.row].id, isTopic: false){
                DispatchQueue.main.async(execute: { APIController.call.getMessagesByTopic(topicId: self.topic.id)})
            }
        }
        
        favoriteAction.backgroundColor = .green
        return [deleteAction, favoriteAction]
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath) as! MessageTableViewCell
        cell.nameLabel.text = allMessage[indexPath.row].author?.login
        cell.contentLabel.text = allMessage[indexPath.row].content
        cell.dateLabel.text = allMessage[indexPath.row].created_at
        
        let dateFormatterGet = DateFormatter()
        let dateFormatterPrint = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        dateFormatterPrint.dateFormat = "dd/MM/yyyy HH:mm"
        
        if let date = allMessage[indexPath.row].created_at?.dropLast(5) {
            if let date = dateFormatterGet.date(from: String(date)) {
                cell.dateLabel.text = dateFormatterPrint.string(from: date)
            }
        }
  
        cell.layer.borderWidth = 0.8
        cell.layer.borderColor = UIColor.blue.cgColor
        cell.layer.cornerRadius = 8.0
        return cell
    }
    
    @IBAction func unWindSegue(segue: UIStoryboardSegue) {
        APIController.call.getMessagesByTopic(topicId: self.topic.id)
    }
}
