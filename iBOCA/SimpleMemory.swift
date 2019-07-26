//
//  SimpleMemoryTask.swift
//  iBOCA
//
//  Created by School on 8/29/16.
//  Copyright © 2016 sunspot. All rights reserved.
//

import Foundation

import UIKit

var afterBreakSM = Bool()

var recognizeIncorrectSM = [String]()

var imagesSM = [String]()

var imageSetSM = Int()
var incorrectImageSetSM = Int()

var startTimeSM = TimeInterval()
var timerSM = Timer()
var StartTimer = Foundation.Date()
class SimpleMemoryTask: ViewController {
    
    // MARK: - Outlet
    @IBOutlet weak var lblBack: UILabel!
    @IBOutlet weak var lblDescTask: UILabel!
    
    @IBOutlet weak var collectionViewLevel: UICollectionView!
    
    @IBOutlet weak var vShadowTask: UIView!
    @IBOutlet weak var vTask: UIView!
    @IBOutlet weak var ivTask: UIImageView!
    
    @IBOutlet weak var lblSetDelayTime: UILabel!
    @IBOutlet weak var vSetDelayTime: UIView!
    
    @IBOutlet weak var lblChooseDelayTime: UILabel!
    @IBOutlet weak var btnChooseDelayTime: UIButton!
    @IBOutlet weak var btnSetDelayTime: UIButton!
    
    @IBOutlet weak var vDelay: UIView!
    
    @IBOutlet weak var collectionViewObjectName: UICollectionView!
    
    @IBOutlet weak var vResults: UIView!
    @IBOutlet weak var lblDelayLength: UILabel!
    @IBOutlet weak var btnStartNew: GradientButton!
    @IBOutlet weak var quitButton: GradientButton!
    
    @IBOutlet weak var lblTimeCompleteTask: UILabel!
    
    @IBOutlet weak var tableViewResults: UITableView!
    
    @IBOutlet weak var vCounterTimer: UIView!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var delayLabel: UILabel!
    @IBOutlet weak var resultTitleLabel: UILabel!
    
    @IBOutlet weak var next1: UIButton!
    @IBOutlet weak var start: GradientButton!
    @IBOutlet weak var back: UIButton!
    
    @IBOutlet weak var btnArrowLeft: UIButton!
    @IBOutlet weak var btnArrowRight: UIButton!
    
    // MARK: - Variable
    var TestTypes : [String] = ["1", "2", "3", "4", "5", "6", "7", "8"]
    
    var IncorrectTypes: [String] = ["1", "2", "3", "4", "5", "6", "7", "8"]
    
    var resultList : [String:Any] = [:]
    
    var delayTime = Double()
    
    let maxSeconds = 60.0
    
    var totalTime = 60
    
    var ended = false
    
    var isStartNew = false
    
    var testCount = 0
    
    var images0 = ["binoculars", "can", "cat", "elbow", "pipe", "rainbow"]
    var images1 = ["bottle", "coral", "ladder", "owl", "saw", "shoe"]
    var images2 = ["bee", "corn", "lamp", "sheep", "violin", "watch"]
    var images3 = ["basket", "candle", "doll", "knife", "skeleton", "star"]
    var images4 = ["briefcase", "chair", "duck", "microphone", "needle", "stairs"]
    var images5 = ["baseball", "drum", "necklace", "shovel", "tank", "toilet"]
    var images6 = ["anchor", "eyebrow", "flashlight", "glove", "moon", "sword"]
    var images7 = ["lion", "nut", "piano", "ring", "scissors", "whisk"]
    
    var imagesLevel = ["binoculars", "bottle", "bee", "basket"]
    
    var imageName = ""
    var image = UIImage()
    var imageView = UIImageView()
    
    var imageName1 = ""
    var image1 = UIImage()
    
    var imageName2 = ""
    var image2 = UIImage()
    
    var buttonList = [UIButton]()
    
    var buttonTaps = [Bool]()
    
    var recallIncorrect = Int()
    var recallPlus = UIButton()
    var recallLabel = UILabel()
    
    var arrowButton1 = UIButton()
    var arrowButton2 = UIButton()
    
    var orderRecognize = [Int]()
    
    var testSelectButtons : [UIButton] = []
    
    var result: Results!
    
    var resultsTask: [SMResultModel] = [SMResultModel]()
    
    var counterTime: CounterTimeView!
    var totalTimeCounter = Timer()
    var startTimeTask = Foundation.Date()
    
    let dataMinutesDropDown = [
        "1 minute",
        "2 minutes",
        "3 minutes",
        "4 minutes",
        "5 minutes"
    ]
    var dropDownView: DropdownView!
    
