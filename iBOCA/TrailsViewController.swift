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


class TrailsAViewController: ViewController, UIPickerViewDelegate {
    
    @IBOutlet weak var vBack: UIView!
    @IBOutlet weak var lblBack: UILabel!
    @IBOutlet weak var btnBack: UIButton!
    
    @IBOutlet weak var vTaskShadow: UIView!
    @IBOutlet weak var vTask: UIView!
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
    
    var dropdownChooseTheTest: DropDown!
    var dropdownChooseNumberOfPoints: DropDown!
    
    var maxNumberOfPoints: Int = 0
    
    var arrNumberOfPoints: [String] = [String]()
    
    //============
    
    var drawingView: DrawingViewTrails!
    var imageView: UIImageView!
    
    var ended = false
    
    var startTime = TimeInterval()
    var startTime2 = Foundation.Date()
    
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var startButton: UIButton!

    
    @IBOutlet weak var testPicker: UIPickerView!
    var TestTypes : [String] = []
    
    @IBOutlet weak var numBubblesPicker: UIPickerView!
    
    @IBOutlet weak var resultsLabel: UILabel!
    
    @IBAction func StartButton(sender: AnyObject) {
        testPicker.isHidden = true
        
        self.title = TrailsTests[selectedTest].0
        
        startTest()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for test in TrailsTests {
            TestTypes.append(test.0)
        }
        
        testPicker.delegate = self
        testPicker.transform = CGAffineTransform(scaleX: 0.8, y: 1.0)
        selectedTest = testPicker.selectedRow(inComponent: 0)
        testPicker.isHidden = false
        
        numBubblesPicker.delegate = self
        numBubblesPicker.transform = CGAffineTransform(scaleX: 0.8, y: 1.0)
        numBubblesPicker.selectRow(TrailsTests[selectedTest].1.count - 3, inComponent: 0, animated:true)
        numBubbles = numBubblesPicker.selectedRow(inComponent: 0) + 2
        numBubblesPicker.isHidden = false
        
        
        startButton.isHidden = false

        timerLabel.text = ""
        resultsLabel.text = ""
        
        
        self.title = TestTypes[selectedTest]
        
        self.setupView()
    }
    
    
    func startTest() {
        startButton.isEnabled = false
        testPicker.isHidden = true
        numBubblesPicker.isHidden = true
        ended = false

        self.navigationItem.setHidesBackButton(true, animated:true)
        
        if drawingView !== nil {
            drawingView.removeFromSuperview()
        }
        
        if imageView !== nil {
            
            imageView.removeFromSuperview()
            imageView.image = nil
            
        }
        
        timedConnectionsA = [Double]()
        
        let drawViewFrame = CGRect(x: 0.0, y: 135.0, width: view.bounds.width, height: view.bounds.height-135)
        drawingView = DrawingViewTrails(frame: drawViewFrame)
        
        print("\(view.bounds.width) \(view.bounds.height)")
        
        view.addSubview(drawingView)
        
        drawingView.reset()
        
        startTime2 = Foundation.Date()
        
        
        
        startTime = NSDate.timeIntervalSinceReferenceDate
        timedConnectionsA = [Double]()
        stopTrailsA = false
        displayImgTrailsA = false
        
        drawingView.canDraw = true
        
        bubbleColor = UIColor.red
        
        _ = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(update(timer:)), userInfo: nil, repeats: true)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if !ended {
            done()
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
    
    
    
    func numberOfComponentsInPickerView(_ pickerView : UIPickerView!) -> Int{
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        if pickerView == testPicker {
            return TestTypes.count
        } else  if pickerView == numBubblesPicker {
            return TrailsTests[selectedTest].1.count - 2
        } else {
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == testPicker {
            selectedTest = row
            numBubblesPicker.reloadAllComponents()
            return TestTypes[row]
        } else  if pickerView == numBubblesPicker {
            numBubbles = row + 2
            return String(row + 2)
        } else {
            return ""
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == testPicker {
            selectedTest = row
            numBubblesPicker.reloadAllComponents()
            numBubblesPicker.selectRow(TrailsTests[selectedTest].1.count - 3, inComponent: 0, animated:true)
        } else  if pickerView == numBubblesPicker {
            numBubbles = row + 2
        } else  {
        }
    }
    
    
    
    /* Not sure how to conver to swift 3 -Saman
     override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
     return UIInterfaceOrientationMask.Landscape
     } */
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnBackTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnChooseTheTestTapped(_ sender: UIButton) {
        self.vChooseTheTest.layer.borderColor = Color.color(hexString: "#649BFF").cgColor
        self.dropdownChooseTheTest.show()
        // Update state selected first
        if let item = self.lblChooseTheTest.text, let idx = self.TestTypes.index(of: item) {
            self.dropdownChooseTheTest.selectRow(idx)
        }
    }
    
    @IBAction func btnChooseNumberOfPointsTapped(_ sender: UIButton) {
        self.vChooseNumberOfPoints.layer.borderColor = Color.color(hexString: "#649BFF").cgColor
        self.dropdownChooseNumberOfPoints.show()
    }
    
    @IBAction func btnStartTaskTapped(_ sender: GradientButton) {
        
    }
    
    func update(timer: Timer) {
        if stopTrailsA == false {
            let currTime = NSDate.timeIntervalSinceReferenceDate
            var diff: TimeInterval = currTime - startTime
            
            timePassedTrailsA = diff
            
            let minutes = UInt8(diff / 60.0)
            
            diff -= (TimeInterval(minutes)*60.0)
            
            let seconds = UInt8(diff)
            
            diff = TimeInterval(seconds)
            
            let strMinutes = minutes > 9 ? String(minutes):"0"+String(minutes)
            let strSeconds = seconds > 9 ? String(seconds):"0"+String(seconds)
            
            timerLabel.text = "\(strMinutes) : \(strSeconds)"
        }
        else {
            timer.invalidate()
            done()
        }
        
    }
    
    func done() {
        ended = true
        if drawingView != nil {
            drawingView.canDraw = false
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
            result.name = "Trails B Test"
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
            
            result.json["Path"] = drawingView.bubbles.jsontimes
            result.json["Name"] = self.title
            result.json["Total Bubbles"] = numBubbles
            result.json["Errors"] = drawingView.incorrect
            result.json["Correct Path Length"] = drawingView.nextBubb
            result.json["Full Path"] = drawingView.resultpath
            resultsArray.add(result)
            
            Status[TestTrails] = TestStatus.Done
            testPicker.isHidden = false
            numBubblesPicker.isHidden = false
        }
        
        displayImgTrailsA = false
        
        startButton.isEnabled = true
        testPicker.isHidden = false
        numBubblesPicker.isHidden = false
        
        bubbleColor = UIColor(red:0.6, green:0.0, blue:0.0, alpha:1.0)
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
        
        // View Begin Task
        self.setupViewBegin()
    }
    
    fileprivate func setupViewBegin() {
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
        
        // MARK: - Config Choose The Test
        DPDConstant.UI.BorderWidth = 1.0
        DPDConstant.UI.BorderColor = Color.color(hexString: "#649BFF").cgColor
        self.dropdownChooseTheTest = DropDown()
        self.dropdownChooseTheTest.anchorView = self.vGroupChosseTheTest
        self.dropdownChooseTheTest.bottomOffset = CGPoint(x: 0, y: self.vGroupChosseTheTest.bounds.height + 4.0)
        self.dropdownChooseTheTest.dataSource = self.TestTypes
        self.dropdownChooseTheTest.dropDownHeight = 118.0
        
        let appearance = DropDown.appearance()
        appearance.cellHeight = 118.0/3.0
        appearance.textFont = Font.font(name: Font.Montserrat.medium, size: 18.0)
        appearance.backgroundColor = UIColor.white
        appearance.selectionBackgroundColor = Color.color(hexString: "#EAEAEA")
        appearance.textColor = .black
        appearance.shadowOpacity = 0
        
        // Action triggered on selection
        self.dropdownChooseTheTest.selectionAction = { [weak self] (index, item) in
            self?.vChooseTheTest.layer.borderColor = Color.color(hexString: "#EAEAEA").cgColor
            self?.lblChooseTheTest.text = item
            
            // Update dataSource dropdown number of points
            selectedTest = index
            self?.maxNumberOfPoints = TrailsTests[selectedTest].1.count - 2
            self?.arrNumberOfPoints.removeAll()
            for i in 0..<self!.maxNumberOfPoints {
                self?.arrNumberOfPoints.append("\(i+2)")
            }
            
            let idxNumber = TrailsTests[selectedTest].1.count - 3
            self?.lblChooseNumberOfPoints.text = self?.arrNumberOfPoints[idxNumber]
            self?.dropdownChooseNumberOfPoints.dataSource = (self?.arrNumberOfPoints)!
            self?.dropdownChooseNumberOfPoints.selectRow(idxNumber)
            self?.dropdownChooseNumberOfPoints.reloadAllComponents()
            print("ChooseTheTest: \(item)")
            print("NumberOfPoints: \(idxNumber + 2)")
        }
        
        self.dropdownChooseTheTest.cancelAction = { [unowned self] in
            // You could for example deselect the selected item
            self.vChooseTheTest.layer.borderColor = Color.color(hexString: "#EAEAEA").cgColor
        }
        // End Config Choose The Test
        
        self.maxNumberOfPoints = TrailsTests[selectedTest].1.count - 2
        self.arrNumberOfPoints.removeAll()
        for i in 0..<self.maxNumberOfPoints {
            self.arrNumberOfPoints.append("\(i+2)")
        }
    }
    
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
        self.lblChooseNumberOfPoints.font = Font.font(name: Font.Montserrat.medium, size: 18.0)
        self.lblChooseNumberOfPoints.textColor = .black
        self.lblChooseNumberOfPoints.textAlignment = .left
        self.btnChooseNumberOfPoints.tintColor = .clear
        self.btnChooseNumberOfPoints.setTitleColor(UIColor.clear, for: .normal)
        
        // MARK: - Config Choose Number Of Points
        self.dropdownChooseNumberOfPoints = DropDown()
        self.dropdownChooseNumberOfPoints.anchorView = self.vGroupChooseNumberOfPoints
        self.dropdownChooseNumberOfPoints.bottomOffset = CGPoint(x: 0, y: self.vGroupChooseNumberOfPoints.bounds.height + 4.0)
        self.dropdownChooseNumberOfPoints.direction = .bottom
        self.dropdownChooseNumberOfPoints.dataSource = self.arrNumberOfPoints
        self.dropdownChooseNumberOfPoints.dropDownHeight = 118.0
        self.dropdownChooseNumberOfPoints.selectRow(idxNumber)
        self.dropdownChooseNumberOfPoints.setNeedsUpdateConstraints()
        
        // Action triggered on selection
        self.dropdownChooseNumberOfPoints.selectionAction = { [weak self] (index, item) in
            self?.vChooseNumberOfPoints.layer.borderColor = Color.color(hexString: "#EAEAEA").cgColor
            self?.lblChooseNumberOfPoints.text = item
            numBubbles = index + 2
            print("numBubbles: \(numBubbles)")
        }
        
        self.dropdownChooseNumberOfPoints.cancelAction = { [unowned self] in
            // You could for example deselect the selected item
            self.vChooseNumberOfPoints.layer.borderColor = Color.color(hexString: "#EAEAEA").cgColor
        }
        // End Config Choose Number Of Points
    }
}
