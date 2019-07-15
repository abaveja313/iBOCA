//
//  BubblesA.swift
//  Integrated test v1
//
//  Created by School on 7/16/15.
//  Copyright (c) 2015 sunspot. All rights reserved.
//

import Foundation
import UIKit
let PracticeTests: (String, [(String, Int, Int)]) = ("Practice",[("1", 810, 230),
                                                                ("a", 710, 195),
                                                                ("2", 420, 200),
                                                                ("b", 300, 80),
                                                                ("3", 375, 330)])
let TrailsTests : [(String, [(String, Int, Int)])] =
    [("Trails B0", [("1", 695, 315),
                   ("a", 820, 280),
                   ("2", 840, 365),
                   ("b", 550, 385),
                   ("3", 550, 285),
                   ("c", 150, 385),
                   ("4", 350, 350),
                   ("d", 70, 275),
                   ("5", 425, 225),
                   ("e", 225, 180),
                   ("6", 250, 295),
                   ("f", 60, 140),
                   ("7", 170, 90),
                   ("g", 700, 100),
                   ("8", 550, 80),
                   ("h", 820, 125),
                   ("9", 600, 180),
                   ("i", 720, 220),
                   ("10", 380, 110),
                   ("j", 450, 420)]),
     ("Trails B1", [("1", 170, 300),
                    ("a", 40, 245),
                    ("2", 170, 50),
                    ("b", 850, 40),
                    ("3", 590, 120),
                    ("c", 970, 105),
                    ("4", 870, 215),
                    ("d", 770, 320),
                    ("5",420, 145),
                    ("e", 450, 420),
                    ("6", 710, 380),
                    ("f", 950, 360),
                    ("7", 970, 565),
                    ("g", 500, 580),
                    ("8", 580, 525),
                    ("h", 110, 540),
                    ("9", 290, 450),
                    ("i", 70, 450),
                    ("10", 280, 325),
                    ("j", 190, 180)]),
     ("Trails B2", [("1", 450, 420),
                    ("a", 420, 145),
                    ("2", 750, 380),
                    ("b", 760, 215),
                    ("3", 970, 105),
                    ("c", 590, 120),
                    ("4", 850, 40),
                    ("d", 170, 50),
                    ("5", 40, 245),
                    ("e", 310, 300),
                    ("6", 190, 180),
                    ("f", 590, 325),
                    ("7", 150, 380),
                    ("g", 290, 480),
                    ("8", 110, 540),
                    ("h", 780, 525),
                    ("9", 500, 580),
                    ("i", 970, 565),
                    ("10",950, 300),
                    ("j", 710, 380)]),
     ("Trails B3", [("1", 190, 180),
                    ("a", 280, 325),
                    ("2", 70, 450),
                    ("b", 290, 450),
                    ("3", 110, 540),
                    ("c", 580, 525),
                    ("4", 500, 580),
                    ("d", 970, 565),
                    ("5",950, 300),
                    ("e", 710, 410),
                    ("6", 450, 420),
                    ("f", 420, 145),
                    ("7", 770, 320),
                    ("g", 780, 215),
                    ("8", 970, 105),
                    ("h", 560, 110),
                    ("9", 850, 40),
                    ("i", 170, 50),
                    ("10", 40, 245),
                    ("j", 170, 300),]),
        ("Trails B4", [("1", 250, 150),
                       ("a", 300, 350),
                       ("2", 150, 550),
                       ("b", 50, 525),
                       ("3", 120, 190),
                       ("c", 30, 20),
                       ("4", 250, 40),
                       ("d", 850, 70),
                       ("5", 950, 150),
                       ("e", 700, 140),
                       ("6", 520, 170),
                       ("f", 530, 320),
                       ("7", 440, 270),
                       ("g", 310, 550),
                       ("8", 510, 570),
                       ("h", 670, 300),
                       ("9", 840, 300),
                       ("i", 950, 540),
                       ("10",640, 580),
                       ("j", 750, 450)]),
        ("Trails B5", [("1", 750, 450),
                       ("a", 640, 580),
                       ("2", 950, 540),
                       ("b", 820, 370),
                       ("3", 650, 300),
                       ("c", 510, 570),
                       ("4", 310, 550),
                       ("d", 440, 230),
                       ("5", 500, 320),
                       ("e", 620, 170),
                       ("6", 780, 220),
                       ("f", 950, 150),
                       ("7", 850, 70),
                       ("g", 250, 40),
                       ("8", 30, 20),
                       ("h", 160, 190),
                       ("9", 50, 525),
                       ("i", 150, 550),
                       ("10",190, 400),
                       ("j", 250, 150)]),
        ("Trails B6", [("1", 520, 330),
                       ("a", 720, 440),
                       ("2", 700, 240),
                       ("b", 190, 270),
                       ("3", 320, 340),
                       ("c", 560, 450),
                       ("4", 190, 380),
                       ("d", 200, 520),
                       ("5", 490, 510),
                       ("e", 880, 510),
                       ("6", 820, 320),
                       ("f", 920, 120),
                       ("7", 440, 200),
                       ("g", 650, 120),
                       ("8", 510,  80),
                       ("h", 130, 100),
                       ("9", 130, 310),
                       ("i",  50, 200),
                       ("10", 60, 560),
                       ("j", 720, 580),
                       ("11",960, 580),
                       ("k", 970, 40),
                       ("12",700, 50),
                       ("l", 830, 80)])]



class BubblesA {
    var bubblelist : [(String, Int,Int)] = []
    let radius = 20
    
    var currentBubble = -1
    var lastBubble = -1
    
    var nextBubble = 0
    
    var seqCount = 0
    
    var segmenttimes:[(Int, String, Int)] = []
    var jsontimes : [String:Any] = [:]
    
