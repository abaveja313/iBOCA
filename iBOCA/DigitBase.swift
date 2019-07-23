//
//  DigitBase.swift
//  iBOCA
//
//  Created by saman on 6/10/17.
//  Copyright © 2017 sunspot. All rights reserved.
//

import Foundation

import UIKit
import AVFoundation

class DigitBase: ViewController {
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var backTitleLabel: UILabel!
    @IBOutlet weak var innerShadowView: UIView!
    
    @IBOutlet weak var numKeyboard: NumberKeyboardView!
    @IBOutlet weak var keypadLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var showRandomNumberLabel: UILabel!
    @IBOutlet weak var randomNumberLabel: UILabel!
    
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var correctAnswerLabel: UILabel!
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var quitButton: GradientButton!
    @IBOutlet weak var resetButton: GradientButton!
    
    var base: DigitBaseClass? = nil  // Cannot do a subclass, so using composition
    var value: String = ""
    var ended = false
    let speechSynthesizer = AVSpeechSynthesizer()
    
    // QuickStart Mode
    var quickStartModeOn: Bool = false
    var didBackToResult: (() -> ())?
    var didCompleted: (() -> ())?
    
    var counterTimeView: CounterTimeView!
    var totalTimeCounter = Timer()
    var startTimeTask = Foundation.Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        numKeyboard.delegate = self
        
        // Dispatch according to incoming
        if testName == "ForwardDigitSpan" {
            base = DigitSpanForward()
        } else if testName == "BackwardDigitSpan" {
            base = DigitSpanBackward()
        } else if testName == "SerialSeven" {
            base = DigitSerialSeven()
        } else {
            assert(true, "Error, got here with wrong name")
        }
        base!.base = self
        base!.doStart()
        
        setupCounterTimeView()
        
        // Change back button title if quickStartMode is On
        if quickStartModeOn {
            backTitleLabel.text = "RESULTS"
            quitButton.updateTitle(title: "CONTINUE")
        }
        
        value = ""
        numberLabel.text = ""
        keypadLabel.text = ""
        
        backButton.isHidden = false
    }
    
    fileprivate func runTimer() {
        self.totalTimeCounter = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        self.totalTimeCounter.fire()
    }
    
    func updateTime(timer: Timer) {
        self.counterTimeView.setTimeWith(startTime: self.startTimeTask, currentTime: Foundation.Date())
    }
    
    // This may be call more than when EndPressed, DoEnd may be call within the subclass, which should call this
    func endTest() {
        ended = true
        value = ""
        numberLabel.text = ""
        keypadLabel.text = ""
        correctAnswerLabel.text = ""
    }
    
    func showCorrectAnswer(value: Int) {
        self.correctAnswerLabel.isHidden = false
        self.correctAnswerLabel.text = "Correct answer: \(value)"
    }
    
    func DisplayStringShowContinue(val:String) {
            // digit utterances in the sequence with a short delay in between
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
                if val.count == 0 {
                    self.infoLabel.text = "Start entering the number sequence given by patient, followed by done"
                    self.value = ""
                    self.keypadLabel.text = ""
                    self.base!.levelStartTime = Foundation.Date()
                    self.setButtonEnabled(true)
                } else {
                    let c = String(val.first!)
                    self.value = self.value + c
                    let rest = String(Array(repeating: ".", count: self.base!.level - self.value.count + 1))
    
                    if testName != "ForwardDigitSpan" && testName != "BackwardDigitSpan" {
                        self.numberLabel.text = self.value + rest
                    }
                    
                    let utterence = AVSpeechUtterance(string: c)
                    self.speechSynthesizer.speak(utterence)
                    
                    self.DisplayStringShowContinue(val: String(val.dropFirst(1)))
                }
            }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        self.startTimeTask = Foundation.Date()
        self.totalTimeCounter.invalidate()
        if !ended {
            base!.doEnd()
        }
    }
}

