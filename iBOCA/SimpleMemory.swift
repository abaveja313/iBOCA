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
    
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var delayLabel: UILabel!
    
    @IBOutlet weak var resultTitleLabel: UILabel!
    
    var TestTypes : [String] = ["1", "2", "3", "4", "5", "6", "7", "8"]
    
    var IncorrectTypes: [String] = ["1", "2", "3", "4", "5", "6", "7", "8"]
    
    var resultList : [String:Any] = [:]
    
    var delayTime = Double()
    
    let maxSeconds = 60.0
    
    var totalTime = 60
    
    var ended = false
    
    var isStartNew = false
    
    @IBOutlet weak var next1: GradientButton!
    @IBOutlet weak var start: GradientButton!
    @IBOutlet weak var back: UIButton!
    
    @IBOutlet weak var btnArrowLeft: UIButton!
    @IBOutlet weak var btnArrowRight: UIButton!
    
    var testCount = 0
    
    var images0 = ["binoculars", "can", "cat", "elbow", "pipe", "rainbow"]
    var images1 = ["bottle", "coral", "ladder", "owl", "saw", "shoe"]
    var images2 = ["bee", "corn", "lamp", "sheep", "violin", "watch"]
    var images3 = ["basket", "candle", "doll", "knife", "skeleton", "star"]
    var images4 = ["briefcase", "chair", "duck", "microphone", "needle", "stairs"]
    var images5 = ["baseball", "drum", "necklace", "shovel", "tank", "toilet"]
    var images6 = ["anchor", "eyebrow", "flashlight", "glove", "moon", "sword"]
    var images7 = ["lion", "nut", "piano", "ring", "scissors", "whisk"]
    
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
    
    @IBOutlet weak var lblBack: UILabel!
    @IBOutlet weak var lblDescTask: UILabel!
    
    @IBOutlet weak var collectionViewLevel: UICollectionView!
    
    @IBOutlet weak var vShadowTask: UIView!
    @IBOutlet weak var vTask: UIView!
    @IBOutlet weak var ivTask: UIImageView!
    
    @IBOutlet weak var vDelay: UIView!
    @IBOutlet weak var lblDescDelay: UILabel!
    
    @IBOutlet weak var collectionViewObjectName: UICollectionView!
    
    @IBOutlet weak var vResults: UIView!
    @IBOutlet weak var lblDelayLength: UILabel!
    @IBOutlet weak var btnStartNew: GradientButton!
    
    @IBOutlet weak var lblTimeCompleteTask: UILabel!
    
    @IBOutlet weak var tableViewResults: UITableView!
    
    var resultsTask: [SMResultModel] = [SMResultModel]()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.setupViews()
        
        result = Results()
        result.name = "Simple Memory"
        result.startTime = StartTimer
        next1.isHidden = true
        start.isHidden = false
        
        // Hide arrow
        self.btnArrowLeft.isHidden = true
        self.btnArrowRight.isHidden = true
        
        afterBreakSM = false
        
        // MARK: - TODO
        self.start.isHidden = true
    }
    
    func startAlert() {
        //back.isEnabled = false
        next1.isHidden = true
        
        let startAlert = UIAlertController(title: "Start", message: "Choose start option.", preferredStyle: .alert)
        
        startAlert.addAction(UIAlertAction(title: "Start New Task", style: .default, handler: { (action) -> Void in
            print("start new")
            recognizeIncorrectSM = self.images0
            imagesSM = self.images0
            imageSetSM = 0
            incorrectImageSetSM = 0
            
            self.vShadowTask.isHidden = true
            self.vTask.isHidden = true
            self.vDelay.isHidden = true
            self.next1.isHidden = true
            
            
            self.lblBack.text = "SIMPLE MEMORY"
            self.lblDescTask.isHidden = false
            self.collectionViewLevel.isHidden = false
            
            self.start.isHidden = false
            self.vResults.isHidden = true
            self.btnStartNew.isHidden = true
            
            self.collectionViewLevel.reloadData()
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
    
    func startNewTask(){
        result = Results()
        result.name = "Simple Memory"
        result.startTime = Foundation.Date()
        totalTime = Int(self.maxSeconds)
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
        self.collectionViewLevel.isHidden = true
        self.lblBack.text = "BACK"
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
        imageView.removeFromSuperview()
        print("in delay!")
        
        self.timerLabel.isHidden = false
        self.delayLabel.isHidden = false
        self.lblDescDelay.isHidden = false
        self.delayLabel.text = "Recommended delay: 1 minute"
        
        afterBreakSM = true
        
        self.start.isHidden = false
        
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
            endTimer()
        }
    }
    
    func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % Int(self.maxSeconds)
        let minutes: Int = (totalSeconds / Int(self.maxSeconds)) % Int(self.maxSeconds)
        //     let hours: Int = totalSeconds / 3600
        return String(format: "%02d : %02d", minutes, seconds)
    }
    
    func endTimer() {
        timerSM.invalidate()
        self.totalTime = Int(self.maxSeconds)
        for b in self.testSelectButtons {
            b.isHidden = true
        }
        
        self.start.isHidden = true
        self.resumeTask()
    }
    
    func resumeTask() {
        
        timerSM.invalidate()
        
        self.timerLabel.isHidden = true
        self.delayLabel.isHidden = true
        self.lblDescDelay.isHidden = true
        
        delayTime = self.maxSeconds - Double(self.totalTime)//findTime()
        
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
    
    func findTime()->Double{
        
        let currTime = NSDate.timeIntervalSinceReferenceDate
        let time = Double(Int((currTime - startTimeSM)*10))/10.0
        print("time: \(time)")
        return time
        
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
    
    @IBAction func btnBackTapped(_ sender: Any) {
        ended = true
        timerSM.invalidate()
        afterBreakSM = false
        if Status[TestSimpleMemory] != TestStatus.Done {
            Status[TestSimpleMemory] = TestStatus.NotStarted
        }
    }
    
    @objc private func doneSM() {
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
            totalTime = Int(self.maxSeconds)
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
            result.endTime = Foundation.Date()
            result.shortDescription = "Recall: \(correct) correct, \(incorrect) incorrect. (Sets correct:\(imageSetSM), incorrect:\(incorrectImageSetSM))"
            result.numErrors = incorrect
            
            resultList["CorrectImageSet"] = imageSetSM
            resultList["IncorrectImageSet"] = incorrectImageSetSM
            resultList["DelayTime"] = delayTime
            resultList["Recall Correct"] =  correct
            resultList["Recall Incorrect"] =  incorrect
            resultList["CompleteTime"] = findTime()
            
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
            self.lblTimeCompleteTask.text = "Test complete in \(findTime()) seconds"
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

// MARK: - Setup UI
extension SimpleMemoryTask {
    fileprivate func setupViews() {
        // Label Back
        self.lblBack.font = Font.font(name: Font.Montserrat.semiBold, size: 28.0)
        self.lblBack.textColor = Color.color(hexString: "#013AA5")
        self.lblBack.addTextSpacing(-0.56)
        self.lblBack.text = "SIMPLE MEMORY"
        
        // Label Description Task
        self.lblDescTask.font = Font.font(name: Font.Montserrat.mediumItalic, size: 18.0)
        self.lblDescTask.textColor = Color.color(hexString: "#013AA5")
        self.lblDescTask.alpha = 0.67
        self.lblDescTask.text = "Ask Patient to name and remember these images"
        self.lblDescTask.addTextSpacing(-0.36)
        self.lblDescTask.addLineSpacing(10.0)
        
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
        self.vResults.isHidden = true
        self.btnStartNew.isHidden = true
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
        self.lblDescDelay.font = Font.font(name: Font.Montserrat.medium, size: 18.0)
        self.lblDescDelay.textColor = Color.color(hexString: "#8A9199")
        self.lblDescDelay.text = "Ask Patient to name the items that were displayed  earlier. Record their answers"
        self.lblDescDelay.addTextSpacing(-0.36)
        self.lblDescDelay.addLineSpacing(10.0)
        self.lblDescDelay.textAlignment = .center
        
        self.delayLabel.font = Font.font(name: Font.Montserrat.semiBold, size: 28.0)
        self.delayLabel.textColor = Color.color(hexString: "#013AA5")
        self.delayLabel.text = "Recommended Delay : 1 minute"
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
    
    fileprivate func setupViewObjectName() {
        // Table View
        self.collectionViewObjectName.register(SimpleMemoryCell.nib(), forCellWithReuseIdentifier: SimpleMemoryCell.identifier())
        self.collectionViewObjectName.delegate = self
        self.collectionViewObjectName.dataSource = self
        self.collectionViewObjectName.isHidden = true
        
        // Button complete
        self.next1.setTitle(title: "COMPLETE", withFont: Font.font(name: Font.Montserrat.bold, size: 18.0))
        self.next1.setupShadow(withColor: .clear, sketchBlur: 0, opacity: 0)
        self.next1.setupGradient(arrColor: [Color.color(hexString: "#69C394"), Color.color(hexString: "#40B578")], direction: .topToBottom)
        self.next1.render()
        self.next1.addTextSpacing(-0.36)
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
        self.btnStartNew.setTitle(title: "START NEW", withFont: Font.font(name: Font.Montserrat.bold, size: 18.0))
        self.btnStartNew.setupShadow(withColor: Color.color(hexString: "#FDECBF"), sketchBlur: 9.0, opacity: 1.0)
        self.btnStartNew.setupGradient(arrColor: [Color.color(hexString: "#FFDC6E"), Color.color(hexString: "#FFC556")], direction: .topToBottom)
        self.btnStartNew.render()
        self.btnStartNew.addTextSpacing(-0.36)
        
        // TableView Results
        self.tableViewResults.register(SMResultCell.nib(), forCellReuseIdentifier: SMResultCell.identifier())
        self.tableViewResults.delegate = self
        self.tableViewResults.dataSource = self
    }
}

// MARK: - UICollectionView Delegate, DataSource, DelegateFlowLayout
extension SimpleMemoryTask: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionViewLevel {
            return 4
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
            cell.ivLevel.image = UIImage.init(named: "level_\(idx)")
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
        if let cell = tableView.dequeueReusableCell(withIdentifier: SMResultCell.identifier(), for: indexPath) as? SMResultCell {
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
        return UITableViewCell()
    }
}
