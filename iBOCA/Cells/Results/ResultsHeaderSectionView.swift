//
//  ResultsHeaderSectionView.swift
//  iBOCA
//
//  Created by Dat Huynh on 7/8/19.
//  Copyright © 2019 sunspot. All rights reserved.
//

import UIKit

protocol ResultsHeaderSectionViewDelegate: class {
    
    func resultsHeaderSectionView(didExpand expand: Bool, at section: Int, sender: ResultsHeaderSectionView)
}

class ResultsHeaderSectionView: UITableViewHeaderFooterView {

    @IBOutlet weak var lbTestName: UILabel!
    @IBOutlet weak var lbTime: UILabel!
    @IBOutlet weak var lbRound: UILabel!
    @IBOutlet weak var lbNumOfErrors: UILabel!
    @IBOutlet weak var lbNumOfCorrects: UILabel!
    @IBOutlet weak var btnExpand: UIButton!
    
    weak var delegate: ResultsHeaderSectionViewDelegate?
    private var section: Int?
    private var isCollapse: Bool = true {
        didSet {
            if isCollapse {
                btnExpand.setImage(UIImage.init(named: "ic_triangle_down"), for: .normal)
            }
            else {
                btnExpand.setImage(UIImage.init(named: "ic_triangle_up"), for: .normal)
            }
        }
    }
    private var results: Results? {
        didSet {
            guard let results = results else {return}
            isCollapse      = results.collapsed
            lbTestName.text = results.name ?? ""
            lbTime.text     = results.elapsedTime
            lbRound.text    = results.numOfRounds
            lbNumOfErrors.text      = results.numOfErrors
            lbNumOfCorrects.text    = results.numOfCorrects
        }
    }
    
    override func awakeFromNib() {
        configureUI()
    }
    
    private func configureUI() {
        lbTestName.font = Font.font(name: Font.Montserrat.medium, size: 18)
        lbTime.font     = lbTestName.font
        lbRound.font    = lbTestName.font
        lbNumOfErrors.font      = lbTestName.font
        lbNumOfCorrects.font    = lbTestName.font
        lbTestName.text = ""
        lbTime.text     = ""
        lbRound.text    = ""
        lbNumOfErrors.text      = ""
        lbNumOfCorrects.text    = ""
    }
    
    func bindData(result: Results, section: Int) {
        self.results = result
        self.section = section
    }
    
    @IBAction func ibaExpand(_ sender: Any) {
        isCollapse = !isCollapse
        delegate?.resultsHeaderSectionView(didExpand: !isCollapse, at: section!, sender: self)
    }
    
}
