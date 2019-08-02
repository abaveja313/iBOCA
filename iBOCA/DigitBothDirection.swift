//
//  DigitBothDirection.swift
//  iBOCA
//
//  Created by saman on 6/11/17.
//  Copyright © 2017 sunspot. All rights reserved.
//

import Foundation

import UIKit
import AVFoundation

// Inherited by both Forward and Backward digit span. They overrite two methods and done!
class DigitBothDirection:DigitBaseClass {
    var genval:String = ""
    var redo = 0
    let MAX_REDO = 2
    
    var genStrings:[String] = []
    var gotStrings:[String] = []
    var gotLevels:[Int] = []
    var gotDuration:[Int] = []
    var totErrors = 0
    var totCorrects = 0
    var currRound = 0
        
    var resultList : [String:Any] = [:]
    
    override func DoInitialize() {
        testInitialize()
        base.infoLabel.text = "Press start to begin \(testName) and tell the patient the first set of numbers"
        level  = levelStart() - 1
        redo = 0
    }
    
    override func doStart() {
        testInitialize()
        base.setButtonEnabled(false)
        base.infoLabel.text = "Tell the patient the numbers, followed by entering his/her response"
        level = levelStart() - 1
        redo = 0
        
        startTime = Foundation.Date()
        genStrings = []
        gotStrings = []
        gotLevels  = []
        gotDuration = []
        totErrors = 0
        totCorrects = 0
        currRound = 0
        resultList = [:]
        startDisplay()
    }
    
    func startDisplay() {
        genval = ""
        var candidate = [0, 1, 2, 4, 5, 6, 7, 8, 9]
        for _ in 0...level {
            let pos = (Int)(arc4random_uniform(UInt32(candidate.count)))
            genval = genval + String(candidate[pos])
            candidate.remove(at: pos)
        }
        base.DisplayStringShowContinue(val: genval)
    }
    
    override func doEnterDone() {
        genStrings.append(genval)
        gotStrings.append(base.keypadLabel.text!)
        gotLevels.append(level+1)
        let levelEndTime = Foundation.Date()
        let elapsedTime = (Int)(1000*levelEndTime.timeIntervalSince(levelStartTime))
        gotDuration.append(elapsedTime)
        
        var tempList:[String:Any] = [:]
        tempList["Generated"] = genval
        tempList["Entered"] = base.keypadLabel.text
        tempList["ElapsedTime (msec)"] = elapsedTime
        
        resultList[String(currRound)] = tempList
        
        currRound += 1
        
        guard let _ = Int(base.keypadLabel.text!) else {
            base.infoLabel.text = "Error: Enter a number"
            return
        }
        
        let pgenval = procesString(val: genval)
        if base.keypadLabel.text == pgenval {
            totCorrects += 1
            base.infoLabel.text = "Correct! Tell the next set of numbers"
            level += 1
            if level >= levelEnd() {
                base.infoLabel.text = "Correct!, test done"
                base.startTimeTask = Foundation.Date()
                base.totalTimeCounter.invalidate()
                base.setButtonEnabled(true)
                base.numKeyboard.isEnabled(false)
                doEnd()
            } else {
                redo = 0
                base.setButtonEnabled(false)
                startDisplay()
            }
        } else {
            redo += 1
            totErrors += 1
            if redo >= MAX_REDO {
                base.infoLabel.text = "Too many incorrect answers, test ended"
                base.startTimeTask = Foundation.Date()
                base.totalTimeCounter.invalidate()
                base.setButtonEnabled(true)
                base.numKeyboard.isEnabled(false)
                doEnd()
            } else {
                base.infoLabel.text = "Incorrect, Repeat with new numbers"
                base.setButtonEnabled(false)
                startDisplay()
            }
        }
        
        base.keypadLabel.text = ""
    }
    
    override func doEnd() {
        Status[testStatus] = TestStatus.Done
        endTest()
    }
    
    func endTest() {
        let endTime = Foundation.Date()
        
        let result = Results()
        result.name = testName
        result.startTime = startTime
        result.endTime = endTime
        
        result.shortDescription = "\(level) level with \(totErrors) errors"
        
        for (i, l) in gotLevels.enumerated() {
            result.longDescription.add("\(l): \(genStrings[i])-->\(gotStrings[i])  \(gotDuration[i]) msec")
        }
        
        result.json["Details"] = resultList
        result.json["Levels"] = level
        result.json["Errors"] = totErrors
        
        result.rounds = currRound
        result.numCorrects = totCorrects
        result.numErrors = totErrors
        
        resultsArray.add(result)
        
        base.endTest()
        Status[testStatus] = TestStatus.Done
    }
    
    // Mainly redefined in the subclass
    func testInitialize() {
        
    }
    
    func procesString(val: String) -> String {
        return val
    }
    
    func levelStart() -> Int {
        return 0
    }
    
    func levelEnd() -> Int {
        return 6
    }
}

