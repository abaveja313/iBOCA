//
//  ResultDigitSpanCell.swift
//  iBOCA
//
//  Created by hdwebsoft on 7/25/19.
//  Copyright © 2019 sunspot. All rights reserved.
//

import UIKit

class ResultDigitSpanCell: UITableViewCell {
    @IBOutlet weak var digitLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    var labelGroup: [UILabel]!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        labelGroup = [digitLabel, resultLabel, timeLabel]
        for label in labelGroup {
            label.font = Font.font(name: Font.Montserrat.medium, size: 18.0)
            label.textColor = Color.color(hexString: "#000000")
            label.addTextSpacing(-0.36)
        }
    }
    
    func bindData(result: Results, row: Int) {
//        if let result = result.json["Details"] as? [String: Any], let item = result[row] as? [Int: Any] {
//        }
    }
}
