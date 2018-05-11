//
//  HangTableViewCell.swift
//  blndIn
//
//  Created by Zyad Galal on 4/17/18.
//  Copyright © 2018 Zyad Galal. All rights reserved.
//

import UIKit

class HangTableViewCell: UITableViewCell {

    @IBOutlet weak var hangBackground: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var userLocation: UILabel!
    @IBOutlet weak var createdAt: UILabel!
    @IBOutlet weak var hangUIview: UIView!
    @IBOutlet weak var secondUIView: UIView!
    @IBOutlet weak var ViewBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
