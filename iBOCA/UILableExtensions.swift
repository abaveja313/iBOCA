//
//  UILableExtensions.swift
//  swift-project
//
//  Created by Son Huynh on 5/24/19.
//  Copyright © 2019 Son Huynh. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    
    ///
    func getEstimatedSize(_ width: CGFloat = CGFloat.greatestFiniteMagnitude, height: CGFloat = CGFloat.greatestFiniteMagnitude) -> CGSize {
        return sizeThatFits(CGSize(width: width, height: height))
    }
    
    ///
    func getEstimatedHeight() -> CGFloat {
        return sizeThatFits(CGSize(width: w, height: CGFloat.greatestFiniteMagnitude)).height
    }
    
    ///
    func getEstimatedWidth() -> CGFloat {
        return sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: h)).width
    }
    
    func addTextSpacing(_ spacing: CGFloat) {
        var attributedString = NSMutableAttributedString(string: text ?? "")
        if let attributedText = attributedText {
            attributedString = NSMutableAttributedString(attributedString: attributedText)
        }
        attributedString.addAttribute(NSKernAttributeName, value: spacing, range: NSRange(location: 0, length: attributedString.length))
        attributedText = attributedString
    }
    
    func addLineSpacing(_ spacing: CGFloat) {
        var attributedString = NSMutableAttributedString(string: text ?? "")
        if let attributedText = attributedText {
            attributedString = NSMutableAttributedString(attributedString: attributedText)
        }
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = spacing
        attributedString.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSRange(location: 0, length: attributedString.length))
        
        attributedText = attributedString
    }
    
    func setLineHeight(lineHeight: CGFloat) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 1.0
        paragraphStyle.lineHeightMultiple = lineHeight
        paragraphStyle.alignment = self.textAlignment
        
        let attrString = NSMutableAttributedString(string: self.text ?? "")
        attrString.addAttribute(NSFontAttributeName, value: self.font as Any, range: NSRange(location: 0, length: attrString.length))
        attrString.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSRange(location: 0, length: attrString.length))
        self.attributedText = attrString
    }
}
