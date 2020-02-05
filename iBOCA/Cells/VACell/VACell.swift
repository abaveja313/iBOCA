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
    @IBOutlet weak var containView: UIView!
    
    @IBOutlet weak var testTypeLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var timeView: UIView!
    @IBOutlet weak var resultView: UIView!
    @IBOutlet weak var twxtTypeView: UIView!
    @IBOutlet weak var timeLabelLeading: NSLayoutConstraint!
    @IBOutlet weak var inputLabelLeading: NSLayoutConstraint!
    
    fileprivate var labelGroup: [UILabel]!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        labelGroup = [testTypeLabel, resultLabel, timeLabel]
        containView.backgroundColor = Color.color(hexString: "#EAEAEA")
        
        testTypeLabel.text = ""
        resultLabel.text = ""
        timeLabel.text = ""
    }
}

extension VACell {
    func bindData(result: Results, row: Int) {
        timeLabelLeading.constant = 43.5
        inputLabelLeading.constant = 14
        if let recallList = result.json["Recall"] as? [String: Any], let regconizeList = result.json["Recognize"] as? [String: Any] {
            setupContentCell()
            resultLabel.textAlignment = .left
            timeLabel.textAlignment = .left
            if row < 5 {
                guard let item = recallList[result.imageVA[row]] as? [String: Any] else {return}
                testTypeLabel.text = "Recalled \(result.imageVA[row])"
                resultLabel.text = "\(String(describing: item["Condition"] as! String))"
                timeLabel.text = "\(String(describing: item["Time"] as! Double)) seconds"
            } else {
                testTypeLabel.text = "Recognized \(result.imageVA[row - 5])"
                guard let item = regconizeList[result.imageVA[row - 5]] as? [String: Any], let isCorrect = item["Condition"] as? String else {return}
                if isCorrect == "Correct" {
                    resultLabel.textColor = Color.color(hexString: "#013AA5")
                    resultLabel.text = "Correct"
                } else {
                    resultLabel.textColor = Color.color(hexString: "#E94533")
                    resultLabel.text = "Incorrect"
                }
                timeLabel.text = "\(String(describing: item["Time"] as! Double)) seconds"
            }
        }
    }
    
    
    
    func configRecallTest(imageNameList: [String], resultList: [String], determinedAdminList: [String], timeList: [Double], indexPath: IndexPath) {
        timeLabelLeading.constant = 0
        inputLabelLeading.constant = 0
        if indexPath.row == 0 {
            setupHeaderCell()
            testTypeLabel.text = "Recalled Test"
            resultLabel.text = "Input"
            timeLabel.text = "Times"
        } else {
            setupContentCell()
            testTypeLabel.text = "Recalled \(imageNameList[indexPath.row - 1])"
            // determinedAdmin is Correct | InCorrect | Don't Know
            let determinedAdmin = determinedAdminList.count > 0 ? " (\(determinedAdminList[indexPath.row - 1]))" : ""
            resultLabel.text = "\(resultList[indexPath.row - 1])\(determinedAdmin)"
            
            let recalledTime = String(format:"%.1f", timeList[indexPath.row - 1])
            timeLabel.text = "\(recalledTime) seconds"
        }
    }
    
    func configRegconizedTest(imageNameList: [String], recognizeErrors: [Int], timeList: [Double], indexPath: IndexPath) {
        timeLabelLeading.constant = 0
        inputLabelLeading.constant = 0
        if indexPath.row == 0 {
            setupHeaderCell()
            testTypeLabel.text = "Recognized Test"
            resultLabel.text = "Results"
            timeLabel.text = "Times"
        } else {
            setupContentCell()
            testTypeLabel.text = "Recognized \(imageNameList[indexPath.row - 1])"
            if recognizeErrors[indexPath.row - 1] == 0 {
                resultLabel.textColor = Color.color(hexString: "#013AA5")
                resultLabel.text = "Correct"
            } else {
                resultLabel.textColor = Color.color(hexString: "#E94533")
                resultLabel.text = "Incorrect"
            }
            
            let recognizedTime = String(format:"%.1f", timeList[indexPath.row - 1])
            timeLabel.text = "\(recognizedTime) seconds"
        }
    }
    
    fileprivate func setupHeaderCell() {
        twxtTypeView.backgroundColor = Color.color(hexString: "#649BFF")
        timeView.backgroundColor = Color.color(hexString: "#649BFF")
        resultView.backgroundColor = Color.color(hexString: "#649BFF")
        for label in labelGroup {
            label.font = Font.font(name: Font.Montserrat.semiBold, size: 18.0)
            label.textColor = Color.color(hexString: "#FFFFFF")
            label.addTextSpacing(-0.36)
        }
    }
    
    fileprivate func setupContentCell() {
        twxtTypeView.backgroundColor = Color.color(hexString: "#FFFFFF")
        timeView.backgroundColor = Color.color(hexString: "#FFFFFF")
        resultView.backgroundColor = Color.color(hexString: "#FFFFFF")
        for label in labelGroup {
            label.font = Font.font(name: Font.Montserrat.medium, size: 18.0)
            label.textColor = Color.color(hexString: "#000000")
            label.addTextSpacing(-0.36)
        }
    }
}

enum TestType {
    case recalled
    case recognized
}

