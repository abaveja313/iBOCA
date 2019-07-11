//
//  ResultsHeaderView.swift
//  iBOCA
//
//  Created by Dat Huynh on 7/8/19.
//  Copyright © 2019 sunspot. All rights reserved.
//

import UIKit

class ResultsHeaderView: UIView {

    static let identifierString: String = "ResultsHeaderView"
    
    @IBOutlet weak var lbTestName: UILabel!
    @IBOutlet weak var lbTime: UILabel!
    @IBOutlet weak var lbRounds: UILabel!
    @IBOutlet weak var lbResults: UILabel!
    
    override func awakeFromNib() {
        configureUI()
    }
    
    private func configureUI() {
        lbTestName.font = Font.font(name: Font.Montserrat.semiBold, size: 18)
        lbTime.font     = lbTestName.font
        lbRounds.font   = lbTestName.font
        lbResults.font  = lbTestName.font
    }

}
