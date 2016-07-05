//
//  AddMeal.swift
//  CookLit
//
//  Created by Mohammed Abdulwahhab on 7/4/16.
//  Copyright © 2016 Mohammed Abdulwahhab. All rights reserved.
//

import UIKit
import MapKit

class AddMeal: UIViewController {

    @IBOutlet weak var bigImage: UIImageView!
    @IBOutlet weak var profileImage: UIImageView!
    //@IBOutlet weak var map: MKMapView!
    @IBOutlet weak var myMap: MKMapView!
    
    let initialLocation = CLLocation(latitude: 37.556578, longitude: -121.985858)
    
    let regionRadius: CLLocationDistance = 8000
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius * 2.0, regionRadius * 2.0)
        
        
        
        myMap.setRegion(coordinateRegion, animated: true)
        
        var anotation = MKPointAnnotation()
        anotation.coordinate = CLLocationCoordinate2D(latitude: 37.556578, longitude: -121.985858)
        anotation.title = "You"
        //anotation.subtitle = "This is the location !!!"
        
        
        
        myMap.addAnnotation(anotation)

        
        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        centerMapOnLocation(initialLocation)
        var blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
        var blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = bigImage.bounds
        blurEffectView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        bigImage.addSubview(blurEffectView)
        profileImage.layer.cornerRadius = profileImage.frame.size.width / 2;
        profileImage.clipsToBounds = true
        
        profileImage.layer.borderWidth = 3.0
        profileImage.layer.borderColor = UIColor.whiteColor().CGColor

        
    }
    
    @IBAction func cancel(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
