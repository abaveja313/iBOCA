//
//  SimpleMemoryCell.swift
//  iBOCA
//
//  Created by Macintosh HD on 7/1/19.
//  Copyright © 2019 sunspot. All rights reserved.
//

import UIKit

class SimpleMemoryCell: UICollectionViewCell {

    @IBOutlet weak var buttonsStackView: UIStackView!
    @IBOutlet weak var vContents: UIView!
    @IBOutlet weak var tfObjectName: UITextField!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var correctButton: UIButton!
    @IBOutlet weak var incorrectButton: UIButton!
    @IBOutlet weak var dontKnowButton: UIButton!
    
    var textDeterminedAdmin = ""
    var showError: (() -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.setupView()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.textDeterminedAdmin = ""
        self.correctButton.setTitleColor(Color.color(hexString: "013AA5"), for: .normal)
        self.incorrectButton.setTitleColor(Color.color(hexString: "505259"), for: .normal)
        self.dontKnowButton.setTitleColor(Color.color(hexString: "013AA5"), for: .normal)
    }
    
    fileprivate func setupView() {
        self.backgroundColor = UIColor.clear
        self.vContents.backgroundColor = UIColor.clear
        
        self.correctButton.layer.cornerRadius = 5
        self.incorrectButton.layer.cornerRadius = 5
        self.dontKnowButton.layer.cornerRadius = 5
        
        self.lblTitle.font = Font.font(name: Font.Montserrat.medium, size: 16.0)
        self.lblTitle.textColor = Color.color(hexString: "#8A9199")
        self.lblTitle.addTextSpacing(-0.36)
        
        self.tfObjectName.backgroundColor = Color.color(hexString: "#F7F7F7")
        self.tfObjectName.layer.cornerRadius = 5.0
        self.tfObjectName.layer.borderWidth = 1.0
        self.tfObjectName.layer.borderColor = Color.color(hexString: "#EAEAEA").cgColor
        self.tfObjectName.tintColor = UIColor.black
        self.tfObjectName.font = Font.font(name: Font.Montserrat.medium, size: 18.0)
        self.tfObjectName.textColor = UIColor.black
        self.tfObjectName.addLeftTextPadding(11.0)
    }
    
    func configureView(mode: TestMode) {
        self.buttonsStackView.isHidden = mode == .patient
    }
    
    private func shouldHiddenButtons(_ isHidden: Bool) {
        self.buttonsStackView.isHidden = isHidden
    }
    
    @IBAction func actionCorrect(_ sender: Any) {
        if let text = tfObjectName.text, !text.trimmingCharacters(in: .whitespaces).isEmpty {
            self.textDeterminedAdmin = "Correct"
            self.correctButton.setTitleColor(.red, for: .normal)
            self.incorrectButton.setTitleColor(Color.color(hexString: "505259"), for: .normal)
            self.dontKnowButton.setTitleColor(Color.color(hexString: "013AA5"), for: .normal)
        } else {
            self.showError?()
        }
    }
    
    @IBAction func actionIncorrect(_ sender: Any) {
        if let text = tfObjectName.text, !text.trimmingCharacters(in: .whitespaces).isEmpty {
            self.textDeterminedAdmin = "Incorrect"
            self.correctButton.setTitleColor(Color.color(hexString: "013AA5"), for: .normal)
            self.incorrectButton.setTitleColor(.red, for: .normal)
            self.dontKnowButton.setTitleColor(Color.color(hexString: "013AA5"), for: .normal)
        } else {
            self.showError?()
        }
    }
    
    @IBAction func actionDontKnow(_ sender: Any) {
        self.textDeterminedAdmin = "Don't know"
        self.correctButton.setTitleColor(Color.color(hexString: "013AA5"), for: .normal)
        self.incorrectButton.setTitleColor(Color.color(hexString: "505259"), for: .normal)
        self.dontKnowButton.setTitleColor(.red, for: .normal)
    }
}
