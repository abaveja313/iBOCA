//
//  Demographics.swift
//  iBOCA
//
//  Created by Ellison Lim on 8/29/16.
//  Copyright © 2016 sunspot. All rights reserved.
//

import UIKit
import MessageUI
import AVFoundation
var name : String?
var age : String?
var MR : String?
var Gender : String?
var Education : String?
var Race : String?
var Ethnicity : String?
var Results1: [String] = []

//added:
var emailOn  : Bool = false
var emailAddress : String = ""


func makeAgeData() -> [String] {
    var str:[String] = []
    for i in 1...120 {
        str.append(String(i))
    }
    return str
}

class Demographics: UIViewController, MFMailComposeViewControllerDelegate, UITextFieldDelegate, UITextViewDelegate,UIPickerViewDelegate {
    
    @IBOutlet weak var GenderPicker: UIPickerView!
    let genderData = ["Male", "Female", "Other", "Prefer Not To Say"]
    
    
    @IBOutlet weak var EducationPicker: UIPickerView!
    let educationData = ["< 9 yrs", "9-11 yrs", "High School Graduate", "Associates Degree", "Bachelors Degree", "Post Graduate Degree"]
    
    
    @IBOutlet weak var EthnicityPicker: UIPickerView!
    var ethnicData = ["Caucasian", "African American", "Latino", "Other"]
    
    @IBOutlet weak var RacePicker: UIPickerView!
    var raceData = ["English", "Spanish", "Other",]
    
    @IBOutlet weak var AgePicker: UIPickerView!
    var ageData:[String] = makeAgeData()
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var MRLabel: UILabel!
    @IBOutlet weak var MRField: UITextField!
    
//added:
    @IBOutlet weak var emailOnOff: UISwitch!
    @IBOutlet weak var email: UITextField!
    
    @IBAction func updateName(_ sender: AnyObject) {
        name = nameField.text
    }
    
    @IBAction func updateMR(_ sender: AnyObject) {
        MR = MRField.text
    }
    
//added:
    @IBAction func emailOnOff(_ sender: Any) {
        emailOn = emailOnOff.isOn
        
        email.isEnabled = emailOn
        UserDefaults.standard.set(!emailOn, forKey: "emailOff")
        UserDefaults.standard.synchronize()
        
    }
    
//added:
    @IBAction func emailChanged(_ sender: Any) {
        emailAddress = email.text!
        UserDefaults.standard.set(emailAddress, forKey:"emailAddress")
        UserDefaults.standard.synchronize()
    }
    
    
    @IBOutlet weak var done: UIButton!
    
    @IBAction func done(_ sender: Any) {
    
        let alert = UIAlertController(title: "Continue", message: "Done with information?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Back", style: .default, handler: { (action) -> Void in
        }))
        
        alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: { (action) -> Void in
            let main = self.storyboard?.instantiateViewController(withIdentifier: "main") as! MainViewController
            self.present(main, animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AgePicker.delegate = self
        GenderPicker.delegate = self
        EthnicityPicker.delegate = self
        EducationPicker.delegate = self
        RacePicker.delegate = self
        
        
        
        name = ""
        MR = ""
        age = ageData[AgePicker.selectedRow(inComponent: 0)]
        Gender = genderData[GenderPicker.selectedRow(inComponent: 0)]
        Ethnicity = ethnicData[EthnicityPicker.selectedRow(inComponent: 0)]
        Education = educationData[EducationPicker.selectedRow(inComponent: 0)]
        Race = raceData[RacePicker.selectedRow(inComponent: 0)]
        
        
//added:
        emailOn = !UserDefaults.standard.bool(forKey: "emailOff")
        
        if(UserDefaults.standard.object(forKey: "emailAddress") != nil) {
            emailAddress = UserDefaults.standard.object(forKey: "emailAddress") as! String
        }
        
        email.isEnabled = emailOn
        emailOnOff.isOn = emailOn
        email.text = emailAddress
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
                    //pickerview setup
    func numberOfComponentsInPickerView(_ pickerView : UIPickerView!) -> Int{
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        if pickerView == AgePicker {
            return ageData.count
        } else if pickerView == GenderPicker {
            return genderData.count
        } else if pickerView == EthnicityPicker {
            return ethnicData.count
        } else if pickerView == EducationPicker {
            return educationData.count
        } else if pickerView == RacePicker {
            return raceData.count
        }
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == AgePicker {
            age = ageData[row]
            return ageData[row]
        } else if pickerView == GenderPicker {
            Gender = genderData[row]
            return genderData[row]
        } else if pickerView == EthnicityPicker {
            Ethnicity = ethnicData[row]
            return ethnicData[row]
        } else if pickerView == EducationPicker {
            Education = educationData[row]
            return educationData[row]
        } else if pickerView == RacePicker {
            Race = raceData[row]
            return raceData[row]
        }
       return ""
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == AgePicker {
            age = ageData[row]
        } else if pickerView == GenderPicker {
            Gender = genderData[row]
        } else if pickerView == EthnicityPicker {
            Ethnicity = ethnicData[row]
            if Ethnicity == "Other" {
                addOtherCondition(pickerView)
            }
        } else if pickerView == EducationPicker {
           Education = educationData[row]
        } else if pickerView == RacePicker {
            Race = raceData[row]
            if Race == "Other" {
                addOtherCondition(pickerView)
            }
        }
    }
    
    func addOtherCondition(_ pickerView:UIPickerView){
        let alert = UIAlertController(title: "Other", message: "Enter other ", preferredStyle: .alert)
        
        //2. Add the text field. You can configure it however you need.
        
        alert.addTextField(configurationHandler: { (textField) -> Void in
            textField.text = ""
            
        })
        
        //3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "Done", style: .default, handler: { (action) -> Void in
            let textField = alert.textFields![0] as UITextField
            //self.resultComments[self.count-startCount] = textField.text!
            let result = textField.text
            
            var cnt : Int = 0
            if pickerView == self.EthnicityPicker {
                self.ethnicData.append(result!)
                cnt = self.ethnicData.count
                Ethnicity = result!
            } else if pickerView == self.RacePicker {
                self.raceData.append(result!)
                cnt = self.raceData.count
                Race = result!
            }
            pickerView.reloadAllComponents()
            pickerView.selectRow(cnt-1, inComponent: 0, animated: true)
        }))
        
        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
    }

    @IBAction func TestDone(_ sender: AnyObject) {
    Results1.append(name!)
    Results1.append(MR!)
    Results1.append(Gender!)
    Results1.append(Ethnicity!)
    Results1.append(Education!)
    Results1.append(age!)
    Results1.append(Race!)
    print(Results1)
    }
}
