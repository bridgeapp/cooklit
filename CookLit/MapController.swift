//
//  MapController.swift
//  CookLit
//
//  Created by Mohammed Abdulwahhab on 6/20/16.
//  Copyright © 2016 Mohammed Abdulwahhab. All rights reserved.
//

import UIKit
import MapKit

class MapController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!

    let initialLocation = CLLocation(latitude: 37.556578, longitude: -121.985858)

    let regionRadius: CLLocationDistance = 4000
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius * 2.0, regionRadius * 2.0)
        
        
        
        mapView.setRegion(coordinateRegion, animated: true)
        
        var anotation = MKPointAnnotation()
        anotation.coordinate = CLLocationCoordinate2D(latitude: 37.556578, longitude: -121.985858)
        anotation.title = "You"
        //anotation.subtitle = "This is the location !!!"
        
        var anotation2 = MKPointAnnotation()
        anotation2.coordinate = CLLocationCoordinate2D(latitude: 37.557578, longitude: -121.985758)
        anotation2.title = "Angus Burger and Fries"
        anotation2.subtitle = "Cooking now"
        
        var anotation3 = MKPointAnnotation()
        anotation3.coordinate = CLLocationCoordinate2D(latitude: 37.551578, longitude: -121.983858)
        anotation3.title = "You"
        //anotation.subtitle = "This is the location !!!"
        
        var anotation4 = MKPointAnnotation()
        anotation4.coordinate = CLLocationCoordinate2D(latitude: 37.553578, longitude: -121.982858)
        anotation4.title = "You"
        //anotation.subtitle = "This is the location !!!"
        
        var anotation5 = MKPointAnnotation()
        anotation5.coordinate = CLLocationCoordinate2D(latitude: 37.545578, longitude: -121.986858)
        anotation5.title = "You"
        //anotation.subtitle = "This is the location !!!"
        
        var anotation6 = MKPointAnnotation()
        anotation6.coordinate = CLLocationCoordinate2D(latitude: 37.555478, longitude: -121.985438)
        anotation6.title = "You"
        //anotation.subtitle = "This is the location !!!"
        
        mapView.addAnnotation(anotation)
        mapView.addAnnotation(anotation2)
        mapView.addAnnotation(anotation3)
        mapView.addAnnotation(anotation4)
        mapView.addAnnotation(anotation5)
        mapView.addAnnotation(anotation6)


        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        centerMapOnLocation(initialLocation)
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
