//
//  VACell.swift
//  iBOCA
//
//  Created by hdwebsoft on 7/9/19.
//  Copyright © 2019 sunspot. All rights reserved.
//

import UIKit

class VACell: UITableViewCell {

    @IBOutlet weak var testTypeLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    fileprivate var labelGroup: [UILabel]!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

extension VACell {
    func configCell(testType: TestType!, imageNameList: [String], resultList: [String], timeList: [String], indexPath: IndexPath) {
        labelGroup = [testTypeLabel, resultLabel, timeLabel]
        
        if testType == .recalled {
            if indexPath.row == 0 {
                setupHeaderCell()
                testTypeLabel.text = "Recalled Test"
                resultLabel.text = "Input"
                timeLabel.text = "Times"
            } else {
                setupContentCell()
                testTypeLabel.text = "Recalled \(imageNameList[indexPath.row])"
                resultLabel.text = "\(resultList[indexPath.row])"
                timeLabel.text = "\(timeList[indexPath.row]) seconds"
            }
        } else {
            if indexPath.row == 0 {
                setupHeaderCell()
                testTypeLabel.text = "Recognized Test"
                resultLabel.text = "Results"
                timeLabel.text = "Times"
            } else {
                setupContentCell()
                testTypeLabel.text = "Recognized \(imageNameList[indexPath.row])"
                resultLabel.text = "\(resultList[indexPath.row])"
                timeLabel.text = "\(timeList[indexPath.row]) seconds"
            }
        }
    }
    
    fileprivate func setupHeaderCell() {
        for label in labelGroup {
            label.font = Font.font(name: Font.Montserrat.semiBold, size: 18.0)
            label.textColor = Color.color(hexString: "#FFFFFF")
            label.backgroundColor = Color.color(hexString: "#649BFF")
            label.addTextSpacing(-0.36)
        }
    }
    
    fileprivate func setupContentCell() {
        for label in labelGroup {
            label.font = Font.font(name: Font.Montserrat.medium, size: 18.0)
            label.textColor = Color.color(hexString: "#000000")
            label.backgroundColor = Color.color(hexString: "#FFFFFF")
            label.addTextSpacing(-0.36)
        }
    }
}

enum TestType {
    case recalled
    case recognized
}

