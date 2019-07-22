//
//  DropdownView.swift
//  iBOCA
//
//  Created by Macintosh HD on 7/18/19.
//  Copyright © 2019 sunspot. All rights reserved.
//

import UIKit

protocol DropdownViewDelegate: class {
    func returnItemSelected(item: String)
}

class DropdownView: UITableView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    var dataArray: [String] = [String]()
    var itemSelected: String?
    var isDropDownShowing = false
    
    weak var dropdownDelegate: DropdownViewDelegate?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        self.setupUI()
    }
    
    fileprivate func setupUI() {
        self.separatorStyle = .none
        self.backgroundColor = UIColor.white
        self.layer.borderWidth = 1.0
        self.layer.borderColor = Color.color(hexString: "#649BFF").cgColor
        self.register(VADropDownCell.nib(), forCellReuseIdentifier: VADropDownCell.identifier())
        self.delegate = self
        self.dataSource = self
        self.isHidden = true
    }
}

// MARK: - Action
extension DropdownView {
    func showDropDown() {
        if isDropDownShowing {
            self.hideDropDown()
        }
        else {
            self.isHidden = false
            if let iSelected = self.itemSelected, self.dataArray.count != 0, let row = self.dataArray.index(of: iSelected) {
                self.reloadData()
                let idxPath = IndexPath.init(row: row, section: 0)
                self.selectRow(at: idxPath, animated: false, scrollPosition: .middle)
            }
            self.isDropDownShowing = true
        }
    }
    
    func hideDropDown() {
        self.isHidden = true
        self.isDropDownShowing = false
    }
}

// MARK: - UITableView Delegate, DataSource
extension DropdownView: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 118.0/3.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dropDownCell = tableView.dequeueReusableCell(withIdentifier: VADropDownCell.cellId, for: indexPath) as! VADropDownCell
        dropDownCell.selectionStyle = .none
        
        if self.dataArray.count != 0 {
            let minute = self.dataArray[indexPath.row]
            dropDownCell.timeLabel.text = minute
        }
        
        let cellSelectedColor = UIView()
        cellSelectedColor.backgroundColor = Color.color(hexString: "#EAEAEA")
        dropDownCell.selectedBackgroundView = cellSelectedColor
        
        return dropDownCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.dataArray.count != 0 {
            let itemSelected = self.dataArray[indexPath.row]
            self.itemSelected = itemSelected
            self.dropdownDelegate?.returnItemSelected(item: itemSelected)
            self.hideDropDown()
        }
    }
}
