//
//  OrderTableViewController.swift
//  CookLit
//
//  Created by Mohammed Abdulwahhab on 7/3/16.
//  Copyright © 2016 Mohammed Abdulwahhab. All rights reserved.
//

import UIKit

class OrderTableViewController: UITableViewController {
    var meals = [Meal]()
    override func viewDidLoad() {
        super.viewDidLoad()
        let photo1 = UIImage(named: "profile")!
        let meal1 = Meal(name: "Mohammed Abdulwahhab", photo: photo1, rating: 5, comment : "Now Cooking")!
        
        let photo2 = UIImage(named: "profile2-2")!
        let meal2 = Meal(name: "Kunal Shah", photo: photo2, rating: 5, comment : "Now Cooking")!
        
        let photo3 = UIImage(named: "profile3")!
        let meal3 = Meal(name: "Taj Shaik", photo: photo3, rating: 3, comment : "Ready")!
        
        let photo4 = UIImage(named: "profile4")!
        let meal4 = Meal(name: "Jerry Yu", photo: photo4, rating: 3, comment : "Received")!
        
        
        
        
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
        let cellIdentifier = "orderCell"
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! OrderTableViewCell
        cell.orderImage.layer.cornerRadius = cell.orderImage.frame.size.width / 2;
        cell.orderImage.clipsToBounds = true
        cell.orderImage.image = meals[indexPath.row].photo
        cell.nameLabel.text = meals[indexPath.row].name
        cell.orderLabel.text = meals[indexPath.row].comment
        
     
        
        
        
        return cell
    }

}
