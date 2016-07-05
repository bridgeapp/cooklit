//
//  Meal.swift
//  CookLit
//
//  Created by Mohammed Abdulwahhab on 6/16/16.
//  Copyright © 2016 Mohammed Abdulwahhab. All rights reserved.
//

import UIKit

class Meal{
    var name: String
    var photo: UIImage?
    var rating: Int
    var comment: String
    
    // MARK: Initialization
    
    init?(name: String, photo: UIImage?, rating: Int, comment: String) {
        // Initialize stored properties.
        self.name = name
        self.photo = photo
        self.rating = rating
        self.comment = comment
        // Initialization should fail if there is no name or if the rating is negative.
        if name.isEmpty || rating < 0 {
            return nil
        }
    }

}
