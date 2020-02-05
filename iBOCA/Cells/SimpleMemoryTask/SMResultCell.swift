//
//  SMResultCell.swift
//  iBOCA
//
//  Created by Macintosh HD on 7/1/19.
//  Copyright © 2019 sunspot. All rights reserved.
//

import UIKit

class SMResultModel: NSObject {
    var objectName: String?
    var input: String?
    var exactResult: String?
    var result: Bool?
    var adminDetermine: String?
    
    override init() {
        super.init()
    }
    
    init(objectName: String, input: String, exactResult: String, result: Bool) {
        super.init()
        self.objectName = objectName
        self.input = input
        self.exactResult = exactResult
        self.result = result
    }
    
    init(objectName: String, input: String, exactResult: String, adminDetermine: String) {
        super.init()
        self.objectName = objectName
        self.input = input
        self.exactResult = exactResult
        self.adminDetermine = adminDetermine
    }
}

class SMResultCell: UITableViewCell {

    @IBOutlet weak var vObjectName: UIView!
    @IBOutlet weak var lblObjectName: UILabel!
    @IBOutlet weak var lblInput: UILabel!
    @IBOutlet weak var lblExactResult: UILabel!
    @IBOutlet weak var lblResult: UILabel!
    
    @IBOutlet var arrayConstraintLineBottom: [NSLayoutConstraint]!
    
    var isHeader: Bool = false {
        didSet {
            self.setupView()
        }
    }
    
    var model: SMResultModel? {
        didSet {
            if self.isHeader == false,
                let resultObj = model,
                let objName = resultObj.objectName,
                let input = resultObj.input,
                let exactResult = resultObj.exactResult {
                // Set Data to UI
                self.lblObjectName.text = objName
                self.lblInput.text = input
                self.lblExactResult.text = exactResult
                if let result = resultObj.result {
                    self.lblResult.textColor = Color.color(hexString: result ? "#013AA5" : "#E94533")
                    self.lblResult.text = result ? "Correct" : "Incorrect"
                }
                
                if let adminDetermine = resultObj.adminDetermine {
                    self.lblResult.textColor = Color.color(hexString: adminDetermine == "Correct" ? "#013AA5" : ( adminDetermine == "Incorrect" ? "#E94533" : "505259"))
                    self.lblResult.text = adminDetermine
                }
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.setupView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupView() {
        if self.isHeader == true {
            self.setupViewHeader()
        }
        else {
            self.setupViewContents()
        }
    }
    
    fileprivate func setupViewHeader() {
        self.lblObjectName.text = ""
        self.lblInput.text = "Input"
        self.lblExactResult.text = "Exact Results"
        self.lblResult.text = "Results"
        
        self.vObjectName.backgroundColor = Color.color(hexString: "#649BFF")
        self.lblObjectName.backgroundColor = UIColor.clear
        self.lblInput.backgroundColor = Color.color(hexString: "#649BFF")
        self.lblExactResult.backgroundColor = Color.color(hexString: "#649BFF")
        self.lblResult.backgroundColor = Color.color(hexString: "#649BFF")
        
        self.lblObjectName.font = Font.font(name: Font.Montserrat.semiBold, size: 18.0)
        self.lblInput.font = Font.font(name: Font.Montserrat.semiBold, size: 18.0)
        self.lblExactResult.font = Font.font(name: Font.Montserrat.semiBold, size: 18.0)
        self.lblResult.font = Font.font(name: Font.Montserrat.semiBold, size: 18.0)
        
        self.lblObjectName.addTextSpacing(-0.36)
        self.lblInput.addTextSpacing(-0.36)
        self.lblExactResult.addTextSpacing(-0.36)
        self.lblResult.addTextSpacing(-0.36)
        
        self.lblObjectName.textColor = UIColor.white
        self.lblInput.textColor = UIColor.white
        self.lblExactResult.textColor = UIColor.white
        self.lblResult.textColor = UIColor.white
    }
    
    fileprivate func setupViewContents() {
        self.lblObjectName.text = ""
        self.lblInput.text = ""
        self.lblExactResult.text = ""
        self.lblResult.text = ""
        
        self.vObjectName.backgroundColor = UIColor.white
        self.lblObjectName.backgroundColor = UIColor.clear
        self.lblInput.backgroundColor = UIColor.white
        self.lblExactResult.backgroundColor = UIColor.white
        self.lblResult.backgroundColor = UIColor.white
        
        self.lblObjectName.font = Font.font(name: Font.Montserrat.medium, size: 18.0)
        self.lblInput.font = Font.font(name: Font.Montserrat.medium, size: 18.0)
        self.lblExactResult.font = Font.font(name: Font.Montserrat.medium, size: 18.0)
        self.lblResult.font = Font.font(name: Font.Montserrat.medium, size: 18.0)
        
        self.lblObjectName.addTextSpacing(-0.36)
        self.lblInput.addTextSpacing(-0.36)
        self.lblExactResult.addTextSpacing(-0.36)
        self.lblResult.addTextSpacing(-0.36)
        
        self.lblObjectName.textColor = UIColor.black
        self.lblInput.textColor = UIColor.black
        self.lblExactResult.textColor = UIColor.black
        self.lblResult.textColor = Color.color(hexString: "#013AA5")
        
    }
}
