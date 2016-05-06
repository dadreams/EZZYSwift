//
//  EZZYCarListTableViewCell.swift
//  EZZYSwift
//
//  Created by 彭懂 on 16/5/6.
//  Copyright © 2016年 彭懂. All rights reserved.
//

import UIKit

class EZZYCarListTableViewCell: UITableViewCell {

    @IBOutlet weak var carNo: UILabel!
    @IBOutlet weak var carDetail: UILabel!
    @IBOutlet weak var carMelige: UILabel!
    @IBOutlet weak var powerImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
