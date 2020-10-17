//
//  AppInfoCell.swift
//  wmp-sample
//
//  Created by Yun Ha on 2020/10/17.
//  Copyright © 2020 Yun Ha. All rights reserved.
//

import UIKit

class AppInfoCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var sellerNameLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
