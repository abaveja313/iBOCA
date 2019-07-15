//
//  QuickStartManager.swift
//  iBOCA
//
//  Created by Dat Huynh on 7/12/19.
//  Copyright © 2019 sunspot. All rights reserved.
//

import UIKit

class QuickStartManager: NSObject {

    let viewController: UIViewController
    var navigationController: UINavigationController?
    
    init(controller: UIViewController) {
        self.viewController = controller
    }
    
    private var backToResult: (() -> ())?
    
    public func start() {
        let backToResult: (() -> ()) = {
            let resultVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ResultsViewController") as! ResultsViewController
            resultVC.didBackToMainView = {
                self.viewController.dismiss(animated: true, completion: nil)
            }
            self.navigationController?.pushViewController(resultVC, animated: true)
        }
        self.backToResult = backToResult
        
        // Start first test
        firstTest()
    }
    
    
    private func firstTest() {
        guard let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "OrientationTask") as? OrientationTask else {
            debugPrint("Unable to launch test")
            return
        }
        vc.quickStartModeOn = true
        vc.didBackToResult = backToResult
        vc.didCompleted = {
            // Move to next test
            self.secondTest()
        }
        
        navigationController = UINavigationController.init(rootViewController: vc)
        navigationController?.isNavigationBarHidden = true
        
        viewController.present(navigationController!, animated: true, completion: nil)
    }
    
    private func secondTest() {
        guard let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SimpleMemoryTask") as? SimpleMemoryTask else {
            debugPrint("Unable to launch test")
            return
        }
        vc.quickStartModeOn = true
        vc.didBackToResult = backToResult
        vc.didCompleted = {
            self.thirdTest()
        }
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func thirdTest() {
        guard let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "VATask") as? VATask else {
            debugPrint("Unable to launch test")
            return
        }
        vc.quickStartModeOn = true
        vc.didBackToResult = backToResult
        vc.didCompleted = {
            // Move to next test
            self.fourthTest()
        }
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func fourthTest() {
        guard let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "VATask") as? VATask else {
            debugPrint("Unable to launch test")
            return
        }
        vc.quickStartModeOn = true
        vc.didBackToResult = backToResult
        vc.didCompleted = {
            
        }
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    class func showAlertCompletion(viewController: UIViewController, cancel: (() -> ())?, ok: (() -> ())?) {
        let alertController = UIAlertController(title: "Completed", message: "Do you want to move to the next test?", preferredStyle: .alert)
        let noAction = UIAlertAction.init(title: "No", style: .cancel, handler: { (_) in
            cancel?()
        })
        let yesAction = UIAlertAction.init(title: "Yes", style: .default) { (_) in
            ok?()
        }
        alertController.addAction(noAction)
        alertController.addAction(yesAction)
        viewController.present(alertController, animated: true, completion: nil)
    }
}
