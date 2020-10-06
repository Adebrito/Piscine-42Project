//
//  ViewController.swift
//  swift_companion
//
//  Created by Sebastien ALIBERT on 4/9/19.
//  Copyright © 2019 Sebastien ALIBERT. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKUIDelegate, WKNavigationDelegate {
    
    @IBOutlet weak var webView: WKWebView!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "successLogin" {
            if let sender = sender as? String {
                APIManager.credential.token = sender
                APIManager.call.makeToken(){}
                HTTPCookieStorage.shared.removeCookies(since: Date.distantPast)
                WKWebsiteDataStore.default().fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes()) {
                    records in
                    records.forEach { record in WKWebsiteDataStore.default().removeData(ofTypes: record.dataTypes, for: [record], completionHandler: {}) }
                }
            }
        }
    }
    
    @IBAction func unWindSegue(segue: UIStoryboardSegue) {
        if segue.identifier == "logOut" {
            APIManager.credential.bearer = nil
            APIManager.credential.token = nil
            setWebView()
        }
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        var action: WKNavigationActionPolicy?
        defer {
            decisionHandler(action ?? .allow)
        }
        guard let url = navigationAction.request.url else { return }
        
        if url.host == "42.fr" {
            print(url.absoluteString)
            if url.absoluteString.range(of: "code") != nil {
                let urlParts = url.absoluteString.components(separatedBy: "?")
                performSegue(withIdentifier: "successLogin", sender: urlParts[1].components(separatedBy: "=")[1])
            }
        }
    }
    func setWebView() {
        let url = URL(string: "https://api.intra.42.fr/oauth/authorize?client_id=\(APIManager.credential.clientId)&redirect_uri=https%3A%2F%2F42.fr&response_type=code&scope=public%20profile")!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //        self.navigationItem.setHidesBackButton(true, animated:true);
        self.webView.navigationDelegate = self
        setWebView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
