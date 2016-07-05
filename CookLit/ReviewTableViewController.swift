//
//  ReviewTableViewController.swift
//  CookLit
//
//  Created by Mohammed Abdulwahhab on 7/3/16.
//  Copyright © 2016 Mohammed Abdulwahhab. All rights reserved.
//

import UIKit


class ReviewTableViewController: UITableViewController {
    var meals = [Meal]()
    override func viewDidLoad() {
        super.viewDidLoad()
        let photo1 = UIImage(named: "profile")!
        let meal1 = Meal(name: "Mohammed Abdulwahhab", photo: photo1, rating: 5, comment : "Great food and fast pickup time. Ive had some pretty good meals from Cooklit but this was by far the best!")!
        
        let photo2 = UIImage(named: "profile2-2")!
        let meal2 = Meal(name: "Kunal Shah", photo: photo2, rating: 5, comment : "Food was fresh and authentic to the taste. Really enjoyed the meal. Another reason to love Cooklit")!
        
        let photo3 = UIImage(named: "profile3")!
        let meal3 = Meal(name: "Taj Shaik", photo: photo3, rating: 3, comment : "I've had better meals, but the food taste and quality was decent. I came late to pickup so mine was a bit stale as well.")!
        
        let photo4 = UIImage(named: "profile4")!
        let meal4 = Meal(name: "Jerry Yu", photo: photo4, rating: 3, comment : "I didnt't mind the rest of the taste, but some of the chicken was slightly undercooked. Might not order again.")!
        
   
        
        
        meals += [meal1, meal2, meal3, meal4]
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return meals.count
        
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        print("this was called")
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "reviewCell"
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! ReviewTableViewCell
        
      
        cell.nameLabel.text = meals[indexPath.row].name
        cell.profileImage.image = meals[indexPath.row].photo
        cell.profileImage.layer.cornerRadius = cell.profileImage.frame.size.width / 2;
        cell.profileImage.clipsToBounds = true
        cell.comment.text = meals[indexPath.row].comment
        cell.rating.text = String(meals[indexPath.row].rating) + "/5"
        
        
        
        
        return cell
    }

}
