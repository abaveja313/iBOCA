//
//  GradientConstants.swift
//  swift-project
//
//  Created by Son Huynh on 5/24/19.
//  Copyright © 2019 Son Huynh. All rights reserved.
//

import Foundation
import UIKit

public struct Gradient {
    
    public static let clear = [
        UIColor.clear.cgColor,
        UIColor.clear.cgColor
    ]
    
    public static let green = [
        UIColor(red: 0.16, green: 0.84, blue: 0.85, alpha: 1).cgColor,
        UIColor(red: 0.4, green: 0.89, blue: 0.81, alpha: 1).cgColor
    ]
    
    public static let red = [
        UIColor(red: 1, green: 0.65, blue: 0.54, alpha: 1).cgColor,
        UIColor(red: 1, green: 0.42, blue: 0.42, alpha: 1).cgColor
    ]
    
    public static func getHorizontalGradient(withColors colors: [CGColor], frame: CGRect) -> CAGradientLayer {
        let gradient = CAGradientLayer()
        gradient.frame = frame
        gradient.colors = colors
        gradient.locations = [0, 1]
        gradient.startPoint = CGPoint(x: -0.1, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.06, y: 0.5)
        return gradient
    }
    
    public static func getVerticalGradient(withColors colors: [CGColor], frame: CGRect) -> CAGradientLayer {
        let gradient = CAGradientLayer()
        gradient.frame = frame
        gradient.colors = colors
        gradient.locations = [0, 1]
        gradient.startPoint = CGPoint(x: 0.5, y: 1.34)
        gradient.endPoint = CGPoint(x: 0.5, y: 0)
        return gradient
    }
    
    public static func creatGradientImage(withLayer layer: CAGradientLayer) -> UIImage? {
        var image: UIImage?
        UIGraphicsBeginImageContext(layer.bounds.size)
        if let context = UIGraphicsGetCurrentContext() {
            layer.render(in: context)
            image = UIGraphicsGetImageFromCurrentImageContext()
        }
        UIGraphicsEndImageContext()
        return image
    }
}
