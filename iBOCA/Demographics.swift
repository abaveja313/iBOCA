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


var testStartTime = Foundation.Date()

var age : String?
var Gender : String?
var Education : String?
var Race : String?
var Ethnicity : String?
var Results1: [String] = []
var Comments : String = ""
var PUID: String = ""
var ModeECT = false
var Protocol = "A"



func makeAgeData() -> [String] {
    var str:[String] = []
    for i in 10...120 {
        str.append(String(i))
    }
    return str
}

enum DemographicsCategory: String {
    case Race = "Race"
    case Ethnicity = "Ethnicity"
}

class Demographics: ViewController, MFMailComposeViewControllerDelegate, UITextFieldDelegate, UITextViewDelegate,UIPickerViewDelegate {
    
    @IBOutlet weak var vBack: UIView!
    @IBOutlet weak var lblBack: UILabel!
    @IBOutlet weak var btnBack: UIButton!
    
    @IBOutlet weak var vTaskShadow: UIView!
    @IBOutlet weak var vTask: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    //=========
    
    @IBOutlet weak var lbGender: UILabel!
    @IBOutlet weak var btnGender: UIButton!
    @IBOutlet weak var lbAge: UILabel!
    @IBOutlet weak var btnAge: UIButton!
    @IBOutlet weak var lbEducation: UILabel!
    @IBOutlet weak var btnEducation: UIButton!
    @IBOutlet weak var lbEthinicity: UILabel!
    @IBOutlet weak var btnEthinicity: UIButton!
    @IBOutlet weak var lbRace: UILabel!
    @IBOutlet weak var btnRace: UIButton!
    @IBOutlet weak var lbProcotol: UILabel!
    @IBOutlet weak var btnProcotol: UIButton!
    
    let genderData = ["Male", "Female", "Other", "Prefer Not To Say"]
    
    let educationData = ["0 years", "1 years","2 years","3 years","4 years","5 years","6 years","7 years","8 years","9 years","10 years","11 years","12 years(High School)","13 years","14 years","15 years","16 years(College)","17 years","18 years","19 years", "20 years", "20+ years"]
    
    var ethnicData = ["Hispanic or Latino", "Not Hispanic or Latino"]
    
    var raceData = ["White", "Black or African American", "Asian", "Native Hawaiian or Other Pacific Islander", "American Indian or Alaskan Native", "Multi-Racial", "Unknown", "Add more",]
    
    var ageData:[String] = makeAgeData()
    
    @IBOutlet weak var MRLabel: UILabel!
    @IBOutlet weak var MRField: UITextField!
    
    @IBOutlet weak var CommentEntry: UITextView!
    
    @IBAction func updateMR(_ sender: AnyObject) {
        guard let _patiantID = self.MRField.text else { return }
        MRField.text = _patiantID
        //TODO: change flow PID
        Settings.patiantID = _patiantID
    }

    @IBOutlet weak var PatientUID: UITextField!
    
    @IBAction func updatePUID(_ sender: UITextField) {
        PUID = sender.text!
        Settings.PUID = sender.text!
    }
    
    @IBOutlet weak var protocolLabel: UILabel!
    @IBOutlet weak var viewProtocol: UIView!
    var protocolData = ["A", "B", "C", "D", "E", "F", "G", "H"]
    
