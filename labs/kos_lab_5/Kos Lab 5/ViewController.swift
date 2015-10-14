//
//  ViewController.swift
//  Kos Lab 5
//
//  Created by Brittany Kos on 10/13/15.
//  Copyright (c) 2015 Kode Studios. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    var locationManager = CLLocationManager()
    
    //defines the area spanned by a map region
    var span = MKCoordinateSpanMake(0.08, 0.08)
    
    let presetLocation = CLLocationCoordinate2D(
        latitude: 39.937648,
        longitude: -105.143547
    )
    
    var eatLocations = [MKPointAnnotation]()
    var shoppingLocations = [MKPointAnnotation]()
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var locationSetting: UISegmentedControl!
    @IBOutlet weak var placeSetting: UISegmentedControl!
    
    @IBAction func changeLocation(sender: UISegmentedControl) {
        if(sender.selectedSegmentIndex == 0) {
            var region = MKCoordinateRegionMake(presetLocation, span)
            mapView.setRegion(region, animated: true)
        } else {
            var region = MKCoordinateRegionMake(locationManager.location.coordinate, span)
            mapView.setRegion(region, animated: true)
        }
        
    }
    
    @IBAction func changePlace(sender: UISegmentedControl) {
        if(sender.selectedSegmentIndex == 0) {
            mapView.removeAnnotations(shoppingLocations)
            mapView.addAnnotations(eatLocations)
        } else {
            mapView.removeAnnotations(eatLocations)
            mapView.addAnnotations(shoppingLocations)
        }
    }
    
    
    
    
    //called when a new location value is available
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        if(locationSetting.selectedSegmentIndex == 0) {
            var region = MKCoordinateRegionMake(presetLocation, span)
            mapView.setRegion(region, animated: true)
        } else {
            var region = MKCoordinateRegionMake(manager.location.coordinate, span)
            mapView.setRegion(region, animated: true)
        }
        
        var locValue:CLLocationCoordinate2D = manager.location.coordinate
        println("locations = \(locValue.latitude) \(locValue.longitude)")
        
    }
    
    //called when the authorization status for the application changed.
    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        //println("didchangeauth")
    
        if status==CLAuthorizationStatus.AuthorizedWhenInUse {
            locationManager.startUpdatingLocation() //starts the location manager
        }
    }
    
    //called when a location cannot be determined
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        var errorType=String()
        if let clError=CLError(rawValue: error.code) {
            if clError == .Denied {
                errorType="access denied"
                
                let alert=UIAlertController(title: "Error", message: errorType, preferredStyle: UIAlertControllerStyle.Alert)
                let okAction:UIAlertAction=UIAlertAction(title: "OK", style:UIAlertActionStyle.Default, handler: nil)
                
                alert.addAction(okAction)
                presentViewController(alert, animated: true, completion: nil)
            }
        }
    }
    
    override func viewDidLoad() {
        //hybrid with map and satellite
        mapView.mapType=MKMapType.Hybrid
        
        // get if location is approved
        var status: CLAuthorizationStatus = CLLocationManager.authorizationStatus()
        if (status == CLAuthorizationStatus.NotDetermined) {
            locationManager.requestWhenInUseAuthorization() //ios8 and later only
        }
        
        
        // set desired location
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.startUpdatingLocation()
        mapView.showsUserLocation = true
        
        var region = MKCoordinateRegionMake(presetLocation, span)
        mapView.setRegion(region, animated: true)
        
        
        // set the annotations
        let c1 = MKPointAnnotation()
        c1.coordinate = CLLocationCoordinate2D( latitude: 39.928471, longitude: -105.147747 )
        c1.title = "Starbucks"
        c1.subtitle = "Always has a seat in the back with an outlet waiting for me."
        eatLocations.append(c1);
        
        let c2 = MKPointAnnotation()
        c2.coordinate = CLLocationCoordinate2D( latitude: 39.955794, longitude: -105.168896 )
        c2.title = "Panera"
        c2.subtitle = "Good for lunch and coffee."
        eatLocations.append(c2);
        
        let c3 = MKPointAnnotation()
        c3.coordinate = CLLocationCoordinate2D( latitude: 39.955625, longitude: -105.168263 )
        c3.title = "Froyo"
        c3.subtitle = "The BEST frozen dessert in Superior."
        eatLocations.append(c3);
        
        
        let s1 = MKPointAnnotation()
        s1.coordinate = CLLocationCoordinate2D( latitude: 39.930738, longitude: -105.134512 )
        s1.title = "2nd and Charles"
        s1.subtitle = "Geek bookstore."
        shoppingLocations.append(s1);
        
        let s2 = MKPointAnnotation()
        s2.coordinate = CLLocationCoordinate2D( latitude: 39.931279, longitude: -105.132157 )
        s2.title = "The Container Store"
        s2.subtitle = "This place makes me happy."
        shoppingLocations.append(s2);
        
        let s3 = MKPointAnnotation()
        s3.coordinate = CLLocationCoordinate2D( latitude: 39.956300, longitude: -105.164465 )
        s3.title = "Superios Liquor"
        s3.subtitle = "For those long grad weekends."
        shoppingLocations.append(s3);
        
        
        // add eat locations first
        mapView.addAnnotations(eatLocations)

        
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

