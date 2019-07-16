//
//  QuickStartManager.swift
//  iBOCA
//
//  Created by Dat Huynh on 7/12/19.
//  Copyright © 2019 sunspot. All rights reserved.
//

import UIKit

class QuickStartManager: NSObject {

    enum TestType {
        case orientation
        case simpleMemory
        case visualAssociation
        case trails
        case speechToText
        case forwardDigitSpan
        case backwardDigitSpan
        case figureCopy
        case serialSevens
        case namingPicture
        case forwardSpatialSpan
        case backwardSpatialSpan
    }
    
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
        
        // Launch Intro
        launchIntroScreen(fromScreen: .orientation)
    }
    
    private func launchIntroScreen(fromScreen type: TestType) {
        Settings.SegueId = type == .trails
        
        let introVC = UIStoryboard(name: "Main", bundle:Bundle.main).instantiateViewController(withIdentifier: "IntroViewController") as! IntroViewController
        introVC.quickStartModeOn = true
        introVC.didMoveToTestScreen = {
            switch type {
            case .orientation:
                self.orientationTest()
                break
            case .simpleMemory:
                self.simpleMemoryTest()
                break
            case .visualAssociation:
                self.VATest()
                break
            case .trails:
                self.trailsTest()
                break
            case .speechToText:
                
                break
            case .forwardDigitSpan:
                self.forwardDigitSpanTest()
                break
            case .backwardDigitSpan:
                self.backwardDigitSpanTest()
                break
            case .figureCopy:
                
                break
            case .serialSevens:
                
                break
            case .namingPicture:
                
                break
            case .forwardSpatialSpan:
                
                break
            case .backwardSpatialSpan:
                
                break
            }
        }
        
        if let _ = navigationController {
            navigationController?.pushViewController(introVC, animated: true)
            for i in 0...(navigationController!.viewControllers.count - 2) {
                navigationController?.viewControllers.remove(at: i)
            }
        }
        else {
            navigationController = UINavigationController.init(rootViewController: introVC)
            navigationController?.isNavigationBarHidden = true
            
            viewController.present(navigationController!, animated: true, completion: nil)
        }
    }
    
    
    private func orientationTest() { // First test
        guard let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "OrientationTask") as? OrientationTask else {
            debugPrint("Unable to launch test")
            return
        }
        vc.quickStartModeOn = true
        vc.didBackToResult = backToResult
        vc.didCompleted = {
            // Move to next test
            self.launchIntroScreen(fromScreen: .simpleMemory)
        }
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func simpleMemoryTest() { // Second test
        guard let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SimpleMemoryTask") as? SimpleMemoryTask else {
            debugPrint("Unable to launch test")
            return
        }
        vc.quickStartModeOn = true
        vc.didBackToResult = backToResult
        vc.didCompleted = {
            self.launchIntroScreen(fromScreen: .visualAssociation)
        }
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func VATest() { // Third test
        guard let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "VATask") as? VATask else {
            debugPrint("Unable to launch test")
            return
        }
        vc.quickStartModeOn = true
        vc.didBackToResult = backToResult
        vc.didCompleted = {
            // Move to next test
            self.launchIntroScreen(fromScreen: .trails)
        }

        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func trailsTest() { // Fourth test
        guard let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TrailsAViewController") as? TrailsAViewController else {
            debugPrint("Unable to launch test")
            return
        }
        vc.quickStartModeOn = true
        vc.didBackToResult = backToResult
        vc.didCompleted = {
            self.launchIntroScreen(fromScreen: .forwardDigitSpan)
        }
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func forwardDigitSpanTest() { // Fifth test
        guard let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DigitBase") as? DigitBase else {
            debugPrint("Unable to launch test")
            return
        }
        testName  = "ForwardDigitSpan"
        vc.quickStartModeOn = true
        vc.didBackToResult = backToResult
        vc.didCompleted = {
            self.launchIntroScreen(fromScreen: .backwardDigitSpan)
        }

        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func backwardDigitSpanTest() { // Sixth test
        guard let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DigitBase") as? DigitBase else {
            debugPrint("Unable to launch test")
            return
        }
        testName  = "BackwardDigitSpan"
        vc.quickStartModeOn = true
        vc.didBackToResult = backToResult
        vc.didCompleted = {
            self.launchIntroScreen(fromScreen: .figureCopy)
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
