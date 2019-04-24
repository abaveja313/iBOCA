//
//  OrientationTask.swift
//  iBOCA
//
//  Created by Ellison Lim on 8/1/16.
//  Copyright © 2016 sunspot. All rights reserved.
//

import UIKit
import MessageUI

var firstTimeThrough = true
//declare variables to be defined by pickerviews
var startTime = Foundation.Date()

class OrientationTask:  ViewController, MFMailComposeViewControllerDelegate, UITextFieldDelegate, UITextViewDelegate,UIPickerViewDelegate  {
    
    let defaultBlueColor: UIColor = UIColor.init(red: 0/255.0, green: 122/255.0, blue: 255/255.0, alpha: 1.0)
    var Week : String?
    var State : String?
    var Date : String?
    var Time : String?
    var TimeOK : Bool = false
    var DateOK : Bool = false
    var dkDate : Bool = false {
        didSet {
            if dkDate {
                btnDontKnowDate.setTitleColor(UIColor.red, for: .normal)
            }
            else {
                btnDontKnowDate.setTitleColor(defaultBlueColor, for: .normal)
            }
        }
    }
    var dkMonth : Bool = false {
        didSet {
            if dkMonth {
                btnDontKnowMonth.setTitleColor(UIColor.red, for: .normal)
            }
            else {
                btnDontKnowMonth.setTitleColor(defaultBlueColor, for: .normal)
            }
        }
    }
    var dkYear : Bool = false {
        didSet {
            if dkYear {
                btnDontKnowYear.setTitleColor(UIColor.red, for: .normal)
            }
            else {
                btnDontKnowYear.setTitleColor(defaultBlueColor, for: .normal)
            }
        }
    }
    var dkWeek : Bool = false {
        didSet {
            if dkWeek {
                btnDontKnowWeek.setTitleColor(UIColor.red, for: .normal)
            }
            else {
                btnDontKnowWeek.setTitleColor(defaultBlueColor, for: .normal)
            }
        }
    }
    var dkState : Bool = false {
        didSet {
            if dkState {
                btnDontKnowState.setTitleColor(UIColor.red, for: .normal)
            }
            else {
                btnDontKnowState.setTitleColor(defaultBlueColor, for: .normal)
            }
        }
    }
    var dkTime : Bool = false {
        didSet {
            if dkTime {
                btnDontKnowTime.setTitleColor(UIColor.red, for: .normal)
            }
            else {
                btnDontKnowTime.setTitleColor(defaultBlueColor, for: .normal)
            }
        }
    }

    //pickerview content set up(defines options)
    
    @IBOutlet weak var WeekPicker: UIPickerView!
    let weekData = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday", "Do not know"]
    
    @IBOutlet weak var StatePicker: UIPickerView!
    let stateData = ["Alabama", "Alaska", "Arizona", "Arkansas", "California", "Colorado", "Connecticut", "Delaware", "Florida", "Georgia","Hawaii", "Idaho", "Illinois", "Indiana", "Iowa", "Kansas", "Kentucky", "Louisiana", "Maine", "Maryland", "Massachusetts", "Michigan", "Minnesota", "Mississippi", "Missouri", "Montana", "Nebraska", "Nevada", "New Hampshire", "New Jersey", "New Mexico", "New York", "North Carolina", "North Dakota", "Ohio", "Oklahoma", "Oregon", "Pennsylvania", "Rhode Island", "South Carolina", "South Dakota", "Tennessee", "Texas", "Utah", "Vermont", "Virginia", "Washington", "West Virginia", "Wisconsin", "Wyoming", "Don't Know"]
    
    
    @IBOutlet weak var currentDate: UIDatePicker!
    
    @IBOutlet weak var btnDontKnowMonth: UIButton!
    @IBOutlet weak var btnDontKnowDate: UIButton!
    @IBOutlet weak var btnDontKnowYear: UIButton!
    @IBOutlet weak var btnDontKnowWeek: UIButton!
    @IBOutlet weak var btnDontKnowState: UIButton!
    @IBOutlet weak var btnDontKnowTime: UIButton!
    
    
    var body:String?
    //text field input and results
    
    @IBAction func updateDate(_ sender: AnyObject) {
        let d:UIDatePicker = sender as! UIDatePicker
        let formatter = DateFormatter()
        formatter.dateFormat = "y-MM-dd"
        Date = formatter.string(from: d.date)
        let v = startTime.timeIntervalSince(d.date)
        if abs(v) < 60*60*24 {
            DateOK = true
        } else {
            DateOK = false
        }
        
        dkDate = false
        dkMonth = false
        dkYear = false
    }
    
    
    @IBOutlet weak var currentTime: UIDatePicker!
    
