//
//  VisualAssociationTask.swift
//  iBOCA
//
//  Created by School on 8/6/16.
//  Copyright © 2016 sunspot. All rights reserved.
//

import Foundation
import UIKit

var StartTime = Foundation.Date()

var mixedImages = [String]()
var halfImages = [String]()
var recognizeIncorrectVA = [String]()

var afterBreakVA = Bool()

var imageSetVA = Int()

var startTimeVA = TimeInterval()
var timerVA = Timer()

class VATask: ViewController, UIPickerViewDelegate {
    
    var recallErrors = [Int]()
    var recallTimes = [Double]()
    
    var recognizeErrors = [Int]()
    var recognizeTimes = [Double]()
    
    var resultList : [String:Any] = [:]
    
    var delayTime = Double()
    
    var totalTime = 300
    
    var mixed0 = ["Backpack-Soccer", "Chair-Dog", "Dogbowl-Rope", "Mixer-Tennis", "Pot-Shoe"]
    var half0 = ["Backpack", "Chair", "Dogbowl", "Mixer", "Pot"]
    var incorrect0 = ["Backpack-Other", "Chair-Other", "Dogbowl-Other", "Mixer-Other", "Pot-Other"]
    
    var mixed1 = ["Barney-FishingRod", "Chess-Calculator", "Goal-Bike", "Painting-Cello", "Racquet-Baseball"]
    var half1 = ["Barney", "Chess", "Goal", "Painting", "Racquet"]
    var incorrect1 = ["Barney-Other", "Chess-Other", "Goal-Other", "Painting-Other", "Racquet-Other"]
    
    var mixed2 = ["Birdcage-Car", "Dog-Hat", "Horn-Duck", "Plant-Rabbit", "Teapot-Flower"]
    var half2 = ["Birdcage", "Dog", "Horn", "Plant", "Teapot"]
    var incorrect2 = ["Birdcage-Other", "Dog-Other", "Horn-Other", "Plant-Other", "Teapot-Other"]
    
    var mixed3 = ["Basket-Hanger", "FireExt-Scarf", "Grater-Lightbulb", "Pocketknife-Umbrella", "Sled-Dog"]
    var half3 = ["Basket", "FireExt", "Grater", "Pocketknife", "Sled"]
    var incorrect3 = ["Basket-Other", "FireExt-Other", "Grater-Other", "Pocketknife-Other", "Sled-Other"]
    
    var mixed4 = ["Candle-Sunglasses", "Firewood-Net", "Microwave-Eggbeater", "Shell-Watch", "Surge-Forks"]
    var half4 = ["Candle", "Firewood", "Microwave", "Shell", "Surge"]
    var incorrect4 = ["Candle-Other", "Firewood-Other", "Microwave-Other", "Shell-Other", "Surge-Other"]
    
    var orderRecognize = [Int]()
    
    var firstDisplay = Bool()
    
    var testCount = Int()
    
    // MARK: Outlet
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var correct: UIButton!
    @IBOutlet weak var incorrect: UIButton!
    @IBOutlet weak var dk: UIButton!
    
    @IBOutlet weak var back: UIButton!
    @IBOutlet weak var backTitleLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var collectionViewLevel: UICollectionView!
    
    @IBOutlet weak var taskView: UIView!
    @IBOutlet weak var shadowTaskView: UIView!
    @IBOutlet weak var taskImageView: UIImageView!
    @IBOutlet weak var arrowLeftButton: UIButton!
    @IBOutlet weak var arrowRightButton: UIButton!
    
    @IBOutlet weak var noticeLabel: UILabel!
    @IBOutlet weak var noticeButton: GradientButton!
    @IBOutlet weak var noticeView: UIView!
    
    @IBOutlet weak var delayView: UIView!
    @IBOutlet weak var delayDescriptionLabel: UILabel!
    @IBOutlet weak var delayLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var startButton: GradientButton!
    
