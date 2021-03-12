//
//  CustomLeaderboardCell.swift
//  pokeDash
//
//  Created by Prism Student on 2020-04-16.
//  Copyright © 2020 Pranav Patel. All rights reserved.
//

import UIKit

class CustomLeaderboardCell: UITableViewCell{

    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var secondsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
