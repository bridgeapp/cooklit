//
//  SettingsViewController.swift
//  CookLit
//
//  Created by Mohammed Abdulwahhab on 6/27/16.
//  Copyright © 2016 Mohammed Abdulwahhab. All rights reserved.
//

import UIKit
import Firebase

class SettingsViewController: UIViewController {
    
    
    @IBAction func logout(sender: AnyObject) {
        
        var refreshAlert = UIAlertController(title: "Logout", message: "Would you like to signout of Cooklit?", preferredStyle: UIAlertControllerStyle.Alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
            print("Handle Ok logic here")
            // unauth() is the logout method for the current user.
            
            DataService.dataService.CURRENT_USER_REF.unauth()
            
            // Remove the user's uid from storage.
            
            NSUserDefaults.standardUserDefaults().setValue(nil, forKey: "uid")
            
            self.performSegueWithIdentifier("settingsToLogin", sender: nil)
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: { (action: UIAlertAction!) in
            print("Handle Cancel Logic here")
        }))
        
        presentViewController(refreshAlert, animated: true, completion: nil)
    }

  
}
