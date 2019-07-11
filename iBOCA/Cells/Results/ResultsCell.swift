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
    }
    
    private var status: ResultStatus? {
        didSet {
            guard let status = status else {return}
            switch status {
            case .error:
                lbStatus.text   = ResultStatus.error.rawValue.capitalized
                statusContainer.backgroundColor = Color.color(hexString: "FFE7E2")
                break
            case .correct:
                lbStatus.text   = ResultStatus.correct.rawValue.capitalized
                statusContainer.backgroundColor = Color.color(hexString: "69C394").withAlphaComponent(0.18)
                break
            }
        }
    }
    private var row: Int?
    private var result: Results? {
        didSet {
            guard let result = result, let row = row else {return}
            imgResultImage.image = result.screenshot[row]
            
            guard let imageName = result.originalImages?[row] else {return}
            imgOriginalImage.image = UIImage.init(named: imageName)
            if let dic = result.json[imageName] as? [String: Any], let isCorrect = dic[ResultStatus.correct.rawValue] as? Bool {
                status = isCorrect ? .correct : .error
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
