//
//  ViewController.swift
//  Siri
//
//  Created by Sebastien ALIBERT on 4/4/19.
//  Copyright © 2019 Sebastien ALIBERT. All rights reserved.
//

import UIKit
import ForecastIO
import RecastAI

class ViewController: UIViewController {

    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var summeryLabel: UILabel!
    @IBOutlet weak var contentRequestTextField: UITextField!
    
    let client = DarkSkyClient(apiKey: "a53db748ed3404e26ff3b45fdab1cdbe")
    let bot = RecastAIClient(token : "27d275b1dae047fde5a17585de3938e2", language: "en")
    
    @IBAction func sendRequest(_ sender: Any) {
        DispatchQueue.main.async {
            if (!(self.contentRequestTextField.text?.isEmpty)!) {
                self.makeRequest()
            }
            self.contentRequestTextField.text = ""
        }
    }
    
    func makeRequest() {
        self.bot.textRequest(contentRequestTextField.text!, successHandler: recastRequestDone, failureHandle: recastRequestError)
    }
    
    func recastRequestError(_ error : Error) {
        DispatchQueue.main.async {
            print(error)
            self.weatherLabel.text = "sorry error"
            self.summeryLabel.text = "\(String(describing: error))"
        }
    }
    
    func recastRequestDone(_ response : Response) {
        print(response)
        if let location = response.get(entity: "location") {
            guard let lat = location["lat"] as? Double, let lng = location["lng"] as? Double else { return }
            client.getForecast(latitude: lat, longitude: lng) {
                result in
                DispatchQueue.main.async() {
                    switch result {
                    case .success(let currentForecast, _):
                        print(currentForecast)
                        if let currently = currentForecast.currently {
                            guard let temperature = currently.temperature , let summary = currently.summary else { return }
                            self.weatherLabel.text = "\(temperature) C"
                            self.summeryLabel.text = "\(summary)"
                        }
                    case .failure(let error):
                        print(error)
                        self.weatherLabel.text = "sorry error"
                        self.summeryLabel.text = "\(String(describing: error))"
                    }
                }
            }
        } else {
            self.weatherLabel.text = "NOT FOUND"
            self.summeryLabel.text = "SORRY"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        client.language = .english
        client.units = .si
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

