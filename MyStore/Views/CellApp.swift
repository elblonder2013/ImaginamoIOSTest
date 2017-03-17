//
//  CellApp.swift
//  MyStore
//
//  Created by Developer on 13/3/17.
//  Copyright © 2017 Developer. All rights reserved.
//

import UIKit

class CellApp: UITableViewCell {

    @IBOutlet weak var imgApp: UIImageView!
    
    @IBOutlet weak var lblTitleApp: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
