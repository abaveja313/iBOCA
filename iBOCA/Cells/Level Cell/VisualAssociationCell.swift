//
//  VisualAssociationCell.swift
//  iBOCA
//
//  Created by hdwebsoft on 7/1/19.
//  Copyright © 2019 sunspot. All rights reserved.
//

import UIKit

class VisualAssociationCell: UICollectionViewCell {

    @IBOutlet weak var vContents: UIView!
    @IBOutlet weak var ivLevel: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.setupView()
    }
    
    fileprivate func setupView() {
        // Shadow cell
        self.layer.cornerRadius = 8.0
        self.layer.shadowColor = Color.color(hexString: "#649BFF").withAlphaComponent(0.32).cgColor
        self.layer.shadowOpacity = 1.0
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowRadius = 10 / 2.0
        self.layer.shadowPath = nil
        self.layer.masksToBounds = false
        
        // View Contents
        self.vContents.clipsToBounds = true
        self.vContents.backgroundColor = UIColor.white
        self.vContents.layer.cornerRadius = 8.0
        
        // Label title
        self.lblTitle.font = Font.font(name: Font.Montserrat.semiBold, size: 18.0)
        self.lblTitle.addTextSpacing(-0.36)
        self.lblTitle.backgroundColor = Color.color(hexString: "#649BFF")
    }
}
