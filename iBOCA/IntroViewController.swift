//
//  IntroViewController.swift
//  iBOCA
//
//  Created by hdwebsoft on 7/11/19.
//  Copyright © 2019 sunspot. All rights reserved.
//

import UIKit

class IntroViewController: BaseViewController {

    @IBOutlet weak var backTitleLabel: UILabel!
    @IBOutlet weak var innerShadowView: UIView!
    @IBOutlet weak var videoView: VideoView!
    @IBOutlet weak var playVideoButton: UIButton!
    @IBOutlet weak var introDescriptionTextView: UITextView!
    
    @IBOutlet weak var trailContentButtonView: UIView!
    @IBOutlet weak var trailStartButton: UIButton!
    @IBOutlet weak var trailStartPracticeButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    
    // QuickStart Mode
    var showResultButton: Bool = false
    var quickStartModeOn: Bool = false
    var didBackToResult: (() -> ())?
    var didMoveToTestScreen: (() -> ())?
    var testTypeQuickStart: QuickStartManager.TestType = .orientation
    
    var testId: String!
    var videoName: String!
    
    var mode : TestMode = TestMode.admin
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.videoName = "sample-test-intro"
        self.testId = Settings.TestId
        self.setupView()
        self.isPracticeButtonHidden(!Settings.SegueId!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.testId = Settings.TestId
        if quickStartModeOn == false {
            self.loadDataIntroDescription()
        }
        else {
            self.loadDataIntroDescription(withTestType: self.testTypeQuickStart)
        }
    }
    
    private func stopVideo() {
        if videoView.isPlaying() {
            videoView.stop()
        }
    }

    @IBAction func actionBack(_ sender: Any) {
        self.stopVideo()
        
        guard !showResultButton else {
            didBackToResult?()
            return
        }
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
            (viewController as! VATask).mode = self.mode == .admin ? .patient : .admin
        case "trails":
            viewController = (storyboard.instantiateViewController(withIdentifier: "TrailsAViewController") as? TrailsAViewController)!
            isPracticeTest = false
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
            isPracticeTest = true
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension IntroViewController {
    fileprivate func setupView() {
        self.backTitleLabel.font = Font.font(name: Font.Montserrat.semiBold, size: 28.0)
        self.backTitleLabel.textColor = Color.color(hexString: "#013AA5")
        self.backTitleLabel.addTextSpacing(-0.56)
        self.backTitleLabel.text = showResultButton ? "RESULTS" : "BACK"
        
        self.innerShadowView.layer.cornerRadius = 8
        self.innerShadowView.layer.shadowColor = Color.color(hexString: "#649BFF").withAlphaComponent(0.32).cgColor
        self.innerShadowView.layer.shadowOpacity = 1
        self.innerShadowView.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.innerShadowView.layer.shadowRadius = 10 / 2
        self.innerShadowView.layer.shadowPath = nil
        self.innerShadowView.layer.masksToBounds = false
        
        self.videoView.delegate = self
        
        self.introDescriptionTextView.isEditable = false
        self.introDescriptionTextView.isSelectable = false
        self.introDescriptionTextView.font = Font.font(name: Font.Montserrat.medium, size: 18.0)
        
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
    
    func loadDataIntroDescription() {
        switch self.testId {
        case "orientation":
            self.introDescriptionTextView.text = IntroDescription.ORIENTATION
        case "simple-memory":
            self.introDescriptionTextView.text = IntroDescription.SIMPLE_MEMORY
        case "visual-association":
            self.introDescriptionTextView.text = IntroDescription.VISUAL_ASSOCIATION
        case "trails":
            self.introDescriptionTextView.text = IntroDescription.TRAILS
        case "ForwardDigitSpan":
            self.introDescriptionTextView.text = IntroDescription.FORWARD_DIGIT_SPAN
        case "BackwardDigitSpan":
            self.introDescriptionTextView.text = IntroDescription.BACKWARD_DIGIT_SPAN
        case "SerialSeven":
            self.introDescriptionTextView.text = IntroDescription.SERIAL_SEVENS
        case "3d-figure":
            self.introDescriptionTextView.text = IntroDescription.THREE_DIMENSION_FIGURE_COPY
        case "naming-picture":
            self.introDescriptionTextView.text = IntroDescription.NAMING_PICTURE
        case "ForwardSpatialSpan":
            self.introDescriptionTextView.text = IntroDescription.FORWARD_SPATIAL_SPAN
        case "BackwardSpatialSpan":
            self.introDescriptionTextView.text = IntroDescription.BACKWARD_SPATIAL_SPAN
        default:
            break
        }
        
        self.introDescriptionTextView.addTextSpacing(-0.36)
        self.introDescriptionTextView.addLineSpacing(10.0)
        self.introDescriptionTextView.textAlignment = .center
    }
    
    func loadDataIntroDescription(withTestType testType: QuickStartManager.TestType) {
        switch testType {
        case .orientation:
            self.introDescriptionTextView.text = IntroDescription.ORIENTATION
        case .simpleMemory:
            self.introDescriptionTextView.text = IntroDescription.SIMPLE_MEMORY
        case .visualAssociation:
            self.introDescriptionTextView.text = IntroDescription.VISUAL_ASSOCIATION
        case .trails:
            self.introDescriptionTextView.text = IntroDescription.TRAILS
        case .forwardDigitSpan:
            self.introDescriptionTextView.text = IntroDescription.FORWARD_DIGIT_SPAN
        case .backwardDigitSpan:
            self.introDescriptionTextView.text = IntroDescription.BACKWARD_DIGIT_SPAN
        case .serialSevens:
            self.introDescriptionTextView.text = IntroDescription.SERIAL_SEVENS
        case .figureCopy:
            self.introDescriptionTextView.text = IntroDescription.THREE_DIMENSION_FIGURE_COPY
        case .namingPicture:
            self.introDescriptionTextView.text = IntroDescription.NAMING_PICTURE
        case .forwardSpatialSpan:
            self.introDescriptionTextView.text = IntroDescription.FORWARD_SPATIAL_SPAN
        case .backwardSpatialSpan:
            self.introDescriptionTextView.text = IntroDescription.BACKWARD_SPATIAL_SPAN
        default:
            break
        }
        
        self.introDescriptionTextView.addTextSpacing(-0.36)
        self.introDescriptionTextView.addLineSpacing(10.0)
        self.introDescriptionTextView.textAlignment = .center
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
