//
//  BaseButton.swift
//  human-elements
//
//  Created by Son Huynh on 5/27/19.
//  Copyright © 2019 Goldfish Code. All rights reserved.
//

import UIKit

class BaseButton: UIButton {
    
    // MARK: - Properties
    
    
    
    // MARK: - Initializers
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    public convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.updateFrame()
    }
    
    
    // MARK: - Setup button
    open func setupButton() {
        
    }
    
    open func setupConstraint() {
        
    }
}


// MARK: - Private methods
extension BaseButton {
    
    fileprivate func setup() {
        self.setupButton()
        self.setupConstraint()
    }
    
    fileprivate func updateFrame() {
        
    }
}
