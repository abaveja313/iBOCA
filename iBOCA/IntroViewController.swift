//
//  IntroViewController.swift
//  iBOCA
//
//  Created by hdwebsoft on 7/11/19.
//  Copyright © 2019 sunspot. All rights reserved.
//

import UIKit

class IntroViewController: ViewController {

    @IBOutlet weak var backTitleLabel: UILabel!
    @IBOutlet weak var innerShadowView: UIView!
    @IBOutlet weak var videoView: VideoView!
    @IBOutlet weak var playVideoButton: UIButton!
    @IBOutlet weak var introDescriptionLabel: UILabel!
    @IBOutlet weak var trailContentButtonView: UIView!
    @IBOutlet weak var trailStartButton: UIButton!
    @IBOutlet weak var trailStartPracticeButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    
    // QuickStart Mode
    var quickStartModeOn: Bool = false
    var didBackToResult: (() -> ())?
    var didMoveToTestScreen: (() -> ())?
    
    var testId: String!
    var videoName: String!
    
    var mode : TestMode = TestMode.admin
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.videoName = "sample-test-intro"
        self.setupView()
        
        self.isPracticeButtonHidden(!Settings.SegueId!)
        self.testId = Settings.TestId
    }
    
    private func stopVideo() {
        if videoView.isPlaying() {
            videoView.stop()
        }
    }

    @IBAction func actionBack(_ sender: Any) {
        self.stopVideo()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func actionPlayVideo(_ sender: Any) {
        if !videoView.isPlaying() {
            videoView.config(name: self.videoName)
            videoView.play()
            playVideoButton.isHidden = true
        }
    }
    
    @IBAction func actionStart(_ sender: Any) {
        self.stopVideo()
        
        guard !quickStartModeOn else {
            didMoveToTestScreen?()
            return
        }
        
        let storyboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        var viewController = UIViewController()
        
        switch testId {
        case "orientation":
            viewController = (storyboard.instantiateViewController(withIdentifier: "OrientationTask") as? OrientationTask)!
        case "simple-memory":
            viewController = (storyboard.instantiateViewController(withIdentifier: "SimpleMemoryTask") as? SimpleMemoryTask)!
        case "visual-association":
            viewController = (storyboard.instantiateViewController(withIdentifier: "VATask") as? VATask)!
        case "trails":
            viewController = (storyboard.instantiateViewController(withIdentifier: "TrailsAViewController") as? TrailsAViewController)!
        case "ForwardDigitSpan", "BackwardDigitSpan", "SerialSeven":
            testName = testId
            viewController = (storyboard.instantiateViewController(withIdentifier: "DigitBase") as? DigitBase)!
        case "3d-figure":
            viewController = (storyboard.instantiateViewController(withIdentifier: "ThreeDFigureCopy") as? ThreeDFigureCopy)!
            (viewController as! ThreeDFigureCopy).mode = mode
        case "naming-picture":
            viewController = (storyboard.instantiateViewController(withIdentifier: "PicturesViewController") as? PicturesViewController)!
        case "ForwardSpatialSpan", "BackwardSpatialSpan":
            testName = testId
            viewController = (storyboard.instantiateViewController(withIdentifier: "TapInOrderViewController") as? TapInOrderViewController)!
        default:
            break
        }
        
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    @IBAction func actionPracticeTest(_ sender: Any) {
        let storyboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        if let vc = (storyboard.instantiateViewController(withIdentifier: "TrailsAViewController") as? TrailsAViewController) {
            vc.isPracticeTest = true
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension IntroViewController {
    fileprivate func setupView() {
        self.backTitleLabel.font = Font.font(name: Font.Montserrat.semiBold, size: 28.0)
        self.backTitleLabel.textColor = Color.color(hexString: "#013AA5")
        self.backTitleLabel.addTextSpacing(-0.56)
        self.backTitleLabel.text = "BACK"
        
        self.innerShadowView.layer.cornerRadius = 8
        self.innerShadowView.layer.shadowColor = Color.color(hexString: "#649BFF").withAlphaComponent(0.32).cgColor
        self.innerShadowView.layer.shadowOpacity = 1
        self.innerShadowView.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.innerShadowView.layer.shadowRadius = 10 / 2
        self.innerShadowView.layer.shadowPath = nil
        self.innerShadowView.layer.masksToBounds = false
        
        self.videoView.delegate = self
        
        self.introDescriptionLabel.font = Font.font(name: Font.Montserrat.medium, size: 18.0)
        self.introDescriptionLabel.addTextSpacing(-0.36)
        
        self.trailStartButton.titleLabel?.font = Font.font(name: Font.Montserrat.bold, size: 22.0)
        self.trailStartButton.setTitle("START YOUR TEST", for: .normal)
        self.trailStartButton.layer.cornerRadius = 8
        self.trailStartButton.layer.masksToBounds = true
        
        self.trailStartPracticeButton.titleLabel?.font = Font.font(name: Font.Montserrat.bold, size: 22.0)
        self.trailStartPracticeButton.setTitle("PRACTICE THIS TEST", for: .normal)
        self.trailStartPracticeButton.layer.cornerRadius = 8
        self.trailStartPracticeButton.layer.masksToBounds = true
        
        self.startButton.titleLabel?.font = Font.font(name: Font.Montserrat.bold, size: 22.0)
        self.startButton.setTitle("START YOUR TEST", for: .normal)
        self.startButton.layer.cornerRadius = 8
        self.startButton.layer.masksToBounds = true
    }
    
    fileprivate func isPracticeButtonHidden(_ isHidden: Bool) {
        self.trailStartButton.isHidden = isHidden
        self.trailStartPracticeButton.isHidden = isHidden
        self.trailContentButtonView.isHidden = isHidden
        self.startButton.isHidden = !isHidden
    }
}

extension IntroViewController: VideoViewDelegate {
    func videoDidFinishPlaying() {
        self.playVideoButton.isHidden = false
    }
}
