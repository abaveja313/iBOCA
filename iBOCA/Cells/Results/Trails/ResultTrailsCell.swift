//
//  ResultTrailsCell.swift
//  iBOCA
//
//  Created by Macintosh HD on 7/25/19.
//  Copyright © 2019 sunspot. All rights reserved.
//

import UIKit

class ResultTrailsCell: UITableViewCell {

    @IBOutlet weak var lblTitleTrails: UILabel!
    @IBOutlet weak var lblDescCorrect: UILabel!
    
    @IBOutlet weak var lblDescIncorrect: UILabel!
    
    @IBOutlet weak var ivTrails: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.setupView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    fileprivate func setupView() {
        self.lblTitleTrails.font = Font.font(name: Font.Montserrat.medium, size: 18.0)
        self.lblTitleTrails.addTextSpacing(-0.36)
        
        self.lblDescCorrect.font = Font.font(name: Font.Montserrat.medium, size: 18.0)
        self.lblDescCorrect.numberOfLines = 0
        self.lblDescCorrect.addTextSpacing(-0.36)
        
        self.lblDescIncorrect.font = Font.font(name: Font.Montserrat.medium, size: 18.0)
        self.lblDescIncorrect.numberOfLines = 0
        self.lblDescIncorrect.addTextSpacing(-0.36)
        
        self.ivTrails.contentMode = .scaleAspectFit
        
        lblTitleTrails.text = ""
        lblDescCorrect.text = ""
        lblDescIncorrect.text = ""
    }
    
}

extension ResultTrailsCell {
    func configResult(result: Results) {
        if let name = result.json["Name"] as? String, let descCorrect = result.longDescription[2] as? String, let descIncorrect = result.longDescription[3] as? String, let imageTrails = result.screenshot.first {
            
            self.lblTitleTrails.text = name
            self.lblDescCorrect.text = descCorrect
            self.lblDescCorrect.addLineSpacing(10.0)
            self.lblDescIncorrect.text = descIncorrect
            self.lblDescIncorrect.addLineSpacing(10.0)
            self.ivTrails.image = imageTrails
        }
    }
}
