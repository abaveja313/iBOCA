//
//  VADropDownCell.swift
//  iBOCA
//
//  Created by hdwebsoft on 7/10/19.
//  Copyright © 2019 sunspot. All rights reserved.
//

import UIKit

class VADropDownCell: UITableViewCell {
    static let cellId = "VADropDownCell"
    
    @IBOutlet weak var timeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setupView() {
        timeLabel.font = Font.font(name: Font.Montserrat.medium, size: 18.0)
    }
}
