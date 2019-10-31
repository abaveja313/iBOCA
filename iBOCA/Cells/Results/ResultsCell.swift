//
//  ResultsCell.swift
//  iBOCA
//
//  Created by Dat Huynh on 7/8/19.
//  Copyright © 2019 sunspot. All rights reserved.
//

import UIKit

class ResultsCell: UITableViewCell {

    static let cellIdentifier: String = "ResultsCell"
    
    @IBOutlet weak var imgOriginalImage: UIImageView!
    @IBOutlet weak var imgResultImage: UIImageView!
    @IBOutlet weak var lbStatus: UILabel!
    @IBOutlet weak var statusContainer: UIView!
    
    private enum ResultStatus: String {
        case error      = "error"
        case correct    = "correct"
        case noInformation
    }
    
    private var status: ResultStatus? {
        didSet {
            guard let status = status else {return}
            switch status {
            case .error:
                lbStatus.font = Font.font(name: Font.Montserrat.medium, size: 15.0)
                lbStatus.text   = ResultStatus.error.rawValue.capitalized
                lbStatus.textColor = Color.color(hexString: "#FF5430")
                statusContainer.backgroundColor = Color.color(hexString: "FFE7E2")
            case .correct:
                lbStatus.font = Font.font(name: Font.Montserrat.medium, size: 15.0)
                lbStatus.text   = ResultStatus.correct.rawValue.capitalized
                lbStatus.textColor = Color.color(hexString: "#46A573")
                statusContainer.backgroundColor = Color.color(hexString: "69C394").withAlphaComponent(0.18)
            case .noInformation:
                lbStatus.isHidden = true
                statusContainer.isHidden = true
            }
        }
    }
    
    private var row: Int?
    private var result: Results? {
        didSet {
            guard let result = result, let row = row else {return}
            imgResultImage.image = result.screenshot[row]
            imgOriginalImage.image = UIImage.init(named: result.originalImages[row])
            if let dic = result.json[result.originalImages[row]] as? [String: Any], let isCorrect = dic[ResultStatus.correct.rawValue] as? Bool {
                status = isCorrect ? .correct : .error
            } else {
                status = .noInformation
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }

    private func configureUI() {
        lbStatus.font   = Font.font(name: Font.Montserrat.medium, size: 15)
        statusContainer.layer.cornerRadius = 5
    }
    
    func bindData(result: Results, row: Int) {
        self.row = row
        self.result = result
    }
    
}
