//
//  VACell.swift
//  iBOCA
//
//  Created by hdwebsoft on 7/9/19.
//  Copyright © 2019 sunspot. All rights reserved.
//

import UIKit

class VACell: UITableViewCell {
    static let cellId = "VACell"

    @IBOutlet weak var testTypeLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var twxtTypeView: UIView!
    
    fileprivate var labelGroup: [UILabel]!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        labelGroup = [testTypeLabel, resultLabel, timeLabel]
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

extension VACell {
    func config(testType: TestType!, imageNameList: [String], resultList: [String], timeList: [Double], indexPath: IndexPath) {
        labelGroup = [testTypeLabel, resultLabel, timeLabel]
        if testType == .recalled {
            if indexPath.row == 0 {
                setupHeaderCell()
                testTypeLabel.text = "Recalled Test"
                resultLabel.text = "Input"
                timeLabel.text = "Times"
            } else {
                setupContentCell()
                testTypeLabel.text = "Recalled \(imageNameList[indexPath.row - 1])"
                resultLabel.text = "\(resultList[indexPath.row - 1])"
                timeLabel.text = "\(timeList[indexPath.row - 1]) seconds"
            }
        } else {
            if indexPath.row == 0 {
                setupHeaderCell()
                testTypeLabel.text = "Recognized Test"
                resultLabel.text = "Results"
                timeLabel.text = "Times"
            } else {
                setupContentCell()
                testTypeLabel.text = "Recognized \(imageNameList[indexPath.row - 1])"
                resultLabel.text = "\(resultList[indexPath.row - 1])"
                timeLabel.text = "\(timeList[indexPath.row - 1]) seconds"
            }
        }
    }
    
    func configRecallTest(imageNameList: [String], resultList: [String], timeList: [Double], indexPath: IndexPath) {
        if indexPath.row == 0 {
            setupHeaderCell()
            testTypeLabel.text = "Recalled Test"
            resultLabel.text = "Input"
            timeLabel.text = "Times"
        } else {
            setupContentCell()
            testTypeLabel.text = "Recalled \(imageNameList[indexPath.row - 1])"
            resultLabel.text = "\(resultList[indexPath.row - 1])"
            timeLabel.text = "\(timeList[indexPath.row - 1]) seconds"
        }
    }
    
    func configRegconizedTest(imageNameList: [String], recognizeErrors: [Int], timeList: [Double], indexPath: IndexPath) {
        if indexPath.row == 0 {
            setupHeaderCell()
            testTypeLabel.text = "Recognized Test"
            resultLabel.text = "Results"
            timeLabel.text = "Times"
        } else {
            setupContentCell()
            testTypeLabel.text = "Recognized \(imageNameList[indexPath.row - 1])"
            if recognizeErrors[indexPath.row - 1] == 0 {
                resultLabel.textColor = Color.color(hexString: "#E94533")
                resultLabel.text = "Correct"
            } else {
                resultLabel.textColor = Color.color(hexString: "#013AA5")
                resultLabel.text = "Incorrect"
            }
            timeLabel.text = "\(timeList[indexPath.row - 1]) seconds"
        }
    }
    
    fileprivate func setupHeaderCell() {
        twxtTypeView.backgroundColor = Color.color(hexString: "#649BFF")
        for label in labelGroup {
            label.font = Font.font(name: Font.Montserrat.semiBold, size: 18.0)
            label.textColor = Color.color(hexString: "#FFFFFF")
            label.backgroundColor = Color.color(hexString: "#649BFF")
            label.addTextSpacing(-0.36)
        }
    }
    
    fileprivate func setupContentCell() {
        twxtTypeView.backgroundColor = Color.color(hexString: "#FFFFFF")
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

