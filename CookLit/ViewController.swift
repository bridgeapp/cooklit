//
//  ViewController.swift
//  CookLit
//
//  Created by Mohammed Abdulwahhab on 6/14/16.
//  Copyright © 2016 Mohammed Abdulwahhab. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    @IBAction func done(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)

        
    }
    //@IBOutlet weak var mapView: MKMapView!
    
    
    
    
    @IBOutlet weak var containerNew: UIView!
    
    @IBOutlet weak var containerDesc: UIView!
    @IBOutlet weak var containerReviews: UIView!
    @IBOutlet weak var containerLiveStream: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
       // let initialLocation = CLLocation(latitude: 37.560165, longitude: -121.979946)
        //centerMapOnLocation(initialLocation)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    //Work on finding current location
    /*func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
        
        let center = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        self.mapView.setRegion(region, animated: true)
    }*/
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    
    
    @IBAction func indexChanged(sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0 {
            UIView.animateWithDuration(0.5, animations: {
                self.containerNew.alpha = 1
                self.containerDesc.alpha = 0
                self.containerReviews.alpha = 0
                self.containerLiveStream.alpha = 0
            })}
        else if sender.selectedSegmentIndex == 1  {
            UIView.animateWithDuration(0.5, animations: {
                self.containerDesc.alpha = 0
                self.containerReviews.alpha = 1
                self.containerLiveStream.alpha = 0
            })}
        else{
            UIView.animateWithDuration(0.5, animations: {
                self.containerDesc.alpha = 0
                self.containerReviews.alpha = 0
                self.containerLiveStream.alpha = 1
            })
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

