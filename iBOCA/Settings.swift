//
//  Settings.swift
//  iBOCA
//
//  Created by Macintosh HD on 5/16/19.
//  Copyright © 2019 sunspot. All rights reserved.
//

import Foundation

class Settings {
    
    // MARK: - Administrator Name
    public class var administratorName: String? {
        set {
            UserDefaults.setObj(newValue, forKey: "AdministratorName")
        }
        get {
            return UserDefaults.obj(forKey: "AdministratorName") as? String
        }
    }
    
    // MARK: - Patiant ID
    public class var patiantID: String? {
        set {
            UserDefaults.setObj(newValue, forKey: "PatiantID")
        }
        get {
            return UserDefaults.obj(forKey: "PatiantID") as? String
        }
    }
    
    // MARK: - Age User
    public class var ageUser: String? {
        set {
            UserDefaults.setObj(newValue, forKey: "AgeUser")
        }
        get {
            return UserDefaults.obj(forKey: "AgeUser") as? String
        }
    }
    
    // MARK: - Gender User
    public class var genderUser: String? {
        set {
            UserDefaults.setObj(newValue, forKey: "GenderUser")
        }
        get {
            return UserDefaults.obj(forKey: "GenderUser") as? String
        }
    }
    
    // MARK: - Education User
    public class var educationUser: String? {
        set {
            UserDefaults.setObj(newValue, forKey: "EducationUser")
        }
        get {
            return UserDefaults.obj(forKey: "EducationUser") as? String
        }
    }
    
    // MARK: - Race User
    public class var raceUser: String? {
        set {
            UserDefaults.setObj(newValue, forKey: "RaceUser")
        }
        get {
            return UserDefaults.obj(forKey: "RaceUser") as? String
        }
    }
    
    // MARK: - Ethnicity User
    public class var ethnicityUser: String? {
        set {
            UserDefaults.setObj(newValue, forKey: "EthnicityUser")
        }
        get {
            return UserDefaults.obj(forKey: "EthnicityUser") as? String
        }
    }
    
    // MARK: - Protocol User
    public class var protocolUser: String? {
        set {
            UserDefaults.setObj(newValue, forKey: "ProtocolUser")
        }
        get {
            return UserDefaults.obj(forKey: "ProtocolUser") as? String
        }
    }
    
    // MARK: - Comments User
    public class var commentsUser: String? {
        set {
            UserDefaults.setObj(newValue, forKey: "CommentsUser")
        }
        get {
            return UserDefaults.obj(forKey: "CommentsUser") as? String
        }
    }
    
    // MARK: - PUID
    public class var PUID: String? {
        set {
            UserDefaults.setObj(newValue, forKey: "PUID")
        }
        get {
            return UserDefaults.obj(forKey: "PUID") as? String
        }
    }
    
    // MARK: - Results Email Address
    public class var resultsEmailAddress: String? {
        set {
            UserDefaults.setObj(newValue, forKey: "ResultsEmailAddress")
        }
        get {
            return UserDefaults.obj(forKey: "ResultsEmailAddress") as? String
        }
    }
    
    // MARK: - Patiant ID
    public class var isGotoTest: Bool? {
        set {
            UserDefaults.setObj(newValue, forKey: "GotoTest")
        }
        get {
            return UserDefaults.obj(forKey: "GotoTest") as? Bool
        }
    }
    
    // MARK: - Functions
    public class func removeALL() {
        Settings.administratorName = nil
        Settings.patiantID = nil
        Settings.genderUser = nil
        Settings.ageUser = nil
        Settings.educationUser = nil
        Settings.ethnicityUser = nil
        Settings.raceUser = nil
        Settings.protocolUser = nil
        Settings.commentsUser = nil
        Settings.PUID = nil
        Settings.isGotoTest = false
    }
    
    // MARK: - Comments User
    public class var SMDelayTime: Int? {
        set {
            UserDefaults.setObj(newValue, forKey: "SMDelayTime")
        }
        get {
            return UserDefaults.obj(forKey: "SMDelayTime") as? Int
        }
    }
    
    public class var VADelayTime: Int? {
        set {
            UserDefaults.setObj(newValue, forKey: "VADelayTime")
        }
        get {
            return UserDefaults.obj(forKey: "VADelayTime") as? Int
        }
    }
    
    public class var TestId: String? {
        set {
            UserDefaults.setObj(newValue, forKey: "TestId")
        }
        get {
            return UserDefaults.obj(forKey: "TestId") as? String
        }
    }
    
    public class var SegueId: Bool? {
        set {
            UserDefaults.setObj(newValue, forKey: "SegueId")
        }
        get {
            return UserDefaults.obj(forKey: "SegueId") as? Bool
        }
    }
    
}

public extension UserDefaults {
    
    // MARK: - UserDefaults
    class func obj(forKey key: String) -> Any? {
        let defaults = UserDefaults.standard
        
        let obj = defaults.object(forKey: key)
        return obj
    }
    
    class func setObj(_ obj: Any?, forKey key: String) {
        let defaults = UserDefaults.standard
        
        defaults.set(obj, forKey: key)
        defaults.synchronize()
    }
    
    class func removeObj(forKey key: String) {
        let defaults = UserDefaults.standard
        
        defaults.removeObject(forKey: key)
        defaults.synchronize()
    }
    
    class func obj(forKey key: String, unarchive: Bool) -> Any? {
        var obj = self.obj(forKey: key)
        //Check for archiving/unarchiving
        if unarchive && (obj is Data) {
            obj = NSKeyedUnarchiver.unarchiveObject(with: obj as! Data)
        }
        return obj
    }
    
    class func setObj(_ obj: Any?, forKey key: String, archive: Bool) {
        
        //Error protection
        if let obj = obj {
            if archive && (obj as AnyObject).responds!(to: #selector(NSData.encode(with:))) {
                let objData = NSKeyedArchiver.archivedData(withRootObject: obj)
                self.setObj(objData, forKey: key)
            } else {
                self.setObj(obj, forKey: key)
            }
        }
    }
    
    class func clearDefaults() {
        let appDomain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: appDomain)
    }
}
