//
//  TrailsAViewController.swift
//  Integrated test v1
//
//  Created by Seth Amarasinghe on 7/14/15.
//  Copyright (c) 2015 sunspot. All rights reserved.
//
import UIKit

var stopTrailsA:Bool = false

var timePassedTrailsA = 0.0
var timedConnectionsA = [Double]()
var displayImgTrailsA = false
var bubbleColor:UIColor?

var selectedTest = 0
var numBubbles = 0

var previousTestNumber = -1

var isPracticeTest: Bool = false

class TrailsAViewController: BaseViewController, UIPickerViewDelegate {
    
    // MARK: - Outlet
    @IBOutlet weak var vBack: UIView!
    @IBOutlet weak var lblBack: UILabel!
    @IBOutlet weak var btnBack: UIButton!
    
    @IBOutlet weak var vCounterTimer: UIView!
    
    @IBOutlet weak var vTaskShadow: UIView!
    @IBOutlet weak var vTask: UIView!
    @IBOutlet weak var lblTitlePracticeTest: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    
    @IBOutlet weak var vGroupChosseTheTest: UIView!
    @IBOutlet weak var lblTitleChooseTheTest: UILabel!
    @IBOutlet weak var vChooseTheTest: UIView!
    @IBOutlet weak var lblChooseTheTest: UILabel!
    @IBOutlet weak var btnChooseTheTest: UIButton!
    
    @IBOutlet weak var vGroupChooseNumberOfPoints: UIView!
    @IBOutlet weak var lblTitleChooseNumberOfPoints: UILabel!
    @IBOutlet weak var vChooseNumberOfPoints: UIView!
    @IBOutlet weak var lblChooseNumberOfPoints: UILabel!
    @IBOutlet weak var btnChooseNumberOfPoints: UIButton!
    
    @IBOutlet weak var btnStartTask: GradientButton!
    @IBOutlet weak var btnReset: GradientButton!
    @IBOutlet weak var btnQuit: GradientButton!
    
    
    // MARK: - Variable
    // QuickStart Mode
    var quickStartModeOn: Bool = false
    var didBackToResult: (() -> ())?
    var didCompleted: (() -> ())?
    
    // Dropdown Choose The Test
    var ddChooseTheTest: UITableView!
    var isDropDownChooseTheTestShowing = false
    var TestTypes: [String] = []
    
    // Dropdown Choose Number Of Points
    var ddChooseNumberOfPoints: UITableView!
    var isDropDownChooseNumberOfPointsShowing = false
    var maxNumberOfPoints: Int = 0
    var arrNumberOfPoints: [String] = [String]()
    
    // Practice Test
    var endedPracticeTest = false
    var timerPractice: Timer?
    
    var drawingView: DrawingViewTrails!
    var imageView: UIImageView!
    
    // Trails Test
    var ended = false
    var startTime = TimeInterval()
    var startTime2 = Foundation.Date()
    var runtimer: Timer?
    
    var counterTime: CounterTimeView!
    
    // MARK: - Load Views
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Append data source Dropdown Choose The Test
        for test in TrailsTests {
            TestTypes.append(test.0)
        }
        