    var startTime = Foundation.Date()
    
    // Frame the bubbles within the bounding box
    // first get the bounding box
    var xmin = 982//1000
    var xmax = 42//9
    var ymin = 721//1000
    var ymax = 133//0
    
    var parentFrame: CGRect? {
        didSet {
            if let frame = parentFrame {
                self.xmin = Int(frame.origin.x + frame.size.width)
                self.xmax = Int(frame.origin.x)
                self.ymin = Int(frame.origin.y + frame.size.height)
                self.ymax = Int(frame.origin.y)
            }
        }
    }
    
    func getrange() {
        for (_, x, y) in bubblelist {
            xmin = min(x, xmin)
            xmax = max(x, xmax)
            ymin = min(y, ymin)
            ymax = max(y, ymax)
        }
    }
    
    //Rotate (180 degrees) or mirror (on x or y) the point
    var xt:Bool = false
    var yt:Bool = false
    
    func transform(coord:(String, Int, Int)) -> (String, Int, Int) {
        var x = coord.1
        var y = coord.2
        
        // frame the bubbles within the bounding box
        let bcount = (29 - bubblelist.count) * 5//(24 - bubblelist.count) * 5 // more bubbles, larger area
        
        // Check Division by zero
        if (xmax - xmin) != 0 {
            x = ((x - xmin)*(950-60-2*bcount)/(xmax - xmin)) + bcount + 40
        }
        
        // Check Division by zero
        if (ymax - ymin) != 0 {
            var paddingItem = 40
            if ScreenSize.SCREEN_MAX_LENGTH == 1194.0 {
                // ipad pro 11 inch
                paddingItem = 0
            }
            y = ((y - ymin)*(580-60-2*bcount)/(ymax - ymin)) + bcount + paddingItem
        }
        
        if xt  {
            x  = xmax - x//1010 - x
        }
        
        if yt {
            y = ymin - y//625 - y
        }
        
        return (coord.0, x, y)
    }
    
    
    init() {
        for i in 0...numBubbles-1 {
            bubblelist.append(TrailsTests[selectedTest].1[i])
        }
        getrange()
        bubblelist = bubblelist.map(transform)
        startTime = Foundation.Date()
        jsontimes.removeAll()
        segmenttimes.removeAll()
        seqCount = 0
    }
    
    init(withPracticeTest isPracticeTest: Bool) {
        if isPracticeTest == true {
            for i in 0...3 {
                bubblelist.append(PracticeTests.1[i])
            }
        }
        else {
            for i in 0...numBubbles-1 {
                bubblelist.append(TrailsTests[selectedTest].1[i])
            }
        }
        print("x - min: \(xmin) - max: \(xmax)")
        print("y - min: \(ymin) - max: \(ymax)")
        getrange()
        bubblelist = bubblelist.map(transform)
        startTime = Foundation.Date()
        print("after")
        print("x - min: \(xmin) - max: \(xmax)")
        print("y - min: \(ymin) - max: \(ymax)")
        print("Device: \(ScreenSize.SCREEN_MAX_LENGTH)")
        jsontimes.removeAll()
        segmenttimes.removeAll()
        seqCount = 0
    }
    
    
    func inBubble(x:CGFloat, y:CGFloat)->Int{
        
        for (index,bubble) in bubblelist.enumerated(){
            let (_, a, b) = bubble
            
            let z = (x-CGFloat(a))*(x-CGFloat(a)) + (y-CGFloat(b))*(y-CGFloat(b))
            
            if z <= 700.0 {
                //println("inside bubble " + name)
                return index
            }
            
        }
        
        return -1
    }
    
    func inNewBubble(x:CGFloat, y:CGFloat) -> Bool {
        let curr = inBubble(x: x, y:y)
        if curr == currentBubble {
            return false
        }
        if curr == -1 {
            return false
        }
        print("Found new bubble \(curr)")
        
        
        lastBubble = currentBubble
        currentBubble = curr
        
        seqCount += 1
        return true
        
    }
    
    func inCorrectBubble()->Bool{
        let currTime = Foundation.Date()
        // the path has to start with the previous end of selection and go to the one higher than that
        if (currentBubble == nextBubble) && (lastBubble == nextBubble - 1){
            
            nextBubble += 1
            
            if nextBubble == bubblelist.count {
                print("Done")
                nextBubble = 0
                stopTrailsA = true
                displayImgTrailsA = true
            }
            
            segmenttimes.append((Int(timePassedTrailsA), "\(lastBubble)->\(currentBubble):OK ", Int(1000*currTime.timeIntervalSince(startTime))))
            jsontimes[String(seqCount-1)] = ["Start":lastBubble, "End":currentBubble, "Correct":true, "Time (ms)":Int(1000*currTime.timeIntervalSince(startTime))]
            
            timedConnectionsA.append(timePassedTrailsA)
            return true
            
        }
        
        if currentBubble == nextBubble-1 {
            segmenttimes.append((Int(timePassedTrailsA), "\(lastBubble)->\(currentBubble):OK ", Int(1000*currTime.timeIntervalSince(startTime))))
            jsontimes[String(seqCount-1)] = ["Start":lastBubble, "End":currentBubble, "Correct":true, "Time (ms)":Int(1000*currTime.timeIntervalSince(startTime))]

            return true
            
        }
        
        segmenttimes.append((Int(timePassedTrailsA), "\(lastBubble)->\(currentBubble):OK ", Int(1000*currTime.timeIntervalSince(startTime))))
        jsontimes[String(seqCount-1)] = ["Start":lastBubble, "End":currentBubble, "Correct":false, "Time (ms)":Int(1000*currTime.timeIntervalSince(startTime))]
        
        currentBubble = lastBubble
        return false
    }
    
    
    
}
