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

class VATask: ViewController, UIPickerViewDelegate {
    
    var recallErrors = [Int]()
    var recallTimes = [Double]()
    
    var recognizeErrors = [Int]()
    var recognizeTimes = [Double]()
    
    var resultList : [String:Any] = [:]
    
    var delayTime = Double()
    
    var totalTime: Int!
    
    var startTimeVA = TimeInterval()
    var timerVA = Timer()
    
    var afterBreakVA = Bool()
    var imageSetVA = Int()
    
    var mixedImages = [String]()
    var halfImages = [String]()
    var recognizeIncorrectVA = [String]()
    
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
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var resultLabel: UILabel!
    
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
    @IBOutlet weak var delayTimePickerView: UIView!
    @IBOutlet weak var delayTimePickerLabel: UILabel!
    @IBOutlet weak var delayTimePickerImageView: UIImageView!
    @IBOutlet weak var delayTimePickerButton: UIButton!
    @IBOutlet weak var setDelayTimeButton: UIButton!
    @IBOutlet weak var timePickerContentView: UIView!
    @IBOutlet weak var timePickerTableView: UITableView!
    @IBOutlet weak var delayLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var startButton: GradientButton!
    
    @IBOutlet weak var viewRegconize: UIView!
    @IBOutlet weak var firstButton: UIButton!
    @IBOutlet weak var secondButton: UIButton!
    
    @IBOutlet weak var missingItemLabel: UILabel!
    @IBOutlet weak var missingItemTextField: UITextField!
    @IBOutlet weak var remainingPhotoLabel: UILabel!
    
    @IBOutlet weak var resultTitleLabel: UILabel!
    @IBOutlet weak var totalTimeLabel: UILabel!
    @IBOutlet weak var delayLengthLabel: UILabel!
    @IBOutlet weak var delayTimeLabel: UILabel!
    
    @IBOutlet weak var quitButton: GradientButton!
    @IBOutlet weak var resetButton: GradientButton!
    
    @IBOutlet weak var resultScrollView: UIScrollView!
    @IBOutlet weak var resultContentView: UIView!
    @IBOutlet weak var recalledTableView: UITableView!
    @IBOutlet weak var regconizedTableView: UITableView!
    
    // QuickStart Mode
    var quickStartModeOn: Bool = false
    var didBackToResult: (() -> ())?
    var didCompleted: (() -> ())?
    
    var result: Results!
    
    var counterTimeView: CounterTimeView!
    var totalTimeCounter = Timer()
    var startTimeTask = Foundation.Date()
    
    var inputTimer = Timer()
    var timeInput = Double()
    
    var isRecalledTestMode = false
    
    var textInputList: [String]!
    
    var isDropDownShowing = false
    var delayReccommendedTime: Int!
    
    var isMissingItemTextFieldChanged = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupView()
        setupCounterTimeView()
        
        startDisplayAlert()
        
        result = Results()
        result.name = TestName.VISUAL_ASSOCIATION
        result.startTime = Foundation.Date()
        
        missingItemTextField.delegate = self
        startButton.removeTarget(self, action: nil, for:.allEvents)
        resetButton.addTarget(self, action: #selector(actionReset(_:)), for: .touchUpInside)
        
        // Change back button title if quickStartMode is On
        if quickStartModeOn {
            backTitleLabel.text = "RESULTS"
            quitButton.updateTitle(title: "CONTINUE")
        }
        
        if afterBreakVA {
            timerVA = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimeDecreases), userInfo: nil, repeats: true)
            timerVA.fire()
            
            startButton.addTarget(self, action: #selector(startAlert), for:.touchUpInside)
        } else {
//            imageSetVA = 0
//            mixedImages = mixed0
//            halfImages = half0
//            recognizeIncorrectVA = incorrect0
            
            startButton.addTarget(self, action: #selector(startDisplayAlert), for:.touchUpInside)
        }
        
        print(afterBreakVA)
    }
    
