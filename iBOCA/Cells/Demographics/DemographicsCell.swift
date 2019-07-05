//
//  DemographicsCell.swift
//  iBOCA
//
//  Created by Macintosh HD on 7/5/19.
//  Copyright © 2019 sunspot. All rights reserved.
//

import UIKit

class DemographicsCell: UICollectionViewCell {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var vSelected: UIView!
    @IBOutlet weak var lblSelected: UILabel!
    @IBOutlet weak var btnSelected: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.setupView()
    }
    
    fileprivate func setupView() {
        self.lblTitle.addTextSpacing(-0.36)
        self.lblTitle.font = Font.font(name: Font.Montserrat.medium, size: 16.0)
        self.lblTitle.textColor = Color.color(hexString: "#8A9199")
        
        self.vSelected.layer.cornerRadius = 5.0
        self.vSelected.layer.borderWidth = 1.0
        self.vSelected.layer.borderColor = Color.color(hexString: "#EAEAEA").cgColor
        
        self.lblSelected.addTextSpacing(-0.36)
        self.lblSelected.font = Font.font(name: Font.Montserrat.medium, size: 18.0)
        self.lblSelected.textColor = .black
    }
    
    @IBAction func btnSelectedTapped(_ sender: Any) {
        
    }
    
}
