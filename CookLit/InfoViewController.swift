//
//  InfoViewController.swift
//  CookLit
//
//  Created by Mohammed Abdulwahhab on 7/4/16.
//  Copyright © 2016 Mohammed Abdulwahhab. All rights reserved.
//

import UIKit
import MapKit

class InfoViewController: UIViewController {
    @IBOutlet weak var cookName: UILabel!
    @IBOutlet weak var cookDescription: UITextView!
    @IBOutlet weak var map: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        centerMapOnLocation(initialLocation)
        
    }
    let initialLocation = CLLocation(latitude: 37.556578, longitude: -121.985858)
    
    let regionRadius: CLLocationDistance = 8000
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius * 2.0, regionRadius * 2.0)
        
        
        
        map.setRegion(coordinateRegion, animated: true)
        
        var anotation = MKPointAnnotation()
        anotation.coordinate = CLLocationCoordinate2D(latitude: 37.556578, longitude: -121.985858)
        anotation.title = "3242 Nathan Ct. Fremont, CA"
        //anotation.subtitle = "This is the location !!!"
        
        
        
        map.addAnnotation(anotation)
        
        
        
        
    }

}