    private func randomTest() {
        let randomNumber = Int.random(in: 0...4)
        imageSetVA = randomNumber
        
        switch randomNumber {
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
    }
    
    fileprivate func runTimer() {
        self.totalTimeCounter = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        self.totalTimeCounter.fire()
    }
    
    func updateTime(timer: Timer) {
        self.counterTimeView.setTimeWith(startTime: self.startTimeTask, currentTime: Foundation.Date())
    }
    
    @objc fileprivate func startDisplayAlert() {
        Status[TestVisualAssociation] = TestStatus.Running
        randomTest()
        
//        isCollectionViewHidden(true)
        isTaskViewHidden(false)
        
        firstDisplay = true
        
        textInputList = []
        
        let newStartAlert = UIAlertController(title: "Display", message: "Name out loud and remember the two items in the photographs.", preferredStyle: .alert)
        newStartAlert.addAction(UIAlertAction(title: "Start", style: .default, handler: { (action) -> Void in
            print("start")
            self.display()
        }))
        self.present(newStartAlert, animated: true, completion: nil)
    }
    
    @objc fileprivate func startAlert() {
        if isDropDownShowing {
            isDropDownViewHidden(true)
            isDropDownShowing = false
            self.delayTimePickerView.layer.borderColor =  Color.color(hexString: "#EAEAEA").cgColor
        }
        
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
        inputTimer.invalidate()
        
        Status[TestVisualAssociation] = TestStatus.NotStarted
        
        self.remainingPhotoLabel.text = "1/5"
        
        if let delayTime = Settings.VADelayTime {
            self.delayLabel.text = delayTime / 60 == 1 ? "Recommended Delay : 1 minute" : "Recommended Delay : \(delayTime / 60) minutes"
        } else {
            self.delayLabel.text = "Recommended Delay : 5 minutes"
        }
        
        self.result.startTime = Foundation.Date()
        
        self.startTimeTask = Foundation.Date()
        self.totalTimeCounter.invalidate()
        self.runTimer()
        
        self.isRecalledTestMode = false
        self.isRecommendDelayHidden(true)
//        self.isCollectionViewHidden(false)
//        self.isTaskViewHidden(true)
        
        result.startTime = Foundation.Date()
        
//        imageSetVA = 0
//        mixedImages = self.mixed0
//        halfImages = self.half0
//        recognizeIncorrectVA = self.incorrect0
        
        timerVA.invalidate()
        
        recallErrors = [Int]()
        recallTimes = [Double]()
        recognizeErrors = [Int]()
        recognizeTimes = [Double]()
        orderRecognize = [Int]()
        testCount = 0
        resultLabel.text = ""
        isResultViewHidden(true)
        firstDisplay = true
        
        startDisplayAlert()
    }
    
    @objc fileprivate func display() {
        testCount = 0
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
        
        self.taskImageView.isHidden = false
        self.taskImageView.image = UIImage(named: name)!
    }
    
    fileprivate func beginDelay() {
        // Hide Arrow
        isImageViewHidden(true)
        isRecommendDelayHidden(false)
        
        print("in delay...")
        afterBreakVA = true
        
        if let delayTimes = Settings.VADelayTime {
            delayTime = Double(delayTimes)
            totalTime = delayTimes
        } else {
            delayTime = 300
            totalTime = 300
        }
        
        timerVA = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimeDecreases), userInfo: nil, repeats: true)
        timerVA.fire()
        startTimeVA = NSDate.timeIntervalSinceReferenceDate
        
        startButton.removeTarget(self, action: nil, for:.allEvents)
        startButton.addTarget(self, action: #selector(startAlert), for:.touchUpInside)
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
        self.resumeTask()
    }
    
