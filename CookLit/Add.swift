//
//  Add.swift
//  CookLit
//
//  Created by Mohammed Abdulwahhab on 6/15/16.
//  Copyright © 2016 Mohammed Abdulwahhab. All rights reserved.
//

import UIKit
import Firebase

class Add: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var imagePicker = UIImagePickerController()
    @IBOutlet weak var imgView: UIImageView!
    
    @IBAction func btnClicked(sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary){
            print("Button capture")
            
            
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary;
            imagePicker.allowsEditing = false
            
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
    }
    @IBAction func cancel(sender: UIBarButtonItem) {
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    var currentUsername = ""
    
    @IBOutlet weak var jokeField: UITextField!
    @IBAction func saveData(sender: UIButton) {
      
        let jokeText = jokeField.text
        var data: NSData = NSData()
        if let image = imgView.image {
            data = UIImageJPEGRepresentation(image,0.1)!
        }
        let base64String = data.base64EncodedStringWithOptions(NSDataBase64EncodingOptions.Encoding64CharacterLineLength)

        
        if jokeText != "" {
            
            // Build the new Joke.
            // AnyObject is needed because of the votes of type Int.
            
            let newJoke: Dictionary<String, AnyObject> = [
                "mealText": jokeText!,
                "votes": 0,
                "author": currentUsername,
                "base64" : base64String
            ]
            
            // Send it over to DataService to seal the deal.
            
            DataService.dataService.createNewJoke(newJoke)
            
            /*if let navController = self.navigationController {
                navController.popViewControllerAnimated(true)
            }*/
        }
    }
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!){
        self.dismissViewControllerAnimated(true, completion: { () -> Void in
            
        })
        
        imgView.image = image
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        DataService.dataService.CURRENT_USER_REF.observeEventType(FEventType.Value, withBlock: { snapshot in
            
            let currentUser = snapshot.value.objectForKey("email") as! String
            
            print("Username: \(currentUser)")
            self.currentUsername = currentUser
            }, withCancelBlock: { error in
                print(error.description)
        })
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
