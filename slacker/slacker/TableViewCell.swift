//
//  TableViewCell.swift
//  slacker
//
//  Created by Kevin Tran on 2/28/18.
//  Copyright © 2018 ateamhasnoname. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var workoutTitle: UILabel!
    @IBOutlet weak var workoutDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