    fileprivate func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        return String(format: "%02d : %02d", minutes, seconds)
    }
    
    fileprivate func resumeTask() {
        self.isRecalledTestMode = true
        self.isRecommendDelayHidden(true)
        
        delayTime = delayTime - Double(self.totalTime)
        
        timerVA.invalidate()
        
        let recallAlert = UIAlertController(title: "Recall", message: "Type the name of the item that is missing from the picture.", preferredStyle: .alert)
        recallAlert.addAction(UIAlertAction(title: "Continue", style: .default, handler: { (action) -> Void in
            print("recalling...")
            self.recall()
        }))
        self.present(recallAlert, animated: true, completion: nil)
    }
    
    fileprivate func recall() {
        inputTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateTimeInput), userInfo: nil, repeats: true)
        inputTimer.fire()
        
        testCount = 0
        
        outputDisplayImage(withImageName: halfImages[testCount])
        
        self.isMissingItemViewHidden(false)
        
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
    
    @objc fileprivate func updateTimeInput(timer: Timer) -> Double {
        self.timeInput += 0.1
        return self.timeInput
    }
    
    fileprivate func loadHalfImages() {
        recallTimes.append(findTime())
        self.testCount += 1
        if testCount == halfImages.count {
            isImageViewHidden(true)
            isMissingItemViewHidden(true)
            isRememberAgainViewHidden(false)
        } else {
            print("next pic!")
            outputDisplayImage(withImageName: halfImages[testCount])
        }
    }
    
    @objc fileprivate func recognize() {
        print("IN RECOGNIZE!!!")
        isRememberAgainViewHidden(true)
        timeInput = 0
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
            setupResultTableView()
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
        self.isResultViewHidden(false)
        self.startTimeTask = Foundation.Date()
        self.totalTimeCounter.invalidate()
        self.inputTimer.invalidate()
        
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
        result.numCorrects = 0
        
        recalledTableView.reloadData()
        
        totalTimeLabel.text = "Text complete in \(result.totalElapsedSeconds()) seconds"
        delayTimeLabel.text = "\(delayTime) seconds"
        
        var missingItem = [String]()
        for item in mixedImages {
            missingItem.append(item.components(separatedBy: "-")[1])
        }
        
        result.imageVA = self.mixedImages
        result.inputVA = self.textInputList
        
        for i in 0...textInputList.count - 1 {
            result.longDescription.add("Recalled \(missingItem[i]) - Input: \(textInputList[i]) - in \(recallTimes[i]) seconds")
            recallResult += "Recalled \(missingItem[i]) - Input: \(textInputList[i]) - in \(recallTimes[i]) seconds\n"
            if missingItem[i] == textInputList[i] {
                result.numCorrects += 1
            } else {
                result.numErrors += 1
            }
        }
        
        for k in 0 ..< mixedImages.count {
            if (recognizeErrors[k] == 0) {
                result.longDescription.add("Recognized \(mixedImages[k]) - Correct in \(recognizeTimes[k]) seconds")
                recognizeResult += "Recognized \(mixedImages[k]) - Correct in \(recognizeTimes[k]) seconds\n"
                result.numCorrects += 1
            }
            if (recognizeErrors[k] == 1) {
                result.longDescription.add("Recognized \(mixedImages[k]) - Incorrect in \(recognizeTimes[k]) seconds ")
                recognizeResult += "Recognized \(mixedImages[k]) - Incorrect in \(recognizeTimes[k]) seconds\n"
                result.numErrors += 1
            }
        }
        
        resultLabel.text = imageSetResult + delayResult + recallResult + recognizeResult
        resultLabel.isHidden = true
        
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
        
        for i in 0...textInputList.count-1 {
            var res = "Correct"
            if missingItem[i] != textInputList[i] {
                res = "Incorrect"
            }
            tmpResultList2[mixedImages[i]] = ["Condition":res, "Time":recallTimes[i]]
        }
        
        resultList["Recall"] = tmpResultList2
        
        result.json = resultList
        resultsArray.add(result)
        
        resultList = [:]
        
        recalledTableView.reloadData()
        regconizedTableView.reloadData()
    }
    
    fileprivate func dismissDropDownList() {
        isDropDownViewHidden(true)
        isDropDownShowing = false
        self.delayTimePickerView.layer.borderColor =  Color.color(hexString: "#EAEAEA").cgColor
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.landscape
    }
}

extension VATask {
    // MARK: Action
    @IBAction func btnArrowLeftTapped(_ sender: Any) {
        print("Arrow Left Tapped")
        view.endEditing(true)
        testCount -= 1
        timeInput = 0
        if testCount >= 0 {
            print("testCount: \(testCount)")
            if isRecalledTestMode {
                self.outputDisplayImage(withImageName: halfImages[testCount])
                missingItemTextField.text = textInputList[testCount]
                remainingPhotoLabel.text = "\(testCount + 1)/\(mixedImages.count)"
            } else {
                self.outputDisplayImage(withImageName: mixedImages[testCount])
            }
            
        }
    }
    
