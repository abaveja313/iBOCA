//
//  ColorConstants.swift
//  swift-project
//
//  Created by Son Huynh on 5/24/19.
//  Copyright © 2019 Son Huynh. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Color Constants

/// All constants related to app's color.
public struct Color {
    
    public static func color(red: Int, green: Int, blue: Int, alpha: CGFloat = 1.0) -> UIColor {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        return UIColor(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: alpha)
    }
    
    public static func color(hexString: String) -> UIColor {
        var hexString: String = hexString.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        hexString = hexString.replacingOccurrences(of: "0x", with: "")
        hexString = hexString.replacingOccurrences(of: "#", with: "")
        
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        return UIColor(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
    
    // Background
    public static let navBarBg      = UIColor.white
    public static let tabBarBg      = UIColor.white
    public static let whiteBg       = UIColor.white
    public static let grayBg        = color(red: 240, green: 240, blue: 240)
    
    
    // Gradient
    public static let gradientFrom = color(hexString: "FF8866")
    public static let gradientTo = color(hexString: "FF64A3")
    public static let gradientShadow = color(hexString: "FF7881")

    // Text
    public static let whiteText     = UIColor.white
    public static let grayText      = color(red: 240, green: 240, blue: 240)
}