        self.setupView()
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if isPracticeTest == true {
            isPracticeTest = false
            timerPractice?.invalidate()
        }
        else {
            runtimer?.invalidate()
        }
    }
    
    /*   @IBAction func HelpButton(sender: AnyObject) {
     if(selectedTest == "Trails A" || selectedTest == "Trails A Practice") {
     let vc = storyboard!.instantiateViewController(withIdentifier: "Trails A Help") as UIViewController
     navigationController!.pushViewController(vc, animated:true)
     } else {
     let vc = storyboard!.instantiateViewController(withIdentifier: "Trails B Help") as UIViewController
     navigationController!.pushViewController(vc, animated:true)
     }
     stopTrailsA = true
     done()
     } */
    
    /* Not sure how to conver to swift 3 -Saman
     override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
     return UIInterfaceOrientationMask.Landscape
     } */
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
// MARK: - Setup Views
extension TrailsAViewController {
    fileprivate func setupView() {
        // View Back
        self.lblBack.addTextSpacing(-0.56)
        self.lblBack.font = Font.font(name: Font.Montserrat.semiBold, size: 28.0)
        self.lblBack.textColor = Color.color(hexString: "#013AA5")
        self.btnBack.tintColor = .clear
        
        // View Task Shadow
        self.vTaskShadow.layer.cornerRadius = 8.0
        self.vTaskShadow.layer.shadowColor = Color.color(hexString: "#649BFF").withAlphaComponent(0.32).cgColor
        self.vTaskShadow.layer.shadowOpacity = 1.0
        self.vTaskShadow.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.vTaskShadow.layer.shadowRadius = 10 / 2.0
        self.vTaskShadow.layer.shadowPath = nil
        self.vTaskShadow.layer.masksToBounds = false
        
        // View Task
        self.vTask.clipsToBounds = true
        self.vTask.backgroundColor = UIColor.white
        self.vTask.layer.cornerRadius = 8.0
        
        if isPracticeTest == true {
            // Hidden View
            self.vCounterTimer.isHidden = true
            self.btnReset.isHidden = true
            self.btnQuit.isHidden = true
            
            // Setup Practice Test
            self.lblTitlePracticeTest.isHidden = false
            self.lblTitlePracticeTest.text = "PRACTICE TEST"
            self.lblTitlePracticeTest.font = Font.font(name: Font.Montserrat.bold, size: 22.0)
            self.lblTitlePracticeTest.textColor = Color.color(hexString: "#013AA5")
            self.lblTitlePracticeTest.addTextSpacing(-0.44)
            self.setupPracticeTest()
        }
        else { // Trails Test
            self.lblTitlePracticeTest.isHidden = true
            // View Begin Task
            self.setupViewBeginTrails()
            
            // View Counter Timer
            self.setupViewCounterTimer()
            
            // Button Reset, Quit
            self.setupButtonGradient()
            
            // hide button Reset
            self.btnReset.isHidden = true
            
            self.randomTest()
        }
        
        // Change back button title if quickStartMode is On
        if quickStartModeOn {
            lblBack.text = "RESULTS"
            btnQuit.updateTitle(title: "CONTINUE")
        }
    }
    
    fileprivate func setupPracticeTest() {
        // Hidden View Begin Trails
        self.lblDesc.isHidden = true
        self.vGroupChosseTheTest.isHidden = true
        self.vGroupChooseNumberOfPoints.isHidden = true
        self.btnStartTask.isHidden = true
        
        self.startPracticeTest()
    }
    
    fileprivate func setupViewBeginTrails() {
        self.lblDesc.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt (describtion how to play the test)"
        self.lblDesc.font = Font.font(name: Font.Montserrat.medium, size: 18.0)
        self.lblDesc.addTextSpacing(-0.36)
        self.lblDesc.addLineSpacing(10.0)
        self.lblDesc.textAlignment = .center
        
        self.setupViewGroupChooseTheTest()
        
        self.setupViewGroupChooseNumberOfPoints()
        
        self.btnStartTask.setTitle(title: "START", withFont: Font.font(name: Font.Montserrat.bold, size: 22.0))
        self.btnStartTask.setupShadow(withColor: UIColor.clear, sketchBlur: 0, opacity: 0)
        self.btnStartTask.setupGradient(arrColor: [Color.color(hexString: "#FCD24B"),Color.color(hexString: "#FFC556")], direction: .topToBottom)
        self.btnStartTask.render()
        self.btnStartTask.addTextSpacing(-0.44)
    }
    