    @IBAction func btnArrowRightTapped(_ sender: Any) {
        if !missingItemTextField.isHidden && (missingItemTextField.text?.isEmpty)! {
            let warningAlert = UIAlertController(title: "Warning", message: "Please enter Missing Item fields.", preferredStyle: .alert)
            warningAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) -> Void in
                warningAlert.dismiss(animated: true, completion: nil)
            }))
            self.present(warningAlert, animated: true, completion: nil)
        } else {
            print("Arrow Right Tapped")
            view.endEditing(true)
            testCount += 1
            if (testCount == mixedImages.count) {
                print("delay")
                isImageViewHidden(true)
                if isRecalledTestMode {
                    isMissingItemViewHidden(true)
                    isRememberAgainViewHidden(false)
                    
                    textInputList.append(missingItemTextField.text!)
                    missingItemTextField.text = ""
                    recallTimes.append((timeInput * 10).rounded() / 10)
                    
                    isMissingItemTextFieldChanged = false
                    remainingPhotoLabel.text = "\(testCount + 1)/\(mixedImages.count)"
                } else {
                    if !firstDisplay {
                        beginDelay()
                    } else {
                        firstDisplay = false
                        isRememberAgainViewHidden(false)
                        self.noticeButton.removeTarget(nil, action: nil, for: .allEvents)
                        self.noticeButton.addTarget(self, action: #selector(display), for: .touchUpInside)
                    }
                }
            } else {
                print("testCount: \(testCount)")
                if isRecalledTestMode {
                    
                    if testCount - 1 == textInputList.count {
                        textInputList.append(missingItemTextField.text!)
                        missingItemTextField.text = ""
                        recallTimes.append((timeInput * 10).rounded() / 10)
                    } else if testCount == textInputList.count {
                        textInputList[testCount - 1] = missingItemTextField.text!
                        missingItemTextField.text = ""
                        if isMissingItemTextFieldChanged {
                            recallTimes[testCount - 1] += (timeInput * 10).rounded() / 10
                        }
                    } else {
                        textInputList[testCount - 1] = missingItemTextField.text!
                        if isMissingItemTextFieldChanged {
                            recallTimes[testCount - 1] += (timeInput * 10).rounded() / 10
                        }
                        missingItemTextField.text = textInputList[testCount]
                    }
                    
                    timeInput = 0
                    
                    isMissingItemTextFieldChanged = false
                    remainingPhotoLabel.text = "\(testCount + 1)/\(mixedImages.count)"
                    self.outputDisplayImage(withImageName: halfImages[testCount])
                } else {
                    self.outputDisplayImage(withImageName: mixedImages[testCount])
                }
            }
        }
    }
    
    @IBAction func btnBackTapped(_ sender: Any) {
        if Status[TestVisualAssociation] != TestStatus.Done {
            Status[TestVisualAssociation] = TestStatus.NotStarted
        }
        timerVA.invalidate()
        inputTimer.invalidate()
        self.startTimeTask = Foundation.Date()
        self.totalTimeCounter.invalidate()
        afterBreakVA = false
        
        // Check if is in quickStart mode
        guard !quickStartModeOn else {
            didBackToResult?()
            return
        }
        
        navigationController?.popViewController(animated: true)
        
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
        recognizeTimes.append((timeInput * 10).rounded() / 10)
        timeInput = 0
        if (orderRecognize[testCount] == 0) {
            recognizeErrors.append(0)
        } else {
            recognizeErrors.append(1)
        }
        
        recognizeNext()
    }
    
    @IBAction func recognize2(_ sender: AnyObject) {
        recognizeTimes.append((timeInput * 10).rounded() / 10)
        timeInput = 0
        if (orderRecognize[testCount] == 0) {
            recognizeErrors.append(1)
        } else {
            recognizeErrors.append(0)
        }
        
        recognizeNext()
    }
    
    @IBAction func actionQuit(_ sender: Any) {
        if Status[TestVisualAssociation] != TestStatus.Done {
            Status[TestVisualAssociation] = TestStatus.NotStarted
        }
        timerVA.invalidate()
        inputTimer.invalidate()
        self.startTimeTask = Foundation.Date()
        self.totalTimeCounter.invalidate()
        afterBreakVA = false
        
        // Check if is in quickStart mode
        guard !quickStartModeOn else {
            QuickStartManager.showAlertCompletion(viewController: self, cancel: {
                self.didBackToResult?()
            }) {
                self.didCompleted?()
            }
            return
        }
        
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func actionReset(_ sender: Any) {
        
//        isTaskViewHidden(true)
        isImageViewHidden(true)
        isRecommendDelayHidden(true)
        isRememberAgainViewHidden(true)
        isViewRegconizeHidden(true)
        isMissingItemViewHidden(true)
        isResultViewHidden(true)
        isDropDownViewHidden(true)
        self.startNewTask()
    }
    
    @IBAction func showDropDownList(_ sender: Any) {
        if isDropDownShowing {
            dismissDropDownList()
        } else {
            isDropDownViewHidden(false)
            isDropDownShowing = true
            self.delayTimePickerView.layer.borderColor =  Color.color(hexString: "#649BFF").cgColor
        }
    }
    
    @IBAction func setDelayTimePicker(_ sender: Any) {
        Settings.VADelayTime = delayReccommendedTime
        dismissDropDownList()
    }
}

