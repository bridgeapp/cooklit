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
    /*
     @IBAction func refresh(sender: AnyObject) {
     let pending = UIAlertController(title: "Just a second", message: nil, preferredStyle: .Alert)
     
     
     //create an activity indicator
     let indicator = UIActivityIndicatorView(frame: pending.view.bounds)
     indicator.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
     indicator.color = UIColor.darkGrayColor()
     //add the activity indicator as a subview of the alert controller's view
     pending.view.addSubview(indicator)
     indicator.userInteractionEnabled = false // required otherwise if there buttons in the UIAlertController you will not be able to press them
     indicator.startAnimating()
     
     self.presentViewController(pending, animated: true, completion: nil)
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
     pending.dismissViewControllerAnimated(true, completion: {
     
     })
     })
     
     }*/
    
    var meals = [Meal]()
    var mealModels = [MealModel]()
    
    /// View which contains the loading text and the spinner
    let loadingView = UIView()
    
    /// Spinner shown during load the TableView
    let spinner = UIActivityIndicatorView()
    
    /// Text shown during load the TableView
    let loadingLabel = UILabel()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Load the sample data.
        print("loaded the ui table view controller")
        //loadSampleMeals()
        
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        
        
        let pending = UIAlertController(title: "Just a second", message: nil, preferredStyle: .Alert)
        
        //create an activity indicator
        let indicator = UIActivityIndicatorView(frame: pending.view.bounds)
        indicator.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        indicator.color = UIColor.darkGrayColor()
        //add the activity indicator as a subview of the alert controller's view
        pending.view.addSubview(indicator)
        indicator.userInteractionEnabled = false // required otherwise if there buttons in the UIAlertController you will not be able to press them
        indicator.startAnimating()
        
        self.presentViewController(pending, animated: true, completion: nil)
        self.setLoadingScreen()
        
        
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
                };pending.dismissViewControllerAnimated(true, completion: {})
                
                
            }
            
            // Be sure that the tableView updates when there is new data.
            
            self.tableView.reloadData();self.removeLoadingScreen()
        })
        
        ///////////////////////
        ///////////////////////
    }
    
    /*
     
     func loadSampleMeals() {
     print("loaded sample meals")
     let photo1 = UIImage(named: "food")!
     let meal1 = Meal(name: "Angus Burger + Fries", photo: photo1, rating: 4)!
     
     let photo2 = UIImage(named: "food2")!
     let meal2 = Meal(name: "Spanish style Suasage & Omelette", photo: photo2, rating: 5)!
     
     let photo3 = UIImage(named: "food3")!
     let meal3 = Meal(name: "Seasoned catfish", photo: photo3, rating: 3)!
     
     meals += [meal1, meal2, meal3]
     }*/
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
    
    
    // Set the activity indicator into the main view
    private func setLoadingScreen() {
        
        // Sets the view which contains the loading text and the spinner
        /*
         let width: CGFloat = 120
         let height: CGFloat = 30
         let x = (self.tableView.frame.width / 2) - (width / 2)
         let y = (self.tableView.frame.height / 2) - (height / 2) - (self.navigationController?.navigationBar.frame.height)!
         loadingView.frame = CGRectMake(x, y, width, height)
         
         // Sets loading text
         self.loadingLabel.textColor = UIColor.grayColor()
         self.loadingLabel.textAlignment = NSTextAlignment.Center
         self.loadingLabel.text = "Loading..."
         self.loadingLabel.frame = CGRectMake(0, 0, 140, 30)
         
         // Sets spinner
         self.spinner.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
         self.spinner.frame = CGRectMake(0, 0, 30, 30)
         self.spinner.startAnimating()
         
         // Adds text and spinner to the view
         loadingView.addSubview(self.spinner)
         loadingView.addSubview(self.loadingLabel)
         self.tableView.addSubview(loadingView)
         */
        
    }
    
    // Remove the activity indicator from the main view
    private func removeLoadingScreen() {
        
        // Hides and stops the text and the spinner
        self.spinner.stopAnimating()
        self.loadingLabel.hidden = true
        
    }
 }
