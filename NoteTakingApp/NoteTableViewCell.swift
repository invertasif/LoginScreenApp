//
//  NoteTableViewCell.swift
//  NoteTakingApp
//
//  Created by Fariha Binte Mahmud on 3/23/17.
//  Copyright © 2017 bcc. All rights reserved.
//

import UIKit

class NoteTableViewCell: UITableViewCell {
    @IBOutlet weak var messageCell: UILabel!

    @IBOutlet weak var checkMarkLabel: UILabel!
    
    @IBOutlet weak var title: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
