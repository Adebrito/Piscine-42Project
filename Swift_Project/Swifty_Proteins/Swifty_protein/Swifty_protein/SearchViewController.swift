//
//  SearchViewController.swift
//  Swifty_protein
//
//  Created by Adrien DEBRITO on 4/16/19.
//  Copyright © 2019 Adrien DEBRITO. All rights reserved.
//

import UIKit

class SearchViewController:UIViewController, UISearchBarDelegate , UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var listLigand: [String] = []
    var filtered: [String] = []
    var isPending = false
    var showAlert : Bool?
    
    
    @IBAction func unWindSegue(segue: UIStoryboardSegue) {
        print(segue.identifier!)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filtered.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ligandCell") as? LiganCell {
            cell.LigandLabel.text = self.filtered[indexPath.row]
            return cell
        }
        return UITableViewCell()
    }
    
    @IBAction func logout(_ sender: UIBarButtonItem) {
         self.performSegue(withIdentifier: "logout", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "selectLigand" {
            self.isPending = false
            if let destitation = segue.destination as? SceneController{
                let sender = sender as! (name: String, data: [String])
                destitation.contentPDB = sender.data
                destitation.name = sender.name
            }
        }
    }
    
    func countOccurence(_ target: String, _ searchText: String) -> Int {
        var count = 0
        if (target.count < searchText.count) { return 0 }
        for char in searchText.uppercased() {
            count = count + target.reduce(0, { $0 + ($1 == char ? 1 : 0) })
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (self.isPending == false) {
            self.isPending = true
            let name = self.filtered[indexPath.row]
            if let nurl = NSURL(string: "https://files.rcsb.org/ligands/download/\(name)_model.pdb") {
                  DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = true
                }
                let request = NSMutableURLRequest(url: nurl as URL)
                request.httpMethod = "GET"
                URLSession.shared.dataTask(with: request as URLRequest) {
                    data, response, error in
                    if error != nil {
                        print(error!.localizedDescription)
                        self.isPending = false
                    } else if let d = data {
                        if String(decoding: d, as: UTF8.self).contains("404") {
                            self.isPending = false
                            self.showAlert = true
                            DispatchQueue.main.async {
                                self.viewDidAppear(true)
                            }
                        }
                        else {
                        DispatchQueue.main.async {
                            self.performSegue(withIdentifier: "selectLigand", sender: (name: name, data: String(decoding: d, as: UTF8.self).components(separatedBy: "\n")))
                            }
                        }
                    }
                      DispatchQueue.main.async {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    }
                }.resume()
            }
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            self.filtered = self.listLigand
        }
        else {
            self.filtered = self.listLigand.filter( { ligand in ligand.contains(searchText.uppercased())})
        }
        self.tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let totalCharacters = (searchBar.text?.appending(text).count ?? 0) - range.length
        return totalCharacters <= 3
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        if let filepath = Bundle.main.path(forResource: "ligands", ofType: "txt") {
            do {
                let contents = try String(contentsOfFile: filepath).components(separatedBy: "\n").filter({ !$0.isEmpty })
                self.listLigand = contents
                self.filtered = self.listLigand
            } catch {
                print("POURQUOI !")
            }
        } else {
            print("NO")   }
        
        self.showAlert = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if self.showAlert == true {
            self.showAlert = false
            let alertController = UIAlertController(title: "Error 👨🏻‍🔬", message: "We can't find this Ligand actually! 🙀", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK 😭", style: .cancel, handler: nil))
            present(alertController, animated: true, completion: nil)
           
        }
    }
    
}