    @IBAction func updateTime(_ sender: Any) {
        let d:UIDatePicker = sender as! UIDatePicker
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        Time = formatter.string(from: d.date)
        TimeOK = TimeDiffOK(date1: startTime, date2: d.date)
        
        dkTime = false
    }
    
    @IBAction func DontKnowMonth(_ sender: UIButton) {
        dkMonth = true
    }
    
    @IBAction func DontKnowDate(_ sender: Any) {
        dkDate = true
    }
    
    @IBAction func DontKnowYear(_ sender: UIButton) {
        dkYear = true
    }
    
    @IBAction func DontKnowWeek(_ sender: Any) {
        Week = "Dont Know"
        dkWeek = true
    }
    
    
    @IBAction func DontKnowState(_ sender: Any) {
        State = "Dont Know"
        dkState = true
    }
    
    
    @IBAction func DontKnowTime(_ sender: Any) {
        Time = "Dont Know"
        dkTime = true
        TimeOK = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Check location permission before continue
        if !LocationManager.shared.isLocationServiceAvailable() && !LocationManager.shared.isLocationServiceNotEnable() {
            let alertController = UIAlertController.init(title: "", message: "Please turn on location permission to do this test.", preferredStyle: .alert)
            let cancelAction = UIAlertAction.init(title: "Cancel", style: .cancel) { (_) in
                self.dismiss(animated: true, completion: nil)
            }
            let okAction = UIAlertAction.init(title: "OK", style: .default) { (_) in
                if let url = URL.init(string: UIApplicationOpenSettingsURLString) {
                    UIApplication.shared.openURL(url)
                }
                
                self.dismiss(animated: true, completion: nil)
            }
            
            alertController.addAction(cancelAction)
            alertController.addAction(okAction)
            DispatchQueue.main.async {
                self.present(alertController, animated: true, completion: nil)
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //declare pickerviews
        WeekPicker.delegate = self
        StatePicker.delegate = self
        
        LocationManager.shared.requestLocationServiceIfNeeded(in: self)
        
        dkDate = false
        dkMonth = false
        dkYear = false
        
        // Get the random State
        let indexState = Int(arc4random_uniform(UInt32(stateData.count)))
        State = stateData[indexState]
        StatePicker.selectRow(indexState, inComponent: 0, animated: true)
        
        let formatter = DateFormatter()
        if let date_random = Foundation.Date().generateRandomDate(daysBack: 20) {
            // Get the random date
            formatter.dateFormat = "y-MM-dd"
            currentDate.setDate( date_random,  animated: false)
            Date = formatter.string(from: currentDate.date)
            DateOK = true
            
            // Get the random time
            formatter.dateFormat = "yyyy/MM/dd HH:mm"
            currentTime.setDate(date_random,  animated: false)
            formatter.dateFormat = "HH:MM"
            Time = formatter.string(from: currentTime.date)
            TimeOK = true
            
            // Get the random week
            Week = weekData[WeekPicker.selectedRow(inComponent: 0)]
            formatter.dateFormat = "EEEE"
            let wk = formatter.string(from: date_random)
            let v = weekData.index(of: wk)
            if (v != nil) {
                Week  = wk
                WeekPicker.selectRow(v!, inComponent: 0, animated: false)
            }
        }
        
        currentDate.isUserInteractionEnabled = true
        currentTime.isUserInteractionEnabled = true
        WeekPicker.isUserInteractionEnabled = true
        StatePicker.isUserInteractionEnabled = true
        currentDate.alpha = 1.0
        currentTime.alpha = 1.0
        WeekPicker.alpha = 1.0
        StatePicker.alpha = 1.0
        
        startTime = Foundation.Date()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        dismiss(animated: true, completion: nil)
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        body = textView.text
        
        if text == "\n" {
            textView.resignFirstResponder()
            
            return false
        }
        
        return true
    }
    
    @IBAction func DoneButton(_ sender: AnyObject) {
        let alert = UIAlertController(title: "Confirm", message: "Do you really want to complete this test?", preferredStyle: .alert)
        
        let noAction = UIAlertAction.init(title: "No", style: .cancel, handler: nil)
        let yesAction = UIAlertAction.init(title: "Yes", style: .default) { (action) in
            self.completeTest()
            // Show MainViewController
            self.dismiss(animated: true, completion: nil)
        }
        alert.addAction(noAction)
        alert.addAction(yesAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    private func completeTest() {
        let result = Results()
        result.name = "Orientation"
        result.startTime = startTime
        result.endTime = Foundation.Date()
        
        result.json["Week Given"] = Week!
        result.json["State Given"] = State!
        result.json["Date Given"] = Date!
        result.json["Time Given"] = Time!
        
        let formatter = DateFormatter()
        formatter.dateFormat = "y-MM-dd"
        let rightDate = formatter.string(from: startTime)
        result.json["Date Tested"] = rightDate
        formatter.dateFormat = "HH:MM"
        let rightTime = formatter.string(from: startTime)
        result.json["Time Tested"] = rightTime
        formatter.dateFormat = "EEEE"
        let rightWeek = formatter.string(from: startTime)
        result.json["Week Tested"] = rightWeek
        let WeekOK = rightWeek == Week!
        
        var stateOK = false
        let currentState = LocationManager.shared.currentState
        if !currentState.isEmpty {
            stateOK = currentState == State!
        }
        
        result.json["Time Correct"] = TimeOK
        result.json["Date Correct"] = DateOK
        result.json["Week Correct"] = WeekOK
        result.json["Dont Know Date"] = dkDate
        result.json["Dont Know Month"] = dkMonth
        result.json["Dont Know Year"] = dkYear
        result.json["State Correct"] = stateOK
        

        if stateOK == false {
            result.shortDescription = "State: \(State!)(\(currentState)) "
        }
        if WeekOK == false {
            result.shortDescription = result.shortDescription! + " Week: \(Week!)(\(rightWeek)) "
        }
        if DateOK == false {
            result.shortDescription = result.shortDescription! + " Date: \(Date!)(\(rightDate)) "
        }
        if dkDate {
            result.shortDescription = result.shortDescription! + " Don't know date "
        }
        if dkMonth {
            result.shortDescription = result.shortDescription! + " Don't know month "
        }
        
        if dkYear {
            result.shortDescription = result.shortDescription! + " Don't know year "
        }
        
        if TimeOK == false {
            result.shortDescription = result.shortDescription! + " Time: \(Time!)(\(rightTime)) "
        }
        
        resultsArray.add(result)
        Status[TestOrientation] = TestStatus.Done
    }
    
    //pickerview setup and whatnot
    
    func numberOfComponentsInPickerView(_ pickerView : UIPickerView!) -> Int{
        return 1
    }
    
    //returns length of pickerview contents
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        print("0:", pickerView)
        if pickerView == WeekPicker {
            return weekData.count
        }
        else if pickerView == StatePicker {
            return stateData.count
        }
        return 1
    }
    
    ////sets the final variables to selected row of the pickerview's text
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        print("1:",pickerView)
        if pickerView == WeekPicker {
            Week = weekData[row]
            return weekData[row]
        }
        else if pickerView == StatePicker {
            State = stateData[row]
            return stateData[row]
        }
        
        return ""
    }
    
    //sets final variables to the selected row
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        print("2:", pickerView)
        if pickerView == WeekPicker {
            dkWeek = false
            Week = weekData[row]
        }
        else if pickerView == StatePicker {
            dkState = false
            State = stateData[row]
        }
    }
    
    func TimeDiffOK(date1: Date, date2: Date) -> Bool {
        var h1 = Calendar.current.component(.hour, from: date1)
        var h2 = Calendar.current.component(.hour, from: date2)
        let m1 = Calendar.current.component(.minute, from: date1)
        let m2 = Calendar.current.component(.minute, from: date2)
        
        // Deal with noon and 1PM
        if h1 == 12 && h2 == 1 {
            h2 = 13
        }
        if h1 == 1 && h2 == 12 {
            h1 = 13
        }
        return abs(h1*60 + m1 - h2*60 - m2) < 15*60
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
  */
}

// MARK: - Extension Date
extension Date {
    func generateRandomDate(daysBack: Int)-> Date?{
        let day = arc4random_uniform(UInt32(daysBack))+1
        let hour = arc4random_uniform(23)
        let minute = arc4random_uniform(59)
        
        let today = Date(timeIntervalSinceNow: 0)
        let gregorian  = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)
        var offsetComponents = DateComponents()
        offsetComponents.day = Int(day - 1)
        offsetComponents.hour = Int(hour)
        offsetComponents.minute = Int(minute)
        
        let randomDate = gregorian?.date(byAdding: offsetComponents, to: today, options: .init(rawValue: 0) )
        return randomDate
    }
}
