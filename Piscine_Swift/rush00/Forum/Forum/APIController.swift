//
//  APIController.swift
//  Forum
//
//  Created by Kai LIN on 3/30/19.
//  Copyright © 2019 Sebastien ALIBERT. All rights reserved.
//

import Foundation

protocol ManageTopic: NSObjectProtocol {
    func renderAllTopics(topics: [Topic])
    func renderTopicById(topic: Topic)
}

protocol ManageMessage: NSObjectProtocol {
    func renderMessagesByTopic(messages: [TopicMessage])
    func renderMessageById(message: TopicMessage)
}

struct typeCredential {
    let clientId: String
    let secretKey: String
    var user: User?
    var token: String?
    var bearer: String?
    init (cliendtId: String!, secretKey: String!, token: String?, bearer: String?, user: User?) {
        self.clientId = cliendtId
        self.secretKey = secretKey
        self.token = token
        self.bearer = bearer
        self.user = user
    }
}

let HOST = "https://api.intra.42.fr"

typealias Void = ()

class APIController {
    
    weak var ManageTopic: ManageTopic?
    weak var ManageMessage: ManageMessage?
    
    static let call = APIController()
    static var credential = typeCredential(
        cliendtId: "2b871a494d17526e53152d1afd41c34c35f52da29ae42de74bfae41797dab4ce",
        secretKey: "40b3d4093edfe9f9d1e5eb5651bc8dab743d4f66ab1e57519afaf2383a446c8e",
        token: nil,
        bearer: nil,
        user: nil
    )
    
    func dispatchAction(status: Int, completionHandler: @escaping () -> Swift.Void) {
        switch status {
            case 200:
                completionHandler()
            case 401:
                APIController.call.makeToken(){ completionHandler() }
        default:
            print("JE SAIS PAS QUOI FAIRE")
        }
    }
    
    func makeRequest(url: URL, method: String) -> NSMutableURLRequest {
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = method
        request.setValue("Bearer \(APIController.credential.bearer!)", forHTTPHeaderField: "Authorization")
        return request
    }

