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
    var base:DigitBaseClass? = nil  // Cannot do a subclass, so using composition

    @IBOutlet weak var StartButton: UIButton!
    @IBOutlet weak var BackButton: UIButton!
    
    @IBOutlet weak var Button_1: UIButton!
    @IBOutlet weak var Button_2: UIButton!
    @IBOutlet weak var Button_3: UIButton!
    @IBOutlet weak var Button_4: UIButton!
    @IBOutlet weak var Button_5: UIButton!
    @IBOutlet weak var Button_6: UIButton!
    @IBOutlet weak var Button_7: UIButton!
    @IBOutlet weak var Button_8: UIButton!
    @IBOutlet weak var Button_9: UIButton!
    @IBOutlet weak var Button_0: UIButton!
    @IBOutlet weak var Button_done: UIButton!
    @IBOutlet weak var Button_delete: UIButton!
    
    var NumKeys:[UIButton] = []
    
    @IBOutlet weak var NumberLabel: UILabel!
    @IBOutlet weak var lbCorrectAnswer: UILabel!
    
    
    @IBOutlet weak var numKeyboard: NumberKeyboardView!
    @IBOutlet weak var innerShadowView: UIView!
    @IBOutlet weak var backTitleLabel: UILabel!
    @IBOutlet weak var KeypadLabel: UILabel!
    @IBOutlet weak var InfoLabel: UILabel!
    @IBOutlet weak var lbShowRandomNumber: UILabel!
    @IBOutlet weak var randomNumberLabel: UILabel!
    @IBOutlet weak var quitButton: GradientButton!
    @IBOutlet weak var resetButton: GradientButton!
    
    var value: String = ""
    
    var ended = false
    
    let speechSynthesizer = AVSpeechSynthesizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        numKeyboard.delegate = self
        self.isNumKeyboardHidden(isHidden: true)
        
        hideKeypad()
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
        base!.DoInitialize()
        base!.DoStart()
        
        
        NumKeys.append(Button_1)
        NumKeys.append(Button_2)
        NumKeys.append(Button_3)
        NumKeys.append(Button_4)
        NumKeys.append(Button_5)
        NumKeys.append(Button_6)
        NumKeys.append(Button_7)
        NumKeys.append(Button_8)
        NumKeys.append(Button_9)
        NumKeys.append(Button_0)
        NumKeys.append(Button_done)
        NumKeys.append(Button_delete)
        
        value = ""
        InfoLabel.text = ""
        NumberLabel.text = ""
        KeypadLabel.text = ""
        
        StartButton.isHidden = true
