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
    
    @IBOutlet weak var back: UIButton!
    
    
    @IBOutlet weak var resultLabel: UILabel!
    
    
    var delayTime = Double()
    
    @IBOutlet weak var correct: UIButton!
    @IBOutlet weak var incorrect: UIButton!
    @IBOutlet weak var dk: UIButton!
    
    
    @IBOutlet weak var testPicker: UIPickerView!
    var TestTypes : [String] = ["1", "2", "3", "4", "5"]
    
    @IBOutlet weak var testPickerLabel: UILabel!
    
    @IBOutlet weak var btnArrowLeft: UIButton!
    @IBOutlet weak var btnArrowRight: UIButton!
    
    var totalTime = 300
    
    //Backpack Soccer
    var mixed0 = ["Backpack-Soccer", "Chair-Dog", "Dogbowl-Rope", "Mixer-Tennis", "Pot-Shoe"]
    var half0 = ["Backpack", "Chair", "Dogbowl", "Mixer", "Pot"]
    var incorrect0 = ["Backpack-Other", "Chair-Other", "Dogbowl-Other", "Mixer-Other", "Pot-Other"]
        //["red", "yellow", "blue", "black"]
    
    var mixed1 = ["Barney-FishingRod", "Chess-Calculator", "Goal-Bike", "Painting-Cello", "Racquet-Baseball"]
    var half1 = ["Barney", "Chess", "Goal", "Painting", "Racquet"]
    var incorrect1 = ["Barney-Other", "Chess-Other", "Goal-Other", "Painting-Other", "Racquet-Other"]
        //["red", "yellow", "blue", "black"]
    
    var mixed2 = ["Birdcage-Car", "Dog-Hat", "Horn-Duck", "Plant-Rabbit", "Teapot-Flower"]
    var half2 = ["Birdcage", "Dog", "Horn", "Plant", "Teapot"]
    var incorrect2 = ["Birdcage-Other", "Dog-Other", "Horn-Other", "Plant-Other", "Teapot-Other"]
    
    var mixed3 = ["Basket-Hanger", "FireExt-Scarf", "Grater-Lightbulb", "Pocketknife-Umbrella", "Sled-Dog"]
    var half3 = ["Basket", "FireExt", "Grater", "Pocketknife", "Sled"]
    var incorrect3 = ["Basket-Other", "FireExt-Other", "Grater-Other", "Pocketknife-Other", "Sled-Other"]
    
    var mixed4 = ["Candle-Sunglasses", "Firewood-Net", "Microwave-Eggbeater", "Shell-Watch", "Surge-Forks"]
    var half4 = ["Candle", "Firewood", "Microwave", "Shell", "Surge"]
    var incorrect4 = ["Candle-Other", "Firewood-Other", "Microwave-Other", "Shell-Other", "Surge-Other"]
    
        //["red", "yellow", "blue", "black"]
    /*
    var mixed3 = ["CarDog", "HornDuck", "PlantRabbit", "ToasterWrench"]
    var half3 = ["Car", "Horn", "Plant", "Toaster"]
    var incorrect3 = ["BikeOwl", "GolfShovel", "PiggybankPlant", "TeapotFlower"]
        //["red", "yellow", "blue", "black"]
    */
    var imageName = ""
    var image = UIImage()
    var imageView = UIImageView()
    var gestureHalf = UIPanGestureRecognizer()
    var gestureDisplay = UIPanGestureRecognizer()
    
    var imageName1 = ""
    var image1 = UIImage()
    var imageView1 = UIImageView()
    
    var imageName2 = ""
    var image2 = UIImage()
    var imageView2 = UIImageView()
    
    var arrowButton1 = UIButton()
    var arrowButton2 = UIButton()
    
    var orderRecognize = [Int]()
    
    var firstDisplay = Bool()
    
    var testCount = Int()
    
    
    @IBOutlet weak var startButton: GradientButton!
    
    @IBOutlet weak var backButton: UILabel!
    @IBOutlet weak var backLabel: UILabel!
    
    @IBOutlet weak var collectionViewLevel: UICollectionView!
    
    @IBOutlet weak var taskView: UIView!
    @IBOutlet weak var shadowTaskView: UIView!
    @IBOutlet weak var taskImageView: UIImageView!
    
    @IBOutlet weak var delayView: UIView!
    @IBOutlet weak var delayDescriptionLabel: UILabel!
    @IBOutlet weak var delayLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var rememberLabel: UILabel!
    @IBOutlet weak var rememberContinueButton: GradientButton!
    @IBOutlet weak var viewRememberAgain: UIView!
    
    @IBOutlet weak var viewRegconize: UIView!
    @IBOutlet weak var firstButton: UIButton!
    @IBOutlet weak var secondButton: UIButton!
    @IBOutlet weak var startNewButton: GradientButton!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.setupView()
        // Do any additional setup after loading the view, typically from a nib.
        //navigationItem.title = "back"
        
        // Hide arrow
        self.btnArrowLeft.isHidden = true
        self.btnArrowRight.isHidden = true
        
        testPicker.delegate = self
        testPicker.transform = CGAffineTransform(scaleX: 0.8, y: 1.0)
        
        gestureHalf = UIPanGestureRecognizer(target: self, action: #selector(wasDraggedHalf))
        
//        gestureDisplay = UIPanGestureRecognizer(target: self, action: #selector(wasDraggedDisplay))
        
        if(afterBreakVA == true){
//            timerVA = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(updateInDelay), userInfo: nil, repeats: true)
            timerVA = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimeDecreases), userInfo: nil, repeats: true)
            timerVA.fire()
