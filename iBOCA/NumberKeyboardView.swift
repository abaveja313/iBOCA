//
//  NumberKeyboardView.swift
//  iBOCA
//
//  Created by hdwebsoft on 7/4/19.
//  Copyright © 2019 sunspot. All rights reserved.
//

import UIKit

protocol NumberKeyboardViewDelegate {
    func didNumberPressed(_ text: String)
    func didEnterPressed()
    func didDeletePressed()
}

class NumberKeyboardView: UIView {
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var oneButton: UIButton!
    @IBOutlet weak var twoButton: UIButton!
    @IBOutlet weak var threeButton: UIButton!
    @IBOutlet weak var fourButton: UIButton!
    @IBOutlet weak var fiveButton: UIButton!
    @IBOutlet weak var sixButton: UIButton!
    @IBOutlet weak var sevenButton: UIButton!
    @IBOutlet weak var eightButton: UIButton!
    @IBOutlet weak var nineButton: UIButton!
    @IBOutlet weak var zeroButton: UIButton!
    @IBOutlet weak var enterButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    fileprivate var buttonGroup: [UIButton]!
    private var buttonWidth: CGFloat!
    private var buttonHeight: CGFloat!
    var delegate: NumberKeyboardViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    private func initialize() {
        Bundle.main.loadNibNamed("NumberKeyboardView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        
        setupButton()
        setFrame()
        setButtonStyleDefault()
    }
    
    private func setupButton() {
        buttonGroup = [oneButton, twoButton, threeButton, fourButton, fiveButton, sixButton, sevenButton, eightButton, nineButton, zeroButton, enterButton, deleteButton]
        for button in buttonGroup {
            button.removeTarget(self, action: nil, for: .allEvents)
            button.addTarget(self, action: #selector(actionPressed), for: .touchUpInside)
        }
    }
    
    private func setFrame() {
        let horizontalMargin: CGFloat = 17.0
        let verticalMargin: CGFloat = 18.58
        buttonWidth = (contentView.frame.width - 2 * horizontalMargin) / 3
        buttonHeight = (contentView.frame.height - 3 * verticalMargin) / 4
        
        oneButton.frame = CGRect(x: contentView.origin.x, y: contentView.origin.y, width: buttonWidth, height: buttonHeight)
        twoButton.frame = CGRect(x: oneButton.frame.width + horizontalMargin, y: contentView.origin.y, width: buttonWidth, height: buttonHeight)
        threeButton.frame = CGRect(x: oneButton.frame.width * 2 + horizontalMargin * 2, y: contentView.origin.y, width: buttonWidth, height: buttonHeight)
        fourButton.frame = CGRect(x: contentView.origin.x, y: oneButton.frame.height + verticalMargin, width: buttonWidth, height: buttonHeight)
        fiveButton.frame = CGRect(x: oneButton.frame.width + horizontalMargin, y: oneButton.frame.height + verticalMargin, width: buttonWidth, height: buttonHeight)
        sixButton.frame = CGRect(x: oneButton.frame.width * 2 + horizontalMargin * 2, y: oneButton.frame.height + verticalMargin, width: buttonWidth, height: buttonHeight)
        sevenButton.frame = CGRect(x: contentView.origin.x, y: oneButton.frame.height * 2 + verticalMargin * 2, width: buttonWidth, height: buttonHeight)
        eightButton.frame = CGRect(x: oneButton.frame.width + horizontalMargin, y: oneButton.frame.height * 2 + verticalMargin * 2, width: buttonWidth, height: buttonHeight)
        nineButton.frame = CGRect(x: oneButton.frame.width * 2 + horizontalMargin * 2, y: oneButton.frame.height * 2 + verticalMargin * 2, width: buttonWidth, height: buttonHeight)
        enterButton.frame = CGRect(x: contentView.origin.x, y: oneButton.frame.height * 3 + verticalMargin * 3, width: buttonWidth, height: buttonHeight)
        zeroButton.frame = CGRect(x: oneButton.frame.width + horizontalMargin, y: oneButton.frame.height * 3 + verticalMargin * 3, width: buttonWidth, height: buttonHeight)
        deleteButton.frame = CGRect(x: oneButton.frame.width * 2 + horizontalMargin * 2, y: oneButton.frame.height * 3 + verticalMargin * 3, width: buttonWidth, height: buttonHeight)
    }
    
    private func setButtonStyleDefault() {
        self.setNumberKeyStyle(font: Font.font(name: Font.Montserrat.semiBold, size: buttonWidth * 0.35),
                               withColor: Color.color(hexString: "#013AA5"),
                               withBackgroundColor: Color.color(hexString: "#E5EFFC"))
        self.setEnterKeyStyle(font: Font.font(name: Font.Montserrat.semiBold, size: buttonHeight * 0.22),
                              withColor: Color.color(hexString: "#FFFFFF"),
                              withBackgroundColor: Color.color(hexString: "#69C394"))
        self.setDeleteKeyStyle(font: Font.font(name: Font.Montserrat.semiBold, size: buttonHeight * 0.22),
                               withColor: Color.color(hexString: "#FFFFFF"),
                               withBackgroundColor: Color.color(hexString: "#FE786A"))
    }
    
    @objc private func actionPressed(button: UIButton) {
        switch button.tag {
        case 10:
            self.delegate?.didNumberPressed("0")
        case 11:
            self.delegate?.didEnterPressed()
        case 12:
            self.delegate?.didDeletePressed()
        default:
            self.delegate?.didNumberPressed("\(button.tag)")
        }
    }
}

// MARK: Public function
extension NumberKeyboardView {
    func setNumberKeyStyle(font: UIFont? = nil, withColor color: UIColor? = nil, withBackgroundColor backgroundColor: UIColor? = nil) {
        for button in buttonGroup.filter({ $0.tag < 11 }) {
            button.titleLabel?.font = font
            button.tintColor = color
            button.backgroundColor = backgroundColor
        }
    }
    
    func setEnterKeyStyle(font: UIFont? = nil, withColor color: UIColor? = nil, withBackgroundColor backgroundColor: UIColor? = nil) {
        if let button = buttonGroup.first(where: { $0.tag == 11 }) {
            button.titleLabel?.font = font
            button.tintColor = color
            button.backgroundColor = backgroundColor
        }
    }
    
    func setDeleteKeyStyle(font: UIFont? = nil, withColor color: UIColor? = nil, withBackgroundColor backgroundColor: UIColor? = nil) {
        if let button = buttonGroup.first(where: { $0.tag == 12 }) {
            button.titleLabel?.font = font
            button.tintColor = color
            button.backgroundColor = backgroundColor
        }
    }
    
    func isEnabled(_ isEnabled: Bool) {
        for button in buttonGroup {
            button.isEnabled = isEnabled
        }
    }
}
