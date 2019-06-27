//
//  GradientButton.swift
//  human-elements
//
//  Created by LiemTran on 5/28/19.
//  Copyright © 2019 Goldfish Code. All rights reserved.
//

import UIKit

@IBDesignable
class GradientButton: BaseButton {
    
    // MARK: - Properties
    fileprivate var graLayer: CAGradientLayer!
    fileprivate var shadowLayer: CAShapeLayer!
    

    // MARK: - Setup button
    override func setupButton() {
        super.setupButton()
        
        setBackgroundColor(UIColor.clear, forState: .normal)
        setTitleColor(UIColor.white, for: .normal)
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
    
    func setTitleWithFont(title: String, font: UIFont) {
        setTitle(title, for: .normal)
        titleLabel?.font = font
    }
}


// MARK: - Private methods
extension GradientButton {
    
    fileprivate func configureGradient() {
        graLayer = Gradient.getHorizontalGradient(withColors: [Color.gradientFrom.cgColor, Color.gradientTo.cgColor], frame: CGRect.init(x: 0, y: 0, width: frame.width, height: frame.height))
        
        graLayer.cornerRadius = 7
        self.layer.addSublayer(graLayer)
        
        self.shadowLayer = CAShapeLayer()
        
        self.shadowLayer.path = UIBezierPath(roundedRect: self.bounds, cornerRadius: 7).cgPath
        self.shadowLayer.fillColor = Color.gradientShadow.cgColor
        self.shadowLayer.shadowColor = Color.gradientShadow.cgColor
        self.shadowLayer.shadowPath = shadowLayer.path
        self.shadowLayer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        self.shadowLayer.shadowOpacity = 0.3
        self.shadowLayer.shadowRadius = 5
        
        self.layer.insertSublayer(shadowLayer, at: 0)
        
        if let label = self.titleLabel {
            self.bringSubview(toFront: label)
        }
    }
   
    //Apply new frame for gradient layer when self bounds change
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if (object as? GradientButton) != nil {
            if shadowLayer != nil && graLayer != nil {
                graLayer.removeFromSuperlayer()
                shadowLayer.removeFromSuperlayer()
                self.configureGradient()
            }
        }
    }
}
