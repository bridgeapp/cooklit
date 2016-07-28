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
    
    var mealModels = [MealModel]()
    var mainArray = [Dictionary<String, AnyObject>]()

    
 
    override func viewDidLoad() {
        
        super.viewDidLoad()
        print("loaded the ui table view controller")

        //Presents loading animation
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        let pending = UIAlertController(title: "Just a second", message: nil, preferredStyle: .Alert)
        let indicator = UIActivityIndicatorView(frame: pending.view.bounds)
        indicator.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        indicator.color = UIColor.darkGrayColor()
        pending.view.addSubview(indicator)
        indicator.userInteractionEnabled = false
        indicator.startAnimating()
        self.presentViewController(pending, animated: true, completion: nil)
        //End loading animation
        
        Firebase(url: "https://cooklit.firebaseio.com/basic_info").observeEventType(.Value, withBlock: { snapshot in
            
            // The snapshot is a current look at our jokes data.
            
            //print(snapshot.value)
            var mainArray = [Dictionary<String, AnyObject>]()

            
            if let snapshots = snapshot.children.allObjects as? [FDataSnapshot] {
                
                
                for snap in snapshots {
                    
                    // Make our jokes array for the tableView.
                    
                    if let postDictionary = snap.value as? Dictionary<String, AnyObject> {
                        let key = snap.key
                        
                        // Items are returned chronologically, but it's more fun with the newest jokes first.
                        
                        self.mainArray.insert(postDictionary, atIndex: 0)
                        
                    }
                };pending.dismissViewControllerAnimated(true, completion: {})

                
            }
            
            // Be sure that the tableView updates when there is new data.
            
            self.tableView.reloadData()
        })
        
        
    }
    

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainArray.count
      
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        print("this was called")
        let cellIdentifier = "mtvc2"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! MealTableViewCell
        //ratings, price
        var temp : Dictionary<String,AnyObject>
        temp = mainArray[indexPath.row]
        print(temp)
        if let name = temp["name"] as? String {
            
            cell.mealName.text = name
        }
        if let profPic = temp["base64Prof"] as? String {
            let dataDecoded:NSData = NSData(base64EncodedString: profPic, options: NSDataBase64DecodingOptions.IgnoreUnknownCharacters)!
            var decodedimage = UIImage(data: dataDecoded)
            cell.profileImage.image = decodedimage
        }
        if let bigPic = temp["base64Big"] as? String {
            let dataDecoded:NSData = NSData(base64EncodedString: bigPic, options: NSDataBase64DecodingOptions.IgnoreUnknownCharacters)!
            var decodedimage = UIImage(data: dataDecoded)
            cell.bigImage.image = decodedimage
            cell.backImage.image = decodedimage

            
        }
        
        
        
        var blurEffect = UIBlurEffect(style: UIBlurEffectStyle.ExtraLight)
        var blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = cell.backImage.bounds
        blurEffectView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        cell.backImage.addSubview(blurEffectView)

        cell.profileImage.layer.cornerRadius = cell.profileImage.frame.size.width / 2;
        cell.profileImage.clipsToBounds = true
        
        cell.profileImage.layer.borderWidth = 3.0
        cell.profileImage.layer.borderColor = UIColor.whiteColor().CGColor
        return cell
    }
    

    
 
    
}