    // MARK: - Config Choose The Test
    fileprivate func setupViewGroupChooseTheTest() {
        selectedTest = 0
        
        self.lblTitleChooseTheTest.text = "Choose the test"
        self.lblTitleChooseTheTest.font = Font.font(name: Font.Montserrat.medium, size: 16.0)
        self.lblTitleChooseTheTest.addTextSpacing(-0.32)
        self.lblTitleChooseTheTest.textColor = Color.color(hexString: "#8A9199")
        self.lblTitleChooseTheTest.textAlignment = .left
        
        self.vChooseTheTest.clipsToBounds = true
        self.vChooseTheTest.backgroundColor = Color.color(hexString: "#F7F7F7")
        self.vChooseTheTest.layer.cornerRadius = 5.0
        self.vChooseTheTest.layer.borderWidth = 1.0
        self.vChooseTheTest.layer.borderColor = Color.color(hexString: "#EAEAEA").cgColor
        
        self.lblChooseTheTest.addTextSpacing(-0.36)
        self.lblChooseTheTest.text = self.TestTypes[selectedTest]
        self.lblChooseTheTest.font = Font.font(name: Font.Montserrat.medium, size: 18.0)
        self.lblChooseTheTest.textColor = .black
        self.lblChooseTheTest.textAlignment = .left
        self.btnChooseTheTest.tintColor = .clear
        self.btnChooseTheTest.setTitleColor(UIColor.clear, for: .normal)
        
        // Dropdown Choose The Test
        self.ddChooseTheTest = UITableView()
        let x = self.vGroupChosseTheTest.origin.x
        let y = self.vGroupChosseTheTest.origin.y + self.vGroupChosseTheTest.frame.size.height + 14.0
        self.ddChooseTheTest.frame = CGRect.init(x: x, y: y, width: self.vGroupChosseTheTest.frame.size.width, height: 118.0)
        self.ddChooseTheTest.register(VADropDownCell.nib(), forCellReuseIdentifier: VADropDownCell.identifier())
        self.vTask.addSubview(self.ddChooseTheTest)
        self.ddChooseTheTest.delegate = self
        self.ddChooseTheTest.dataSource = self
        self.ddChooseTheTest.separatorStyle = .none
        self.ddChooseTheTest.layer.borderWidth = 1.0
        self.ddChooseTheTest.layer.borderColor = Color.color(hexString: "#649BFF").cgColor
        self.ddChooseTheTest.isHidden = true
        // End Choose The Test
        
        self.maxNumberOfPoints = TrailsTests[selectedTest].1.count - 2
        self.arrNumberOfPoints.removeAll()
        for i in 0..<self.maxNumberOfPoints {
            self.arrNumberOfPoints.append("\(i+2)")
        }
    }
    
