//
//  scrollViewController.swift
//  APM
//
//  Created by Sebastien ALIBERT on 3/28/19.
//  Copyright © 2019 Sebastien ALIBERT. All rights reserved.
//

import UIKit

class scrollViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    
    var imageView = UIImageView()
    var newTitle = String()
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.addSubview(imageView)
        scrollView.contentSize = imageView.frame.size
        var minZoom = min(self.scrollView.bounds.size.width / imageView.bounds.size.width, self.scrollView.bounds.size.height / imageView.bounds.size.height);
        scrollView.minimumZoomScale = minZoom
        if (minZoom > 1.0) {
            minZoom = 1.0
        }
        scrollView.maximumZoomScale = 100
        scrollView.minimumZoomScale = minZoom
        self.title = newTitle
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
