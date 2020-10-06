//
//  ForumViewController.swift
//  Forum
//
//  Created by Sebastien ALIBERT on 3/30/19.
//  Copyright © 2019 Sebastien ALIBERT. All rights reserved.
//

import UIKit

class ForumViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, ManageTopic  {
    
    @IBOutlet weak var tableView: UITableView!
    var allTopic : [Topic] = []
    let dateFormatterGet = DateFormatter()
    let dateFormatterPrint = DateFormatter()
    
    func renderAllTopics(topics: [Topic]) {
        self.allTopic = topics
        self.tableView.reloadData()
    }
    
    func renderTopicById(topic: Topic) {
        print(topic)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        dateFormatterPrint.dateFormat = "dd/MM/yyyy HH:mm"
        APIController.call.ManageTopic = self
        APIController.call.makeToken(){ APIController.call.getAllTopics(); APIController.call.getMe(); }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allTopic.count
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        if self.allTopic[indexPath.row].author?.id != APIController.credential.user?.id {
            return []
        }
        
        let favoriteTitle = NSLocalizedString("Modify", comment: "Modify action")
        let favoriteAction = UITableViewRowAction(style: .normal, title: favoriteTitle) { (action, indexPath) in
            print("modify: \(self.allTopic[indexPath.row])")
            self.performSegue(withIdentifier: "modTopicSegue", sender: self.allTopic[indexPath.row])
        }
        
        let deleteTitle = NSLocalizedString("Delete", comment: "Delete action")
        let deleteAction = UITableViewRowAction(style: .destructive, title: deleteTitle) { (action, indexPath) in
            APIController.call.delete(id: self.allTopic[indexPath.row].id, isTopic: true){
                DispatchQueue.main.async(execute: {APIController.call.getAllTopics()})
            }
        }
       
        favoriteAction.backgroundColor = .green
        return [deleteAction, favoriteAction]
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "topicCell", for: indexPath) as! TopicTableViewCell
        cell.nameLabel.text = allTopic[indexPath.row].author?.login
        cell.contentLabel.text = allTopic[indexPath.row].name
        cell.dateLabel.text = allTopic[indexPath.row].created_at
        
        if let date = allTopic[indexPath.row].created_at?.dropLast(5) {
            if let date = dateFormatterGet.date(from: String(date)) {
                cell.dateLabel.text = dateFormatterPrint.string(from: date)
            }
        }
        cell.layer.borderWidth = 0.8
        cell.layer.borderColor = UIColor.blue.cgColor
        cell.layer.cornerRadius = 8.0
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "messageSegue" {
            if let destitation = segue.destination as? MessageViewController{
                let data = sender as! Topic
                destitation.topic = data
            }
        }
        if segue.identifier == "modTopicSegue" {
            if let destitation = segue.destination as? GestionViewController{
                let data = sender as! Topic
                destitation.oldTopic = data
                destitation.isAdd = false
                destitation.isTopic = true
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "messageSegue", sender: self.allTopic[indexPath.row])
    }
    
    @IBAction func unWindSegue(segue: UIStoryboardSegue) {
        print("reloadTopic")
        APIController.call.getAllTopics()
    }
    
}