    // MARK: - Config Choose Number Of Points
    fileprivate func setupViewGroupChooseNumberOfPoints() {
        self.lblTitleChooseNumberOfPoints.text = "Choose number of points"
        self.lblTitleChooseNumberOfPoints.font = Font.font(name: Font.Montserrat.medium, size: 16.0)
        self.lblTitleChooseNumberOfPoints.addTextSpacing(-0.32)
        self.lblTitleChooseNumberOfPoints.textColor = Color.color(hexString: "#8A9199")
        self.lblTitleChooseNumberOfPoints.textAlignment = .left
        
        self.vChooseNumberOfPoints.clipsToBounds = true
        self.vChooseNumberOfPoints.backgroundColor = Color.color(hexString: "#F7F7F7")
        self.vChooseNumberOfPoints.layer.cornerRadius = 5.0
        self.vChooseNumberOfPoints.layer.borderWidth = 1.0
        self.vChooseNumberOfPoints.layer.borderColor = Color.color(hexString: "#EAEAEA").cgColor
        
        let idxNumber = TrailsTests[selectedTest].1.count - 3
        self.lblChooseNumberOfPoints.addTextSpacing(-0.36)
        self.lblChooseNumberOfPoints.text = self.arrNumberOfPoints[idxNumber]
        numBubbles = idxNumber + 2
        self.lblChooseNumberOfPoints.font = Font.font(name: Font.Montserrat.medium, size: 18.0)
        self.lblChooseNumberOfPoints.textColor = .black
        self.lblChooseNumberOfPoints.textAlignment = .left
        self.btnChooseNumberOfPoints.tintColor = .clear
        self.btnChooseNumberOfPoints.setTitleColor(UIColor.clear, for: .normal)
        
        // Choose Number Of Points
        self.ddChooseNumberOfPoints = UITableView()
        let x = self.vGroupChooseNumberOfPoints.origin.x
        let y = self.vGroupChooseNumberOfPoints.origin.y + self.vGroupChooseNumberOfPoints.frame.size.height + 14.0
        self.ddChooseNumberOfPoints.frame = CGRect.init(x: x, y: y, width: self.vGroupChooseNumberOfPoints.frame.size.width, height: 118.0)
        self.ddChooseNumberOfPoints.register(VADropDownCell.nib(), forCellReuseIdentifier: VADropDownCell.identifier())
        self.vTask.addSubview(self.ddChooseNumberOfPoints)
        self.ddChooseNumberOfPoints.delegate = self
        self.ddChooseNumberOfPoints.dataSource = self
        self.ddChooseNumberOfPoints.separatorStyle = .none
        self.ddChooseNumberOfPoints.layer.borderWidth = 1.0
        self.ddChooseNumberOfPoints.layer.borderColor = Color.color(hexString: "#649BFF").cgColor
        self.ddChooseNumberOfPoints.isHidden = true
        // End Choose Number Of Points
    }
    
    fileprivate func setupViewCounterTimer() {
        // View Couter Timer
        self.counterTime = CounterTimeView()
        self.vCounterTimer.backgroundColor = .clear
        self.vCounterTimer.addSubview(self.counterTime)
        self.counterTime.centerXAnchor.constraint(equalTo: self.vCounterTimer.centerXAnchor).isActive = true
        self.counterTime.centerYAnchor.constraint(equalTo: self.vCounterTimer.centerYAnchor).isActive = true
        
        self.vCounterTimer.isHidden = true
    }
    