extension VATask {
    fileprivate func setupView() {
        // Label Back
        self.backTitleLabel.font = Font.font(name: Font.Montserrat.semiBold, size: 28.0)
        self.backTitleLabel.textColor = Color.color(hexString: "#013AA5")
        self.backTitleLabel.addTextSpacing(-0.56)
        self.backTitleLabel.text = "BACK"
        
        // Label Description Task
        self.descriptionLabel.font = Font.font(name: Font.Montserrat.mediumItalic, size: 18.0)
        self.descriptionLabel.textColor = Color.color(hexString: "#013AA5")
        self.descriptionLabel.alpha = 0.67
        self.descriptionLabel.text = "Ask Patient to name and remember the two items in the photograph"
        self.descriptionLabel.addLineSpacing(10.0)
        self.descriptionLabel.addTextSpacing(-0.36)
        
        // Button Reset
        self.resetButton.setTitle(title: "RESET", withFont: Font.font(name: Font.Montserrat.bold, size: 18))
        self.resetButton.setupShadow(withColor: UIColor.clear, sketchBlur: 0, opacity: 0)
        self.resetButton.setupGradient(arrColor: [Color.color(hexString: "#FFDC6E"),Color.color(hexString: "#FFC556")], direction: .topToBottom)
        self.resetButton.render()
        self.resetButton.addTextSpacing(-0.36)
        
        // Button Quit
        self.quitButton.setTitle(title: "QUIT", withFont: Font.font(name: Font.Montserrat.bold, size: 18))
        self.quitButton.setupShadow(withColor: UIColor.clear, sketchBlur: 0, opacity: 0)
        self.quitButton.setupGradient(arrColor: [Color.color(hexString: "FFAFA6"),Color.color(hexString: "FE786A")], direction: .topToBottom)
        self.quitButton.render()
        self.quitButton.addTextSpacing(-0.36)
        
        self.setupCollectionView()
        self.setupViewTask()
        self.setupViewDelay()
        self.setupViewNotice()
        self.setupViewMissingItem()
        self.setupViewResult()
        
        isTaskViewHidden(true)
        isImageViewHidden(true)
        isRecommendDelayHidden(true)
        isRememberAgainViewHidden(true)
        isViewRegconizeHidden(true)
        isMissingItemViewHidden(true)
        isResultViewHidden(true)
        isDropDownViewHidden(true)
        isCollectionViewHidden(true)
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
        self.delayDescriptionLabel.text = "Setting delay time"
        self.delayDescriptionLabel.addTextSpacing(-0.36)
        self.delayDescriptionLabel.textAlignment = .center
        
        self.delayTimePickerView.layer.borderWidth = 1
        self.delayTimePickerView.layer.borderColor = Color.color(hexString: "#EAEAEA").cgColor
        self.delayTimePickerView.layer.cornerRadius = 8
        self.delayTimePickerView.layer.masksToBounds = true
        
        var row: Int!
        self.delayTimePickerLabel.font = Font.font(name: Font.Montserrat.medium, size: 18.0)
        if let timeDelay = Settings.VADelayTime {
            self.delayTimePickerLabel.text = timeDelay / 60 == 1 ? "1 minute" : "\(timeDelay / 60) minutes"
            row = timeDelay / 60 - 1
        } else {
            self.delayTimePickerLabel.text = "5 minutes"
            row = 4
        }
        
        self.setDelayTimeButton.backgroundColor = Color.color(hexString: "#EEF3F9")
        self.setDelayTimeButton.titleLabel?.font = Font.font(name: Font.Montserrat.semiBold, size: 18.0)
        self.setDelayTimeButton.tintColor = Color.color(hexString: "#013AA5")
        self.setDelayTimeButton.layer.cornerRadius = 8
        self.setDelayTimeButton.layer.masksToBounds = true
        
        self.delayLabel.font = Font.font(name: Font.Montserrat.semiBold, size: 28.0)
        self.delayLabel.textColor = Color.color(hexString: "#013AA5")
        if let delayTime = Settings.VADelayTime {
            self.delayLabel.text = delayTime / 60 == 1 ? "Recommended Delay : 1 minute" : "Recommended Delay : \(delayTime / 60) minutes"
        } else {
            self.delayLabel.text = "Recommended Delay : 5 minutes"
        }
        self.delayLabel.addTextSpacing(-0.56)
        
        self.timerLabel.font = Font.font(name: Font.Montserrat.semiBold, size: 72.0)
        self.timerLabel.textColor = Color.color(hexString: "#013AA5")
        self.timerLabel.addTextSpacing(-1.44)
        
        self.startButton.setTitle(title: "START NOW", withFont: Font.font(name: Font.Montserrat.bold, size: 22.0))
        self.startButton.setupShadow(withColor: .clear, sketchBlur: 0, opacity: 0)
        self.startButton.setupGradient(arrColor: [Color.color(hexString: "#FFDC6E"),Color.color(hexString: "#FFC556")], direction: .topToBottom)
        self.startButton.addTextSpacing(-0.36)
        self.startButton.render()
        
        self.timePickerContentView.layer.borderWidth = 1
        self.timePickerContentView.layer.borderColor = Color.color(hexString: "#649BFF").cgColor
        self.timePickerContentView.layer.masksToBounds = true
        
        self.timePickerTableView.dataSource = self
        self.timePickerTableView.delegate = self
        self.timePickerTableView.isScrollEnabled = false
        self.timePickerTableView.separatorStyle = .none
        self.timePickerTableView.register(VADropDownCell.nib(), forCellReuseIdentifier: VADropDownCell.cellId)
        self.timePickerTableView.selectRow(at: IndexPath.init(row: row, section: 0), animated: false, scrollPosition: .none)
    }
    
