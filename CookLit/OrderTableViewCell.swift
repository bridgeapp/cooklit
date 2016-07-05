//
//  OrderTableViewCell.swift
//  CookLit
//
//  Created by Mohammed Abdulwahhab on 7/3/16.
//  Copyright © 2016 Mohammed Abdulwahhab. All rights reserved.
//

import UIKit

class OrderTableViewCell: UITableViewCell {
    
    @IBOutlet weak var orderImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var orderLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    

}
