//
//  DataService.swift
//  CookLit
//
//  Created by Mohammed Abdulwahhab on 6/15/16.
//  Copyright © 2016 Mohammed Abdulwahhab. All rights reserved.
//
import Foundation
import Firebase

class DataService {
    // Use Firebase library to configure APIs
    static let dataService = DataService()
    
    private var _BASE_REF = Firebase(url: "https://cooklit.firebaseio.com")
    private var _USER_REF = Firebase(url: "https://cooklit.firebaseio.com/users")
    private var _MEAL_REF = Firebase(url: "https://cooklit.firebaseio.com/meals")

    
    var BASE_REF: Firebase {
        return _BASE_REF
    }
    
    var USER_REF: Firebase {
        return _USER_REF
    }
    var MEAL_REF: Firebase{
        return _MEAL_REF
    }
    
    var CURRENT_USER_REF: Firebase {
        let userID = NSUserDefaults.standardUserDefaults().valueForKey("uid") as! String
        
        let currentUser = Firebase(url: "https://cooklit.firebaseio.com/users").childByAppendingPath(userID)
        
        return currentUser!
    }
    
    
    
    func createNewJoke(joke: Dictionary<String, AnyObject>) {
        
        // Save the Joke
        // JOKE_REF is the parent of the new Joke: "jokes".
        // childByAutoId() saves the joke and gives it its own ID.
        
        let firebaseNewJoke = Firebase(url: "https://cooklit.firebaseio.com/meals").childByAutoId()
        
        // setValue() saves to Firebase.
        
        firebaseNewJoke.setValue(joke)
    }
    func createNewAccount(uid: String, user: Dictionary<String, String>) {
        
        // A User is born.
        print("reached the saving new account method")
        Firebase(url: "https://cooklit.firebaseio.com/users").childByAppendingPath(uid).setValue(user)
        print("a new account was saved")
    }
}