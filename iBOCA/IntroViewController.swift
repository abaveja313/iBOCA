//
//  IntroViewController.swift
//  iBOCA
//
//  Created by hdwebsoft on 7/11/19.
//  Copyright © 2019 sunspot. All rights reserved.
//

import UIKit

class IntroViewController: UIViewController {

    @IBOutlet weak var backTitleLabel: UILabel!
    @IBOutlet weak var innerShadowView: UIView!
    @IBOutlet weak var videoView: VideoView!
    @IBOutlet weak var playVideoButton: UIButton!
    @IBOutlet weak var introDescriptionLabel: UILabel!
    @IBOutlet weak var trailContentButtonView: UIView!
    @IBOutlet weak var trailStartButton: UIButton!
    @IBOutlet weak var trailStartPracticeButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    
    var testId: String!
    var videoName: String!
    
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
        if let vc = storyboard!.instantiateViewController(withIdentifier: "main") as? MainViewController {
            vc.mode = .patient
            self.present(vc, animated: true, completion: nil)
        }
        self.stopVideo()
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
        
        switch testId {
        case "ForwardDigitSpan", "BackwardDigitSpan", "SerialSeven":
            testName = testId
            UserDefaults.standard.set(testId, forKey: "testId")
            self.testId = "digit-base"
        case "ForwardSpatialSpan", "BackwardSpatialSpan":
            testName = testId
            self.testId = "baseSpatial"
        default:
            break
        }
        
        performSegue(withIdentifier: self.testId, sender: nil)
    }
    
    @IBAction func actionPracticeTest(_ sender: Any) {
        if let vc = storyboard!.instantiateViewController(withIdentifier: "TrailsAViewController") as? TrailsAViewController {
            vc.isPracticeTest = true
            self.present(vc, animated: true, completion: nil)
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
