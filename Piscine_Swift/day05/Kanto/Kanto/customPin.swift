//
//  customPin.swift
//  Kanto
//
//  Created by Sebastien ALIBERT on 4/1/19.
//  Copyright © 2019 Sebastien ALIBERT. All rights reserved.
//

import Foundation
import MapKit

struct Data {
    static var locationList: [customPin] = [
        customPin(title: "42", subtitle: "ecole 42", location: CLLocationCoordinate2D(latitude: 48.896559, longitude: 2.318365)),
        customPin(title: "je sais pas ou", subtitle: "un peu plus loin de 42", location: CLLocationCoordinate2D(latitude: 47.8950823, longitude: 3.3173929)),
        customPin(title: "Chatelet", subtitle: "Chatelet - Les Halles", location: CLLocationCoordinate2D(latitude: 48.8619965, longitude: 2.3461299))
    ]
}

class customPin: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(title:String, subtitle: String, location:CLLocationCoordinate2D) {
        self.coordinate = location
        self.title = title
        self.subtitle = subtitle
    }
}
