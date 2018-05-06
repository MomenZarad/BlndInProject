//
//  postsTableViewCell.swift
//  blndIn
//
//  Created by Zyad Galal on 4/16/18.
//  Copyright © 2018 Zyad Galal. All rights reserved.
//

import UIKit

class postsTableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var commentContainer: UIView!
    @IBOutlet weak var likeBtn: UIButton!
    @IBOutlet weak var commentBtn: UIButton!
    @IBOutlet weak var hangoutBtn: UIButton!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userLocation: UILabel!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var backgroud: UIImageView!
    @IBOutlet weak var userDescription: UILabel!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
