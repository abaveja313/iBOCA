//
//  GradientButton.swift
//  human-elements
//
//  Created by LiemTran on 5/28/19.
//  Copyright © 2019 Goldfish Code. All rights reserved.
//

// Step by step init GradientButton
// (1) GradientButton.colors
// (2) GradientButton.shadowColor
// (3) GradientButton.setTitleWithFont(title: String, font: UIFont)


import UIKit

@IBDesignable
class GradientButton: BaseButton {
    
    // MARK: - Properties
    fileprivate var graLayer: CAGradientLayer!
    fileprivate var shadowLayer: CAShapeLayer!
    
    /// Set color from, color to
    var colors: [CGColor] = [Color.gradientFrom.cgColor, Color.gradientTo.cgColor]
    
    /// Set color shadow
    var shadowColor: CGColor = Color.gradientShadow.cgColor

    // MARK: - Setup button
    override func setupButton() {
        super.setupButton()
        
        self.setBackgroundColor(UIColor.clear, forState: .normal)
        self.setTitleColor(UIColor.white, for: .normal)
        self.configureGradient()
        self.addObserver(self, forKeyPath: "center", options: NSKeyValueObservingOptions.old, context: nil)
    }
    
    override func setupConstraint() {
        super.setupConstraint()
        
    }
    
    deinit {
        self.removeObserver(self, forKeyPath: "center")
    }
}


// MARK: - Public methods
extension GradientButton {
    
    func setTitleWithFont(title: String, font: UIFont, colors: [CGColor], shadowColor: CGColor) {
        self.setTitle(title, for: .normal)
        self.titleLabel?.font = font
        self.colors = colors
        self.shadowColor = shadowColor
        self.graLayer.removeFromSuperlayer()
        self.shadowLayer.removeFromSuperlayer()
        self.configureGradient()
    }
}


// MARK: - Private methods
extension GradientButton {
    
    fileprivate func configureGradient() {
        self.graLayer = Gradient.getHorizontalGradient(withColors: [self.colors[0], self.colors[1]], frame: CGRect.init(x: 0, y: 0, width: frame.width, height: frame.height))
        
        self.graLayer.cornerRadius = 8
        self.layer.addSublayer(self.graLayer)
        
        self.shadowLayer = CAShapeLayer()
        
        self.shadowLayer.path = UIBezierPath(roundedRect: self.bounds, cornerRadius: 8).cgPath
        self.shadowLayer.fillColor = self.shadowColor
        self.shadowLayer.shadowColor = self.shadowColor
        self.shadowLayer.shadowPath = self.shadowLayer.path
        self.shadowLayer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        self.shadowLayer.shadowOpacity = 0.7
        self.shadowLayer.shadowRadius = 5
        
        self.layer.insertSublayer(self.shadowLayer, at: 0)
        
        if let label = self.titleLabel {
            self.bringSubview(toFront: label)
        }
    }
   
    //Apply new frame for gradient layer when self bounds change
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if (object as? GradientButton) != nil {
            if self.shadowLayer != nil && self.graLayer != nil {
                self.graLayer.removeFromSuperlayer()
                self.shadowLayer.removeFromSuperlayer()
                self.configureGradient()
            }
        }
    }
}
