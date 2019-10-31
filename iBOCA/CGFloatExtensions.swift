//
//  CGFloatExtensions.swift
//  swift-project
//
//  Created by Son Huynh on 5/24/19.
//  Copyright © 2019 Son Huynh. All rights reserved.
//

import Foundation
import UIKit

extension CGFloat {
    
    ///
    func degreesToRadians() -> CGFloat {
        return (.pi * self) / 180.0
    }
    
    ///
    mutating func toRadiansInPlace() {
        self = (.pi * self) / 180.0
    }
    
    /// Converts angle degrees to radians.
    static func degreesToRadians(_ angle: CGFloat) -> CGFloat {
        return (.pi * angle) / 180.0
    }
    
    /// Converts radians to degrees.
    func radiansToDegrees() -> CGFloat {
        return (180.0 * self) / .pi
    }
    
    /// Converts angle radians to degrees mutable version.
    mutating func toDegreesInPlace() {
        self = (180.0 * self) / .pi
    }
    
    /// Converts angle radians to degrees static version.
    static func radiansToDegrees(_ angleInDegrees: CGFloat) -> CGFloat {
        return (180.0 * angleInDegrees) / .pi
    }
    
    /// Returns a random floating point number between 0.0 and 1.0, inclusive.
    static func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / Float(UINT32_MAX))
    }
    
    /// Returns a random floating point number in the range min...max, inclusive.
    static func random(within: Range<CGFloat>) -> CGFloat {
        return CGFloat.random() * (within.upperBound - within.lowerBound) + within.lowerBound
    }
    
    /// Returns a random floating point number in the range min...max, inclusive.
    static func random(within: ClosedRange<CGFloat>) -> CGFloat {
        return CGFloat.random() * (within.upperBound - within.lowerBound) + within.lowerBound
    }
}
