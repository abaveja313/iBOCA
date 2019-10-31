//
//  UITextViewExtensions.swift
//  swift-project
//
//  Created by Son Huynh on 5/24/19.
//  Copyright © 2019 Son Huynh. All rights reserved.
//

import Foundation
import UIKit

extension UITextView {
    
    /// Automatically adds a toolbar with a done button to the top of the keyboard. Tapping the button will dismiss the keyboard.
    func addDoneButton(_ barStyle: UIBarStyle = .default, title: String? = nil) {
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.items = [
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(title: title ?? "Done", style: .done, target: self, action: #selector(resignFirstResponder))
        ]
        
        keyboardToolbar.barStyle = barStyle
        keyboardToolbar.sizeToFit()
        
        inputAccessoryView = keyboardToolbar
    }
    
    func addTextSpacing(_ spacing: CGFloat) {
        var attributedString = NSMutableAttributedString(string: text ?? "")
        if let attributedText = attributedText {
            attributedString = NSMutableAttributedString(attributedString: attributedText)
        }
        attributedString.addAttribute(NSAttributedString.Key.kern, value: spacing, range: NSRange(location: 0, length: attributedString.length))
        attributedText = attributedString
    }
    
    func addLineSpacing(_ spacing: CGFloat) {
        var attributedString = NSMutableAttributedString(string: text ?? "")
        if let attributedText = attributedText {
            attributedString = NSMutableAttributedString(attributedString: attributedText)
        }
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = spacing
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedString.length))
        
        attributedText = attributedString
    }
    
    func setLineHeight(lineHeight: CGFloat) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 1.0
        paragraphStyle.lineHeightMultiple = lineHeight
        paragraphStyle.alignment = self.textAlignment
        
        let attrString = NSMutableAttributedString(string: self.text ?? "")
        attrString.addAttribute(NSAttributedString.Key.font, value: self.font as Any, range: NSRange(location: 0, length: attrString.length))
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attrString.length))
        self.attributedText = attrString
    }
}
