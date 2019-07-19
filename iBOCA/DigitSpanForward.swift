//
//  DigitSpanForward.swift
//  iBOCA
//
//  Created by saman on 6/10/17.
//  Copyright © 2017 sunspot. All rights reserved.
//

import Foundation

import UIKit

class DigitSpanForward:DigitBothDirection {
    
    override func procesString(val: String) -> String {
        return val
    }
    
    override func testInitialize() {
        testName =  "Forward Digit Span Test"
        testStatus = TestForwardDigitSpan
    }
    
    override func levelStart() -> Int {
        return 4
    }
    
    override func levelEnd() -> Int {
        return 9
    }
}

