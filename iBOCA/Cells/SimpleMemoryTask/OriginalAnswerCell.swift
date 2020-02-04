//
//  OriginalAnswerCell.swift
//  iBOCA
//
//  Created by Hoàng Hiệp Lê on 2/4/20.
//  Copyright © 2020 sunspot. All rights reserved.
//

import UIKit

class OriginalAnswerCell: UITableViewCell {
    static let identifier = "OriginalAnswerCell"
    @IBOutlet weak var originalAnswerLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(name: String) {
        self.originalAnswerLabel.text = name
    }
}