    // QuickStart Mode
    var quickStartModeOn: Bool = false
    var didBackToResult: (() -> ())?
    var didCompleted: (() -> ())?
    
    // MARK: - Load Views
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.setupViews()
        startDisplayAlert()
        
        StartTimer = Foundation.Date()
        
        result = Results()
        result.name = TestName.SIMPLE_MEMORY
        result.startTime = StartTimer
        next1.isHidden = true
        start.isHidden = false
        
        
        // QuickStart Mode
        if quickStartModeOn {
            lblBack.text = "RESULT"
            quitButton.updateTitle(title: "CONTINUE")
        }
        
        // Hide arrow
        self.btnArrowLeft.isHidden = true
        self.btnArrowRight.isHidden = true
        
        afterBreakSM = false
        
        // MARK: - TODO
        self.start.isHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.landscape
    }
}

// MARK: - Setup UI
extension SimpleMemoryTask {
    fileprivate func setupViews() {
        // View Counter Timer
        self.setupViewCounterTimer()
        
        // Label Back
        self.lblBack.font = Font.font(name: Font.Montserrat.semiBold, size: 28.0)
        self.lblBack.textColor = Color.color(hexString: "#013AA5")
        self.lblBack.addTextSpacing(-0.56)
        self.lblBack.text = "BACK"
        
        // Label Description Task
        self.lblDescTask.font = Font.font(name: Font.Montserrat.mediumItalic, size: 18.0)
        self.lblDescTask.textColor = Color.color(hexString: "#013AA5")
        self.lblDescTask.alpha = 0.67
        self.lblDescTask.text = "Ask Patient to name and remember these images"
        self.lblDescTask.addTextSpacing(-0.36)
        self.lblDescTask.addLineSpacing(10.0)
        
        self.quitButton.setTitle(title: "QUIT", withFont: Font.font(name: Font.Montserrat.bold, size: 18))
        self.quitButton.setupShadow(withColor: UIColor.clear, sketchBlur: 0, opacity: 0)
        self.quitButton.setupGradient(arrColor: [Color.color(hexString: "FFAFA6"),Color.color(hexString: "FE786A")], direction: .topToBottom)
        self.quitButton.render()
        self.quitButton.addTextSpacing(-0.36)
        
        // Collection View Level
        self.setupCollectionView()
        
        // View Task
        self.setupViewTask()
        
        // View Delay
        self.setupViewDelay()
        
        // View Object Name
        self.setupViewObjectName()
        
        // View Results
        self.setupViewResults()
        
        self.vShadowTask.isHidden = true
        self.vTask.isHidden = true
        self.vDelay.isHidden = true
        self.lblSetDelayTime.isHidden = true
        self.vSetDelayTime.isHidden = true
        self.btnSetDelayTime.isHidden = true
        self.vResults.isHidden = true
        self.collectionViewLevel.isHidden = true
    }
    
    fileprivate func setupCollectionView() {
        self.collectionViewLevel.backgroundColor = UIColor.clear
        self.collectionViewLevel.register(LevelCell.nib(), forCellWithReuseIdentifier: LevelCell.identifier())
        self.collectionViewLevel.delegate = self
        self.collectionViewLevel.dataSource = self
    }
    
    fileprivate func setupViewTask() {
        self.vShadowTask.layer.cornerRadius = 8.0
        self.vShadowTask.layer.shadowColor = Color.color(hexString: "#649BFF").withAlphaComponent(0.32).cgColor
        self.vShadowTask.layer.shadowOpacity = 1.0
        self.vShadowTask.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.vShadowTask.layer.shadowRadius = 10 / 2.0
        self.vShadowTask.layer.shadowPath = nil
        self.vShadowTask.layer.masksToBounds = false
        
        self.vTask.clipsToBounds = true
        self.vTask.backgroundColor = UIColor.white
        self.vTask.layer.cornerRadius = 8.0
        
        // Button Arrow Left, Right
        self.btnArrowLeft.backgroundColor = Color.color(hexString: "#EEF3F9")
        self.btnArrowLeft.layer.cornerRadius = self.btnArrowLeft.frame.size.height / 2.0
        self.btnArrowRight.backgroundColor = Color.color(hexString: "#EEF3F9")
        self.btnArrowRight.layer.cornerRadius = self.btnArrowRight.frame.size.height / 2.0
    }
    