    @IBOutlet weak var viewRegconize: UIView!
    @IBOutlet weak var firstButton: UIButton!
    @IBOutlet weak var secondButton: UIButton!
    
    @IBOutlet weak var startNewButton: GradientButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        self.setupView()
        startButton.removeTarget(self, action: nil, for:.allEvents)
        
        if afterBreakVA {
            timerVA = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimeDecreases), userInfo: nil, repeats: true)
            timerVA.fire()
            
            startButton.addTarget(self, action: #selector(startAlert), for:.touchUpInside)
        } else {
            imageSetVA = 0
            mixedImages = mixed0
            halfImages = half0
            recognizeIncorrectVA = incorrect0
            
            startButton.addTarget(self, action: #selector(startDisplayAlert), for:.touchUpInside)
        }
        
        print(afterBreakVA)
    }
    
    @objc fileprivate func startDisplayAlert() {
        Status[TestVisualAssociation] = TestStatus.Running
        
        isCollectionViewHidden(true)
        isTaskViewHidden(false)
        self.backTitleLabel.text = "BACK"
        
        firstDisplay = true
        
        let newStartAlert = UIAlertController(title: "Display", message: "Name out loud and remember the two items in the photographs.", preferredStyle: .alert)
        newStartAlert.addAction(UIAlertAction(title: "Start", style: .default, handler: { (action) -> Void in
            print("start")
            self.display()
        }))
        self.present(newStartAlert, animated: true, completion: nil)
    }
    
    @objc fileprivate func startAlert() {
        let startAlert = UIAlertController(title: "Start", message: "Choose start option.", preferredStyle: .alert)
        
        startAlert.addAction(UIAlertAction(title: "Start New Task", style: .default, handler: { (action) -> Void in
            print("start new")
            self.startNewTask()
        }))
        
        if afterBreakVA {
            startAlert.addAction(UIAlertAction(title: "Resume Task", style: .default, handler: { (action) -> Void in
                print("resume old")
                self.resumeTask()
            }))
        }
        
        startAlert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (action) -> Void in
            print("cancel")
        }))
        
        self.present(startAlert, animated: true, completion: nil)
    }
    
    fileprivate func startNewTask() {
        Status[TestVisualAssociation] = TestStatus.NotStarted
        
        self.startNewButton.isHidden = true
        self.isRecommendDelayHidden(true)
        self.isCollectionViewHidden(false)
        self.backTitleLabel.text = "VISUAL ASSOCIATION"
        self.isTaskViewHidden(true)
        
        imageSetVA = 0
        mixedImages = self.mixed0
        halfImages = self.half0
        recognizeIncorrectVA = self.incorrect0
        
        timerVA.invalidate()
        totalTime = 300
        recallErrors = [Int]()
        recallTimes = [Double]()
        recognizeErrors = [Int]()
        recognizeTimes = [Double]()
        orderRecognize = [Int]()
        testCount = 0
        resultLabel.text = ""
        firstDisplay = true
    }
    
    @objc fileprivate func display() {
        testCount = 0
        self.taskImageView.isHidden = false
        self.arrowRightButton.isHidden = false
        self.arrowLeftButton.isHidden = true
        isRememberAgainViewHidden(true)
        outputDisplayImage(withImageName: mixedImages[testCount])
    }
    
    fileprivate func outputDisplayImage(withImageName name: String) {
        // Check Show/ Hide Arrow
        if testCount == 0 {
            self.arrowLeftButton.isHidden = true
            self.arrowRightButton.isHidden = false
        } else {
            self.arrowLeftButton.isHidden = false
            self.arrowRightButton.isHidden = false
        }
        
        self.taskImageView.image = UIImage(named: name)!
    }
    
    fileprivate func beginDelay() {
        // Hide Arrow
        isImageViewHidden(true)
        isRecommendDelayHidden(false)
        
        print("in delay...")
        afterBreakVA = true
        
        startButton.removeTarget(self, action: nil, for:.allEvents)
        startButton.addTarget(self, action: #selector(startAlert), for:.touchUpInside)
        
        timerVA = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimeDecreases), userInfo: nil, repeats: true)
        timerVA.fire()
        startTimeVA = NSDate.timeIntervalSinceReferenceDate
    }
    
    fileprivate func updateInDelay(_ timer: Timer) {
        let currTime = Foundation.Date.timeIntervalSinceReferenceDate
        var diff: TimeInterval = currTime - startTimeVA
        
        let minutes = UInt8(diff / 60.0)
        
        diff -= (TimeInterval(minutes)*60.0)
        
        let seconds = UInt8(diff)
        
        diff = TimeInterval(seconds)
        
        let strMinutes = minutes > 9 ? String(minutes):"0"+String(minutes)
        let strSeconds = seconds > 9 ? String(seconds):"0"+String(seconds)
        
        // Check  the time is over 5 minute
        if let intMinutes = Int(strMinutes), intMinutes >= 5, strSeconds != "00" {
            timerLabel.textColor = UIColor.red
        }
        timerLabel.text = "\(strMinutes) : \(strSeconds)"
    }
    
    @objc fileprivate func updateTimeDecreases(timer:Timer) {
        timerLabel.text = "\(timeFormatted(totalTime))"
        if totalTime != 0 {
            totalTime -= 1
        } else {
            endTimer()
        }
    }
    
    fileprivate func endTimer() {
        timerVA.invalidate()
        self.totalTime = 300
        self.resumeTask()
    }
    
    fileprivate func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        //     let hours: Int = totalSeconds / 3600
        return String(format: "%02d : %02d", minutes, seconds)
    }
    
    fileprivate func resumeTask() {
        self.isRecommendDelayHidden(true)
        
        delayTime = 300.0 - Double(self.totalTime)
        
        timerVA.invalidate()
        
        let recallAlert = UIAlertController(title: "Recall", message: "Type the name of the item that is missing from the picture.", preferredStyle: .alert)
        recallAlert.addAction(UIAlertAction(title: "Continue", style: .default, handler: { (action) -> Void in
            print("recalling...")
            self.recall()
        }))
        self.present(recallAlert, animated: true, completion: nil)
    }
    
    fileprivate func recall() {
        correct.isHidden = false
        incorrect.isHidden = false
        dk.isHidden = false
        
        testCount = 0
        
        outputDisplayImage(withImageName: halfImages[testCount])
        
        // Temp
        isImageViewHidden(true)
        taskImageView.isHidden = false
        
        self.noticeLabel.text = "Choose the photograph that you were previously asked to remember"
        self.noticeButton.updateTitle(title: "CONTINUE", spacing: -0.36)
        self.noticeButton.render()
        self.noticeButton.removeTarget(nil, action: nil, for: .allEvents)
        self.noticeButton.addTarget(self, action: #selector(recognize), for: .touchUpInside)
        
        startTimeVA = NSDate.timeIntervalSinceReferenceDate
    }
    
    fileprivate func findTime() -> Double {
        let currTime = NSDate.timeIntervalSinceReferenceDate
        let time = Double(Int((currTime - startTimeVA)*10))/10.0
        return time
    }
    
    fileprivate func loadHalfImages() {
        recallTimes.append(findTime())
        self.testCount += 1
        if testCount == halfImages.count {
            correct.isHidden = true
            incorrect.isHidden = true
            dk.isHidden = true
            
            isImageViewHidden(true)
            isRememberAgainViewHidden(false)
        } else {
            print("next pic!")
            outputDisplayImage(withImageName: halfImages[testCount])
            
            // Temp
            isImageViewHidden(true)
            taskImageView.isHidden = false
        }
    }
    
    @objc fileprivate func recognize() {
        print("IN RECOGNIZE!!!")
        isRememberAgainViewHidden(true)
        
        testCount = 0
        
        randomizeRecognize()
        
        if (orderRecognize[testCount] == 0) {
            outputRecognizeImages(mixedImages[testCount], name2: recognizeIncorrectVA[testCount])
        } else {
            outputRecognizeImages(recognizeIncorrectVA[testCount], name2: mixedImages[testCount])
        }
        
        startTimeVA = NSDate.timeIntervalSinceReferenceDate
    }
    
    fileprivate func outputRecognizeImages(_ name1: String, name2: String) {
        isViewRegconizeHidden(false)
        
        firstButton.setImage(UIImage(named: name1)!, for: .normal)
        firstButton.removeTarget(nil, action:nil, for: .allEvents)
        
        secondButton.setImage(UIImage(named: name2)!, for: .normal)
        secondButton.removeTarget(nil, action:nil, for: .allEvents)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.firstButton.addTarget(self, action: #selector(VATask.recognize1), for:.touchUpInside)
            self.secondButton.addTarget(self, action: #selector(VATask.recognize2), for:.touchUpInside)
        }
    }
    
    fileprivate func randomizeRecognize() {
        //if 0, correct image on left; if 1, correct on right
        for _ in 0 ..< 5 {
            self.orderRecognize.append(Int(arc4random_uniform(2)))
        }
    }
    
    fileprivate func recognizeNext() {
        testCount += 1
        
        if testCount == mixedImages.count {
            isViewRegconizeHidden(true)
            done()
        } else {
            if(orderRecognize[testCount] == 0) {
                outputRecognizeImages(mixedImages[testCount], name2: recognizeIncorrectVA[testCount])
            } else {
                outputRecognizeImages(recognizeIncorrectVA[testCount], name2: mixedImages[testCount])
            }
        }
    }
    
    fileprivate func done() {
        self.startNewButton.isHidden = false
        self.startNewButton.addTarget(self, action: #selector(startAlert), for: .touchUpInside)
        totalTime = 300
        let result = Results()
        result.name = "Visual Association"
        result.startTime = StartTime
        result.endTime = Foundation.Date()
        
        Status[TestVisualAssociation] = TestStatus.Done
        
        afterBreakVA = false
        
        var recallResult = ""
        var recognizeResult = ""
        var delayResult = ""
        var imageSetResult = ""
        
        imageSetResult = "Image set = \(imageSetVA+1)\n"
        
        delayResult = "Delay length of \(delayTime) seconds\n"
        
        result.numErrors = 0
        
        for k in 0 ..< mixedImages.count {
            if (recallErrors[k] == 0) {
                result.longDescription.add("Recalled \(mixedImages[k]) - Correct in \(recallTimes[k]) seconds")
                recallResult += "Recalled \(mixedImages[k]) - Correct in \(recallTimes[k]) seconds\n"
            }
            if (recallErrors[k] == 1) {
                result.longDescription.add("Recalled \(mixedImages[k]) - Incorrect in \(recallTimes[k]) seconds")
                recallResult += "Recalled \(mixedImages[k]) - Incorrect in \(recallTimes[k]) seconds\n"
                result.numErrors += 1
            }
            if (recallErrors[k] == 2) {
                result.longDescription.add("Couldn't recall \(mixedImages[k]) in \(recallTimes[k]) seconds")
                recallResult += "Couldn't recall \(mixedImages[k]) in \(recallTimes[k]) seconds\n"
                result.numErrors += 1
            }
            if (recognizeErrors[k] == 0) {
                result.longDescription.add("Recognized \(mixedImages[k]) - Correct in \(recognizeTimes[k]) seconds")
                recognizeResult += "Recognized \(mixedImages[k]) - Correct in \(recognizeTimes[k]) seconds\n"
            }
            if (recognizeErrors[k] == 1) {
                result.longDescription.add("Recognized \(mixedImages[k]) - Incorrect in \(recognizeTimes[k]) seconds ")
                recognizeResult += "Recognized \(mixedImages[k]) - Incorrect in \(recognizeTimes[k]) seconds\n"
                result.numErrors += 1
            }
        }
        
        resultLabel.text = imageSetResult + delayResult + recallResult + recognizeResult
        
        resultList["ImageSet"] = imageSetVA
        resultList["DelayTime"] = delayTime
        
        var tmpResultList : [String:Any] = [:]
        
        for i in 0...recognizeErrors.count-1 {
            var res = "Correct"
            if recognizeErrors[i] == 1 {
                res = "Incorrect"
            }
            tmpResultList[mixedImages[i]] = ["Condition":res, "Time":recognizeTimes[i]]
        }
        resultList["Recognize"] = tmpResultList
        
        var tmpResultList2 : [String:Any] = [:]
        
        for i in 0...recallErrors.count-1 {
            var res = "Correct"
            if recallErrors[i] == 1 {
                res = "Incorrect"
            }
            if recallErrors[i] == 2 {
                res = "Couldn'tRecall"
            }
            tmpResultList2[mixedImages[i]] = ["Condition":res, "Time":recallTimes[i]]
        }
        resultList["Recall"] = tmpResultList2
        
        
        result.json = resultList
        resultsArray.add(result)
        
        resultList = [:]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.landscape
    }
    
    // MARK: Action
    @IBAction func btnArrowLeftTapped(_ sender: Any) {
        print("Arrow Left Tapped")
        testCount -= 1
        if testCount >= 0 {
            print("pic: \(testCount)")
            self.outputDisplayImage(withImageName: mixedImages[testCount])
        }
    }
    
    @IBAction func btnArrowRightTapped(_ sender: Any) {
        print("Arrow Right Tapped")
        testCount += 1
        if (testCount == mixedImages.count) {
            print("delay")
            isImageViewHidden(true)
            if !firstDisplay {
                beginDelay()
            } else {
                firstDisplay = false
                isRememberAgainViewHidden(false)
                self.noticeButton.removeTarget(nil, action: nil, for: .allEvents)
                self.noticeButton.addTarget(self, action: #selector(display), for: .touchUpInside)
            }
        } else {
            print("pic: \(testCount)")
            self.outputDisplayImage(withImageName: mixedImages[testCount])
        }
    }
    
    @IBAction func btnBackTapped(_ sender: Any) {
        timerVA.invalidate()
        self.totalTime = 300
        afterBreakVA = false
        Status[TestVisualAssociation] = TestStatus.NotStarted
    }
    
    @IBAction func correctButton(_ sender: Any) {
        recallErrors.append(0)
        self.loadHalfImages()
    }
    
    @IBAction func incorrectButton(_ sender: Any) {
        recallErrors.append(1)
        self.loadHalfImages()
    }
    
    @IBAction func dkButton(_ sender: Any) {
        recallErrors.append(2)
        self.loadHalfImages()
    }
    
    @IBAction func recognize1(_ sender: AnyObject) {
        if (orderRecognize[testCount] == 0) {
            recognizeErrors.append(0)
            recognizeTimes.append(findTime())
        } else {
            recognizeErrors.append(1)
            recognizeTimes.append(findTime())
        }
        
        recognizeNext()
    }
    
    @IBAction func recognize2(_ sender: AnyObject) {
        if (orderRecognize[testCount] == 0) {
            recognizeErrors.append(1)
            recognizeTimes.append(findTime())
        } else {
            recognizeErrors.append(0)
            recognizeTimes.append(findTime())
        }
        
        recognizeNext()
    }
}

extension VATask {
    fileprivate func setupView() {
        // Label Back
        self.backTitleLabel.font = Font.font(name: Font.Montserrat.semiBold, size: 28.0)
        self.backTitleLabel.textColor = Color.color(hexString: "#013AA5")
        self.backTitleLabel.addTextSpacing(-0.56)
        self.backTitleLabel.text = "VISUAL ASSOCIATION"
        
        // Label Description Task
        self.descriptionLabel.font = Font.font(name: Font.Montserrat.mediumItalic, size: 18.0)
        self.descriptionLabel.textColor = Color.color(hexString: "#013AA5")
        self.descriptionLabel.alpha = 0.67
        self.descriptionLabel.text = "Ask Patient to name and remember the two items in the photograph"
        self.descriptionLabel.addLineSpacing(10.0)
        self.descriptionLabel.addTextSpacing(-0.36)
        
        // Button Start New
        self.startNewButton.setTitle(title: "START NEW", withFont: Font.font(name: Font.Montserrat.bold, size: 18.0))
        self.startNewButton.setupShadow(withColor: .clear, sketchBlur: 0, opacity: 0)
        self.startNewButton.setupGradient(arrColor: [Color.color(hexString: "#FFDC6E"),Color.color(hexString: "#FFC556")], direction: .topToBottom)
        self.startNewButton.addTextSpacing(-0.36)
        self.startNewButton.render()
        
        self.setupCollectionView()
        self.setupViewTask()
        self.setupViewDelay()
        self.setupViewNotice()
        
        isTaskViewHidden(true)
        isImageViewHidden(true)
        isRecommendDelayHidden(true)
        isRememberAgainViewHidden(true)
        isViewRegconizeHidden(true)
        startNewButton.isHidden = true
        
        correct.isHidden = true
        incorrect.isHidden = true
        dk.isHidden = true
    }
    
    fileprivate func setupCollectionView() {
        self.collectionViewLevel.backgroundColor = UIColor.clear
        self.collectionViewLevel.register(VisualAssociationCell.nib(), forCellWithReuseIdentifier: VisualAssociationCell.identifier())
        self.collectionViewLevel.delegate = self
        self.collectionViewLevel.dataSource = self
    }
    
    fileprivate func setupViewTask() {
        self.shadowTaskView.layer.cornerRadius = 8.0
        self.shadowTaskView.layer.shadowColor = Color.color(hexString: "#649BFF").withAlphaComponent(0.32).cgColor
        self.shadowTaskView.layer.shadowOpacity = 1.0
        self.shadowTaskView.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.shadowTaskView.layer.shadowRadius = 10 / 2.0
        self.shadowTaskView.layer.shadowPath = nil
        self.shadowTaskView.layer.masksToBounds = false
        
        self.taskView.clipsToBounds = true
        self.taskView.backgroundColor = UIColor.white
        self.taskView.layer.cornerRadius = 8.0
        
        self.arrowLeftButton.backgroundColor = Color.color(hexString: "#EEF3F9")
        self.arrowLeftButton.layer.cornerRadius = self.arrowLeftButton.frame.size.height / 2.0
        self.arrowRightButton.backgroundColor = Color.color(hexString: "#EEF3F9")
        self.arrowRightButton.layer.cornerRadius = self.arrowRightButton.frame.size.height / 2.0
    }
    
    fileprivate func setupViewDelay() {
        self.delayDescriptionLabel.font = Font.font(name: Font.Montserrat.medium, size: 18.0)
        self.delayDescriptionLabel.textColor = Color.color(hexString: "#8A9199")
        self.delayDescriptionLabel.text = "Ask Patient to name which item is missing from the picture and record their answer"
        self.delayDescriptionLabel.addLineSpacing(15.0)
        self.delayDescriptionLabel.addTextSpacing(-0.36)
        self.delayDescriptionLabel.textAlignment = .center
        
        self.delayLabel.font = Font.font(name: Font.Montserrat.semiBold, size: 28.0)
        self.delayLabel.textColor = Color.color(hexString: "#013AA5")
        self.delayLabel.text = "Recommended Delay : 5 minute"
        self.delayLabel.addTextSpacing(-0.56)
        
        self.timerLabel.font = Font.font(name: Font.Montserrat.semiBold, size: 72.0)
        self.timerLabel.textColor = Color.color(hexString: "#013AA5")
        self.timerLabel.addTextSpacing(-1.44)
        
        self.startButton.setTitle(title: "START NOW", withFont: Font.font(name: Font.Montserrat.bold, size: 18.0))
        self.startButton.setupShadow(withColor: .clear, sketchBlur: 0, opacity: 0)
        self.startButton.setupGradient(arrColor: [Color.color(hexString: "#FFDC6E"),Color.color(hexString: "#FFC556")], direction: .topToBottom)
        self.startButton.addTextSpacing(-0.36)
        self.startButton.render()
    }
    
    fileprivate func setupViewNotice() {
        self.noticeLabel.font = Font.font(name: Font.Montserrat.medium, size: 18.0)
        self.noticeLabel.textColor = Color.color(hexString: "#000000")
        self.noticeLabel.text = "Name out loud and remember the two items in the photographs again"
        self.noticeLabel.addLineSpacing(15.0)
        self.noticeLabel.addTextSpacing(-0.36)
        self.noticeLabel.textAlignment = .center
        
        self.noticeButton.setTitle(title: "START NOW", withFont: Font.font(name: Font.Montserrat.bold, size: 18.0))
        self.noticeButton.setupShadow(withColor: .clear, sketchBlur: 0, opacity: 0)
        self.noticeButton.setupGradient(arrColor: [Color.color(hexString: "#FFDC6E"),Color.color(hexString: "#FFC556")], direction: .topToBottom)
        self.noticeButton.addTextSpacing(-0.36)
        self.noticeButton.render()
    }
    
    fileprivate func isCollectionViewHidden(_ isHidden: Bool) {
        self.descriptionLabel.isHidden = isHidden
        self.collectionViewLevel.isHidden = isHidden
    }
    
    fileprivate func isTaskViewHidden(_ isHidden: Bool) {
        self.taskView.isHidden = isHidden
        self.shadowTaskView.isHidden = isHidden
    }
    
    fileprivate func isImageViewHidden(_ isHidden: Bool) {
        self.arrowLeftButton.isHidden = isHidden
        self.arrowRightButton.isHidden = isHidden
        self.taskImageView.isHidden = isHidden
    }
    
    fileprivate func isRememberAgainViewHidden(_ isHidden: Bool) {
        self.noticeView.isHidden = isHidden
        self.noticeLabel.isHidden = isHidden
        self.noticeButton.isHidden = isHidden
    }
    
    fileprivate func isRecommendDelayHidden(_ isHidden: Bool) {
        self.delayView.isHidden = isHidden
        self.delayDescriptionLabel.isHidden = isHidden
        self.startButton.isHidden = isHidden
        self.delayLabel.isHidden = isHidden
        self.timerLabel.isHidden = isHidden
    }
    
    fileprivate func isViewRegconizeHidden(_ isHidden: Bool) {
        self.viewRegconize.isHidden = isHidden
        self.firstButton.isHidden = isHidden
        self.secondButton.isHidden = isHidden
    }
}

extension VATask: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VisualAssociationCell.identifier(), for: indexPath) as! VisualAssociationCell
        var imageName: String!
        
        switch indexPath.row {
        case 0:
            imageName = mixed0[0]
        case 1:
            imageName = mixed1[1]
        case 2:
            imageName = mixed2[0]
        case 3:
            imageName = mixed3[0]
        default:
            imageName = mixed4[0]
        }
        
        cell.ivLevel.image = UIImage.init(named: imageName)
        cell.lblTitle.text = "Level \(indexPath.row + 1)"
        return cell
    }
}

extension VATask: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: 220, height: 235.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 27
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension VATask: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        imageSetVA = indexPath.row
        
        switch indexPath.row {
        case 0:
            mixedImages = mixed0
            halfImages = half0
            recognizeIncorrectVA = incorrect0
        case 1:
            mixedImages = mixed1
            halfImages = half1
            recognizeIncorrectVA = incorrect1
        case 2:
            mixedImages = mixed2
            halfImages = half2
            recognizeIncorrectVA = incorrect2
        case 3:
            mixedImages = mixed3
            halfImages = half3
            recognizeIncorrectVA = incorrect3
        default:
            mixedImages = mixed4
            halfImages = half4
            recognizeIncorrectVA = incorrect4
        }
        self.startDisplayAlert()
    }
}
