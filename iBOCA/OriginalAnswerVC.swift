//
//  OriginalAnswerVC.swift
//  iBOCA
//
//  Created by Hoàng Hiệp Lê on 2/4/20.
//  Copyright © 2020 sunspot. All rights reserved.
//

import UIKit

class OriginalAnswerVC: UIViewController {
    
    @IBOutlet weak var originalNameTableView: UITableView!
    var nameList: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.originalNameTableView.register(OriginalAnswerCell.nib(), forCellReuseIdentifier: OriginalAnswerCell.identifier())
        self.originalNameTableView.delegate = self
        self.originalNameTableView.dataSource = self
    }
    
    init(frame: CGSize) {
        super.init(nibName: nil, bundle: nil)
        self.view.frame.size.width = frame.width
        self.view.frame.size.height = frame.height
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

extension OriginalAnswerVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.nameList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OriginalAnswerCell.identifier(), for: indexPath) as! OriginalAnswerCell
        cell.configure(name: "Object name: \(indexPath.row + 1): \(self.nameList[indexPath.row])")
        return cell
    }
}


