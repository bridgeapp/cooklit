//
//  AddMeal.swift
//  CookLit
//
//  Created by Mohammed Abdulwahhab on 7/4/16.
//  Copyright © 2016 Mohammed Abdulwahhab. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import AddressBookUI
import Firebase

class AddMeal: UIViewController,UIImagePickerControllerDelegate,
UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var bigImage: UIImageView!
    @IBOutlet weak var profileImage: UIImageView!
    //@IBOutlet weak var map: MKMapView!
    @IBOutlet weak var myMap: MKMapView!
    @IBOutlet weak var nameOfDish: UITextField!
    
    @IBOutlet weak var desc: UITextField!
    @IBOutlet weak var startTime: UITextField!
    @IBOutlet weak var endTime: UITextField!
    @IBOutlet weak var servings: UITextField!
    @IBOutlet weak var location: UITextField!
    var lat : CLLocationDegrees = 0.0
    var long : CLLocationDegrees = 0.0
    let initialLocation = CLLocation(latitude: 37.556578, longitude: -121.985858)
    
    let regionRadius: CLLocationDistance = 8000
    func textFieldShouldReturn(textField: UITextField!) -> Bool {   //delegate method
        textField.resignFirstResponder()
        return true
    }
    
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius * 2.0, regionRadius * 2.0)
        
        
        
        myMap.setRegion(coordinateRegion, animated: true)
        
        
        
        
        
    }
    
    func formValidation(){
    //IMPLEMENT_VALIDATION_LOGIC
    }
    
    
    
    func randomStringWithLength (len : Int) -> NSString {
        
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        
        var randomString : NSMutableString = NSMutableString(capacity: len)
        
        for (var i=0; i < len; i++){
            var length = UInt32 (letters.length)
            var rand = arc4random_uniform(length)
            randomString.appendFormat("%C", letters.characterAtIndex(Int(rand)))
        }
        
        return randomString
    }
    
    @IBAction func addBannerImage(sender: AnyObject) {
        
        // 1
        let optionMenu = UIAlertController(title: nil, message: "Choose Option", preferredStyle: .ActionSheet)
        
        // 2
        let cameraAction = UIAlertAction(title: "From Camera", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            print("File from camera")
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
                var imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = UIImagePickerControllerSourceType.Camera;
                imagePicker.allowsEditing = false
                self.presentViewController(imagePicker, animated: true, completion: nil)
            }
        })
        let galleryAction = UIAlertAction(title: "From Gallery", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            print("File from saved gallery")
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) {
                var imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary;
                imagePicker.allowsEditing = true
                self.presentViewController(imagePicker, animated: true, completion: nil)
            }
        })
        
        // 4
        optionMenu.addAction(cameraAction)
        optionMenu.addAction(galleryAction)
        
        // 5
        self.presentViewController(optionMenu, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        bigImage.image = image
        self.dismissViewControllerAnimated(true, completion: nil);
    }

    
    //current User data comes from stored defaults during the login process
    @IBOutlet weak var geocode: UIBarButtonItem!
    
    @IBAction func geocode(sender: AnyObject) {
        CLGeocoder().geocodeAddressString(location.text!, completionHandler: { (placemarks, error) in
            if error != nil {
                print(error)
                print("we hit an error")
                self.signupErrorAlert("Location not found", message : "We could not find the location you provided.")
                return
            }
            if placemarks?.count > 0 {
                let placemark = placemarks?[0]
                let location = placemark?.location
                let coordinate = location?.coordinate
                self.lat = (location?.coordinate.latitude)!
                self.long = (location?.coordinate.longitude)!
                print("nope we didnt")
                print("\nlat: \(coordinate!.latitude), long: \(coordinate!.longitude)")
                let coordinateRegion = MKCoordinateRegionMakeWithDistance(coordinate!,
                    self.regionRadius * 2.0, self.regionRadius * 2.0)
                
                
                
                self.myMap.setRegion(coordinateRegion, animated: true)
                
                var anotation = MKPointAnnotation()
                anotation.coordinate = CLLocationCoordinate2D(latitude: self.lat, longitude: self.long)
                anotation.title = "Serving Location"
                
                //anotation.subtitle = "This is the location !!!"
                
                
                
                self.myMap.addAnnotation(anotation)
                self.submit()
            }
        })

    }
    
    @IBAction func startTimeEditing(sender: UITextField) {
        let datePickerView:UIDatePicker = UIDatePicker()
        
        datePickerView.datePickerMode = UIDatePickerMode.DateAndTime
        
        sender.inputView = datePickerView
        
        datePickerView.addTarget(self, action: #selector(self.datePickerValueChanged), forControlEvents: UIControlEvents.ValueChanged)
    }
    
    @IBAction func endTimeEditing(sender: UITextField) {
        let datePickerView:UIDatePicker = UIDatePicker()
        
        datePickerView.datePickerMode = UIDatePickerMode.Time
        
        sender.inputView = datePickerView
        
        datePickerView.addTarget(self, action: #selector(self.timePickerValueChanged), forControlEvents: UIControlEvents.ValueChanged)

        
    }
    func timePickerValueChanged(sender:UIDatePicker) {
        
        let dateFormatter = NSDateFormatter()
        
        dateFormatter.dateStyle = NSDateFormatterStyle.NoStyle
        
        dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
        
        endTime.text = dateFormatter.stringFromDate(sender.date)
        
    }
    
    func datePickerValueChanged(sender:UIDatePicker) {
        
        let dateFormatter = NSDateFormatter()
        
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        
        dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
        
        startTime.text = dateFormatter.stringFromDate(sender.date)
        
    }
    
    func signupErrorAlert(title: String, message: String) {
        
        // Called upon signup error to let the user know signup didn't work.
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let action = UIAlertAction(title: "Ok", style: .Default, handler: nil)
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
    }
    
    func isValid() -> Bool{
        if(nameOfDish.text != "" && desc.text != "" && startTime.text != "" && endTime.text != "" && location.text != "" && servings.text != ""){
            return true
            
        }else{
            signupErrorAlert("Fields empty", message: "Please fill out all fields")
            return false
        }
    }
    
    func submit() {
        
       

        let pending = UIAlertController(title: "Just a second", message: nil, preferredStyle: .Alert)
        
        
        //create an activity indicator
        let indicator = UIActivityIndicatorView(frame: pending.view.bounds)
        indicator.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        indicator.color = UIColor.darkGrayColor()
        //add the activity indicator as a subview of the alert controller's view
        pending.view.addSubview(indicator)
        indicator.userInteractionEnabled = false // required otherwise if there buttons in the UIAlertController you will not be able to press them
        

        
        if (isValid() == false) {
            return
        }
        
        indicator.startAnimating()
        self.presentViewController(pending, animated: true, completion: nil)
        
        //encode both the profile image and the banner image
        var dataProf: NSData = NSData()
        if let profImage = profileImage.image {
            dataProf = UIImageJPEGRepresentation(profImage,0.1)!
        }
        let base64Prof = dataProf.base64EncodedStringWithOptions(NSDataBase64EncodingOptions.Encoding64CharacterLineLength)
        
        var dataBig: NSData = NSData()
        if let bigImg = bigImage.image {
            dataBig = UIImageJPEGRepresentation(bigImg,0.1)!
        }
        let base64Big = dataBig.base64EncodedStringWithOptions(NSDataBase64EncodingOptions.Encoding64CharacterLineLength)
        //END ENCODING
        
        let newMeal: Dictionary<String, AnyObject> = [
            "name": nameOfDish.text!,
            "servings": servings.text!,
            "displayName":  "test",
            "startTime" : startTime.text!,
            "endTime" : endTime.text!,
            "location" : location.text!,
            "desc" : desc.text!,
            "base64Prof" : base64Prof,
            "base64Big" : base64Big,
            "latitude" : self.lat,
            "longitude" : self.long,
            "hashid" : randomStringWithLength(12)
        ]
        
        let ref = Firebase(url: "https://cooklit.firebaseio.com/basic_info").childByAutoId()
        
        ref.setValue(newMeal, withCompletionBlock: {
            (error:NSError?, ref:Firebase!) in
            if (error != nil) {
                print("Data could not be saved.")
            } else {
                print("Data saved successfully!")
                pending.dismissViewControllerAnimated(true, completion: {})
                self.signupErrorAlert("Success", message : "You're meal is live on CookLit!")

            }
        })

        
        
        
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
        setDelegates()
 
    }
    
    func setDelegates(){
        nameOfDish.delegate = self
        desc.delegate = self
        startTime.delegate = self
        endTime.delegate = self
        servings.delegate = self
        location.delegate = self
        
    }
    @IBAction func cancel(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
