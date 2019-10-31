//
//  AckViewController.swift
//  iBOCA
//
//  Created by saman on 7/10/17.
//  Copyright © 2017 sunspot. All rights reserved.
//

import Foundation
import UIKit


class AckViewController:  BaseViewController {

    @IBOutlet weak var versionLabel: UILabel!
    
    @IBAction func BCSbutton(_ sender: Any) {
        if let url = URL.init(string: "http://www.bostoncognitive.org") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    @IBAction func CNBSbutton(_ sender: Any) {
        if let url = URL.init(string: "http://tmslab.org") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //declare pickerviews
        
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String
        
        versionLabel.text = "Version " + version! + " (build " + build! + ")"
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func actionBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
