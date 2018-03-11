//
//  StopwatchTableViewCell.swift
//  slacker
//
//  Created by Kevin Tran on 3/8/18.
//  Copyright © 2018 ateamhasnoname. All rights reserved.
//

import UIKit

class StopwatchTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lapNumber: UILabel!
    @IBOutlet weak var overallTime: UILabel!
    @IBOutlet weak var lapTime: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
