//
//  SMCell.swift
//  iBOCA
//
//  Created by hd on 5/9/19.
//  Copyright © 2019 sunspot. All rights reserved.
//

import UIKit

class SMCell: UITableViewCell {

    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        textField.placeholder = "Please enter value!"
        self.selectionStyle = .none
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
