//
//  DemographicsCell.swift
//  iBOCA
//
//  Created by Macintosh HD on 7/5/19.
//  Copyright © 2019 sunspot. All rights reserved.
//

import UIKit

enum DemoGraphicsCellStyle{
    case PaientIDNumber
    case Ethnicity
    case Gender
    case Race
    case Age
    case PatientUID
    case Education
    case Protocols
}

protocol DemoGraphicsCellDelegate: class {
    func showDropDown(indexPath: IndexPath, style: DemoGraphicsCellStyle)
}

class DemographicsCell: UICollectionViewCell {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var vSelected: UIView!
    @IBOutlet weak var lblSelected: UILabel!
    
    @IBOutlet weak var textField: UITextField!
    
    var style: DemoGraphicsCellStyle?
    var indexPath: IndexPath?
    
    weak var delegate: DemoGraphicsCellDelegate?
    
    override var isSelected: Bool {
        didSet {
            if let style = self.style {
                if style == .PaientIDNumber || style == .PatientUID { }
                else {
                    if isSelected == true {
                        self.vSelected.layer.borderColor = Color.color(hexString: "#649BFF").cgColor
                    }
                    else {
                        self.vSelected.layer.borderColor = Color.color(hexString: "#EAEAEA").cgColor
                    }
                    
                    if let style = self.style, let indexPath = self.indexPath {
                        self.delegate?.showDropDown(indexPath: indexPath, style: style)
                    }
                }
            }
        }
    }
    
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
        
        self.textField.layer.cornerRadius = 5.0
        self.textField.layer.borderWidth = 1.0
        self.textField.layer.borderColor = Color.color(hexString: "#EAEAEA").cgColor
        self.textField.backgroundColor = Color.color(hexString: "#F7F7F7")
        self.textField.textColor = UIColor.black
        self.textField.tintColor = UIColor.black
        self.textField.addLeftTextPadding(11.0)
        self.textField.font = Font.font(name: Font.Montserrat.medium, size: 18.0)
    }
    
    func bindData(style: DemoGraphicsCellStyle, value: String) {
        self.style = style
        if style == .PaientIDNumber || style == .PatientUID {
            self.vSelected.isHidden = true
            self.textField.isHidden = false
            self.textField.text = value
        }
        else {
            self.vSelected.isHidden = false
            self.textField.isHidden = true
            self.lblSelected.text = value
        }
        
        if style == .PaientIDNumber {
            self.lblTitle.text = "Paient ID Number"
        }
        else if style == .Ethnicity {
            self.lblTitle.text = "Ethnicity"
        }
        else if style == .Gender {
            self.lblTitle.text = "Gender"
        }
        else if style == .Race {
            self.lblTitle.text = "Race"
        }
        else if style == .Age {
            self.lblTitle.text = "Age"
        }
        else if style == .PatientUID {
            self.lblTitle.text = "PatientUID"
        }
        else if style == .Education {
            self.lblTitle.text = "Education"
        }
        else {
            self.lblTitle.text = "Protocol"
        }
    }
}
