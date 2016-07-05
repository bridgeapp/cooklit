//
//  ReviewTableViewCell.swift
//  CookLit
//
//  Created by Mohammed Abdulwahhab on 7/3/16.
//  Copyright © 2016 Mohammed Abdulwahhab. All rights reserved.
//

import UIKit

class ReviewTableViewCell: UITableViewCell {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var comment: UITextView!
    @IBOutlet weak var rating: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