    fileprivate func setupViewNotice() {
        self.noticeLabel.font = Font.font(name: Font.Montserrat.medium, size: 18.0)
        self.noticeLabel.textColor = Color.color(hexString: "#000000")
        self.noticeLabel.text = "Name out loud and remember the two items in the photographs again"
        self.noticeLabel.addLineSpacing(15.0)
        self.noticeLabel.addTextSpacing(-0.36)
        self.noticeLabel.textAlignment = .center
        
        self.noticeButton.setTitle(title: "START NOW", withFont: Font.font(name: Font.Montserrat.bold, size: 22.0))
        self.noticeButton.setupShadow(withColor: .clear, sketchBlur: 0, opacity: 0)
        self.noticeButton.setupGradient(arrColor: [Color.color(hexString: "#FFDC6E"),Color.color(hexString: "#FFC556")], direction: .topToBottom)
        self.noticeButton.addTextSpacing(-0.36)
        self.noticeButton.render()
    }
    
    fileprivate func setupViewMissingItem() {
        self.missingItemLabel.font = Font.font(name: Font.Montserrat.medium, size: 28.0)
        self.missingItemLabel.textColor = Color.color(hexString: "#8A9199")
        self.missingItemLabel.addTextSpacing(-0.36)
        self.missingItemLabel.text = "The missing item is"
        
        self.missingItemTextField.font = Font.font(name: Font.Montserrat.medium, size: 28.0)
        
        self.remainingPhotoLabel.font = Font.font(name: Font.Montserrat.medium, size: 28.0)
        self.remainingPhotoLabel.textColor = Color.color(hexString: "#8A9199")
        self.remainingPhotoLabel.addTextSpacing(-0.36)
        self.remainingPhotoLabel.text = "1/5"
    }
    
    fileprivate func setupCounterTimeView() {
        counterTimeView = CounterTimeView()
        contentView.addSubview(counterTimeView!)
        counterTimeView?.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        counterTimeView?.centerYAnchor.constraint(equalTo: backTitleLabel.centerYAnchor).isActive = true
        self.totalTimeCounter.invalidate()
        self.runTimer()
    }
    
