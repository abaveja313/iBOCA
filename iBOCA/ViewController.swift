//
//  ViewController.swift
//  iBOCA
//
//  Created by Seth Amarasinghe on 8/1/16.
//  Copyright © 2016 sunspot. All rights reserved.
//

import UIKit
import MessageUI

class ViewController: UIViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        navigationItem.title = nil
    }


    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // iPadPro resizing
        if self.view.frame.size.width > 1024 {
            let scale = self.view.frame.size.width / 1024.0
            self.view.transform = CGAffineTransform(scaleX: scale, y: scale);
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func savePID(){
        Settings.patiantID = PID.getID()
    }

    func showPopup(_ title: String, message: String, okAction: @escaping () -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert    )
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            okAction()
        }
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}

