//
//  ImageCollectionViewCell.swift
//  APM
//
//  Created by Sebastien ALIBERT on 3/28/19.
//  Copyright © 2019 Sebastien ALIBERT. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageCell: UIImageView!
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    var url : String? {
        didSet {
            if let existUrl = url {
                if let nsurl = NSURL(string: existUrl) {
                    showLoader()
                    DispatchQueue.global(qos: .userInitiated).async {
                        if let data = NSData(contentsOf: nsurl as URL) {
                            DispatchQueue.main.async {
                                let image = UIImage(data: data as Data)
                                self.imageCell.image = image!
                                self.removeLoader()
                            }
                        } else {
                            self.Alert(nsurl.absoluteString)
                            self.url = nil
                        }
                    }
                }
            }
        }
    }
        
    func setupLoader() {
        removeLoader()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = .gray
    }
        
    func showLoader() {
        setupLoader()
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            self.activityIndicator.center = self.imageCell.center
            self.activityIndicator.startAnimating()
            self.imageCell.addSubview(self.activityIndicator)
            UIApplication.shared.beginIgnoringInteractionEvents()
        }
    }
    
    func removeLoader() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.activityIndicator.removeFromSuperview()
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            UIApplication.shared.endIgnoringInteractionEvents()
        }
    }
    
    func Alert(_ url: String!) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: "Billy the guy who will get your pics", message:
                "\(url!) is not found", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: .default))
            UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
        }
    }
}
