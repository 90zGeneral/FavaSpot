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

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    //Outlet
    @IBOutlet weak var mapView: MKMapView!
   
    //Location Manager
    var locationManager: CLLocationManager!
    
    var userCoordinate = CLLocationCoordinate2D()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Initializer
        locationManager = CLLocationManager()
        
        //Delegates
        mapView.delegate = self
        locationManager.delegate = self
        
        //Permission request for user's location
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        //Create an annotation
        let annotation = MKPointAnnotation()
        annotation.coordinate = userCoordinate
        annotation.title = "Current Location"
        annotation.subtitle = "You are here now"
        mapView.addAnnotation(annotation)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let userLocation: CLLocation = locations[0]
        print(userLocation)
        
        let userLat: CLLocationDegrees = userLocation.coordinate.latitude
        let userLong: CLLocationDegrees = userLocation.coordinate.longitude
        let userLatDelta: CLLocationDegrees = 0.01
        let userLongDelta: CLLocationDegrees = 0.01

        userCoordinate = CLLocationCoordinate2D(latitude: userLat, longitude: userLong)
        let span: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: userLatDelta, longitudeDelta: userLongDelta)

        let region: MKCoordinateRegion = MKCoordinateRegion(center: userCoordinate, span: span)

        mapView.setRegion(region, animated: false)
        
    }

}

