//
//  FontConstants.swift
//  swift-project
//
//  Created by Son Huynh on 5/24/19.
//  Copyright © 2019 Son Huynh. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Color Constants

/// All fonts define here.
public struct Font {
    
    public static func font(size: CGFloat, weight: UIFont.Weight = UIFontWeightRegular) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: weight)
    }
    
    public static func font(name: String, size: CGFloat) -> UIFont {
        if let font = UIFont(name: name, size: size) {
            return font
        }
        print("Missing Font: \(name)")
        return UIFont.systemFont(ofSize: size)
    }
    
    public struct BrandonGrotesque {
        public static let blackItalic: String   = "BrandonGrotesque-BlackItalic"
        public static let black: String         = "BrandonGrotesque-Black"
        public static let boldItalic: String    = "BrandonGrotesque-BoldItalic"
        public static let bold: String          = "BrandonGrotesque-Bold"
        public static let lightItalic: String   = "BrandonGrotesque-LightItalic"
        public static let light: String         = "BrandonGrotesque-Light"
        public static let mediumItalic: String  = "BrandonGrotesque-MediumItalic"
        public static let medium: String        = "BrandonGrotesque-Medium"
        public static let regularItalic: String = "BrandonGrotesque-RegularItalic"
        public static let regular: String       = "BrandonGrotesque-Regular"
        public static let thinItalic: String    = "BrandonGrotesque-ThinItalic"
        public static let thin: String          = "BrandonGrotesque-Thin"
    }
    
    public struct LucidaGrande {
        public static let bold: String          = "LucidaGrande-Bold"
    }
    
}