    fileprivate func setupViewDelay() {
        
        self.setupViewSetDelayTime()
        
        self.delayLabel.font = Font.font(name: Font.Montserrat.semiBold, size: 28.0)
        self.delayLabel.textColor = Color.color(hexString: "#013AA5")
        self.delayLabel.text = "Recommended Delay : \(self.minuteOfString())"
        self.delayLabel.addTextSpacing(-0.56)
        
        self.timerLabel.font = Font.font(name: Font.Montserrat.semiBold, size: 72.0)
        self.timerLabel.textColor = Color.color(hexString: "#013AA5")
        self.timerLabel.addTextSpacing(-1.44)
        
        self.start.setTitle(title: "START NOW", withFont: Font.font(name: Font.Montserrat.bold, size: 22.0))
        self.start.setupShadow(withColor: UIColor.clear, sketchBlur: 0, opacity: 0)
        self.start.setupGradient(arrColor: [Color.color(hexString: "#FFDC6E"),Color.color(hexString: "#FFC556")], direction: .topToBottom)
        self.start.render()
        self.start.addTextSpacing(-0.44)
    }
    
    fileprivate func setupViewSetDelayTime() {
        self.lblSetDelayTime.font = Font.font(name: Font.Montserrat.medium, size: 18.0)
        self.lblSetDelayTime.textColor = Color.color(hexString: "#8A9199")
        self.lblSetDelayTime.text = "Setting delay time"
        self.lblSetDelayTime.addTextSpacing(-0.36)
        
        self.vSetDelayTime.clipsToBounds = true
        self.vSetDelayTime.backgroundColor = Color.color(hexString: "#F7F7F7")
        self.vSetDelayTime.layer.cornerRadius = 5.0
        self.vSetDelayTime.layer.borderWidth = 1.0
        self.vSetDelayTime.layer.borderColor = Color.color(hexString: "#EAEAEA").cgColor
        
        self.lblChooseDelayTime.addTextSpacing(-0.36)
        self.lblChooseDelayTime.text = self.minuteOfString()
        self.lblChooseDelayTime.font = Font.font(name: Font.Montserrat.medium, size: 18.0)
        self.lblChooseDelayTime.textColor = .black
        
        self.btnChooseDelayTime.tintColor = .clear
        self.btnChooseDelayTime.setTitleColor(UIColor.clear, for: .normal)
        
        // MARK: - Config Dropdown minute
        let x = self.vSetDelayTime.origin.x
        let y = self.vSetDelayTime.origin.y + self.vSetDelayTime.bounds.height + 6.0
        let frame = CGRect.init(x: x, y: y, width: self.vSetDelayTime.size.width, height: 118.0)
        self.dropDownView = DropdownView.init(frame: frame, style: .plain)
        self.dropDownView.dataArray = self.dataMinutesDropDown
        if let timeChoose = self.lblChooseDelayTime.text {
            self.dropDownView.itemSelected = timeChoose
        }
        self.dropDownView.dropdownDelegate = self
        self.vTask.addSubview(self.dropDownView)
        
        self.btnSetDelayTime.addTextSpacing(-0.36)
        self.btnSetDelayTime.layer.cornerRadius = 5.0
        self.btnSetDelayTime.setTitle("SET", for: .normal)
        self.btnSetDelayTime.setTitleColor(Color.color(hexString: "#013AA5"), for: .normal)
        self.btnSetDelayTime.titleLabel?.font = Font.font(name: Font.Montserrat.semiBold, size: 18.0)
        self.btnSetDelayTime.backgroundColor = Color.color(hexString: "#EEF3F9")
    }
    
    fileprivate func minuteOfString() -> String {
        if let delayTime = Settings.SMDelayTime, delayTime > 1 {
            return "\(delayTime) minutes"
        }
        else {
            return "1 minute"
        }
    }
    
    fileprivate func setupViewObjectName() {
        // Table View
        self.collectionViewObjectName.register(SimpleMemoryCell.nib(), forCellWithReuseIdentifier: SimpleMemoryCell.identifier())
        self.collectionViewObjectName.delegate = self
        self.collectionViewObjectName.dataSource = self
        self.collectionViewObjectName.isHidden = true
        
        // Button complete
        self.next1.titleLabel?.font = Font.font(name: Font.Montserrat.bold, size: 22.0)
        self.next1.backgroundColor = Color.color(hexString: "#EEF3F9")
        self.next1.tintColor = Color.color(hexString: "#013AA5")
        self.next1.setTitle("FINISH", for: .normal)
        self.next1.layer.cornerRadius = 8
        self.next1.layer.masksToBounds = true
    }
    
