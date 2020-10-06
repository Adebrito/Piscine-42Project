//
//  ViewController.swift
//  APM
//
//  Created by Sebastien ALIBERT on 3/27/19.
//  Copyright © 2019 Sebastien ALIBERT. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let listPathImages: [String] = [
            "https://www.nasa.gov/sites/default/files/thumbnails/image/jsc2007e08828.jpg",
            "https://www.nasa.gov/sites/default/files/thumbnails/image/ngacm1_1.jpg",
            "https://iAmNotAPicture.jpg",
            "https://www.nasa.gov/sites/default/files/thumbnails/image/47328135122_85619ed320_o.jpg",
            "https://images.wallpaperscraft.com/image/planet_galaxy_universe_121293_3840x2160.jpg",
            "https://images.wallpaperscraft.com/image/space_planet_sky_94434_3840x2160.jpg",
            "https://images.wallpaperscraft.com/image/yuri_gagarin_first_cosmonaut_ussr_80_years_old_93412_1920x1080.jpg",
            "https://wallpaperplay.com/walls/full/e/5/3/181223.jpg",
            "https://wallpaperplay.com/walls/full/f/5/3/181224.jpg",
            "https://wallpaperplay.com/walls/full/e/2/e/181226.jpg"
            
            
            ]
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "putImageSegue" {
            let vc = segue.destination as! scrollViewController
            vc.imageView = UIImageView(image: (sender as! ImageCollectionViewCell).imageCell.image)
            vc.newTitle = String("Image")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.listPathImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! ImageCollectionViewCell
        cell.url = listPathImages[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! ImageCollectionViewCell
        if cell.url != nil {
            performSegue(withIdentifier: "putImageSegue", sender: cell)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

