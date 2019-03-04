//
//  WordCell.swift
//  Rimichka
//
//  Created by Alexander on 5.03.19.
//  Copyright © 2019 Yalishanda. All rights reserved.
//

import UIKit

class WordCell : UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: false)
    }
}
