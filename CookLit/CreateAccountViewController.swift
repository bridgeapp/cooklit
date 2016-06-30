//
//  CreateAccountViewController.swift
//  CookLit
//
//  Created by Mohammed Abdulwahhab on 6/15/16.
//  Copyright © 2016 Mohammed Abdulwahhab. All rights reserved.
//

import UIKit
import Firebase
import FBSDKCoreKit
import FBSDKLoginKit

class CreateAccountViewController: UIViewController {
    
    @IBAction func facebookLogin(sender: UITapGestureRecognizer) {
        
        print("ok you touched the facebook button")
        let facebookLogin = FBSDKLoginManager()
        print("Logging In")
        facebookLogin.logInWithReadPermissions(["email","public_profile"], fromViewController: self, handler:{(facebookResult, facebookError) -> Void in
            
            if facebookError != nil{
                print(facebookError)
            }
            else if facebookResult.isCancelled{
                print("Facebook login was canelled")
            }else{
                print("you were authenticated via facebook")
                let accessToken = FBSDKAccessToken.currentAccessToken().tokenString
                DataService.dataService.BASE_REF.authWithOAuthProvider("facebook", token : accessToken, withCompletionBlock: {error, authData in
                    
                    
                    if error != nil {
                        print("Login failed. \(error)")
                    }
                    else{
                        print("Logged in \(authData)")
                        let newUser = [
                            "provider" : authData.provider,
                            "displayName" : authData.providerData["displayName"] as? NSString as? String,
                            "email" : authData.providerData["email"] as? NSString as? String,
                            "profile_image" : authData.providerData["profileImageURL"] as? NSString as? String,
                            "id" : authData.providerData["id"] as? NSString as? String
                            
                        ]
                        DataService.dataService.USER_REF.childByAppendingPath(authData.uid).setValue(newUser)
                        
                        // Store the uid for future access - handy!
                        NSUserDefaults.standardUserDefaults().setValue(authData.uid, forKey: "uid")
                        
                        // Enter the app.
                        self.performSegueWithIdentifier("loginToHome", sender: nil)

                        
                    }//end else
                    
                    })}
            
        });
    }
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!

    @IBAction func createAccount(sender: UITapGestureRecognizer) {
        print("create account was invoked");
        let email = emailField.text
        let password = passwordField.text
        
        if email != "" && password != "" {
            
            // Set Email and Password for the New User.
            
            DataService.dataService.BASE_REF.createUser(email, password: password, withValueCompletionBlock: { error, result in
                
                if error != nil {
                    
                    // There was a problem.
                    self.signupErrorAlert("Oops!", message: "Having some trouble creating your account. Try again.")
                    print(error)
                    
                } else {
                    
                    // Create and Login the New User with authUser
                    DataService.dataService.BASE_REF.authUser(email, password: password, withCompletionBlock: {
                        err, authData in
                        if error != nil {
                            self.signupErrorAlert("Oops!", message: "Having some trouble creating your account. Try again2.")
                        }else{
                        let user = ["provider": authData.provider!, "email": email!]
                        
                        // Seal the deal in DataService.swift.
                            DataService.dataService.createNewAccount(authData.uid, user: user)}
                        print("came back here");
                    })
                    
                    // Store the uid for future access - handy!
                    NSUserDefaults.standardUserDefaults().setValue(result ["uid"], forKey: "uid")
                    
                    // Enter the app.
                      self.performSegueWithIdentifier("loginToHome", sender: nil)
                }
            })
            
        } else {
            signupErrorAlert("Oops!", message: "Don't forget to enter your email, password, and a username.")
        }
    }
  //facebook button is temporary login
    @IBAction func tryLogin(sender: UITapGestureRecognizer) {
        print("so was this method called?")
        let email = emailField.text
        let password = passwordField.text
        
        if email != "" && password != "" {
            
            // Login with the Firebase's authUser method
            
            DataService.dataService.BASE_REF.authUser(email, password: password, withCompletionBlock: { error, authData in
                
                if error != nil {
                    print(error)
                    self.loginErrorAlert("Oops!", message: "Check your username and password.")
                } else {
                    
                    // Be sure the correct uid is stored.
                    
                    NSUserDefaults.standardUserDefaults().setValue(authData.uid, forKey: "uid")
                    
                    // Enter the app!
                    print("manual login worked")
                    self.performSegueWithIdentifier("loginToHome", sender: nil)
                }
            })
            
        } else {
            
            // There was a problem
            
            loginErrorAlert("Oops!", message: "Don't forget to enter your email and password.")
        }
    }
    
    
    func signupErrorAlert(title: String, message: String) {
        
        // Called upon signup error to let the user know signup didn't work.
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let action = UIAlertAction(title: "Ok", style: .Default, handler: nil)
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
    }
    
   
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        // If we have the uid stored, the user is already logger in - no need to sign in again!
        
        if NSUserDefaults.standardUserDefaults().valueForKey("uid") != nil && DataService.dataService.CURRENT_USER_REF.authData != nil {
            print("already logged in")
           self.performSegueWithIdentifier("loginToHome", sender: nil)
        }
    }
    
    
    
    func loginErrorAlert(title: String, message: String) {
        
        // Called upon login error to let the user know login didn't work.
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let action = UIAlertAction(title: "Ok", style: .Default, handler: nil)
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        print("view did load");
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

  



}