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
    
    private var row: Int?
    private var result: Results? {
        didSet {
            guard let result = result, let row = row else {return}
            imgResultImage.image = result.screenshot[row]
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    func bindData(result: Results, row: Int) {
        self.row = row
        self.result = result
    }
    
}
