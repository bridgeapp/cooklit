//
//  MealTableViewController.swift
//  CookLit
//
//  Created by Mohammed Abdulwahhab on 6/16/16.
//  Copyright © 2016 Mohammed Abdulwahhab. All rights reserved.
//

import UIKit
import Firebase
class MealTableViewController: UITableViewController {
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var meals = [Meal]()
    var mealModels = [MealModel]()
    
  
 
    override func viewDidLoad() {
        
        super.viewDidLoad()
               // Load the sample data.
        print("loaded the ui table view controller")
        loadSampleMeals()
        
        //////////////////////
        //Loads data from out database
        ////////////////////
        let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
        tableView.backgroundView = activityIndicatorView
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        

        
        Firebase(url: "https://cooklit.firebaseio.com/meals").observeEventType(.Value, withBlock: { snapshot in
            
            // The snapshot is a current look at our jokes data.
            
            //print(snapshot.value)
            
            self.mealModels = []
            
            if let snapshots = snapshot.children.allObjects as? [FDataSnapshot] {
                
                for snap in snapshots {
                    
                    // Make our jokes array for the tableView.
                    
                    if let postDictionary = snap.value as? Dictionary<String, AnyObject> {
                        let key = snap.key
                        let joke = MealModel(key: key, dictionary: postDictionary)
                        
                        // Items are returned chronologically, but it's more fun with the newest jokes first.
                        
                        self.mealModels.insert(joke, atIndex: 0)
                        
                        
                    }
                }
                
            }
            
            // Be sure that the tableView updates when there is new data.
            
            self.tableView.reloadData()
        })
        
        ///////////////////////
        ///////////////////////
    }
    
    
    
    func loadSampleMeals() {
        print("loaded sample meals")
        let photo1 = UIImage(named: "food")!
        let meal1 = Meal(name: "Angus Burger + Fries", photo: photo1, rating: 4)!
        
        let photo2 = UIImage(named: "food2")!
        let meal2 = Meal(name: "Spanish style Suasage & Omelette", photo: photo2, rating: 5)!
        
        let photo3 = UIImage(named: "food3")!
        let meal3 = Meal(name: "Seasoned catfish", photo: photo3, rating: 3)!
        
        meals += [meal1, meal2, meal3]
    }
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       print(mealModels.count)
        print("got to table view cell count")
        return mealModels.count
      
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        print("this was called")
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "mtvc2"
       
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! MealTableViewCell
        
        // Fetches the appropriate meal for the data source layout.
        //let meal = meals[indexPath.row]
        
        cell.mealName.text = mealModels[indexPath.row].mealText
       // print(mealModels[indexPath.row].mealImage)
        let dataDecoded:NSData = NSData(base64EncodedString: mealModels[indexPath.row].mealImage, options: NSDataBase64DecodingOptions.IgnoreUnknownCharacters)!

       
        var decodedimage = UIImage(data: dataDecoded)
        cell.bigImage.image = decodedimage
        cell.backImage.image = decodedimage
        
        cell.profileImage.layer.cornerRadius = cell.profileImage.frame.size.width / 2;
        cell.profileImage.clipsToBounds = true
        
        cell.profileImage.layer.borderWidth = 3.0
        cell.profileImage.layer.borderColor = UIColor.whiteColor().CGColor
        
        
        
        return cell
    }
}
