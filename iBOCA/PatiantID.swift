//
//  PatientID.swift
//  iBOCA
//
//  Created by saman on 6/25/17.
//  Copyright © 2017 sunspot. All rights reserved.
//

import Foundation

class PatientID {
    var testAdminName    : String = ""
    var currNum : Int = 0
    var currInitials : String = ""
    var currDate : String = ""
    
    
    init() {
        if UserDefaults.standard.object(forKey: "testAdministrator") != nil {
            testAdminName = UserDefaults.standard.object(forKey: "testAdministrator") as! String
        }
        setInitials()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-YYYY"
        currDate = formatter.string(from: Foundation.Date())
        
        if UserDefaults.standard.object(forKey: "lastTestDate") != nil {
            let ltd = UserDefaults.standard.object(forKey: "lastTestDate") as! String
            if ltd == currDate {
                if UserDefaults.standard.object(forKey: "lastPatientNumber") != nil {
                    currNum = (UserDefaults.standard.object(forKey: "lastPatientNumber") as! Int) + 1
                }
            } else {
                UserDefaults.standard.set(currDate, forKey:"lastTestDate")
            }
        } else {
            UserDefaults.standard.set(currDate, forKey:"lastTestDate")
        }
    }
    
    func nameSet(name : String) {
        if name != testAdminName {
            testAdminName = name
            UserDefaults.standard.set(testAdminName, forKey:"testAdministrator")
            setInitials()
            currNum = 0
            UserDefaults.standard.set(currNum, forKey:"lastPatientNumber")
        }
    }
    
    func changeID(proposed : String) -> Bool {
        let r1 = proposed.range(of: "-", options: String.CompareOptions.backwards, range: nil, locale: nil)
        if r1 == nil {
            return false
        }
        let r2 = proposed.index((r1?.lowerBound)!, offsetBy: 1)
        let r3 = r2 ..< proposed.endIndex
        let str = proposed[r3]
        if str == "" {
            return false
        }
        if Int(str) == nil {
            return false
        }
        currNum = Int(str)!
        UserDefaults.standard.set(currNum, forKey:"lastPatientNumber")
        return true
    }
    
    func getID() -> String {
        return "\(currDate)-\(currInitials)-" + String(format: "%03ld", currNum)
    }
    
    func incID() {
        currNum += 1
        UserDefaults.standard.set(currNum, forKey:"lastPatientNumber")
    }
    
    func getName() -> String {
        return testAdminName
    }
    
    func getInitials() -> String {
        return currInitials
    }
    
    func setInitials() {
        if testAdminName == "" {
            currInitials = "XYZ"
            return
        }

        for (index, char) in testAdminName.enumerated() {
            let indexminus1 = index - 1
            if index == 0 {
                currInitials = String(char).uppercased()
            } else if testAdminName[testAdminName.index(testAdminName.startIndex, offsetBy:indexminus1)] == " " {
                self.currInitials += String(char).uppercased()
            }
        }
    }
}
