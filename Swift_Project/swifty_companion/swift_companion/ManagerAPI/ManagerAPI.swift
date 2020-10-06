//
//  ManagerAPI.swift
//  swift_companion
//
//  Created by Sebastien ALIBERT on 4/9/19.
//  Copyright © 2019 Sebastien ALIBERT. All rights reserved.
//

import Foundation

protocol ManageUsers: NSObjectProtocol {
    func renderUserProfile(user: DataUser?)
}

struct typeCredential {
    let clientId: String
    let secretKey: String
    var token: String?
    var bearer: String?
    init (cliendtId: String!, secretKey: String!, token: String?, bearer: String?) {
        self.clientId = cliendtId
        self.secretKey = secretKey
        self.token = token
        self.bearer = bearer
    }
}

let HOST = "https://api.intra.42.fr"

typealias Void = ()

class APIManager {
    
    weak var ManageUsers : ManageUsers?
    static var countTry : Int = 0
    static let call = APIManager()
    static var credential = typeCredential(
        cliendtId: "e2afd6e6a4e00d4f381e8539f240ec043a21a623255f84e4ed55aa176d731640",
        secretKey: "d2e713ee47cf42d3a46b9d1f47910b3f74d1e745c6ad00d43fcb89f2044cf0eb",
        token: nil,
        bearer: nil
    )
    
    func isPrintableUser(dataUser: DataUser) -> Bool {
        guard (dataUser.id != nil), (dataUser.displayname != nil),
            (dataUser.image_url != nil) else { return false }
        if dataUser.campus_users?.first?.campus_id! != 1 {
            return false
        }
        return true
    }
    
    func dispatchAction(status: Int, completionHandler: @escaping () -> Swift.Void) {
        switch status {
        case 200:
            completionHandler()
        case 401:
            APIManager.call.makeToken(){ completionHandler() }
        default:
            print("JE SAIS PAS QUOI FAIRE")
        }
    }
    
    func makeRequest(url: URL, method: String) -> NSMutableURLRequest {
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = method
        request.setValue("Bearer \(APIManager.credential.bearer!)", forHTTPHeaderField: "Authorization")
        return request
    }
    
    func makeToken(completionHandler: @escaping () -> Swift.Void) {
        let request = NSMutableURLRequest(url: NSURL(string: "\(HOST)/oauth/token")! as URL)
        request.httpMethod = "POST"
        request.httpBody = "grant_type=authorization_code&client_id=\(APIManager.credential.clientId)&client_secret=\(APIManager.credential.secretKey)&code=\(APIManager.credential.token!)&redirect_uri=https://42.fr".data(using: String.Encoding.utf8)
        URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            if error != nil {
                print(error!.localizedDescription)
            }
            else if let d = data {
                do {
                    if let dic : NSDictionary = try JSONSerialization.jsonObject(with: d, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                        if let token = dic["access_token"] as? String {
                            APIManager.credential.bearer = token
                            print("token", token)
                            completionHandler()
                        }
                    }
                }
                catch (let err) { print(err) }
            }
        }.resume()
    }
    
    func searchUser(search: String!) {
        let trimSearch = search.trimmingCharacters(in: .whitespacesAndNewlines)
        if let nurl = NSURL(string: "\(HOST)/v2/users/\(trimSearch.lowercased())") as URL? {
            let request = makeRequest(url: nurl, method: "GET")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            URLSession.shared.dataTask(with: request as URLRequest) {
                data, response, error in
                if error != nil {
                    if ((response as! HTTPURLResponse).statusCode == 401 && APIManager.countTry < 5) {
                        APIManager.countTry = APIManager.countTry + 1
                        APIManager.call.makeToken {
                            APIManager.call.searchUser(search: search)
                        }
                        return
                    }
                    print(error!.localizedDescription)
                } else if let d = data {
                    do {
                        APIManager.countTry = 0
                        let dataUser = try JSONDecoder().decode(DataUser.self, from: d)
                        if self.isPrintableUser(dataUser: dataUser) == true {
                            DispatchQueue.main.async(){ self.ManageUsers?.renderUserProfile(user: dataUser) }
                            return
                        }
                    } catch (let err) { print(err) }
                }
                self.ManageUsers?.renderUserProfile(user: nil)
            }.resume()
        } else {
            self.ManageUsers?.renderUserProfile(user: nil)
        }
       
    }
    
    func uploadImage(url: String!, handler: @escaping (_ data: Data?, _ error: String?) -> Swift.Void) {
        if let nsurl = NSURL(string: url!) {
            DispatchQueue.global(qos: .userInitiated).async {
                if let data = NSData(contentsOf: nsurl as URL) {
                    handler(data as Data, nil)
                } else {
                    handler(nil, "error 1")
                }
            }
        } else {
            handler(nil, "error 2")
        }
    }
    
    func getCoalition(id: Int?, handler: @escaping (_ url: String?,_ error: String?) -> Swift.Void) {
        URLSession.shared.dataTask(with: makeRequest(url: NSURL(string: "\(HOST)/v2/users/\(String(id!))/coalitions")! as URL, method: "GET") as URLRequest) {
            data, response, error in
            if error != nil {
                handler(nil, String(describing: error))
            } else if let d = data {
                do {
                    let dataCoalition = try JSONDecoder().decode([Coalition].self, from: d)
                    if let coalition = dataCoalition.last?.slug {
                        var url : String = ""
                        switch coalition {
                        case BackgroundCoalition.TheOrder.rawValue :
                            url = "https://cdn.intra.42.fr/coalition/cover/4/order_background.jpg"
                        case BackgroundCoalition.TheAlliance.rawValue:
                            url = "https://cdn.intra.42.fr/coalition/cover/2/alliance_background.jpg"
                        case BackgroundCoalition.TheAssembly.rawValue:
                            url = "https://cdn.intra.42.fr/coalition/cover/3/assembly_background.jpg"
                        case BackgroundCoalition.TheFederation.rawValue:
                            url = "https://cdn.intra.42.fr/coalition/cover/1/federation_background.jpg"
                        default:
                            url = "https://profile.intra.42.fr/assets/background_login-a4e0666f73c02f025f590b474b394fd86e1cae20e95261a6e4862c2d0faa1b04.jpg"
                        }
                        handler(url, nil)
                    } else { handler(nil, "coaltion slug not found") }
                } catch (let err) {
                    handler(nil, String(describing: err))
                }
            }
        }.resume()
    }
    
}