//        EndButton.isHidden = true
        BackButton.isHidden = false
    }
    
    func enableKeypad() {
        for key in NumKeys {
            key.isHidden = false
            key.isEnabled = true
        }
    }
    
    func disableKeypad() {
        for key in NumKeys {
            key.isEnabled = false
        }
    }
    
    func hideKeypad() {
        for key in NumKeys {
            key.isEnabled = false
            key.isHidden = true
        }
    }
    
    @IBAction func KeyPadKeyPressed(_ sender: UIButton) {
//        guard Int(value + sender.currentTitle!) != nil else {return}
//
//        // Hide answer label
//        lbCorrectAnswer.isHidden = true
//
//        value = value + sender.currentTitle!
//        KeypadLabel.text = value
//        let elapsedTime = (Int)(1000*Foundation.Date().timeIntervalSince(base!.levelStartTime))
//        base!.gotKeys[(String)(elapsedTime)] = sender.currentTitle!
    }
    
    @IBAction func DoneKeyPressed(_ sender: UIButton) {
//        let elapsedTime = (Int)(1000*Foundation.Date().timeIntervalSince(base!.levelStartTime))
//        base!.gotKeys[(String)(elapsedTime)] = "done"

//        base!.DoEnterDone()
    }
    
    @IBAction func DeleteKeyPressed(_ sender: UIButton) {
//        value = String(value.characters.dropLast())
//        KeypadLabel.text = value
//        let elapsedTime = (Int)(1000*Foundation.Date().timeIntervalSince(base!.levelStartTime))
//        base!.gotKeys[(String)(elapsedTime)] = "del"
    }
    
    
    @IBAction func StartPressed(_ sender: UIButton) {
//        ended = false
//        StartButton.isHidden = true
//        quitButton.isHidden = false
//        BackButton.isHidden = true
//        NumberLabel.isHidden = false
//        base!.DoStart()
    }
    
    @IBAction func EndPressed(_ sender: UIButton) {
        speechSynthesizer.stopSpeaking(at: AVSpeechBoundary.immediate)
        base!.DoEnd()
//        NumberLabel.isHidden = true
        if let vc = storyboard!.instantiateViewController(withIdentifier: "main") as? MainViewController {
            vc.mode = .patient
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    @IBAction func actionReset(_ sender: Any) {
        base!.DoStart()
    }
    // This may be call more than when EndPressed, DoEnd may be call within the subclass, which should call this
    func EndTest() {
        ended = true
        value = ""
        NumberLabel.text = ""
        KeypadLabel.text = ""
        lbCorrectAnswer.text = ""

//        disableKeypad()
        
        isNumKeyboardHidden(isHidden: true)
        
        StartButton.isHidden = false
//        EndButton.isHidden = true
        BackButton.isHidden = false
        lbCorrectAnswer.isHidden = true
    }
    
    func showCorrectAnswer(value: Int) {
        self.lbCorrectAnswer.isHidden = false
        self.lbCorrectAnswer.text = "Correct answer: \(value)"
    }
    
    func DisplayStringShowContinue(val:String) {
        if BackButton.isHidden == true {
            // digit utterances in the sequence with a short delay in between
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
                if val.characters.count == 0 {
                    //self.ContinueButton.isHidden = false
                    self.InfoLabel.text = "Start entering the number sequence given by patient, followed by done"
                    self.value = ""
                    self.KeypadLabel.text = ""
                    self.base!.levelStartTime = Foundation.Date()
//                    self.base!.gotKeys = [:]
//                    self.enableKeypad()
                    self.isNumKeyboardHidden(isHidden: false)
                } else {
                    let c = String(val.characters.first!)
                    self.value = self.value + c
                    let rest = String(Array(repeating: ".", count: self.base!.level - self.value.characters.count + 1))
                    
                    if testName != "ForwardDigitSpan" && testName != "BackwardDigitSpan" {
                        self.NumberLabel.text = self.value + rest
                    }
                    
                    let utterence = AVSpeechUtterance(string: c)
                    self.speechSynthesizer.speak(utterence)
                    
                    self.DisplayStringShowContinue(val: String(val.characters.dropFirst(1)))
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if !ended {
            base!.DoEnd()
        }
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
        
        self.KeypadLabel.font = Font.font(name: Font.Montserrat.semiBold, size: 28.0)
        self.KeypadLabel.textColor = Color.color(hexString: "#013AA5")
        self.KeypadLabel.backgroundColor = Color.color(hexString: "#F7F7F7")
        self.KeypadLabel.layer.borderWidth = 1
        self.KeypadLabel.layer.borderColor = Color.color(hexString: "#EAEAEA").cgColor
        self.KeypadLabel.layer.cornerRadius = 8
        self.KeypadLabel.layer.masksToBounds = true
        
        self.InfoLabel.font = Font.font(name: Font.Montserrat.medium, size: 18.0)
        self.InfoLabel.addTextSpacing(-0.36)
        
        self.lbShowRandomNumber.font = Font.font(name: Font.Montserrat.semiBold, size: 18.0)
        self.lbShowRandomNumber.text = "STARTING NUMBER:"
        
        self.randomNumberLabel.font = Font.font(name: Font.Montserrat.semiBold, size: 28.0)
        self.randomNumberLabel.textColor = Color.color(hexString: "#FF5430")
        
    }
    
    func isNumKeyboardHidden(isHidden: Bool) {
        self.numKeyboard.isHidden = isHidden
        self.KeypadLabel.isHidden = isHidden
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
    
    func DoStart()      {  }
    
    func DoEnterDone()  {  }
    
    func DoEnd()        {  }
}

extension DigitBase: NumberKeyboardViewDelegate {
    func didNumberPressed(_ text: String) {
        lbCorrectAnswer.isHidden = true
        KeypadLabel.text = KeypadLabel.text! + text
    }
    
    func didEnterPressed() {
        base!.DoEnterDone()
    }
    
    func didDeletePressed() {
        if !KeypadLabel.text!.isEmpty {
            KeypadLabel.text?.removeLast()
        }
    }
}
