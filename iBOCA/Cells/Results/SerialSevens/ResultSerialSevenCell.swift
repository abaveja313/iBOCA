//
//  ResultSerialSevenCell.swift
//  iBOCA
//
//  Created by hdwebsoft on 7/25/19.
//  Copyright © 2019 sunspot. All rights reserved.
//

import UIKit

class ResultSerialSevenCell: UITableViewCell {

    static let cellId = "ResultSerialSevenCell"
    @IBOutlet weak var enteredLabel: UILabel!
    @IBOutlet weak var subtractLabel: UILabel!
    @IBOutlet weak var sequenceLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    var labelGroup: [UILabel]!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        labelGroup = [enteredLabel, subtractLabel, sequenceLabel, timeLabel]
        for label in labelGroup {
            label.font = Font.font(name: Font.Montserrat.medium, size: 18.0)
            label.textColor = Color.color(hexString: "#000000")
            label.addTextSpacing(-0.36)
        }
        
        enteredLabel.text = ""
        subtractLabel.text = ""
        sequenceLabel.text = ""
        timeLabel.text = ""
    }
    
    func bindData(result: Results, row: Int) {
        if let result = result.json["Results"] as? [Int: Any],
            let item = result[row - 1] as? [String: Any],
            let entered = item["Entered"] as? Int,
            let subtract =  item["Subtract 7"] as? Int,
            let time = item["time (msec)"] as? Int {
            enteredLabel.text = "\(row - 1).  \(entered)"
            subtractLabel.text = "Subject 7 - \(subtract)"
            sequenceLabel.text = ""//"Sequence 7 - \(item["Sequence 7"] as! Int)"
            timeLabel.text = "\(time) msec"
        }
    }
}
