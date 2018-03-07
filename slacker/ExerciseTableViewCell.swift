//
//  ExerciseTableViewCell.swift
//  slacker
//
//  Created by Kevin Tran on 3/2/18.
//  Copyright © 2018 ateamhasnoname. All rights reserved.
//

import UIKit

class ExerciseTableViewCell: UITableViewCell {

    
    @IBOutlet weak var exerciseInfo: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
