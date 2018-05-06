//
//  PlacesTableViewCell.swift
//  blndIn
//
//  Created by Zyad Galal on 5/6/18.
//  Copyright © 2018 Zyad Galal. All rights reserved.
//

import UIKit

class PlacesTableViewCell: UITableViewCell {

    
    @IBOutlet weak var placesImageView: UIImageView!
    @IBOutlet weak var BachgroundView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
