//
//  CellCategory.swift
//  MyStore
//
//  Created by Developer on 13/3/17.
//  Copyright © 2017 Developer. All rights reserved.
//

import UIKit

class CellCategory: UITableViewCell {

    @IBOutlet weak var imgCAtegory: UIImageView!
    
    @IBOutlet weak var lblCategoryName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