    fileprivate func setupViewResults() {
        self.vResults.clipsToBounds = true
        self.vResults.backgroundColor = UIColor.white
        self.vResults.layer.cornerRadius = 8.0
        
        self.resultTitleLabel.font = Font.font(name: Font.Montserrat.semiBold, size: 28.0)
        self.resultTitleLabel.textColor = Color.color(hexString: "#013AA5")
        self.resultTitleLabel.addTextSpacing(-0.56)
        
        self.lblDelayLength.font = Font.font(name: Font.Montserrat.medium, size: 18.0)
        self.lblDelayLength.addTextSpacing(-0.36)
        self.lblDelayLength.textColor = Color.color(hexString: "#8A9199")
        
        self.lblTimeCompleteTask.font = Font.font(name: Font.Montserrat.mediumItalic, size: 18.0)
        self.lblTimeCompleteTask.textColor = UIColor.black
        self.lblTimeCompleteTask.addTextSpacing(-0.36)
        self.lblTimeCompleteTask.textAlignment = .center
        
        // Button Start New
        self.btnStartNew.setTitle(title: "RESET", withFont: Font.font(name: Font.Montserrat.bold, size: 18))
        self.btnStartNew.setupShadow(withColor: UIColor.clear, sketchBlur: 0, opacity: 0)
        self.btnStartNew.setupGradient(arrColor: [Color.color(hexString: "#FFDC6E"),Color.color(hexString: "#FFC556")], direction: .topToBottom)
        self.btnStartNew.render()
        self.btnStartNew.addTextSpacing(-0.36)
        self.btnStartNew.addTarget(self, action: #selector(startNewTask), for:.touchUpInside)
        
        // TableView Results
        self.tableViewResults.register(SMResultCell.nib(), forCellReuseIdentifier: SMResultCell.identifier())
        self.tableViewResults.delegate = self
        self.tableViewResults.dataSource = self
        self.tableViewResults.alwaysBounceVertical = false
    }
    
    fileprivate func setupViewCounterTimer() {
        // View Couter Timer
        self.counterTime = CounterTimeView()
        self.vCounterTimer.backgroundColor = .clear
        self.vCounterTimer.addSubview(self.counterTime)
        self.counterTime.centerXAnchor.constraint(equalTo: self.vCounterTimer.centerXAnchor).isActive = true
        self.counterTime.centerYAnchor.constraint(equalTo: self.vCounterTimer.centerYAnchor).isActive = true
        self.startTimeTask = Foundation.Date()
        self.totalTimeCounter.invalidate()
        self.runTimer()
    }
    
    fileprivate func runTimer() {
        self.totalTimeCounter = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        self.totalTimeCounter.fire()
    }
    
    func updateTime(timer: Timer) {
        self.counterTime.setTimeWith(startTime: self.startTimeTask, currentTime: Foundation.Date())
    }
    
    func startAlert() {
        //back.isEnabled = false
        next1.isHidden = true
        
        // Update item Selected Dropdown & hide Dropdown
        self.updateDataDropDown()
        
        if self.isStartNew == false {
            let startAlert = UIAlertController(title: "Start", message: "Choose start option.", preferredStyle: .alert)
            startAlert.addAction(UIAlertAction(title: "Start New Task", style: .default, handler: { (action) -> Void in
                print("start new")
                recognizeIncorrectSM = self.images0
                imagesSM = self.images0
                imageSetSM = 0
                incorrectImageSetSM = 0
                
                self.startNewTask()
                
                //action
            }))
            
            if(afterBreakSM == true){
                startAlert.addAction(UIAlertAction(title: "Resume Task", style: .default, handler: { (action) -> Void in
                    print("resume old")
                    
                    for b in self.testSelectButtons {
                        b.isHidden = true
                    }
                    
                    self.start.isHidden = true
                    
                    self.resumeTask()
                    //action
                }))
            }
            
            startAlert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (action) -> Void in
                print("cancel")
                //self.back.isEnabled = true
                //action
            }))
            
