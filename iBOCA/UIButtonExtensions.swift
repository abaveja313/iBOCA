//
//  UIButtonExtensions.swift
//  swift-project
//
//  Created by Son Huynh on 5/24/19.
//  Copyright © 2019 Son Huynh. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    
    /// Set a background color for the button.
    func setBackgroundColor(_ color: UIColor, forState: UIControl.State) {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        UIGraphicsGetCurrentContext()?.setFillColor(color.cgColor)
        UIGraphicsGetCurrentContext()?.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let colorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.setBackgroundImage(colorImage, for: forState)
    }
    
    func addTextSpacing(_ spacing: CGFloat, for state: UIControl.State = .normal) {
        let title = self.title(for: state)!
        var attributedString = NSMutableAttributedString(string: title)
        if let attributedText = self.attributedTitle(for: state) {
            attributedString = NSMutableAttributedString(attributedString: attributedText)
        }
        
        attributedString.addAttribute(NSKernAttributeName, value: spacing, range: NSRange(location: 0, length: attributedString.length))
        self.setAttributedTitle(attributedString, for: state)
    }
    
    func addTextSpacing(_ spacing: CGFloat, for state: UIControl.State = .normal, useDefaultFontColor: Bool) {
        let title = self.title(for: state)!
        var attributedString = NSMutableAttributedString(string: title)
        if let attributedText = self.attributedTitle(for: state) {
            attributedString = NSMutableAttributedString(attributedString: attributedText)
        }
        attributedString.addAttribute(NSKernAttributeName, value: spacing, range: NSRange(location: 0, length: attributedString.length))
        if useDefaultFontColor {
            if let textColor = self.titleColor(for: state) {
                attributedString.addAttribute(NSForegroundColorAttributeName, value: textColor, range: NSRange(location: 0, length: attributedString.length))
            }
            if let font = self.titleLabel?.font {
                attributedString.addAttribute(NSFontAttributeName, value: font, range: NSRange(location: 0, length: attributedString.length))
            }
        }
        self.setAttributedTitle(attributedString, for: state)
    }
    
    func addAttributed(font: UIFont, textColor: UIColor, for state: UIControl.State = .normal) {
        let title = self.title(for: state)!
        var attributedString = NSMutableAttributedString(string: title)
        if let attributedText = self.attributedTitle(for: state) {
            attributedString = NSMutableAttributedString(attributedString: attributedText)
        }
        
        attributedString.addAttribute(NSForegroundColorAttributeName, value: textColor, range: NSRange(location: 0, length: attributedString.length))
        attributedString.addAttribute(NSFontAttributeName, value: font, range: NSRange(location: 0, length: attributedString.length))
        self.setAttributedTitle(attributedString, for: state)
    }
}
