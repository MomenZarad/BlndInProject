//
//  HangoutsInvititionsTableViewCell.swift
//  blndIn
//
//  Created by Zyad Galal on 4/28/18.
//  Copyright © 2018 Zyad Galal. All rights reserved.
//

import UIKit

class HangoutsInvititionsTableViewCell: UITableViewCell {

    @IBOutlet weak var userPic: UIImageView!
    @IBOutlet weak var invititionText: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func commoninit(_ imagename :String , text :String)
    {
        userPic.image = UIImage(named: imagename)
        invititionText.text = text
    }
}