            self.present(startAlert, animated: true, completion: nil)
        }
        else {
            recognizeIncorrectSM = self.images0
            imagesSM = self.images0
            imageSetSM = 0
            incorrectImageSetSM = 0
            
            self.startNewTask()
        }
    }
    
    func startNewTask() {
        
        self.lblChooseDelayTime.text = self.minuteOfString()
        // Update item Selected Dropdown & hide DropDown
        self.updateDataDropDown()
        
        self.vShadowTask.isHidden = false
        self.vTask.isHidden = false
        self.vDelay.isHidden = true
        self.lblSetDelayTime.isHidden = true
        self.vSetDelayTime.isHidden = true
        self.btnSetDelayTime.isHidden = true
        self.next1.isHidden = true
        self.collectionViewObjectName.isHidden = true
        
        self.ivTask.isHidden = true
        self.btnArrowLeft.isHidden = true
        self.btnArrowRight.isHidden = true
        
        self.lblDescTask.isHidden = false
//        self.collectionViewLevel.isHidden = false
        startDisplayAlert()
        
        self.start.isHidden = false
        self.vResults.isHidden = true
        
        self.collectionViewLevel.reloadData()
        
        self.delayLabel.text = "Recommended Delay : \(self.minuteOfString())"
        
        startTime = Foundation.Date()
        self.startTimeTask = Foundation.Date()
        self.totalTimeCounter.invalidate()
        self.runTimer()
        
        result = Results()
        result.name = TestName.SIMPLE_MEMORY
        result.startTime = startTime
        //        totalTime = Int(self.maxSeconds)
        ended = true
        self.isStartNew = true
        self.collectionViewObjectName.reloadData()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.isStartNew = false
        }
        timerSM.invalidate()
        afterBreakSM = false
        Status[TestSimpleMemory] = TestStatus.NotStarted
        
        buttonTaps = [Bool]()
        testCount = 0
        orderRecognize = [Int]()
        afterBreakSM = false
    }
    
    func startDisplayAlert() {
        // TODO: -
        randomTest()
        self.collectionViewLevel.isHidden = true
        self.lblDescTask.isHidden = true
        
        self.vShadowTask.isHidden = false
        self.vTask.isHidden = false
        
        Status[TestSimpleMemory] = TestStatus.Running
        
        start.isHidden = true
        
        for b in testSelectButtons {
            b.isHidden = true
        }
        
        //back.isEnabled = false
        
        let newStartAlert = UIAlertController(title: "Display", message: "Ask patient to name and remember these images.", preferredStyle: .alert)
        newStartAlert.addAction(UIAlertAction(title: "Start", style: .default, handler: { (action) -> Void in
            print("start")
            self.ivTask.isHidden = false
            self.display()
            //action
        }))
        self.present(newStartAlert, animated: true, completion: nil)
        
    }
    
    func display(){
        
        testCount = 0
        
        print("testCount = \(testCount), imagesSM = \(imagesSM)")
        print("imagesSM[testCount] = \(imagesSM[testCount])")
        
        // Show Arrow
        self.btnArrowRight.isHidden = false
        self.btnArrowLeft.isHidden = true
        //        outputImage(name: imagesSM[testCount])
        self.outputImage(withImageName: imagesSM[testCount])
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
        
        self.ivTask.image = UIImage(named: name)!
    }
    
    func beginDelay() {
        // Hide Arrow
        self.btnArrowLeft.isHidden = true
        self.btnArrowRight.isHidden = true
        self.ivTask.isHidden = true
        self.vDelay.isHidden = false
        self.lblSetDelayTime.isHidden = false
        self.vSetDelayTime.isHidden = false
        self.btnSetDelayTime.isHidden = false
        imageView.removeFromSuperview()
        print("in delay!")
        
        self.lblSetDelayTime.isHidden = false
        self.vSetDelayTime.isHidden = false
        self.btnSetDelayTime.isHidden = false
        self.timerLabel.isHidden = false
        self.delayLabel.isHidden = false
        
        afterBreakSM = true
        
        self.start.isHidden = false
        
        if let delayTimes = Settings.SMDelayTime {
            delayTime = Double(delayTimes) * 60
            totalTime = delayTimes * 60
        } else {
            delayTime = 60
            totalTime = 60
        }
        
        timerSM = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimeDecreases), userInfo: nil, repeats: true)
        timerSM.fire()
        startTimeSM = NSDate.timeIntervalSinceReferenceDate
    }
    
    func updateInDelay(timer:Timer){
        
        let currTime = NSDate.timeIntervalSinceReferenceDate
        var diff: TimeInterval = currTime - startTimeSM
        
        let minutes = UInt8(diff / self.maxSeconds)
        
        diff -= (TimeInterval(minutes) * self.maxSeconds)
        
        let seconds = UInt8(diff)
        
        diff = TimeInterval(seconds)
        
        let strMinutes = minutes > 9 ? String(minutes):"0"+String(minutes)
        let strSeconds = seconds > 9 ? String(seconds):"0"+String(seconds)
        if strMinutes != "00", strSeconds != "00"  {
            timerLabel.textColor = UIColor.red
        }
        timerLabel.text = "\(strMinutes) : \(strSeconds)"
    }
    
    func updateTimeDecreases(timer:Timer) {
        timerLabel.text = "\(timeFormatted(totalTime))"
        if totalTime != 0 {
            totalTime -= 1
        } else {
            self.updateDataDropDown()
            endTimer()
        }
    }
    
    func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        //     let hours: Int = totalSeconds / 3600
        return String(format: "%02d : %02d", minutes, seconds)
    }
    
    func endTimer() {
        timerSM.invalidate()
        self.start.isHidden = true
        self.resumeTask()
    }
    
    func resumeTask() {
        timerSM.invalidate()
        self.lblSetDelayTime.isHidden = true
        self.vSetDelayTime.isHidden = true
        self.btnSetDelayTime.isHidden = true
        self.timerLabel.isHidden = true
        self.delayLabel.isHidden = true
        
        delayTime = delayTime - Double(self.totalTime)
        
        let recallAlert = UIAlertController(title: "Recall", message: "Ask patients to name the items that were displayed earlier. Record their answers.", preferredStyle: .alert)
        recallAlert.addAction(UIAlertAction(title: "Continue", style: .default, handler: { (action) -> Void in
            print("recalling...")
            
            //action
            self.collectionViewObjectName.isHidden = false
            self.collectionViewObjectName.reloadData()
            self.next1.isHidden = false
            self.next1.isEnabled = true
            self.next1.addTarget(self, action: #selector(self.doneSM), for: UIControlEvents.touchUpInside)
        }))
        self.present(recallAlert, animated: true, completion: nil)
    }
    
    func findTime() -> Double {
        let currTime = NSDate.timeIntervalSinceReferenceDate
        let time = Double(Int((currTime - startTimeSM)*10))/10.0
        print("time: \(time)")
        return time
    }
    
    private func randomTest() {
        let randomNumber = Int.random(in: 0...3)
        switch randomNumber {
        case 0:
            imagesSM = images0
            imageSetSM = 0
            recognizeIncorrectSM = images4
            incorrectImageSetSM = 4
        case 1:
            imagesSM = images1
            imageSetSM = 1
            recognizeIncorrectSM = images5
            incorrectImageSetSM = 5
        case 2:
            imagesSM = images2
            imageSetSM = 2
            recognizeIncorrectSM = images6
            incorrectImageSetSM = 6
        case 3:
            imagesSM = images3
            imageSetSM = 3
            recognizeIncorrectSM = images7
            incorrectImageSetSM = 7
        default:
            imagesSM = images0
            imageSetSM = 0
            recognizeIncorrectSM = images0
            incorrectImageSetSM = 0
        }
    }
}

