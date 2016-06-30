//
//  MealTableViewCell.swift
//  CookLit
//
//  Created by Mohammed Abdulwahhab on 6/16/16.
//  Copyright © 2016 Mohammed Abdulwahhab. All rights reserved.
//

import UIKit

class MealTableViewCell: UITableViewCell {
    
    @IBOutlet weak var bigImage: UIImageView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var mealName: UILabel!
    @IBOutlet weak var mealType: UILabel!
    @IBOutlet weak var mealRating: UILabel!
    @IBOutlet weak var mealTime: UILabel!
    @IBOutlet weak var cookName: UILabel!
    @IBOutlet weak var cookLocation: UILabel!
    
    @IBOutlet weak var backImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
}