    fileprivate func setupButtonGradient() {
        self.btnQuit.setTitle(title: "QUIT", withFont: Font.font(name: Font.Montserrat.bold, size: 18.0))
        self.btnQuit.setupShadow(withColor: .clear, sketchBlur: 0, opacity: 0)
        self.btnQuit.setupGradient(arrColor: [Color.color(hexString: "#FFAFA6"), Color.color(hexString: "#FE786A")], direction: .topToBottom)
        self.btnQuit.render()
        self.btnQuit.addTextSpacing(-0.36)
        // Add action Button Quit
        self.btnQuit.addTarget(self, action: #selector(self.quitTapped(_:)), for: .touchUpInside)
        
        self.btnReset.setTitle(title: "RESET", withFont: Font.font(name: Font.Montserrat.bold, size: 18.0))
        self.btnReset.setupShadow(withColor: .clear, sketchBlur: 0, opacity: 0)
        self.btnReset.setupGradient(arrColor: [Color.color(hexString: "#FCD24B"), Color.color(hexString: "#FFC556")], direction: .topToBottom)
        self.btnReset.render()
        self.btnReset.addTextSpacing(-0.36)
        // Add action Button Reset
        self.btnReset.addTarget(self, action: #selector(self.resetTapped(_:)), for: .touchUpInside)
    }
    
    fileprivate func randomTest() {
        repeat {
            selectedTest = Int.random(in: 0...9)
        } while selectedTest == previousTestNumber
        previousTestNumber = selectedTest
        numBubbles = 20
        
//        self.maxNumberOfPoints = TrailsTests[selectedTest].1.count - 2
//        self.arrNumberOfPoints.removeAll()
//        for i in 0..<self.maxNumberOfPoints {
//            self.arrNumberOfPoints.append("\(i+2)")
//        }
//
//        // Load data selected default from dropdown choose number of points
//        let idxNumber = TrailsTests[selectedTest].1.count - 3
//        self.lblChooseNumberOfPoints.text = self.arrNumberOfPoints[idxNumber]
//        numBubbles = Int(self.arrNumberOfPoints[idxNumber])!
//        self.dismissDropdownChooseTheTest()
//
//        let randomBubble = selectedTest == 6 ? Int.random(in: 0...21) : Int.random(in: 0...17)
//        let numberOfPoints = self.arrNumberOfPoints[randomBubble]
//        self.lblChooseNumberOfPoints.text = numberOfPoints
//        numBubbles = randomBubble + 2
//        self.dismissDropdownChooseNumberOfPoints()
//
        self.lblTitlePracticeTest.isHidden = true
        // Hidden View Begin Trails
        self.lblDesc.isHidden = true
        self.vGroupChosseTheTest.isHidden = true
        self.vGroupChooseNumberOfPoints.isHidden = true
        self.btnStartTask.isHidden = true
        
        startTest()
    }
}

// MARK: - UITableView Delegate, DataSource
extension TrailsAViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.ddChooseTheTest {
            return self.TestTypes.count
        }
        else {
            return self.arrNumberOfPoints.count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 118.0/3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.separatorStyle = .none
        if tableView == self.ddChooseTheTest { // Dropdown Choose The Test
            let chooseTheTestCell = tableView.dequeueReusableCell(withIdentifier: VADropDownCell.cellId, for: indexPath) as! VADropDownCell
            chooseTheTestCell.selectionStyle = .none
            let chooseTheTest = self.TestTypes[indexPath.row]
            chooseTheTestCell.timeLabel.text = chooseTheTest
            
            let cellSelectedColor = UIView()
            cellSelectedColor.backgroundColor = Color.color(hexString: "#EAEAEA")
            chooseTheTestCell.selectedBackgroundView = cellSelectedColor
            
            return chooseTheTestCell
        }
        else { // Dropdown Choose Number Of Points
            let numberOfPointsCell = tableView.dequeueReusableCell(withIdentifier: VADropDownCell.cellId, for: indexPath) as! VADropDownCell
            numberOfPointsCell.selectionStyle = .none
            let numberOfPoints = self.arrNumberOfPoints[indexPath.row]
            numberOfPointsCell.timeLabel.text = numberOfPoints
            
            let cellSelectedColor = UIView()
            cellSelectedColor.backgroundColor = Color.color(hexString: "#EAEAEA")
            numberOfPointsCell.selectedBackgroundView = cellSelectedColor
            
            return numberOfPointsCell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == self.ddChooseTheTest { // Dropdown Choose The Test
            let chooseTheTest = self.TestTypes[indexPath.row]
            self.lblChooseTheTest.text = chooseTheTest
            // Update dataSource dropdown number of points
            selectedTest = indexPath.row
            self.maxNumberOfPoints = TrailsTests[selectedTest].1.count - 2
            self.arrNumberOfPoints.removeAll()
            for i in 0..<self.maxNumberOfPoints {
                self.arrNumberOfPoints.append("\(i+2)")
            }
            
            // Load data selected default from dropdown choose number of points
            let idxNumber = TrailsTests[selectedTest].1.count - 3
            self.lblChooseNumberOfPoints.text = self.arrNumberOfPoints[idxNumber]
            numBubbles = Int(self.arrNumberOfPoints[idxNumber])!
            self.dismissDropdownChooseTheTest()
        }
        else { // Dropdown Choose Number Of Points
            let numberOfPoints = self.arrNumberOfPoints[indexPath.row]
            self.lblChooseNumberOfPoints.text = numberOfPoints
            numBubbles = indexPath.row + 2
            self.dismissDropdownChooseNumberOfPoints()
        }
    }
}

// MARK: - Dismiss Dropdown
extension TrailsAViewController {
    fileprivate func dismissDropdownChooseTheTest() {
        if self.ddChooseTheTest != nil {
            self.ddChooseTheTest.isHidden = true
        }
        
        self.isDropDownChooseTheTestShowing = false
        self.vChooseTheTest.layer.borderColor = Color.color(hexString: "#EAEAEA").cgColor
    }
    
    fileprivate func dismissDropdownChooseNumberOfPoints() {
        if self.ddChooseNumberOfPoints != nil {
            self.ddChooseNumberOfPoints.isHidden = true
        }
        
        self.isDropDownChooseNumberOfPointsShowing = false
        self.vChooseNumberOfPoints.layer.borderColor = Color.color(hexString: "#EAEAEA").cgColor
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        if isPracticeTest == false {
            if touches.first?.view != self.ddChooseTheTest || touches.first?.view != self.ddChooseNumberOfPoints {
                self.dismissDropdownChooseTheTest()
                self.dismissDropdownChooseNumberOfPoints()
            }
        }
    }
}

// MARK: - Action
extension TrailsAViewController {
    // Start Practice Test
    fileprivate func startPracticeTest() {
        self.endedPracticeTest = false
        self.navigationItem.setHidesBackButton(true, animated:true)
        
        // Clean all previous Draw View and refresh Draw View
        if drawingView != nil {
            drawingView.removeFromSuperview()
        }
        
        if imageView != nil {
            imageView.removeFromSuperview()
            imageView.image = nil
        }
        
        timedConnectionsA = [Double]()
        
        let y = self.lblTitlePracticeTest.origin.y + self.lblTitlePracticeTest.frame.size.height
        let width = self.vTask.frame.size.width
        let height = self.vTask.frame.size.height
        let drawViewFrame = CGRect(x: 0.0, y: y, width: width, height: height)
        self.drawingView = DrawingViewTrails.init(frame: drawViewFrame, isPracticeTests: true)
        self.vTask.addSubview(drawingView)
        
        self.drawingView.reset()
        self.startTime2 = Foundation.Date()
        self.startTime = NSDate.timeIntervalSinceReferenceDate
        timedConnectionsA = [Double]()
        stopTrailsA = false
        displayImgTrailsA = false
        self.drawingView.canDraw = true
        bubbleColor = UIColor.red
        
        timerPractice = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(update(timer:)), userInfo: nil, repeats: true)
        timerPractice?.fire()
    }
    
    // Start Trail Test
    func startTest() {
        self.ended = false
        self.vCounterTimer.isHidden = false
        self.title = self.lblChooseTheTest.text
        
        Status[TestTrails] = TestStatus.NotStarted
        
        // Show button Reset
        self.btnReset.isHidden = false
        
        // Clean all previous Draw View and refresh Draw View
        if drawingView != nil {
            drawingView.removeFromSuperview()
        }
        
        if imageView != nil {
            imageView.removeFromSuperview()
            imageView.image = nil
        }
        
        timedConnectionsA = [Double]()
        
        let width = self.vTask.frame.size.width
        let height = self.vTask.frame.size.height
        let drawViewFrame = CGRect(x: 0.0, y: 0.0, width: width, height: height)
        self.drawingView = DrawingViewTrails.init(frame: drawViewFrame, isPracticeTests: false)
        self.vTask.addSubview(drawingView)
        
        self.drawingView.reset()
        self.startTime2 = Foundation.Date()
        self.startTime = NSDate.timeIntervalSinceReferenceDate
        timedConnectionsA = [Double]()
        stopTrailsA = false
        displayImgTrailsA = false
        self.drawingView.canDraw = true
        bubbleColor = UIColor.red
        
        runtimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(update(timer:)), userInfo: nil, repeats: true)
        runtimer?.fire()
    }
    
