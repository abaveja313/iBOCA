//
//  ResultDetailCell.swift
//  iBOCA
//
//  Created by Dat Huynh on 7/11/19.
//  Copyright © 2019 sunspot. All rights reserved.
//

import UIKit

class ResultDetailCell: UITableViewCell {
    
    @IBOutlet weak var lbDescription: UILabel!
    
    private var row: Int?
    private var result: Results? {
        didSet {
            guard let result = result, let row = row else {return}
            if result.longDescription.count > 0 {
                lbDescription.text = result.longDescription[row] as? String
            }
            else {
                lbDescription.text = result.shortDescription
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }

    private func configureUI() {
        lbDescription.font = Font.font(name: Font.Montserrat.regular, size: 18)
    }
    
    func bindData(result: Results, row: Int) {
        self.row    = row
        self.result = result
    }
    
}
