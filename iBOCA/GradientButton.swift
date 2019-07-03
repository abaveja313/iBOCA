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

enum DirectionGradient {
    //NOTE:
    // (0,0) corresponds to the smallest coordinates of the layer's bounds rectangle, which on iOS is its upper-left corner
    // (1,1) corresponds to the largest coordinates of the layer's bounds rectangle, which on iOS is its lower-right corner
    case lefToRight
    case bottomToTop
    case topToBottom
    
    var toStartPoint : CGPoint{
        switch self {
        case .lefToRight:
            return CGPoint.zero
        case .bottomToTop:
            return CGPoint.init(x: 0.5, y: 1)
        case .topToBottom:
            return CGPoint.init(x: 0.5, y: 0)
        }
    }
    
    var toEndPoint : CGPoint{
        switch self {
        case .lefToRight:
            return CGPoint.zero
        case .bottomToTop:
            return CGPoint.init(x: 0.5, y: 0)
        case .topToBottom:
            return CGPoint.init(x: 0.5, y: 1)
        }
    }
}

@IBDesignable
class GradientButton: BaseButton {
    
    // MARK: - Properties
    fileprivate var graLayer: CAGradientLayer!
    fileprivate var shadowLayer: CAShapeLayer!
    
    /// Set color from, color to
    var colors: [CGColor] = [Color.gradientFrom.cgColor, Color.gradientTo.cgColor]
    var directGradient : DirectionGradient = DirectionGradient.bottomToTop
    
    /// Set color shadow
    var shadowColor: CGColor = Color.gradientShadow.cgColor
    var cornerShadow : CGFloat = 8
    var radiusShadow : CGFloat = 4.5
    var opacityShadow : Float = 0.7
    
    
    

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
    
    func setTitle(title:String,withFont font:UIFont){
        self.setTitle(title, for: .normal)
        self.titleLabel?.font = font
    }
    
    func updateTitle(title: String, spacing: CGFloat) {
        let attributedString = NSMutableAttributedString(string: title)
        attributedString.addAttribute(NSKernAttributeName, value: spacing, range: NSRange(location: 0, length: attributedString.length))
        self.setAttributedTitle(attributedString, for: .normal)
    }
    
    /// setup shadow for this Button
    ///
    /// - Parameters:
    ///   - withColor: color of shadow
    ///   - blur: blur indicate from file Sketch
    func setupShadow(withColor color: UIColor,sketchBlur blur:CGFloat,opacity:Float){
        self.shadowColor = color.cgColor
        self.radiusShadow = blur * 0.5
        self.opacityShadow = opacity
        self.shadowLayer.removeFromSuperlayer()
    }
    
    func setupGradient(arrColor:[UIColor],direction:DirectionGradient){
        self.colors = arrColor.map { return $0.cgColor }
        self.directGradient = direction
        self.graLayer.removeFromSuperlayer()
    }
    
    func render(){
        configureShadowAndGradient()
    }
}


// MARK: - Private methods
extension GradientButton {
    
    fileprivate func configureGradient() {
        self.graLayer = Gradient.getHorizontalGradient(withColors: [self.colors[0], self.colors[1]], frame: CGRect.init(x: 0, y: 0, width: frame.width, height: frame.height))
        
        self.graLayer.cornerRadius = cornerShadow
        self.layer.addSublayer(self.graLayer)
        
        self.shadowLayer = CAShapeLayer()
        
        self.shadowLayer.path = UIBezierPath(roundedRect: self.bounds, cornerRadius: cornerShadow).cgPath
        self.shadowLayer.fillColor = self.shadowColor
        self.shadowLayer.shadowColor = self.shadowColor
        self.shadowLayer.shadowPath = self.shadowLayer.path
        self.shadowLayer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        self.shadowLayer.shadowOpacity = opacityShadow
        self.shadowLayer.shadowRadius = radiusShadow
        
        self.layer.insertSublayer(self.shadowLayer, at: 0)
        
        if let label = self.titleLabel {
            self.bringSubview(toFront: label)
        }
    }
    
    fileprivate func configureShadowAndGradient() {
        self.graLayer = Gradient.creGradient(withColors: self.colors, frame: self.bounds, start: directGradient.toStartPoint, end: directGradient.toEndPoint)
        
        self.graLayer.cornerRadius = cornerShadow
        self.layer.addSublayer(self.graLayer)
        
        self.shadowLayer = CAShapeLayer()
        
        self.shadowLayer.path = UIBezierPath(roundedRect: self.bounds, cornerRadius: cornerShadow).cgPath
        self.shadowLayer.fillColor = self.shadowColor
        self.shadowLayer.shadowColor = self.shadowColor
        self.shadowLayer.shadowPath = self.shadowLayer.path
        self.shadowLayer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        self.shadowLayer.shadowOpacity = opacityShadow
        self.shadowLayer.shadowRadius = radiusShadow
        
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
                render()
            }
        }
    }
}
