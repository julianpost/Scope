//
//  StationCell.swift
//  Scope
//
//  Created by Julian Post on 1/25/17.
//  Copyright © 2017 Julian Post. All rights reserved.
//

import UIKit

class StationCell: UITableViewCell {

    static let reuseIdentifier = "StationCell"
    
    // MARK: -
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var iDLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
