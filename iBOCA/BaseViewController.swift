//
//  BaseViewController.swift
//  iBOCA
//
//  Created by Seth Amarasinghe on 8/1/16.
//  Copyright © 2016 sunspot. All rights reserved.
//

import UIKit
import MessageUI

class BaseViewController: UIViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        navigationItem.title = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                // iPadPro resizing
        //        if self.view.frame.size.width > 1024 {
        //            let scale = self.view.frame.size.width / 1024.0
        //            self.scale = scale
        //            self.view.transform = CGAffineTransform(scaleX: scale, y: scale)
        //        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func savePID(){
        Settings.patientID = PID.getID()
    }

    func showPopup(_ title: String, message: String, okAction: @escaping () -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert    )
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            okAction()
        }
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    func presentPopover(_ viewController: UIViewController, sourceView: UIView? = nil, sourceRect: CGRect? = nil, permittedArrowDirections: UIPopoverArrowDirection = .any) {
        viewController.modalPresentationStyle = .popover
        viewController.preferredContentSize = viewController.view.bounds.size
        viewController.definesPresentationContext = true
        viewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        if let pop = viewController.popoverPresentationController {
            pop.sourceView = sourceView ?? self.view
            pop.sourceRect = sourceRect ?? self.view.frame
            pop.permittedArrowDirections = permittedArrowDirections
            if sourceRect == nil {
                pop.permittedArrowDirections = []
                pop.delegate = viewController as? UIPopoverPresentationControllerDelegate
            }
        }
        self.present(viewController, animated: true, completion: nil)
    }
}