    @IBAction func btnBackTapped(_ sender: UIButton) {
        // Check if is in quickStart mode
        guard !quickStartModeOn else {
            didBackToResult?()
            return
        }
        
        if Status[TestTrails] != TestStatus.Done {
            Status[TestTrails] = TestStatus.NotStarted
        }
        
        if let nav = self.navigationController {
            if isPracticeTest == false &&
                ended == false && self.vCounterTimer.isHidden == false && self.drawingView.bubbles.segmenttimes.count != 0 {
//                self.done(showAlertComplete: false)
            }
            ended = false
            endedPracticeTest = false
            nav.popViewController(animated: true)
        }
    }
    
    @objc func resetTapped(_ sender: GradientButton) {
        runtimer?.invalidate()
        timerPractice?.invalidate()
        self.startTest()
    }
    
    @objc func quitTapped(_ sender: GradientButton) {
        // Check if is in quickStart mode
        guard !quickStartModeOn else {
            QuickStartManager.showAlertCompletion(viewController: self, cancel: {
                self.didBackToResult?()
            }, ok: {
                self.didCompleted?()
            })
            return
        }
        
        if let nav = self.navigationController {
            if self.ended == false {
                self.done(showAlertComplete: false)
            }
            self.ended = false
            self.endedPracticeTest = false
            nav.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func btnChooseTheTestTapped(_ sender: UIButton) {
        self.dismissDropdownChooseNumberOfPoints()
        if isDropDownChooseTheTestShowing {
            self.dismissDropdownChooseTheTest()
        }
        else {
            self.vChooseTheTest.layer.borderColor = Color.color(hexString: "#649BFF").cgColor
            // Update state selected first
            if let item = self.lblChooseTheTest.text, let idx = self.TestTypes.firstIndex(of: item) {
                self.ddChooseTheTest.reloadData()
                self.ddChooseTheTest.selectRow(at: IndexPath.init(row: idx, section: 0), animated: false, scrollPosition: .middle)
            }
            self.ddChooseTheTest.isHidden = false
            self.isDropDownChooseTheTestShowing = true
        }
    }
    
    @IBAction func btnChooseNumberOfPointsTapped(_ sender: UIButton) {
        self.dismissDropdownChooseTheTest()
        if isDropDownChooseNumberOfPointsShowing {
            self.dismissDropdownChooseNumberOfPoints()
        }
        else {
            self.vChooseNumberOfPoints.layer.borderColor = Color.color(hexString: "#649BFF").cgColor
            // Update state selected first
            if let item = self.lblChooseNumberOfPoints.text, let idx = self.arrNumberOfPoints.firstIndex(of: item) {
                self.ddChooseNumberOfPoints.reloadData()
                self.ddChooseNumberOfPoints.selectRow(at: IndexPath.init(row: idx, section: 0), animated: false, scrollPosition: .middle)
            }
            self.ddChooseNumberOfPoints.isHidden = false
            self.isDropDownChooseNumberOfPointsShowing = true
        }
    }
    
    @IBAction func btnStartTaskTapped(_ sender: GradientButton) {
        self.lblTitlePracticeTest.isHidden = true
        // Hidden View Begin Trails
        self.lblDesc.isHidden = true
        self.vGroupChosseTheTest.isHidden = true
        self.vGroupChooseNumberOfPoints.isHidden = true
        self.btnStartTask.isHidden = true
        
        // Hiden dropdown
        self.dismissDropdownChooseTheTest()
        self.dismissDropdownChooseNumberOfPoints()
    }
    
    @objc func update(timer: Timer) {
        if stopTrailsA == false {
            if isPracticeTest == false { // Mode is Trails Test
                // Update data into Counter Timer View
                self.counterTime.setTimeWith(startTime: startTime2, currentTime: Foundation.Date())
            }
        }
        else {
            timer.invalidate()
            // Check mode is Practice Test or Trails Test
            if isPracticeTest == true {
                self.drawingView.canDraw = false
                let confirmAlert = UIAlertController(title: "Complete", message: "You complete the practice test.", preferredStyle: .alert)
                let okAction = UIAlertAction.init(title: "Ok", style: .default) { (action) in
                    self.endedPracticeTest = true
                }
                confirmAlert.addAction(okAction)
                self.present(confirmAlert, animated: true, completion: nil)
            }
            else {
                self.done(showAlertComplete: true)
            }
        }
        
    }
    
    func done(showAlertComplete: Bool) {
        ended = true
        if drawingView != nil {
            drawingView.canDraw = false
            if screenSize == nil {
                screenSize = UIScreen.main.bounds
            }
            let imageSize = CGSize(width: screenSize!.maxX, height: screenSize!.maxY - 135)
            imageView = UIImageView(frame: CGRect(origin: CGPoint(x: 0, y: 135), size: imageSize))
            /*           if resultsDisplayOn == true {
             self.view.addSubview(imageView)
             }
             let image = drawCustomImage(imageSize)
             imageView.image = image */
            let image = drawCustomImage(size: imageSize)
            
            // add to results
            let result = Results()
            result.name = TestName.TRAILS
            result.startTime = startTime2 as Date
            result.endTime = Foundation.Date()
            result.screenshot.append(image)
            
            var num = timePassedTrailsA
            let minutes = UInt8(num / 60.0)
            num -= (TimeInterval(minutes)*60.0)
            let seconds = UInt8(num)
            num = TimeInterval(seconds)
            
            result.longDescription.add(String(describing: self.title))
            result.longDescription.add("\(drawingView.nextBubb) correct and \(drawingView.incorrect) incorrect in \(minutes) minutes and \(seconds) second")
            result.longDescription.add("The segments are \(drawingView.bubbles.segmenttimes)\n")
            result.longDescription.add("The incorrect segments are \(drawingView.incorrectlist)")
            result.shortDescription = "\(drawingView.incorrect) errors with \(drawingView.nextBubb) correct bubbles (test \(self.title!))"
            result.numErrors = drawingView.incorrect
            result.numCorrects = drawingView.nextBubb - 1
            result.json["Path"] = drawingView.bubbles.jsontimes
            result.json["Name"] = self.title
            result.json["Total Bubbles"] = numBubbles
            result.json["Errors"] = drawingView.incorrect
            result.json["Correct Path Length"] = drawingView.nextBubb
            result.json["Full Path"] = drawingView.resultpath
            resultsArray.add(result)
            
            Status[TestTrails] = TestStatus.Done
            
            if showAlertComplete == true {
                // Check if is in quickStart mode
                guard !quickStartModeOn else {
                    QuickStartManager.showAlertCompletion(viewController: self, cancel: {
                        self.didBackToResult?()
                    }, ok: {
                        self.didCompleted?()
                    })
                    return
                }
                
                let completeAlert = UIAlertController(title: "Complete", message: "You complete the trails test.", preferredStyle: .alert)
                let okAction = UIAlertAction.init(title: "Ok", style: .cancel, handler: nil)
                completeAlert.addAction(okAction)
                self.present(completeAlert, animated: true, completion: nil)
            }
        }
        
        displayImgTrailsA = false
        
//        bubbleColor = UIColor(red:0.6, green:0.0, blue:0.0, alpha:1.0)
    }
    
    func drawCustomImage(size: CGSize) -> UIImage {
        // Setup our context
        //let bounds = CGRect(origin: CGPoint.zero, size: size)
        let opaque = false
        let scale: CGFloat = 0
        UIGraphicsBeginImageContextWithOptions(size, opaque, scale)
        //let context = UIGraphicsGetCurrentContext()
        
        // Setup complete, do drawing here
        drawingView.drawResultBackground()  //background bubbles
        
        // Drawing complete, retrieve the finished image and cleanup
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!
    }
}