    @IBAction func NextPressed(_ sender: UIButton) {
        // Save PID, PUID
        guard
            let _PID = MRField.text,
            let _PUID = self.PatientUID.text,
            let _genderUser = Gender,
            let _ageUser = age,
            let _educationUser = Education,
            let _ethnicityUser = Ethnicity,
            let _raceUser = Race
        else { return }
        //TODO: change flow PID
        Settings.patiantID = _PID
        Settings.genderUser = _genderUser
        Settings.ageUser = _ageUser
        Settings.educationUser = _educationUser
        Settings.ethnicityUser = _ethnicityUser
        Settings.raceUser = _raceUser
        Settings.protocolUser = Protocol
        Settings.commentsUser = Comments
        Settings.PUID = _PUID
        Settings.isGotoTest = true
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "main") as UIViewController
        self.present(vc, animated: true, completion: nil)
        
    }
    
    @IBAction func GenderPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "PickerViewController") as! PickerViewController
        vc.datasource = genderData
        vc.modalPresentationStyle = .overCurrentContext
        vc.didSelect = ({ value, index in
            self.lbGender.text = self.genderData[index]
            Gender = self.genderData[index]
        })
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func AgePressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "PickerViewController") as! PickerViewController
        vc.datasource = ageData
        vc.modalPresentationStyle = .overCurrentContext
        vc.didSelect = ({ value, index in
            self.lbAge.text = self.ageData[index]
            age = self.ageData[index]
        })
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func EducationPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "PickerViewController") as! PickerViewController
        vc.datasource = educationData
        vc.modalPresentationStyle = .overCurrentContext
        vc.didSelect = ({ value, index in
            self.lbEducation.text = self.educationData[index]
            Education = self.educationData[index]
        })
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func EthinicityPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "PickerViewController") as! PickerViewController
        vc.datasource = ethnicData
        vc.modalPresentationStyle = .overCurrentContext
        vc.didSelect = ({ value, index in
            self.lbEthinicity.text = self.ethnicData[index]
            Ethnicity = self.ethnicData[index]
        })
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func RacePressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "PickerViewController") as! PickerViewController
        vc.datasource = raceData
        vc.category = DemographicsCategory.Race.rawValue
        vc.modalPresentationStyle = .overCurrentContext
        vc.didSelect = ({ value, index in
            if index == self.raceData.count-1 {
                self.showAddMoreRace()
            } else {
                self.lbRace.text = self.raceData[index]
                Race = self.raceData[index]
            }
        })
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func ProtocolPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "PickerViewController") as! PickerViewController
        vc.datasource = protocolData
        vc.modalPresentationStyle = .overCurrentContext
        vc.didSelect = ({ value, index in
            self.lbProcotol.text = self.protocolData[index]
            Protocol = self.protocolData[index]
        })
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func CancelPressed(_ sender: Any) {
        Settings.isGotoTest = true
        dismiss(animated: true, completion: nil)
    }
    
    
    /*
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
        
    } */
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MRField.delegate = self
        
        // Setup First Data
        age = ageData[40]
        lbAge.text = ageData[40]
        
        Gender = genderData[0]
        lbGender.text = genderData[0]
            
        Ethnicity = ethnicData[0]
        lbEthinicity.text = ethnicData[0]
        
        Education = educationData[12]
        lbEducation.text = educationData[12]
        
        Race = raceData[0]
        lbRace.text = raceData[0]
        
        guard let _PID = Settings.patiantID else { return }
        MRField.text = _PID
        
        CommentEntry.text = ""
        CommentEntry.layer.borderWidth = 1
        CommentEntry.layer.borderColor = UIColor.lightGray.cgColor
        Comments = ""
         
        testStartTime = Foundation.Date()
        
        PUID = ""
        Settings.PUID = nil
        if atBIDMCOn == true && theTestClass == 2 {
            ModeECT = true
        } else {
            ModeECT = false
        }
        
        Protocol = protocolData[0]
        lbProcotol.text = self.protocolData[0]
        
        if(ModeECT) {
            protocolLabel.isHidden = false
            viewProtocol.isHidden = false
            btnProcotol.isHidden = false
        } else {
            protocolLabel.isHidden = true
            viewProtocol.isHidden = true
            btnProcotol.isHidden = true
        }
        protocolLabel.isHidden = false
        viewProtocol.isHidden = false
        btnProcotol.isHidden = false
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
    func showAddMoreRace() {
        let alert = UIAlertController(title: "Add more", message: "Enter add more", preferredStyle: .alert)
        //2. Add the text field. You can configure it however you need.
        alert.addTextField(configurationHandler: { (textField) -> Void in
            textField.text = ""
        })
        //3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "Done", style: .default, handler: { (action) -> Void in
            let textField = alert.textFields![0] as UITextField
            //self.resultComments[self.count-startCount] = textField.text!
            
            if let result = textField.text, !result.isEmpty {
                //do something if it's not empty
                self.raceData.insert(result, at: self.raceData.count-1)
                Race = result
                self.lbRace.text = self.raceData[self.raceData.count-2]
                Race = self.raceData[self.raceData.count-2]
            }
            else {
                alert.dismiss(animated: true, completion: nil)
            }
        }))
        
        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        Comments = CommentEntry.text
    }

    @IBAction func TestDone(_ sender: AnyObject) {
        Results1.append(PID.getID())
        Results1.append(Gender!)
        Results1.append(Ethnicity!)
        Results1.append(Education!)
        Results1.append(age!)
        Results1.append(Race!)
        print(Results1)
    }
    
    @IBAction func btnBackTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension Demographics {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if range.length + range.location > textField.text!.count {
            return false
        }
        
        if string.isEmpty {
            return true
        }
        return Int(string) != nil
    }
}

// MARK: - Setup View
extension Demographics {
    
}
