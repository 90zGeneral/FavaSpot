//
//  ViewController.swift
//  FavaSpot
//
//  Created by Roydon Jeffrey on 6/21/17.
//  Copyright © 2017 Italyte. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    //Outlet
    @IBOutlet weak var mapView: MKMapView!
   
    //Location Manager
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Delegates
        mapView.delegate = self
        locationManager.delegate = self
        
        //Permission request for user's location
        locationManager.requestAlwaysAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()

    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let userLocation: CLLocation = locations[0]
        
        let userLat: CLLocationDegrees = userLocation.coordinate.longitude
        let userLong: CLLocationDegrees = userLocation.coordinate.longitude
        let userLatDelta: CLLocationDegrees = 0.01
        let userLongDelta: CLLocationDegrees = 0.01
        
        let userCoordinate: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: userLat, longitude: userLong)
        let span: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: userLatDelta, longitudeDelta: userLongDelta)
        
        let region: MKCoordinateRegion = MKCoordinateRegion(center: userCoordinate, span: span)
        
        mapView.setRegion(region, animated: true)
        
        //Create an annotation
        let annotation = MKPointAnnotation()
        annotation.coordinate = userCoordinate
        annotation.title = "Current Location"
        annotation.subtitle = "You are here now"
        mapView.addAnnotation(annotation)
    }

}

