//
//  RecieverTableViewCell.swift
//  blndIn
//
//  Created by Zyad Galal on 5/6/18.
//  Copyright © 2018 Zyad Galal. All rights reserved.
//

import UIKit

class RecieverTableViewCell: UITableViewCell {

    @IBOutlet weak var RecieverMessageBody: UILabel!
    @IBOutlet weak var UsernameLabel: UILabel!
    @IBOutlet weak var RecieverAvatar: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
