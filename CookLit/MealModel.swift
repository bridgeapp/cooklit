//
//  MealModel.swift
//  CookLit
//
//  Created by Mohammed Abdulwahhab on 6/27/16.
//  Copyright © 2016 Mohammed Abdulwahhab. All rights reserved.
//

import UIKit
import Firebase

class MealModel{
    private var _mealRef: Firebase!
    
    private var _mealKey: String!
    private var _mealText: String!
    private var _mealVotes: Int!
    private var _username: String!
    private var _mealImage: String!
    
    var mealKey: String {
        return _mealKey
    }
    
    var mealText: String {
        return _mealText
    }
    
    var mealVotes: Int {
        return _mealVotes
    }
    
    var username: String {
        return _username
    }
    var mealImage: String {
        return _mealImage
    }
    
    // Initialize the new Joke
    
    init(key: String, dictionary: Dictionary<String, AnyObject>) {
        self._mealKey = key
        
        // Within the Joke, or Key, the following properties are children
        
        if let votes = dictionary["votes"] as? Int {
            self._mealVotes = votes
        }
        
        if let joke = dictionary["mealText"] as? String {
            self._mealText = joke
        }
        if let joke = dictionary["base64"] as? String {
            self._mealImage = joke
        }
        
        if let user = dictionary["author"] as? String {
            self._username = user
        } else {
            self._username = ""
        }
        
        // The above properties are assigned to their key.
        
        self._mealRef = Firebase(url: "https://cooklit.firebaseio.com/meals").childByAppendingPath(self._mealKey)
    }
    

}
