//
//  PickerViewController.swift
//  iBOCA
//
//  Created by Dat Huynh on 4/5/19.
//  Copyright © 2019 sunspot. All rights reserved.
//

import UIKit

class PickerViewController: UIViewController {

    @IBOutlet weak var pickerView: UIPickerView!
    var datasource: [String] = []
    /// DemographicsCategory RawValue
    var category: DemographicsCategory.RawValue?
    var didSelect: ((_ selectedValue: String, _ index: Int) -> ())?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func CancelPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func DonePressed(_ sender: Any) {
        guard datasource.count > 0 else {return}
        let selectedRow = pickerView.selectedRow(inComponent: 0)
        let selectedValue = datasource[selectedRow]
        dismiss(animated: true) {
            self.didSelect?(selectedValue, selectedRow)
        }
    }
}

extension PickerViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return datasource.count
    }

    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerLabel: UILabel? = (view as? UILabel)
        if pickerLabel == nil {
            pickerLabel = UILabel()
            pickerLabel?.textAlignment = .center
        }
        pickerLabel?.font = UIFont.systemFont(ofSize: 30)
        pickerLabel?.text = datasource[row]
        pickerLabel?.textColor = UIColor.black
        
        return pickerLabel!
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 50
    }

}
