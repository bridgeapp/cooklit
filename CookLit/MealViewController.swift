//
//  MealViewController.swift
//  CookLit
//
//  Created by Mohammed Abdulwahhab on 7/1/16.
//  Copyright © 2016 Mohammed Abdulwahhab. All rights reserved.
//

import UIKit
import Firebase

class MealViewController: UIViewController {
    @IBOutlet weak var bigImage: UIImageView!
    @IBOutlet weak var backImage: UIImageView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var mealType: UILabel!
    @IBOutlet weak var mealRating: UILabel!
    @IBOutlet weak var mealLive: UILabel!
    @IBOutlet weak var orderButton: UILabel!

    @IBOutlet weak var sc: UISegmentedControl!
    
    @IBOutlet weak var cvforinfo: UIView!
    
    @IBOutlet weak var cvforreviews: UIView!
    
    @IBOutlet weak var cvfororders: UIView!
    @IBAction func done(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        //set border around profile image
        profileImage.layer.cornerRadius = profileImage.frame.size.width / 2;
        profileImage.clipsToBounds = true
        
        profileImage.layer.borderWidth = 3.0
        profileImage.layer.borderColor = UIColor.whiteColor().CGColor
        super.viewDidLoad()
        var blurEffect = UIBlurEffect(style: UIBlurEffectStyle.ExtraLight)
        var blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = backImage.bounds
        blurEffectView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        backImage.addSubview(blurEffectView)
        
        //makeinfo the selected one
        cvforinfo.hidden=false
        cvfororders.hidden=true
        cvforreviews.hidden=true
        
        //
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    @IBAction func indexChanged(sender: AnyObject) {
        switch sc.selectedSegmentIndex
        {
        case 0:
            cvforinfo.hidden=false
            cvfororders.hidden=true
            cvforreviews.hidden=true
        case 1:
            cvforinfo.hidden=true
            cvfororders.hidden=true
            cvforreviews.hidden=false
        case 2:
            cvforinfo.hidden=true
            cvfororders.hidden=false
            cvforreviews.hidden=true
        case 3:
            cvforinfo.hidden=false
            cvfororders.hidden=true
            cvforreviews.hidden=true
        default:
            break;
        }
        
    }
}
