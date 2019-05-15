//
//  DigitSerialSeven.swift
//  iBOCA
//
//  Created by saman on 6/16/17.
//  Copyright © 2017 sunspot. All rights reserved.
//

import Foundation


import UIKit
import AVFoundation


class DigitSerialSeven:DigitBaseClass {
    var startNum = 0
    var lastNum = 0
    let MAXLEVEL = 7
    var genval:String = ""
    
    var enteredNumber:[Int] = []
    var expectedNumber:[Int] = []
    var sequenceNumber:[Int] = []
    var gotTime:[Date] = []
    var totErrors = 0
    var keys : [[String:String]] = [[:]]
    var buttons : [UIButton] = []
    
    var timer: Timer?
    var countdownTime: Int = 6
    var randomNumber: Int = 50
    
    override func DoInitialize() {
        testName =  "Serial Sevens Test"
        testStatus = TestSerialSevens
        base.InfoLabel.text = "Press start to begin \(testName)"
        base.hideKeypad()
        level = -1
        
//        for (i, val) in [50, 60, 70, 80, 90, 100].enumerated() {
//            let button  = UIButton(frame: CGRect(x: 150+125*i, y: 150, width: 100, height: 50))
//            button.setTitle(String(val), for: .normal)
//            button.setTitleColor(UIColor.blue, for: .normal)
//            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 42.0)
//            button.addTarget(self, action: #selector(DigitSerialSeven.StartNumberButtonTapped), for: .touchDown)
//            button.isHidden = true
//            buttons.append(button)
//            base.view.addSubview(button)
//        }
    }
    
    override func DoStart() {
        let startingNumbers = [50, 60, 70, 80, 90, 100]
        let randomIndex = Int(arc4random_uniform(UInt32(startingNumbers.count)))
        let randomStartingNumber = startingNumbers[randomIndex]
        debugPrint(randomStartingNumber)
        
        // Reset countdown time every starting
        countdownTime = 6
        randomNumber = randomStartingNumber
        base.lbShowRandomNumber.isHidden = false
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(DigitSerialSeven.countdown), userInfo: nil, repeats: true)
        timer?.fire()
        
        
        base.InfoLabel.text = ""
        level = -1
        startTime = Foundation.Date()
        
        enteredNumber = []
        expectedNumber = []
        sequenceNumber = []
        gotTime = []
        totErrors = 0
        keys = []
        
        base.hideKeypad()
        for button in buttons {
            button.isHidden = false
        }
        
    }
    
    @objc private func countdown() {
        countdownTime -= 1
        
        let attributedString = NSMutableAttributedString.init(string: "Starting number is ", attributes: [NSForegroundColorAttributeName: UIColor.black, NSFontAttributeName: UIFont.systemFont(ofSize: 35)])
        let randomNumberString = NSAttributedString.init(string: "\(randomNumber)", attributes: [NSForegroundColorAttributeName: UIColor.blue, NSFontAttributeName: UIFont.boldSystemFont(ofSize: 40)])
        let countdownString = NSAttributedString.init(string: "\n\nThe test will start in ", attributes: [NSForegroundColorAttributeName: UIColor.black, NSFontAttributeName: UIFont.systemFont(ofSize: 35)])
        let countdownNumber = NSAttributedString.init(string: "\(countdownTime)", attributes: [NSForegroundColorAttributeName: UIColor.red, NSFontAttributeName: UIFont.systemFont(ofSize: 35)])
        attributedString.append(randomNumberString)
        attributedString.append(countdownString)
        attributedString.append(countdownNumber)
        base.lbShowRandomNumber.attributedText = attributedString
        
        if countdownTime == 0 {
            // Stop timer
            self.timer?.invalidate()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                // Hide countdown
                self.base.lbShowRandomNumber.isHidden = true
                self.base.lbShowRandomNumber.text = ""
                
                self.startTheTest(startingNumber: self.randomNumber)
            }
        }
    }
    
    private func startTheTest(startingNumber: Int) {
        startNum = startingNumber
        lastNum = startNum
        level = 0
        for button in buttons {
            button.isHidden = true
        }
        base.enableKeypad()
        
        levelStartTime = Foundation.Date()
        
        base.InfoLabel.text = "Ask patiant for the selected start number minus 7, Enter it"
    }
    
    @objc fileprivate func StartNumberButtonTapped(button: UIButton){
        startNum = Int(button.title(for: .normal)!)!
        lastNum = startNum
        level = 0
        for button in buttons {
            button.isHidden = true
        }
        base.enableKeypad()
        
        levelStartTime = Foundation.Date()
        
        base.InfoLabel.text = "Ask patiant for the selected start number minus 7, Enter it"
    }
    
    
    override func DoEnterDone() {
        base.disableKeypad()
        
        if level == -1 {
            // Should not get here....
       } else {
            // Middle of the test
            guard let num = Int(base.value) else {
                base.InfoLabel.text = "Error: Enter a number"
                base.enableKeypad()
                return
            }
            
            level += 1
            base.KeypadLabel.text = ""
            base.value = ""
            
            if num == lastNum - 7 && num == startNum - 7*level {
                base.InfoLabel.text = "Correct: Ask patiant for number minus 7, Enter it"
            } else  if num == lastNum - 7 {
                base.InfoLabel.text = "Correct, but off the sequence: Ask patiant for number minus 7, Enter it"
            } else {
                totErrors += 1
                base.InfoLabel.text = "Incorrect subtraction: End the test or ask patiant for number minus 7 and enter it"
            }
            
            enteredNumber.append(num)
            expectedNumber.append(lastNum - 7)
            sequenceNumber.append(startNum - 7*level)
            keys.append(gotKeys)
            gotTime.append(Foundation.Date())
            
            lastNum = num
        }
   
        if (lastNum - 7 < 0) || (level >= 5) {
            // Done test
            base.InfoLabel.text = "Test Ended"
            DoEnd()
            return
        }
    
        base.enableKeypad()
    }
    
    override func DoEnd() {
        // Stop timer
        timer?.invalidate()
        
        // Hide countdown
        base.lbShowRandomNumber.isHidden = true
        base.lbShowRandomNumber.text = ""
        
        let endTime = Foundation.Date()
        
        let result = Results()
        result.name = testName
        result.startTime = startTime
        result.endTime = endTime
        
        result.longDescription.add("Starting with \(startNum)")
        result.json["Starting Number"] = startNum
        var resultList : [Int:Any] = [:]
        var sttime = levelStartTime
        for (i, l) in enteredNumber.enumerated() {
            var res : [String:Any] = [:]
            res["Entered"] = l
            res["Subtract 7"] = expectedNumber[i]
            res["Sequence 7"] = sequenceNumber[i]
            
            let elapsedTime = (Int)(1000*gotTime[i].timeIntervalSince(sttime))
            sttime = gotTime[i]
            res["time (msec)"] = elapsedTime
            resultList[i] = res
            result.longDescription.add("\(i): \(enteredNumber[i]) --> Subtract 7: \(expectedNumber[i]) (Sequence 7: \(sequenceNumber[i]))  (\(elapsedTime) msec)")
        }
        result.json["Results"] = resultList
        result.json["Errors"] = totErrors
        result.json["Rounds"] = level
        
        result.shortDescription = "\(startNum)->\(enteredNumber) sequence, \(level) rounds with \(totErrors) errors"
        
        resultsArray.add(result)
        Status[testStatus] = TestStatus.Done
    
        base.EndTest()
    }
}
