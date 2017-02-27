//
//  UserDetailCell.swift
//  UserDetails
//
//  Created by Appinventiv on 24/02/17.
//  Copyright © 2017 Appinventiv. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
// MARK: IBOutlets
    
    @IBOutlet weak var detailLabel: UILabel!
    
    @IBOutlet weak var detailTField: UITextField!

// MARK: UserDetailsCell Lif Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
