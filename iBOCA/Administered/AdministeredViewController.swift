//
//  AdministeredViewController.swift
//  iBOCA
//
//  Created by MinhLuan on 6/28/19.
//  Copyright © 2019 sunspot. All rights reserved.
//

import UIKit

class AdministeredViewController: UIViewController {

    
    @IBOutlet weak var mTitleBack: UILabel!
    
    @IBOutlet weak var mTextInputEmail: UILabel!
    
    @IBOutlet weak var mTfMail: UITextField!
    
    @IBOutlet weak var mSwitch: UISwitch!
    
    @IBOutlet weak var mTextEnableConsent: UILabel!
    
    @IBOutlet weak var mBtnSelectTest: UIButton!
    
    @IBOutlet weak var mBtnQuickStart: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
    }
    
    func setupUI(){
        //
        mTitleBack.text = mTitleBack.text?.uppercased()
        mTitleBack.font = Font.font(name: Font.Montserrat.semiBold, size: 28)
        mTitleBack.textColor = Color.color(hexString: "013AA5")
        //
        mTextInputEmail.font = Font.font(name: Font.Montserrat.medium, size: 16)
        mTextInputEmail.textColor = Color.color(hexString: "8A9199")
        //
        mTfMail.font = Font.font(name: Font.Montserrat.medium, size: 18)
        mTfMail.backgroundColor = Color.color(hexString: "F7F7F7")
        mTfMail.textColor = UIColor.black
        mTfMail.layer.borderColor = Color.color(hexString: "649BFF").cgColor
        mTfMail.layer.borderWidth = 1
        mTfMail.layer.cornerRadius = 5
        mTfMail.layer.masksToBounds = true
        //
        mTextEnableConsent.font = Font.font(name: Font.Montserrat.medium, size: 18)
        mTextEnableConsent.textColor = UIColor.black
        //
        mSwitch.onTintColor = Color.color(hexString: "69C394")
        //
        mBtnSelectTest.layer.cornerRadius = 8
        mBtnSelectTest.layer.masksToBounds = true
        mBtnSelectTest.setBackgroundColor(Color.color(hexString: "EEF3F9"), forState: .normal)
        mBtnSelectTest.titleLabel?.font = Font.font(name: Font.Montserrat.bold, size: 22)
        mBtnSelectTest.setTitleColor(Color.color(hexString: "013AA5"), for: .normal)
        //
        mBtnQuickStart.layer.cornerRadius = 8
        mBtnQuickStart.layer.masksToBounds = true
        mBtnQuickStart.setBackgroundColor(Color.color(hexString: "EEF3F9"), forState: .normal)
        mBtnQuickStart.titleLabel?.font = Font.font(name: Font.Montserrat.bold, size: 22)
        mBtnQuickStart.setTitleColor(Color.color(hexString: "013AA5"), for: .normal)
    }
    
    @IBAction func switchChange(_ sender: Any) {
        debugPrint("isON: \(mSwitch.isOn)")
        if mSwitch.isOn == true{
            showAlertTurnOnConsent()
        }
    }
    
    @IBAction func tapSelectTest(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "main") as? MainViewController{
            vc.mode = .admin
            self.present(vc, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func tapQuickStart(_ sender: Any) {
    }
    
    
    private func showAlertTurnOnConsent(){
        CustomAlertView.showAlert(withTitle: "Conset Request", andTextContent: "Please confirm your consent to\nprovide test data", andItems:
        [.cre(title: "Cancel", itag: 0, istyle: .normal),                                                                                                                      .cre(title: "Approve", itag: 1, istyle: .cancel)], inView: self.view) {[weak self](alert, title, itag) in
            if itag == 0 || itag == -1{
                //-1 is this when user tap close button
                self?.mSwitch.isOn = false
            }
            alert.dismiss()
        }
    }
    
    


}
