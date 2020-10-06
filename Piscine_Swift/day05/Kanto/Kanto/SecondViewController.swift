//
//  SecondViewController.swift
//  Kanto
//
//  Created by Sebastien ALIBERT on 4/1/19.
//  Copyright © 2019 Sebastien ALIBERT. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class SecondViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var scSegment: UISegmentedControl!
    @IBOutlet weak var mapView: MKMapView!
    
    var locationManager = CLLocationManager()
    var currentPin: customPin?
    
    @IBAction func findMe(_ sender: Any) {
        if let coord = self.locationManager.location?.coordinate
        {
            let regionOnMe = MKCoordinateRegionMakeWithDistance(coord, 1000, 1000)
            mapView.setRegion(regionOnMe, animated: true)
        }
    }
    
    @IBAction func scSegmentTapped(_ sender: Any) {
        switch (scSegment.selectedSegmentIndex) {
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .satellite
        default:
            mapView.mapType = .hybrid
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?
    {
        let pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "pinView")
        switch annotation.title!! {
        case "42":
            pinView.pinTintColor = UIColor.red
            break
        case "je sais pas ou":
            pinView.pinTintColor = UIColor.black
            break
        case "Chatelet":
            pinView.pinTintColor = UIColor.green
            break
        default:
            return nil
        }
        pinView.canShowCallout = true
        return pinView
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    @IBAction func unWindSegue(segue: UIStoryboardSegue)
    {
        if segue.identifier == "goToPin" {
            if let currentPin = self.currentPin {
                mapView.setRegion(MKCoordinateRegion(center: currentPin.coordinate, span:
                    MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)), animated: true )
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.showsUserLocation = true
        if CLLocationManager.locationServicesEnabled() == true {
            if CLLocationManager.authorizationStatus() == .restricted ||
                CLLocationManager.authorizationStatus() == .denied ||
                CLLocationManager.authorizationStatus() == .notDetermined {
                locationManager.requestWhenInUseAuthorization()
            }
            locationManager.desiredAccuracy = 1.0
            locationManager.delegate = self
            locationManager.startUpdatingLocation()
        } else {
            print("Please turn on location services or GPS")
        }
        mapView.setRegion(MKCoordinateRegion(center: Data.locationList[0].coordinate, span:
            MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)), animated: true)
        self.mapView.addAnnotations(Data.locationList)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

