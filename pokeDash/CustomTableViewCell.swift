//
//  CustomTableViewCell.swift
//  pokeDash
//
//  Created by Prism Student on 2020-02-29.
//  Copyright © 2020 Pranav Patel. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell{

    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var pokemonLabel: UILabel!
    @IBOutlet weak var pokemonImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