    fileprivate func setupViewResult() {
        self.resultTitleLabel.font = Font.font(name: Font.Montserrat.semiBold, size: 28.0)
        self.resultTitleLabel.textColor = Color.color(hexString: "#013AA5")
        self.resultTitleLabel.addTextSpacing(-0.56)
        self.resultTitleLabel.text = "RESULTS"
        
        self.totalTimeLabel.font = Font.font(name: Font.Montserrat.mediumItalic, size: 18.0)
        self.totalTimeLabel.textColor = Color.color(hexString: "#000000")
        self.totalTimeLabel.addTextSpacing(-0.56)
        
        self.delayLengthLabel.font = Font.font(name: Font.Montserrat.medium, size: 18.0)
        self.delayLengthLabel.textColor = Color.color(hexString: "#8A9199")
        self.delayLengthLabel.addTextSpacing(-0.56)
        
        self.delayTimeLabel.font = Font.font(name: Font.Montserrat.medium, size: 18.0)
        self.delayTimeLabel.textColor = Color.color(hexString: "#000000")
        self.delayTimeLabel.addTextSpacing(-0.56)
    }
    
    fileprivate func setupResultTableView() {
        recalledTableView.delegate = self
        recalledTableView.dataSource = self
        recalledTableView.allowsSelection = false
        recalledTableView.separatorStyle = .none
        recalledTableView.register(VACell.nib(), forCellReuseIdentifier: VACell.cellId)
        
        regconizedTableView.delegate = self
        regconizedTableView.dataSource = self
        regconizedTableView.allowsSelection = false
        regconizedTableView.separatorStyle = .none
        regconizedTableView.register(VACell.nib(), forCellReuseIdentifier: VACell.cellId)
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
    
    fileprivate func isMissingItemViewHidden(_ isHidden: Bool) {
        self.missingItemLabel.isHidden = isHidden
        self.missingItemTextField.isHidden = isHidden
        self.remainingPhotoLabel.isHidden = isHidden
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
        self.delayTimePickerView.isHidden = isHidden
        self.delayTimePickerLabel.isHidden = isHidden
        self.delayTimePickerImageView.isHidden = isHidden
        self.setDelayTimeButton.isHidden = isHidden
    }
    
    fileprivate func isViewRegconizeHidden(_ isHidden: Bool) {
        self.viewRegconize.isHidden = isHidden
        self.firstButton.isHidden = isHidden
        self.secondButton.isHidden = isHidden
    }
    
    fileprivate func isResultViewHidden(_ isHidden: Bool) {
        self.resultTitleLabel.isHidden = isHidden
        self.totalTimeLabel.isHidden = isHidden
        self.totalTimeLabel.isHidden = isHidden
        self.delayLengthLabel.isHidden = isHidden
        self.delayTimeLabel.isHidden = isHidden
        self.recalledTableView.isHidden = isHidden
        self.regconizedTableView.isHidden = isHidden
        self.resultScrollView.isHidden = isHidden
    }
    
    fileprivate func isDropDownViewHidden(_ isHidden: Bool) {
        self.timePickerTableView.isHidden = isHidden
        self.timePickerContentView.isHidden = isHidden
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
            imageName = mixed1[0]
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

extension VATask: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableView == timePickerTableView ? 5 : mixedImages.count + 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == timePickerTableView {
            let dropDownCell = tableView.dequeueReusableCell(withIdentifier: VADropDownCell.cellId, for: indexPath) as! VADropDownCell
            dropDownCell.timeLabel.text = indexPath.row == 0 ? "1 minute" : "\(indexPath.row + 1) minutes"
            
            let cellSelectedColor = UIView()
            cellSelectedColor.backgroundColor = Color.color(hexString: "#EAEAEA")
            dropDownCell.selectedBackgroundView = cellSelectedColor
            
            return dropDownCell
        } else {
            var cell = VACell()
            cell = tableView.dequeueReusableCell(withIdentifier: VACell.cellId, for: indexPath) as! VACell
            if tableView == recalledTableView {
                cell.configRecallTest(imageNameList: mixedImages, resultList: textInputList, timeList: recallTimes, indexPath: indexPath)
            } else {
                cell.configRegconizedTest(imageNameList: mixedImages, recognizeErrors: recognizeErrors, timeList: recognizeTimes, indexPath: indexPath)
            }
            return cell
        }
    }
}

extension VATask: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == timePickerTableView {
            delayTimePickerLabel.text = indexPath.row == 0 ? "1 minute" : "\(indexPath.row + 1) minutes"
            delayReccommendedTime = (indexPath.row + 1) * 60
            dismissDropDownList()
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        isMissingItemTextFieldChanged = true
        return true
    }
}

extension VATask: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        if touches.first?.view != timePickerTableView {
            dismissDropDownList()
        }
    }
}