//            delayLabel.text = "Recommended delay: 5 minutes"
            
            testPicker.isHidden = true
            testPickerLabel.isHidden = true
            
            startButton.removeTarget(self, action: #selector(startNewTask), for:.touchUpInside)
            startButton.removeTarget(self, action: #selector(startDisplayAlert), for:.touchUpInside)
            startButton.addTarget(self, action: #selector(startAlert), for:.touchUpInside)
        }
            
        else{
            testPicker.reloadAllComponents()
            testPicker.selectRow(0, inComponent: 0, animated: true)
//            testPicker.isHidden = false
//            testPickerLabel.isHidden = false
            
            imageSetVA = 0
            mixedImages = mixed0
            halfImages = half0
            recognizeIncorrectVA = incorrect0
            
            startButton.removeTarget(self, action: #selector(startNewTask), for:.touchUpInside)
            startButton.removeTarget(self, action: #selector(startAlert), for:.touchUpInside)
            startButton.addTarget(self, action: #selector(startDisplayAlert), for:.touchUpInside)
            
        }
        
        print(afterBreakVA)
        
        //back.isEnabled = true
        startButton.isEnabled = true
        
        correct.isHidden = true
        incorrect.isHidden = true
        dk.isHidden = true
        
    }
    @IBOutlet weak var viewRecommendDelay: UIView!
    
    func startAlert() {
        let startAlert = UIAlertController(title: "Start", message: "Choose start option.", preferredStyle: .alert)
        
        startAlert.addAction(UIAlertAction(title: "Start New Task", style: .default, handler: { (action) -> Void in
            print("start new")
//            Status[TestVisualAssociation] = TestStatus.Running
            
            self.startNewButton.isHidden = true
            self.isRecommendDelayHidden(true)
            self.isCollectionViewHidden(false)
            self.backButton.text = "VISUAL ASSOCIATION"
            self.isTaskViewHidden(true)
            
            imageSetVA = 0
            mixedImages = self.mixed0
            halfImages = self.half0
            recognizeIncorrectVA = self.incorrect0
            
            self.testPicker.reloadAllComponents()
            
            self.testPicker.selectRow(0, inComponent: 0, animated: true)
            
//            self.testPicker.isHidden = false
//            self.testPickerLabel.isHidden = false
            
            self.startNewTask()
            //action
        }))
        
        if(afterBreakVA == true){
            startAlert.addAction(UIAlertAction(title: "Resume Task", style: .default, handler: { (action) -> Void in
                print("resume old")
                
//                self.testPicker.isHidden = true
//                self.testPickerLabel.isHidden = true
                self.isRecommendDelayHidden(true)
                self.resumeTask()
            }))
        }
        
        startAlert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (action) -> Void in
            print("cancel")
        }))
        
        self.present(startAlert, animated: true, completion: nil)
        
    }
    
    func startNewTask(){
        Status[TestVisualAssociation] = TestStatus.NotStarted
        timerVA.invalidate()
        self.totalTime = 300
        recallErrors = [Int]()
        recallTimes = [Double]()
        recognizeErrors = [Int]()
        recognizeTimes = [Double]()
        orderRecognize = [Int]()
        testCount = 0
        resultLabel.text = ""
        afterBreakVA = false
        firstDisplay = true
        
//        timerLabel.text = ""
//        delayLabel.text = ""
        
        
//        timerLabel.text = ""
//        delayLabel.text = ""
        
//        testPicker.reloadAllComponents()
//        testPicker.selectRow(0, inComponent: 0, animated: true)
//        testPicker.isHidden = false
//        testPickerLabel.isHidden = false
        
        imageSetVA = 0
        mixedImages = mixed0
        halfImages = half0
        recognizeIncorrectVA = incorrect0
        
        self.collectionViewLevel.isHidden = false
        startButton.isHidden = false
        startButton.isEnabled = true
        
        startButton.removeTarget(self, action: #selector(startNewTask), for:.touchUpInside)
        startButton.removeTarget(self, action: #selector(startAlert), for:.touchUpInside)
        startButton.addTarget(self, action: #selector(startDisplayAlert), for:.touchUpInside)
        
    }
    
    func startDisplayAlert() {
        self.collectionViewLevel.isHidden = true
        self.backButton.text = "BACK"
        self.backLabel.isHidden = true
        
        self.shadowTaskView.isHidden = false
        self.taskView.isHidden = false
        
        Status[TestVisualAssociation] = TestStatus.Running
        
        startButton.isHidden = true
        testPicker.isHidden = true
        
        testPickerLabel.isHidden = true
        
        firstDisplay = true
        
        let newStartAlert = UIAlertController(title: "Display", message: "Ask patient to name and remember the two items in the photograph.", preferredStyle: .alert)
        newStartAlert.addAction(UIAlertAction(title: "Start", style: .default, handler: { (action) -> Void in
            print("start")
            self.display()
            //action
        }))
        self.present(newStartAlert, animated: true, completion: nil)
        
    }
    
    func numberOfComponentsInPickerView(_ pickerView : UIPickerView!) -> Int{
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        if pickerView == testPicker {
            
            return TestTypes.count
        }
        else {
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == testPicker {
            
            return TestTypes[row]
        }
        else {
            return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        print("2:", pickerView)
        if pickerView == testPicker {
            
            if row == 0 {
                imageSetVA = 0
                mixedImages = mixed0
                halfImages = half0
                recognizeIncorrectVA = incorrect0
            }
            if row == 1 {
                imageSetVA = 1
                mixedImages = mixed1
                halfImages = half1
                recognizeIncorrectVA = incorrect1
            }
            if row == 2 {
                imageSetVA = 2
                mixedImages = mixed2
                halfImages = half2
                recognizeIncorrectVA = incorrect2
            }
            
            if row == 3 {
                imageSetVA = 3
                mixedImages = mixed3
                halfImages = half3
                recognizeIncorrectVA = incorrect3
            }
            
            if row == 4 {
                imageSetVA = 4
                mixedImages = mixed4
                halfImages = half4
                recognizeIncorrectVA = incorrect4
            }
            
            startButton.isEnabled = true
            
        }
        
    }

    
    func display() {
        
        testCount = 0
        
        // Show Arrow
//        self.lblDescDelay.isHidden = true
//        self.start.isHidden = true
        self.taskImageView.isHidden = false
        self.btnArrowRight.isHidden = false
        self.btnArrowLeft.isHidden = true
        isRememberAgainViewHidden(true)
//        self.rememberLabel.isHidden = true
//        self.rememberStartButton.isHidden = true
        outputImage(withImageName: mixedImages[testCount])
    }
    
    func outputDisplayImage(_ name: String) {
        
        imageView.removeFromSuperview()
        
        imageName = name
        
        image = UIImage(named: imageName)!
        
        var x = CGFloat()
        var y = CGFloat()
        if 0.56*image.size.width < image.size.height {
            y = 575.0
            x = (575.0*(image.size.width)/(image.size.height))
        }
        else {
            x = 575.0
            y = (575.0*(image.size.height)/(image.size.width))
        }
        
        imageView = UIImageView(frame:CGRect(x: (512.0-(x/2)), y: (471.0-(y/2)), width: x, height: y))
        
        imageView.image = image
        
        imageView.isUserInteractionEnabled = true
//        imageView.removeGestureRecognizer(gestureHalf)
//        imageView.addGestureRecognizer(gestureDisplay)
        
        // Check Show/ Hide Arrow
        if testCount == 0 {
            self.btnArrowLeft.isHidden = true
            self.btnArrowRight.isHidden = false
        }
        else if testCount == imagesSM.count {
            self.btnArrowLeft.isHidden = false
            self.btnArrowRight.isHidden = true
        }
        else {
            self.btnArrowLeft.isHidden = false
            self.btnArrowRight.isHidden = false
        }
        
        self.view.addSubview(imageView)
        
    }
    
    func outputImage(withImageName name: String) {
        // Check Show/ Hide Arrow
        if testCount == 0 {
            self.btnArrowLeft.isHidden = true
            self.btnArrowRight.isHidden = false
        }
        else if testCount == imagesSM.count {
            self.btnArrowLeft.isHidden = false
            self.btnArrowRight.isHidden = true
        }
        else {
            self.btnArrowLeft.isHidden = false
            self.btnArrowRight.isHidden = false
        }
        
        self.taskImageView.image = UIImage(named: name)!
    }
    
    func outputDisplayImage(withImageName name: String) {
        
        // Check Show/ Hide Arrow
        if testCount == 0 {
            self.btnArrowLeft.isHidden = true
            self.btnArrowRight.isHidden = false
        }
        else if testCount == imagesSM.count {
            self.btnArrowLeft.isHidden = false
            self.btnArrowRight.isHidden = true
        }
        else {
            self.btnArrowLeft.isHidden = false
            self.btnArrowRight.isHidden = false
        }
        
        imageView.removeFromSuperview()
        imageName = name
        image = UIImage(named: imageName)!
        
        var x = CGFloat()
        var y = CGFloat()
        if 0.56*image.size.width < image.size.height {
            y = 575.0
            x = (575.0*(image.size.width)/(image.size.height))
        }
        else {
            x = 575.0
            y = (575.0*(image.size.height)/(image.size.width))
        }
        
        let yPostion = self.back.frame.origin.y + self.back.frame.size.height
        imageView = UIImageView(frame:CGRect(x: (512.0-(x/2)), y: yPostion, width: x, height: y))
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        self.view.addSubview(imageView)
        self.view.sendSubview(toBack: imageView)
    }
    
    func wasDraggedDisplay(_ gesture: UIPanGestureRecognizer) {
        
        let translation = gesture.translation(in: self.view)
        
        let img = gesture.view!
        img.center = CGPoint(x: self.view.bounds.width / 2 + translation.x, y: 471.0)
        
        if gesture.state == UIGestureRecognizerState.ended {
            if img.center.x < 200 {
                
                testCount += 1
                if(testCount == mixedImages.count){
                    
                    imageView.removeFromSuperview()
                    
                    if(firstDisplay == false){
                        imageView.removeGestureRecognizer(gestureDisplay)
                        beginDelay()
                    }
                    else{
                        
                        firstDisplay = false
                        
                        let nextAlert = UIAlertController(title: "Display", message: "Ask patient to name and remember the two items in the photograph again.", preferredStyle: .alert)
                        nextAlert.addAction(UIAlertAction(title: "Continue", style: .default, handler: { (action) -> Void in
                            print("continuing")
                            self.display()
                            //action
                        }))
                        present(nextAlert, animated: true, completion: nil)
                    }
                    
                }
                    
                else{
                    
                    print("next pic!")
                    img.center = CGPoint(x: 512.0, y: 471.0)
                    
                    outputDisplayImage(mixedImages[testCount])
                    
                }
                
            }
                
            else{
                
                print("back to center!")
                img.center = CGPoint(x: 512.0, y: 471.0)
                
            }
            
        }
        
    }
    
    func beginDelay(){
        // Hide Arrow
        isImageViewHidden(true)
        isRecommendDelayHidden(false)
        
        imageView.removeFromSuperview()
        print("in delay...")
        afterBreakVA = true
        
        startButton.removeTarget(self, action: nil, for:.allEvents)
        startButton.addTarget(self, action: #selector(startAlert), for:.touchUpInside)
        
//        timerVA = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(updateInDelay), userInfo: nil, repeats: true)
        timerVA = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimeDecreases), userInfo: nil, repeats: true)
        timerVA.fire()
        startTimeVA = NSDate.timeIntervalSinceReferenceDate
        
    }
    
    func updateInDelay(_ timer: Timer) {
        
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
    
    func updateTimeDecreases(timer:Timer) {
        timerLabel.text = "\(timeFormatted(totalTime))"
        if totalTime != 0 {
            totalTime -= 1
        } else {
            endTimer()
        }
    }
    
    func endTimer() {
        timerVA.invalidate()
        self.totalTime = 300
        self.testPicker.isHidden = true
        self.testPickerLabel.isHidden = true
        self.startButton.isHidden = true
        self.resumeTask()
    }
    
    func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        //     let hours: Int = totalSeconds / 3600
        return String(format: "%02d : %02d", minutes, seconds)
    }
    
    /*
     func updateInRecall(timer: NSTimer) {
     
     }
     */
    
    func outputImage(_ name: String) {
        
        imageView.removeFromSuperview()
        
        imageName = name
        
        image = UIImage(named: imageName)!
        
        var x = CGFloat()
        var y = CGFloat()
        if 0.56*image.size.width < image.size.height {
            y = 575.0
            x = (575.0*(image.size.width)/(image.size.height))
        }
        else {
            x = 575.0
            y = (575.0*(image.size.height)/(image.size.width))
        }
        
        let yPostion = self.back.frame.origin.y + self.back.frame.size.height
        imageView = UIImageView(frame:CGRect(x: (512.0-(x/2)), y: yPostion, width: x, height: y))
        
        imageView.image = image
        
        imageView.isUserInteractionEnabled = false
        
        self.view.addSubview(imageView)
        
    }
    
    func resumeTask(){
        
        delayTime = 300.0 - Double(self.totalTime)//findTime()
        
        timerVA.invalidate()
        
        let recallAlert = UIAlertController(title: "Recall", message: "Ask patient to name which item is missing from the picture and record their answer.", preferredStyle: .alert)
        recallAlert.addAction(UIAlertAction(title: "Continue", style: .default, handler: { (action) -> Void in
            print("recalling...")
            self.recall()
            //action
        }))
        self.present(recallAlert, animated: true, completion: nil)
        
        
    }
    
    func recall(){
        btnArrowLeft.isHidden = false
        btnArrowRight.isHidden = false
        taskImageView.isHidden = false
        
        correct.isHidden = false
        incorrect.isHidden = false
        dk.isHidden = false
        
        correct.isEnabled = true
        incorrect.isEnabled = true
        dk.isEnabled = true
        
        testCount = 0
        
//        outputImage(halfImages[testCount])
        outputImage(withImageName: halfImages[testCount])
        
        startTimeVA = NSDate.timeIntervalSinceReferenceDate
        
    }
    
    @IBAction func correctButton(_ sender: Any) {
        correct.isEnabled = false
        incorrect.isEnabled = false
        dk.isEnabled = false
        
        recallErrors.append(0)
        recallTimes.append(findTime())
        self.loadHalfImages()
    }
    
    @IBAction func incorrectButton(_ sender: Any) {
        
        correct.isEnabled = false
        incorrect.isEnabled = false
        dk.isEnabled = false
        
        recallErrors.append(1)
        recallTimes.append(findTime())
        self.loadHalfImages()
    }
    
    @IBAction func dkButton(_ sender: Any) {
        
        correct.isEnabled = false
        incorrect.isEnabled = false
        dk.isEnabled = false
        
        recallErrors.append(2)
        recallTimes.append(findTime())
        self.loadHalfImages()
    }
    
    func findTime()->Double{
        
        let currTime = NSDate.timeIntervalSinceReferenceDate
        let time = Double(Int((currTime - startTimeVA)*10))/10.0
        return time
        
    }
    
    func loadHalfImages() {
        self.testCount += 1
        if(testCount == halfImages.count) {
            imageView.removeFromSuperview()
            correct.isHidden = true
            incorrect.isHidden = true
            dk.isHidden = true
            
            isImageViewHidden(true)
            isRememberAgainViewHidden(false)
            self.rememberLabel.text = "Ask Patient to choose the photograph they have seen before"
            self.rememberContinueButton.setTitle(title: "CONTINUE", withFont: Font.font(name: Font.Montserrat.bold, size: 18.0))
            self.rememberContinueButton.render()
            self.rememberContinueButton.removeTarget(nil, action: nil, for: .allEvents)
            self.rememberContinueButton.addTarget(self, action: #selector(recognize), for: .touchUpInside)
        }
        else {
            print("next pic!")
            outputImage(withImageName: halfImages[testCount])
//            outputImage(halfImages[testCount])
            correct.isEnabled = true
            incorrect.isEnabled = true
            dk.isEnabled = true
        }
    }
    
    
    func wasDraggedHalf(_ gesture: UIPanGestureRecognizer) {
        
        let translation = gesture.translation(in: self.view)
        
        let img = gesture.view!
        img.center = CGPoint(x: self.view.bounds.width / 2 + translation.x, y: 471.0)
        
        if gesture.state == UIGestureRecognizerState.ended {
            if img.center.x < 200 {
                
                testCount += 1
                if(testCount == halfImages.count){
                    
                    imageView.removeFromSuperview()
                    correct.isHidden = true
                    incorrect.isHidden = true
                    dk.isHidden = true
                    
                    let recognizeAlert = UIAlertController(title: "Recognize", message: "Ask patient to choose the photograph they have seen before.", preferredStyle: .alert)
                    recognizeAlert.addAction(UIAlertAction(title: "Continue", style: .default, handler: { (action) -> Void in
                        print("recognizing...")
                        self.recognize()
                        //action
                    }))
                    self.present(recognizeAlert, animated: true, completion: nil)
                    
                }
                    
                else{
                    
                    print("next pic!")
                    img.center = CGPoint(x: 512.0, y: 471.0)
                    
                    outputImage(halfImages[testCount])
                    
                    correct.isEnabled = true
                    incorrect.isEnabled = true
                    dk.isEnabled = true
                    
//                    startTimeVA = NSDate.timeIntervalSinceReferenceDate
                    
                }
                
            }
                
            else{
                
                print("back to center!")
                img.center = CGPoint(x: 512.0, y: 471.0)
                
            }
            
        }
        
    }
    
    func recognize(){
        
        print("IN RECOGNIZE!!!")
        isRememberAgainViewHidden(true)
        
        testCount = 0
        
        randomizeRecognize()
        
        if(orderRecognize[testCount] == 0) {
            outputRecognizeImages(mixedImages[testCount], name2: recognizeIncorrectVA[testCount])
        }
        else{
            outputRecognizeImages(recognizeIncorrectVA[testCount], name2: mixedImages[testCount])
        }
        
        arrowButton1.isHidden = false
        arrowButton1.isEnabled = true
        
        arrowButton2.isHidden = false
        arrowButton2.isEnabled = true
        
        startTimeVA = NSDate.timeIntervalSinceReferenceDate
        
    }
    
    func outputRecognizeImages(_ name1: String, name2: String){
        
//        arrowButton1.removeFromSuperview()
//        arrowButton2.removeFromSuperview()
        isViewRegconizeHidden(false)
        
        imageName1 = name1
        imageName2 = name2
        
        image1 = UIImage(named: name1)!
        image2 = UIImage(named: name2)!
        
//        var x1 = CGFloat()
//        var x2 = CGFloat()
//
//        var y1 = CGFloat()
//        var y2 = CGFloat()
//
//        if 0.56*image1.size.width < image1.size.height {
//            y1 = 350.0
//            x1 = (350.0*(image1.size.width)/(image1.size.height))
//        }
//        else {
//            x1 = 350.0
//            y1 = (350.0*(image1.size.height)/(image1.size.width))
//        }
//
//        if 0.56*image2.size.width < image2.size.height {
//            y2 = 350.0
//            x2 = (350.0*(image2.size.width)/(image2.size.height))
//        }
//        else {
//            x2 = 350.0
//            y2 = (350.0*(image2.size.height)/(image2.size.width))
//        }
        
//        arrowButton1.frame = CGRect(x: (256.0-(x1/2)), y: (471.0-(y1/2)), width: 419, height: 419)
        firstButton.setImage(image1, for: .normal)
        firstButton.removeTarget(nil, action:nil, for: .allEvents)
        
        
//        arrowButton2.frame = CGRect(x: (768.0-(x2/2)), y: (471.0-(y2/2)), width: 419, height: 419)
        secondButton.setImage(image2, for: .normal)
        secondButton.removeTarget(nil, action:nil, for: .allEvents)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
            self.firstButton.addTarget(self, action: #selector(VATask.recognize1), for:.touchUpInside)
            self.secondButton.addTarget(self, action: #selector(VATask.recognize2), for:.touchUpInside)
        }
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
//            self.view.addSubview(self.arrowButton1)
//            self.view.addSubview(self.arrowButton2)
//        }
    }
    
    func randomizeRecognize(){
        
        //if 0, correct image on left; if 1, correct on right
        
        for _ in 0 ..< 5 {
            self.orderRecognize.append(Int(arc4random_uniform(2)))
        }
        
    }
    
    @IBAction func recognize1(_ sender: AnyObject){
        
        arrowButton1.isEnabled = false
        arrowButton2.isEnabled = false
        
        if(orderRecognize[testCount] == 0){
            recognizeErrors.append(0)
            recognizeTimes.append(findTime())
        }
        else{
            recognizeErrors.append(1)
            recognizeTimes.append(findTime())
        }
        
        recognizeNext()
        
    }
    
    @IBAction func recognize2(_ sender: AnyObject){
        
        arrowButton1.isEnabled = false
        arrowButton2.isEnabled = false
        
        if(orderRecognize[testCount] == 0){
            recognizeErrors.append(1)
            recognizeTimes.append(findTime())
        }
        else{
            recognizeErrors.append(0)
            recognizeTimes.append(findTime())
        }
        
        recognizeNext()
        
    }
    
    
    func recognizeNext() {
        
        testCount += 1
        
        if(testCount == mixedImages.count){
            isViewRegconizeHidden(true)
            done()
        }
            
        else{
            arrowButton1.isEnabled = true
            arrowButton2.isEnabled = true
            
            if(orderRecognize[testCount] == 0) {
                outputRecognizeImages(mixedImages[testCount], name2: recognizeIncorrectVA[testCount])
            }
            else{
                outputRecognizeImages(recognizeIncorrectVA[testCount], name2: mixedImages[testCount])
            }
            
        }
        
        
    }
    
    func done() {
        self.startNewButton.isHidden = false
        self.startNewButton.addTarget(self, action: #selector(startAlert), for: .touchUpInside)
        totalTime = 300
        let result = Results()
        result.name = "Visual Association"
        result.startTime = StartTime
        result.endTime = Foundation.Date()
        
        Status[TestVisualAssociation] = TestStatus.Done
        
        //back.isEnabled = true
        startButton.isEnabled = true
        
        afterBreakVA = false
        
        var recallResult = ""
        var recognizeResult = ""
        var delayResult = ""
        var imageSetResult = ""
        
        imageSetResult = "Image set = \(imageSetVA+1)\n"
        
        delayResult = "Delay length of \(delayTime) seconds\n"
        
        result.numErrors = 0
        
        for k in 0 ..< mixedImages.count {
            
            if(recallErrors[k] == 0){
                result.longDescription.add("Recalled \(mixedImages[k]) - Correct in \(recallTimes[k]) seconds")
                recallResult += "Recalled \(mixedImages[k]) - Correct in \(recallTimes[k]) seconds\n"
            }
            if(recallErrors[k] == 1){
                result.longDescription.add("Recalled \(mixedImages[k]) - Incorrect in \(recallTimes[k]) seconds")
                recallResult += "Recalled \(mixedImages[k]) - Incorrect in \(recallTimes[k]) seconds\n"
                result.numErrors += 1
            }
            if(recallErrors[k] == 2){
                result.longDescription.add("Couldn't recall \(mixedImages[k]) in \(recallTimes[k]) seconds")
                recallResult += "Couldn't recall \(mixedImages[k]) in \(recallTimes[k]) seconds\n"
                result.numErrors += 1
            }
            
            
            if(recognizeErrors[k] == 0){
                result.longDescription.add("Recognized \(mixedImages[k]) - Correct in \(recognizeTimes[k]) seconds")
                recognizeResult += "Recognized \(mixedImages[k]) - Correct in \(recognizeTimes[k]) seconds\n"
            }
            if(recognizeErrors[k] == 1){
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
        
        startButton.isHidden = false
        startButton.isEnabled = true
        startButton.removeTarget(self, action: #selector(startNewTask), for:.touchUpInside)
        startButton.removeTarget(self, action: #selector(startDisplayAlert), for:.touchUpInside)
        startButton.addTarget(self, action: #selector(startAlert), for:.touchUpInside)
        
    }
    
    func delay(_ delay:Double, closure:()->()) {
        /*
        dispatch_after(
            dispatch_time( dispatch_time_t(DISPATCH_TIME_NOW), Int64(delay * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), closure)
        */
        let when = DispatchTime.now() + 2 // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when) {
            //dispatchMain()
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.landscape
    }
    
    // MARK: - Action
    @IBAction func btnArrowLeftTapped(_ sender: Any) {
        print("Arrow Left Tapped")
        testCount -= 1
        if testCount >= 0 {
            print("pic: \(testCount)")
            self.outputImage(withImageName: mixedImages[testCount])
        }
    }
    
    @IBAction func btnArrowRightTapped(_ sender: Any) {
        print("Arrow Right Tapped")
        print("Arrow Right Tapped")
        testCount += 1
        if(testCount == mixedImages.count) {
            imageView.removeFromSuperview()
            print("delay")
            isImageViewHidden(true)
            if(firstDisplay == false) {
                imageView.removeGestureRecognizer(gestureDisplay)
                beginDelay()
            }
            else {
                firstDisplay = false
                isRememberAgainViewHidden(false)
                self.rememberContinueButton.removeTarget(nil, action: nil, for: .allEvents)
                self.rememberContinueButton.addTarget(self, action: #selector(display), for: .touchUpInside)
            }
        }
        else {
            print("pic: \(testCount)")
            self.outputImage(withImageName: mixedImages[testCount])
        }
    }
    
    @IBAction func btnBackTapped(_ sender: Any) {
        timerVA.invalidate()
        self.totalTime = 300
        afterBreakVA = false
        Status[TestVisualAssociation] = TestStatus.NotStarted
    }
    
}

extension VATask {
    fileprivate func setupView() {
        // Label Back
        self.backButton.font = Font.font(name: Font.Montserrat.bold, size: 28.0)
        self.backButton.textColor = Color.color(hexString: "#013AA5")
        self.backButton.addTextSpacing(-0.56)
        self.backButton.text = "VISUAL ASSOCIATION"
        
        // Label Description Task
        self.backLabel.font = Font.font(name: Font.Montserrat.mediumItalic, size: 18.0)
        self.backLabel.textColor = Color.color(hexString: "#013AA5")
        self.backLabel.alpha = 0.67
        self.backLabel.text = "Ask Patient to name and remember the two items in the photograph"
        self.backLabel.addLineSpacing(15.0)
        self.backLabel.addTextSpacing(-0.36)
        
        // Collection View Level
        self.setupCollectionView()
        
        // View Task
        self.setupViewTask()
        
        // View Delay
        self.setupViewDelay()
        
        isTaskViewHidden(true)
        isRecommendDelayHidden(true)
        isRememberAgainViewHidden(true)
        isViewRegconizeHidden(true)
        startNewButton.isHidden = true
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
        
        // Button Arrow Left, Right
        self.btnArrowLeft.backgroundColor = Color.color(hexString: "#EEF3F9")
        self.btnArrowLeft.layer.cornerRadius = self.btnArrowLeft.frame.size.height / 2.0
        self.btnArrowRight.backgroundColor = Color.color(hexString: "#EEF3F9")
        self.btnArrowRight.layer.cornerRadius = self.btnArrowRight.frame.size.height / 2.0
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
        
        let colors = [Color.color(hexString: "#FFDC6E"), Color.color(hexString: "#FFC556")]
        self.startButton.setTitle(title: "START NOW", withFont: Font.font(name: Font.Montserrat.bold, size: 18.0))
        self.startButton.setupShadow(withColor: .clear, sketchBlur: 0, opacity: 0)
        self.startButton.setupGradient(arrColor: colors, direction: .topToBottom)
        self.startButton.addTextSpacing(-0.36)
        self.startButton.render()
        
        self.rememberLabel.font = Font.font(name: Font.Montserrat.medium, size: 18.0)
        self.rememberLabel.textColor = Color.color(hexString: "#000000")
        self.rememberLabel.text = "Ask Patient to name and remember the two items in the photograph again"
        self.rememberLabel.addLineSpacing(15.0)
        self.rememberLabel.addTextSpacing(-0.36)
        self.rememberLabel.textAlignment = .center
        
        self.rememberContinueButton.setTitle(title: "START NOW", withFont: Font.font(name: Font.Montserrat.bold, size: 18.0))
        self.rememberContinueButton.setupShadow(withColor: .clear, sketchBlur: 0, opacity: 0)
        self.rememberContinueButton.setupGradient(arrColor: colors, direction: .topToBottom)
        self.rememberContinueButton.addTextSpacing(-0.36)
        self.rememberContinueButton.render()
        
        self.startNewButton.setTitle(title: "START NEW", withFont: Font.font(name: Font.Montserrat.bold, size: 18.0))
        self.startNewButton.setupShadow(withColor: .clear, sketchBlur: 0, opacity: 0)
        self.startNewButton.setupGradient(arrColor: colors, direction: .topToBottom)
        self.startNewButton.addTextSpacing(-0.36)
        self.startNewButton.render()
    }
    
    func isCollectionViewHidden(_ isHidden: Bool) {
        self.backLabel.isHidden = isHidden
        self.collectionViewLevel.isHidden = isHidden
    }
    
    func isTaskViewHidden(_ isHidden: Bool) {
        self.taskView.isHidden = isHidden
        self.shadowTaskView.isHidden = isHidden
    }
    
    func isImageViewHidden(_ isHidden: Bool) {
        self.btnArrowLeft.isHidden = isHidden
        self.btnArrowRight.isHidden = isHidden
        self.taskImageView.isHidden = isHidden
    }
    
    func isRememberAgainViewHidden(_ isHidden: Bool) {
        self.viewRememberAgain.isHidden = isHidden
        self.rememberLabel.isHidden = isHidden
        self.rememberContinueButton.isHidden = isHidden
    }
    
    func isRecommendDelayHidden(_ isHidden: Bool) {
        self.delayView.isHidden = isHidden
        self.delayDescriptionLabel.isHidden = isHidden
        self.startButton.isHidden = isHidden
        self.delayLabel.isHidden = isHidden
        self.timerLabel.isHidden = isHidden
    }
    
    func isViewRegconizeHidden(_ isHidden: Bool) {
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
        cell.lblTitle.text = "LEVEL \(indexPath.row + 1)"
        return cell
    }
    
    
}

extension VATask: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthCollectionView: CGFloat = self.collectionViewLevel.frame.size.width
        let widthCell = (widthCollectionView / 4) - 20
        return CGSize.init(width: widthCell, height: 235.0)
    }
}

extension VATask: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            imageSetVA = 0
            mixedImages = mixed0
            halfImages = half0
            recognizeIncorrectVA = incorrect0
        case 1:
            imageSetVA = 1
            mixedImages = mixed1
            halfImages = half1
            recognizeIncorrectVA = incorrect1
        case 2:
            imageSetVA = 2
            mixedImages = mixed2
            halfImages = half2
            recognizeIncorrectVA = incorrect2
        case 3:
            imageSetVA = 3
            mixedImages = mixed3
            halfImages = half3
            recognizeIncorrectVA = incorrect3
        default:
            imageSetVA = 4
            mixedImages = mixed4
            halfImages = half4
            recognizeIncorrectVA = incorrect4
        }
        self.startDisplayAlert()
    }
}


