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
    
    //To represent the user's location coordination
    var userCoordinate = CLLocationCoordinate2D()
    
    //Represent new annotations on the map
    var number = 0
    
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
        
        //Add a Long Press Gesture Recognizer to the map after 2 seconds of pressing
        let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(ViewController.lpgrAction(_:)))
        longPressGestureRecognizer.minimumPressDuration = 2.0
        mapView.addGestureRecognizer(longPressGestureRecognizer)

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
    
    func lpgrAction(_ gestureRecognizer: UIGestureRecognizer) {
        
        //Check if the recognizer's state has begun to avoid repeated addition of an annotation to the map
        if gestureRecognizer.state == UIGestureRecognizerState.began {
            
            //Grab the user's touch point and convert it into coordinates
            let userTouch = gestureRecognizer.location(in: mapView)
            let newCoordinates: CLLocationCoordinate2D = mapView.convert(userTouch, toCoordinateFrom: mapView)
            
            number += 1
            
            //Create a new annotation for the new location
            let annotation = MKPointAnnotation()
            annotation.coordinate = newCoordinates
            annotation.title = "New Location"
            annotation.subtitle = "touch point \(Int(number))"
            mapView.addAnnotation(annotation)


        }
        
    }

}

