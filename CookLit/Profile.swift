//
//  Profile.swift
//  CookLit
//
//  Created by Mohammed Abdulwahhab on 6/29/16.
//  Copyright © 2016 Mohammed Abdulwahhab. All rights reserved.
//

import UIKit
import Firebase

class Profile: UIViewController {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameView: UILabel!
    
    var profileName = ""
    var profileImage = ""
    var profileEmail = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
            print("i came into the viewdidload method")
        DataService.dataService.CURRENT_USER_REF.observeEventType(FEventType.Value, withBlock: { snapshot in
            
            let currentUser = snapshot.value.objectForKey("email") as! String
            let pe = snapshot.value.objectForKey("email") as! String
            let pn = snapshot.value.objectForKey("displayName") as! String
            var pi = snapshot.value.objectForKey("id") as! String
            pi = "https://graph.facebook.com/" + pi + "/picture?type=large"
            print("PE: \(pe)")
            print("PN: \(pn)")
            print("PI: \(pi)")
            
            self.profileName = pn
            self.profileImage = pi
            self.profileEmail = pe

            self.setView()

            }, withCancelBlock: { error in
                print(error.description)
        })

        
    }
    
    func setView(){
        let url = NSURL(string: profileImage)
        let data = NSData(contentsOfURL: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check
        imgView.image = UIImage(data: data!)
        imgView.layer.cornerRadius = imgView.frame.size.width / 2;
        imgView.clipsToBounds = true
        
        imgView.layer.borderWidth = 3.0
        imgView.layer.borderColor = UIColor.whiteColor().CGColor
        
        nameView.text = profileName
    
    }
    override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    }

}