    func makeToken(completionHandler: @escaping () -> Swift.Void) {
        let request = NSMutableURLRequest(url: NSURL(string: "\(HOST)/oauth/token") as! URL)
        request.httpMethod = "POST"
        request.httpBody = "grant_type=authorization_code&client_id=\(APIController.credential.clientId)&client_secret=\(APIController.credential.secretKey)&code=\(APIController.credential.token!)&redirect_uri=https://42.fr".data(using: String.Encoding.utf8)
        URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            if error != nil {
                print(error!.localizedDescription)
            }
            else if let d = data {
                do {
                    if let dic : NSDictionary = try JSONSerialization.jsonObject(with: d, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                        if let token = dic["access_token"] as? String {
                            APIController.credential.bearer = token
                            completionHandler()
                        }
                    }
                }
                catch (let err) {
                    print(err)
                }
            }
            }.resume()
    }
    
    func getMe() {
        print("\(HOST)/v2/me")
        URLSession.shared.dataTask(with: makeRequest(url: NSURL(string: "\(HOST)/v2/me")! as URL, method: "GET") as URLRequest) {
            data, response, error in
            if error != nil {
                print(error!.localizedDescription)
            } else if let d = data {
                do {
                    APIController.credential.user = try JSONDecoder().decode(User.self, from: d)
                }
                catch (let err) {
                    print(err)
                }
            }
        }.resume()
    }
    
    func getAllTopics() {
        URLSession.shared.dataTask(with: makeRequest(url: NSURL(string: "\(HOST)/v2/topics.json")! as URL, method: "GET") as URLRequest) {
            data, response, error in
            if error != nil {
                print(error!.localizedDescription)
            } else if let d = data {
                do {
                    let topics = try JSONDecoder().decode([Topic].self, from: d)
                    DispatchQueue.main.async(execute: { self.ManageTopic?.renderAllTopics(topics: topics)})
                }
                catch (let err) {
                    print(err)
                }
            }
        }.resume()
    }
   
    func updateTopic(topic: MutatingTopic, id: Int) {
    let request = makeRequest(url: NSURL(string: "\(HOST)/v2/topics/\(id)")! as URL, method: "PUT")
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    do {
         request.httpBody = try JSONEncoder().encode(createBodyTopic(topic: topic ))
        URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            if error != nil {
                print(error!.localizedDescription)
            }
        }.resume()
    } catch (let err) {
        print(err)
    }
}
    
    func createTopic(topic: MutatingTopic, completionHandler: @escaping () -> Swift.Void)  {
        let request = makeRequest(url: NSURL(string: "\(HOST)/v2/topics.json")! as URL, method: "POST")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            request.httpBody = try JSONEncoder().encode(createBodyTopic(topic: topic ))
            URLSession.shared.dataTask(with: request as URLRequest) {
                data, response, error in
                print(response)
                if error != nil {
                    print(error!.localizedDescription)
                }
                completionHandler()
            }.resume()
        }catch (let err) {
            print(err)
          }
    }
    
    func delete(id: Int?, isTopic: Bool, completionHandler: @escaping () -> Swift.Void) {
        guard let id = id else { return }
        URLSession.shared.dataTask(with: makeRequest(url: NSURL(string: isTopic != true ? "\(HOST)/v2/messages/\(id)" : "\(HOST)/v2/topics/\(id).json")! as URL, method: "DELETE") as URLRequest) {
            _, response, error in
            if error != nil {
                print(error!.localizedDescription)
            } else {
                completionHandler()
                //              DispatchQueue.main.async(execute: { self.ManageMessage!.renderMessagesByTopic(messages: messages) })
            }
            
            }.resume()
    }
    
    func getMessagesByTopic(topicId: Int?) {
        guard let topicId = topicId else { return }
        URLSession.shared.dataTask(with: makeRequest(url: NSURL(string: "\(HOST)/v2/topics/\(topicId)/messages")! as URL, method: "GET") as URLRequest) {
            data, response, error in
            if error != nil {
                print(error!.localizedDescription)
            } else if let d = data {
                do {
                    print("data \(String(describing: data))")
                    let messages = try JSONDecoder().decode([TopicMessage].self, from: d)
                    print(messages)
                    DispatchQueue.main.async(execute: { self.ManageMessage?.renderMessagesByTopic(messages: messages) })
                } catch (let err) {
                    print(err)
                }
            }
        }.resume()
    }
    
    func updateMessage(message: MutatingMessage, messageId: Int?, completionHandler: @escaping () -> Swift.Void)  {
        guard let messageId = messageId else {
            return
        }
        let request = makeRequest(url: NSURL(string: "\(HOST)/v2/messages/\(messageId)")! as URL, method: "PUT")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            request.httpBody = try JSONEncoder().encode(message)
            URLSession.shared.dataTask(with: request as URLRequest) {
                data, response, error in
                if error != nil {
                    print(error!.localizedDescription)
                }
                completionHandler()
            }.resume()
        } catch (let err) {
            print("Error Encoding")
        }
    }
    
    func createMessage(message: MutatingMessage, topicId: Int?, messageId: Int?, completionHandler: @escaping () -> Swift.Void) {
        guard let topicId = topicId else { return }
        var url = "\(HOST)/v2/topics/\(topicId)/messages"
        if let messageId = messageId {
            url = "\(HOST)/v2/topics/\(topicId)/messages/\(messageId)/messages"
        }
        let request = makeRequest(url: NSURL(string: url)! as URL, method: "POST")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            request.httpBody = try JSONEncoder().encode(message)
            URLSession.shared.dataTask(with: request as URLRequest) {
                data, response, error in
                if error != nil {
                    print(error!.localizedDescription)
                }
                completionHandler()
            }.resume()
        } catch {
            print("Error Encoding")
        }
    }
}
