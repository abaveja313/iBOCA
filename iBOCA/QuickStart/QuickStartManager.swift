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
            resultVC.quickStartModeOn = true
            resultVC.didBackToMainView = {
                self.navigationController?.popViewController(animated: true)
            }
            
            let transition = CATransition()
            transition.duration = 0.5
            transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
            transition.type = CATransitionType.fade
            self.navigationController?.view.layer.add(transition, forKey: nil)
            
            self.navigationController?.pushViewController(resultVC, animated: true)
        }
        self.backToResult = backToResult
        
        // Launch Intro
        launchIntroScreen(fromScreen: .orientation)
    }
    
    private func launchIntroScreen(fromScreen type: TestType) {
        Settings.SegueId = type == .trails
        
        let introVC = UIStoryboard(name: "Main", bundle:Bundle.main).instantiateViewController(withIdentifier: "IntroViewController") as! IntroViewController
        introVC.showResultButton = type != .orientation
        introVC.quickStartModeOn = true
        introVC.testTypeQuickStart = type
        introVC.didBackToResult = backToResult
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
                self.figureCopyTest()
                break
            case .serialSevens:
                self.serialSevensTest()
                break
            case .namingPicture:
                self.namingPictureTest()
                break
            case .forwardSpatialSpan:
                self.forwardSpatialSpanTest()
                break
            case .backwardSpatialSpan:
                self.backwardSpatialSpanTest()
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
            viewController.presentViewController(viewController:navigationController!, animated: true, completion: nil)
        }
    }
    
    
    private func orientationTest() { // 1st test
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
    
    private func simpleMemoryTest() { // 2nd test
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
    
    private func VATest() { // 3rd test
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
    
    private func trailsTest() { // 4th test
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
    
    private func forwardDigitSpanTest() { // 5th test
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
    
    private func backwardDigitSpanTest() { // 6th test
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
    
    private func figureCopyTest() { // 7th test
        guard let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ThreeDFigureCopy") as? ThreeDFigureCopy else {
            debugPrint("Unable to launch test")
            return
        }
        vc.quickStartModeOn = true
        vc.didBackToResult = backToResult
        vc.didCompleted = {
            self.launchIntroScreen(fromScreen: .serialSevens)
        }
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func serialSevensTest() { // 8th test
        guard let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DigitBase") as? DigitBase else {
            debugPrint("Unable to launch test")
            return
        }
        testName  = "SerialSeven"
        vc.quickStartModeOn = true
        vc.didBackToResult = backToResult
        vc.didCompleted = {
            self.launchIntroScreen(fromScreen: .namingPicture)
        }
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func namingPictureTest() { // 9th test
        guard let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PicturesViewController") as? PicturesViewController else {
            debugPrint("Unable to launch test")
            return
        }
        vc.quickStartModeOn = true
        vc.didBackToResult = backToResult
        vc.didCompleted = {
            self.launchIntroScreen(fromScreen: .forwardSpatialSpan)
        }
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func forwardSpatialSpanTest() { // 10th test
        guard let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TapInOrderViewController") as? TapInOrderViewController else {
            debugPrint("Unable to launch test")
            return
        }
        testName  = "ForwardSpatialSpan"
        vc.quickStartModeOn = true
        vc.didBackToResult = backToResult
        vc.didCompleted = {
            self.launchIntroScreen(fromScreen: .backwardSpatialSpan)
        }
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func backwardSpatialSpanTest() { // 11th test
        guard let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TapInOrderViewController") as? TapInOrderViewController else {
            debugPrint("Unable to launch test")
            return
        }
        testName  = "BackwardSpatialSpan"
        vc.quickStartModeOn = true
        vc.didBackToResult = backToResult
        vc.didCompleted = backToResult
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    class func showAlertCompletion(viewController: UIViewController, endAllTest: Bool = false, cancel: (() -> ())?, ok: (() -> ())?) {
        let alertTitle  : String = endAllTest ? "Completed": "Warning"
        let alertMessage: String = endAllTest ? "You have completed all the tests. Do you want to check your result?" : "Do you want to move to the next test?"
        let alertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        let noAction = UIAlertAction.init(title: "No", style: .default, handler: { (_) in
//            cancel?()
        })
        let yesAction = UIAlertAction.init(title: "Yes", style: .default) { (_) in
            ok?()
        }
        let quitAction = UIAlertAction.init(title: "Quit", style: .cancel) { (_) in
            viewController.navigationController?.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(quitAction)
        alertController.addAction(noAction)
        alertController.addAction(yesAction)
        viewController.presentViewController(viewController: alertController, animated: true, completion: nil)
    }
}
