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
        testName = TestName.FORWARD_DIGIT_SPAN
        testStatus = TestForwardDigitSpan
    }
    
    override func levelStart() -> Int {
        return 4
    }
    
    override func levelEnd() -> Int {
        return 8
    }
}