// MARK: - UICollectionView Delegate, DataSource, DelegateFlowLayout
extension SimpleMemoryTask: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionViewLevel {
            return self.imagesLevel.count
        }
        else {
            return 6
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.collectionViewLevel {
            let widthCollectionView: CGFloat = self.collectionViewLevel.frame.size.width
            let widthCell = ((widthCollectionView - 60) / 4)
            return CGSize.init(width: widthCell, height: 235.0)
        }
        else {
            let widthCollectionView: CGFloat = self.collectionViewObjectName.frame.size.width
            let widthCell = ((widthCollectionView - 27) / 2)
            return CGSize.init(width: widthCell, height: 74.0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == self.collectionViewLevel {
            return 20.0
        }
        else {
            return 27.0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == self.collectionViewLevel {
            return 20.0
        }
        else {
            return 27.0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.collectionViewLevel {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LevelCell.identifier(), for: indexPath) as! LevelCell
            let idx = indexPath.row + 1
            let strImageName = self.imagesLevel[indexPath.row]
            cell.ivLevel.image = UIImage.init(named: strImageName)
            cell.lblTitle.text = "Level \(idx)"
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SimpleMemoryCell.identifier(), for: indexPath) as! SimpleMemoryCell
            cell.lblTitle.text = "Object name \(indexPath.row + 1):"
            if self.isStartNew == true {
                cell.tfObjectName.text = ""
            }
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.collectionViewLevel {
            let idx = indexPath.item
            print("Selected Item \(idx)")
            switch idx {
            case 0:
                imagesSM = images0
                imageSetSM = 0
                recognizeIncorrectSM = images4
                incorrectImageSetSM = 4
            case 1:
                imagesSM = images1
                imageSetSM = 1
                recognizeIncorrectSM = images5
                incorrectImageSetSM = 5
            case 2:
                imagesSM = images2
                imageSetSM = 2
                recognizeIncorrectSM = images6
                incorrectImageSetSM = 6
            case 3:
                imagesSM = images3
                imageSetSM = 3
                recognizeIncorrectSM = images7
                incorrectImageSetSM = 7
            default:
                imagesSM = images0
                imageSetSM = 0
                recognizeIncorrectSM = images0
                incorrectImageSetSM = 0
            }
            
            self.startDisplayAlert()
        }
    }
}

// MARK: - UITableView Delegate, DataSource
extension SimpleMemoryTask: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SMResultCell.identifier(), for: indexPath) as! SMResultCell
        
        if indexPath.row == 0 {
            cell.isHeader = true
        }
        else {
            cell.isHeader = false
        }
        
        if self.resultsTask.count > 0 {
            cell.model = self.resultsTask[indexPath.row]
            if indexPath.row < self.resultsTask.count - 1 {
                cell.arrayConstraintLineBottom.forEach{ $0.constant = 0 }
            }
            else {
                cell.arrayConstraintLineBottom.forEach{ $0.constant = 1 }
            }
        }
        return cell
    }
}