// MARK: Action
extension DigitBase {
    @IBAction func actionBack(_ sender: Any) {
        if Status[base!.testStatus] != TestStatus.Done {
            Status[base!.testStatus] = TestStatus.NotStarted
        }
        self.startTimeTask = Foundation.Date()
        self.totalTimeCounter.invalidate()
        speechSynthesizer.stopSpeaking(at: .immediate)
        
        // Check if is in quickStart mode
        guard !quickStartModeOn else {
            didBackToResult?()
            return
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func actionQuit(_ sender: UIButton) {
        if Status[base!.testStatus] != TestStatus.Done {
            Status[base!.testStatus] = TestStatus.NotStarted
        }
        self.startTimeTask = Foundation.Date()
        self.totalTimeCounter.invalidate()
        speechSynthesizer.stopSpeaking(at: .immediate)
        
        // Check if is in quickStart mode
        guard !quickStartModeOn else {
            QuickStartManager.showAlertCompletion(viewController: self, cancel: {
                self.didBackToResult?()
            }) {
                self.didCompleted?()
            }
            return
        }
        
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func actionReset(_ sender: Any) {
        self.startTimeTask = Foundation.Date()
        self.totalTimeCounter.invalidate()
        speechSynthesizer.stopSpeaking(at: .immediate)
        self.runTimer()
        
        base!.doStart()
    }
}

extension DigitBase {
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
        
        self.quitButton.setTitle(title: "QUIT", withFont: Font.font(name: Font.Montserrat.bold, size: 18))
        self.quitButton.setupShadow(withColor: UIColor.clear, sketchBlur: 0, opacity: 0)
        self.quitButton.setupGradient(arrColor: [Color.color(hexString: "FFAFA6"),Color.color(hexString: "FE786A")], direction: .topToBottom)
        self.quitButton.render()
        self.quitButton.addTextSpacing(-0.36)
        
        self.resetButton.setTitle(title: "RESET", withFont: Font.font(name: Font.Montserrat.bold, size: 18))
        self.resetButton.setupShadow(withColor: UIColor.clear, sketchBlur: 0, opacity: 0)
        self.resetButton.setupGradient(arrColor: [Color.color(hexString: "#FFDC6E"),Color.color(hexString: "#FFC556")], direction: .topToBottom)
        self.resetButton.render()
        self.resetButton.addTextSpacing(-0.36)
        
        self.keypadLabel.font = Font.font(name: Font.Montserrat.semiBold, size: 28.0)
        self.keypadLabel.textColor = Color.color(hexString: "#013AA5")
        self.keypadLabel.backgroundColor = Color.color(hexString: "#F7F7F7")
        self.keypadLabel.layer.borderWidth = 1
        self.keypadLabel.layer.borderColor = Color.color(hexString: "#EAEAEA").cgColor
        self.keypadLabel.layer.cornerRadius = 8
        self.keypadLabel.layer.masksToBounds = true
        
        self.infoLabel.font = Font.font(name: Font.Montserrat.medium, size: 18.0)
        self.infoLabel.addTextSpacing(-0.36)
        
        self.showRandomNumberLabel.font = Font.font(name: Font.Montserrat.semiBold, size: 18.0)
        self.showRandomNumberLabel.text = "STARTING NUMBER:"
        
        self.randomNumberLabel.font = Font.font(name: Font.Montserrat.semiBold, size: 28.0)
        self.randomNumberLabel.textColor = Color.color(hexString: "#FF5430")
    }
    
    fileprivate func setupCounterTimeView() {
        counterTimeView = CounterTimeView()
        contentView.addSubview(counterTimeView!)
        counterTimeView?.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        counterTimeView?.centerYAnchor.constraint(equalTo: resetButton.centerYAnchor).isActive = true
        self.totalTimeCounter.invalidate()
        self.runTimer()
    }
    
    func isNumKeyboardHidden(isHidden: Bool) {
        self.numKeyboard.isHidden = isHidden
        self.keypadLabel.isHidden = isHidden
    }
    
    func setButtonEnabled(_ isEnabled: Bool) {
        self.quitButton.isEnabled = isEnabled
        self.backButton.isEnabled = isEnabled
        self.resetButton.isEnabled = isEnabled
        self.numKeyboard.isEnabled(isEnabled)
    }
}

// A hacky superclass that implementations can subclass as subclassing DigitBase don't work (cannot  initialize supervlasses within the sotrybaord)
class DigitBaseClass {
    var level = 0
    var testName = ""
    var testStatus = -1
    
    var base:DigitBase = DigitBase()
    
    var startTime = Foundation.Date()
    var levelStartTime = Foundation.Date()
    
    var gotKeys : [String:String] = [:]
    
    func DoInitialize() {  }
    
    func doStart()      {  }
    
    func doEnterDone()  {  }
    
    func doEnd()        {  }
}

extension DigitBase: NumberKeyboardViewDelegate {
    func didNumberPressed(_ text: String) {
        correctAnswerLabel.isHidden = true
        keypadLabel.text = keypadLabel.text! + text
    }
    
    func didEnterPressed() {
        base!.doEnterDone()
    }
    
    func didDeletePressed() {
        if !keypadLabel.text!.isEmpty {
            keypadLabel.text?.removeLast()
        }
    }
}