// MARK: - Action
extension SimpleMemoryTask {
    @IBAction func btnArrowLeftTapped(_ sender: Any) {
        print("Arrow Left Tapped")
        testCount -= 1
        if testCount >= 0 {
            print("pic: \(testCount)")
            self.outputImage(withImageName: imagesSM[testCount])
        }
    }
    
    @IBAction func btnArrowRightTapped(_ sender: Any) {
        print("Arrow Right Tapped")
        testCount += 1
        if(testCount == imagesSM.count) {
            imageView.removeFromSuperview()
            print("delay")
            self.start.removeTarget(nil, action: nil, for: .allEvents)
            self.start.addTarget(self, action: #selector(startAlert), for:.touchUpInside)
            self.beginDelay()
        }
        else {
            print("pic: \(testCount)")
            self.outputImage(withImageName: imagesSM[testCount])
        }
    }
    
    @IBAction func btnChooseDelayTimeTapped(_ sender: Any) {
        self.dropDownView.showDropDown()
        if self.dropDownView.isDropDownShowing == true {
            // Border color selected
            self.vSetDelayTime.layer.borderColor = Color.color(hexString: "#649BFF").cgColor
        }
        else {
            // Border color normal
            self.vSetDelayTime.layer.borderColor = Color.color(hexString: "#EAEAEA").cgColor
        }
    }
    
    @IBAction func btnSetDelayTimeTapped(_ sender: Any) {
        if let item = self.lblChooseDelayTime.text, let idx = self.dataMinutesDropDown.index(of: item) {
            Settings.SMDelayTime = idx + 1
        }
        self.updateDataDropDown()
    }
    
    @IBAction func actionQuit(_ sender: Any) {
        self.startTimeTask = Foundation.Date()
        self.totalTimeCounter.invalidate()
        self.view.endEditing(true)
        Status[TestSimpleMemory] = TestStatus.NotStarted
        
        // Check if is on quickStart mode
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
    
    @IBAction func btnBackTapped(_ sender: Any) {
        ended = true
        timerSM.invalidate()
        afterBreakSM = false
        self.totalTimeCounter.invalidate()
        if Status[TestSimpleMemory] != TestStatus.Done {
            Status[TestSimpleMemory] = TestStatus.NotStarted
        }
        
        // Check if is in quickStart mode
        guard !quickStartModeOn else {
            self.didBackToResult?()
            return
        }
        
        navigationController?.popViewController(animated: true)
        
    }
    
    @objc fileprivate func doneSM() {
        self.view.endEditing(true)
        
        if checkValid() == false {
            let warningAlert = UIAlertController(title: "Warning", message: "Please enter all fields.", preferredStyle: .alert)
            warningAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) -> Void in
                warningAlert.dismiss(animated: true, completion: nil)
            }))
            self.present(warningAlert, animated: true, completion: nil)
        }
        else {
            ended = true
            //            totalTime = Int(self.maxSeconds)
            self.collectionViewObjectName.isHidden = true
            afterBreakSM = false
            self.next1.isHidden = true
            
            var outputResult = ""
            var exactEsults = "Exact results are:"
            var correct = 0
            var incorrect = 0
            self.resultsTask.removeAll()
            self.resultsTask.append(SMResultModel.init())
            
            for i in 0 ..< imagesSM.count {
                exactEsults += " \(imagesSM[i]),"
                let cell = self.collectionViewObjectName.cellForItem(at: IndexPath.init(row: i, section: 0)) as! SimpleMemoryCell
                guard let inputValue = cell.tfObjectName.text else {return}
                let objectName = "Object \(i+1)"
                let exactResult = imagesSM[i]
                if imagesSM.contains(inputValue.lowercased()) {
                    outputResult += "Input \(inputValue) - Correct\n"
                    correct += 1
                    
                    let correctResult = SMResultModel.init(objectName: objectName, input: inputValue, exactResult: exactResult, result: true)
                    self.resultsTask.append(correctResult)
                }
                else {
                    incorrect += 1
                    outputResult += "Input \(inputValue) - Incorrect\n"
                    
                    let inCorrectResult = SMResultModel.init(objectName: objectName, input: inputValue, exactResult: exactResult, result: false)
                    self.resultsTask.append(inCorrectResult)
                }
            }
            
            //delayResult + outputResult + exactEsults + timeComplete
            
            // Save Results
            self.totalTimeCounter.invalidate()
            result.endTime = Foundation.Date()
            let completeTime = result.totalElapsedSeconds()
            result.shortDescription = "Recall: \(correct) correct, \(incorrect) incorrect. (Sets correct:\(imageSetSM), incorrect:\(incorrectImageSetSM))"
            result.numCorrects = correct
            result.numErrors = incorrect
            resultList["CorrectImageSet"] = imageSetSM
            resultList["IncorrectImageSet"] = incorrectImageSetSM
            resultList["DelayTime"] = delayTime
            resultList["Recall Correct"] =  correct
            resultList["Recall Incorrect"] =  incorrect
            resultList["CompleteTime"] = completeTime//findTime()
            // get list result remove header
            for i in 0..<self.resultsTask.count {
                if i != 0 {
                    result.arrSMResult.append(self.resultsTask[i])
                }
            }
            result.json = resultList
            resultsArray.add(result)
            
            resultList = [:]
            
            Status[TestSimpleMemory] = TestStatus.Done
            
            // Set attributed into lblDelayLength
            let attrs1 = [NSFontAttributeName : Font.font(name: Font.Montserrat.medium, size: 18.0), NSForegroundColorAttributeName : Color.color(hexString: "#8A9199")]
            let attrs2 = [NSFontAttributeName : Font.font(name: Font.Montserrat.medium, size: 18.0), NSForegroundColorAttributeName : UIColor.black]
            let attrDelayTitle = NSMutableAttributedString(string:"Delay length :", attributes:attrs1)
            let attrDelayContent = NSMutableAttributedString(string:" \(delayTime) seconds", attributes:attrs2)
            
            attrDelayTitle.append(attrDelayContent)
            self.lblDelayLength.text = ""
            self.lblDelayLength.attributedText = attrDelayTitle
            self.lblTimeCompleteTask.text = "Test complete in \(completeTime) seconds"
            self.tableViewResults.reloadData()
            
            self.vResults.isHidden = false
            self.btnStartNew.isHidden = false
            self.btnStartNew.addTarget(self, action: #selector(startAlert), for:.touchUpInside)
        }
    }
    
    private func checkValid() -> Bool {
        var countEmpty = 0
        for i in 0 ..< imagesSM.count {
            let cell = self.collectionViewObjectName.cellForItem(at: IndexPath.init(row: i, section: 0)) as! SimpleMemoryCell
            if let inputValue = cell.tfObjectName.text, inputValue.isEmpty {
                countEmpty += 1
            }
        }
        
        if countEmpty != 0 {
            return false
        }
        else {
            return true
        }
    }
}

// MARK: - Dismiss Dropdown
extension SimpleMemoryTask {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        if touches.first?.view != self.dropDownView {
            self.vSetDelayTime.layer.borderColor = Color.color(hexString: "#EAEAEA").cgColor
            self.dropDownView.hideDropDown()
        }
    }
}

// MARK: - DropdownView Delegate Get Item Selected
extension SimpleMemoryTask: DropdownViewDelegate {
    func returnItemSelected(item: String) {
        self.vSetDelayTime.layer.borderColor = Color.color(hexString: "#EAEAEA").cgColor
        self.lblChooseDelayTime.text = item
    }
    
    /// Update data Item Selected, hide Dropdown and update State normal into button show dropdown
    func updateDataDropDown() {
        if let item = self.lblChooseDelayTime.text, item != self.minuteOfString() {
            self.dropDownView.itemSelected = item
        }
        else {
            self.dropDownView.itemSelected = self.minuteOfString()
        }
        self.vSetDelayTime.layer.borderColor = Color.color(hexString: "#EAEAEA").cgColor
        self.dropDownView.hideDropDown()
    }
}
