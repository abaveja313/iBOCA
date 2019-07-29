//
//  ResultsViewController.swift
//  Integrated test v1
//
//  Created by saman on 8/12/15.
//  Copyright (c) 2015 sunspot. All rights reserved.
//

import UIKit

class ResultsViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var lbBack: UILabel!
    @IBOutlet weak var lbResult: UILabel!
    @IBOutlet weak var shadowContainer: UIView!
    
    private var headerView: UIView?
    
    // QuickStart Mode
    var quickStartModeOn: Bool = false
    var didBackToMainView: (() -> ())?
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if headerView == nil {
            if let hView = UINib.init(nibName: ResultsHeaderView.identifier(), bundle: nil).instantiate(withOwner: self, options: nil).first as? ResultsHeaderView {
                self.headerView = hView
                self.tableView.tableHeaderView = self.headerView
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    
    private func configureUI() {
        lbBack.textColor    = Color.color(hexString: "013AA5")
        lbBack.font         = Font.font(name: Font.Montserrat.semiBold, size: 28)
        lbResult.textColor  = Color.color(hexString: "013AA5")
        lbResult.font       = Font.font(name: Font.Montserrat.semiBold, size: 28)
        container.layer.cornerRadius = 8
        
        shadowContainer.layer.cornerRadius = 8.0
        shadowContainer.layer.shadowColor = Color.color(hexString: "#649BFF").withAlphaComponent(0.32).cgColor
        shadowContainer.layer.shadowOpacity = 1.0
        shadowContainer.layer.shadowOffset = CGSize(width: 0, height: 2)
        shadowContainer.layer.shadowRadius = 10 / 2.0
        shadowContainer.layer.shadowPath = nil
        shadowContainer.layer.masksToBounds = false
        
        tableView.estimatedSectionHeaderHeight = 40
        tableView.estimatedRowHeight = 40
        tableView.register(UINib.init(nibName: ResultsHeaderSectionView.identifier(), bundle: nil), forHeaderFooterViewReuseIdentifier: ResultsHeaderSectionView.identifier())
        tableView.register(UINib.init(nibName: ResultsCell.cellIdentifier, bundle: nil), forCellReuseIdentifier: ResultsCell.cellIdentifier)
        tableView.register(UINib.init(nibName: VACell.cellId, bundle: nil), forCellReuseIdentifier: VACell.cellId)
        tableView.register(ResultTrailsCell.nib(), forCellReuseIdentifier: ResultTrailsCell.identifier())
        tableView.register(SMResultCell.nib(), forCellReuseIdentifier: SMResultCell.identifier())
        tableView.register(UINib.init(nibName: ResultSerialSevenCell.cellId, bundle: nil), forCellReuseIdentifier: ResultSerialSevenCell.cellId)
        tableView.register(UINib.init(nibName: ResultDigitSpanCell.cellId, bundle: nil), forCellReuseIdentifier: ResultDigitSpanCell.cellId)
        tableView.register(UINib.init(nibName: ResultDetailCell.identifier(), bundle: nil), forCellReuseIdentifier: ResultDetailCell.identifier())
    }
    
    
    @IBAction func actionBack(_ sender: Any) {
        if quickStartModeOn {
            didBackToMainView?()
        }
        else {
            dismiss(animated: true, completion: nil)
        }
    }
    
}

extension ResultsViewController: ResultsHeaderSectionViewDelegate {
    
    func numberOfSectionsInTableView(_ tableView: UITableView) -> Int {
        return resultsArray.numResults()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        let result = resultsArray.get(section)
        
        switch result.name {
        case TestName.THREE_DIMENSION_FIGURE_COPY:
            return result.collapsed ? 0 : result.screenshot.count
        case TestName.TRAILS:
            return result.collapsed ? 0 : result.screenshot.count
        case TestName.SIMPLE_MEMORY:
            return result.collapsed ? 0 : result.arrSMResult.count
        case TestName.SERIAL_SEVENS:
            return result.collapsed ? 0 : result.rounds! + 1
        case TestName.FORWARD_DIGIT_SPAN, TestName.BACKWARD_DIGIT_SPAN:
            return result.collapsed ? 0 : result.rounds!
        default:
            return result.collapsed ? 0 : result.longDescription.count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAtIndexPath indexPath: IndexPath) -> CGFloat {
        let result = resultsArray.get(indexPath.section)
        
        switch result.name {
        case TestName.THREE_DIMENSION_FIGURE_COPY:
            return 190
        case TestName.VISUAL_ASSOCIATION, TestName.SERIAL_SEVENS, TestName.FORWARD_DIGIT_SPAN, TestName.BACKWARD_DIGIT_SPAN, TestName.SIMPLE_MEMORY, TestName.FORWARD_SPATIAL_SPAN, TestName.BACKWARD_SPATIAL_SPAN:
            return 40
        default:
            return UITableViewAutomaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableHeaderFooterView(withIdentifier: "ResultsHeaderSectionView") as? ResultsHeaderSectionView
        cell?.delegate = self
        cell?.bindData(result: resultsArray.get(section), section: section)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell{
        let result = resultsArray.get(indexPath.section)
        
        switch result.name {
        case TestName.THREE_DIMENSION_FIGURE_COPY:
            let cell = tableView.dequeueReusableCell(withIdentifier: ResultsCell.cellIdentifier, for: indexPath) as! ResultsCell
            cell.bindData(result: result, row: indexPath.row)
            tableView.separatorStyle = .none
            
            return cell
        case TestName.VISUAL_ASSOCIATION:
            let cell = tableView.dequeueReusableCell(withIdentifier: VACell.cellId, for: indexPath) as! VACell
            cell.bindData(result: result, row: indexPath.row)
            
            return cell
        case TestName.TRAILS:
            let cell = tableView.dequeueReusableCell(withIdentifier: ResultTrailsCell.identifier(), for: indexPath) as! ResultTrailsCell
            cell.configResult(result: result)
            
            return cell
        case TestName.SIMPLE_MEMORY:
            let cell = tableView.dequeueReusableCell(withIdentifier: SMResultCell.identifier(), for: indexPath) as! SMResultCell
            cell.isHeader = false
            
            if result.arrSMResult.count > 0 {
                cell.model = result.arrSMResult[indexPath.row]
                if indexPath.row < result.arrSMResult.count - 1 {
                    cell.arrayConstraintLineBottom.forEach{ $0.constant = 0 }
                }
                else {
                    cell.arrayConstraintLineBottom.forEach{ $0.constant = 1 }
                }
            }
            
            return cell
        case TestName.SERIAL_SEVENS:
            if indexPath.row == 0 {
                let cell = self.tableView.dequeueReusableCell(withIdentifier: ResultDetailCell.identifier()) as! ResultDetailCell
                cell.bindData(result: result, row: indexPath.row)
                
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: ResultSerialSevenCell.cellId, for: indexPath) as! ResultSerialSevenCell
                cell.bindData(result: result, row: indexPath.row)
                
                return cell
            }
        case TestName.FORWARD_DIGIT_SPAN, TestName.BACKWARD_DIGIT_SPAN:
            let cell = tableView.dequeueReusableCell(withIdentifier: ResultDigitSpanCell.cellId, for: indexPath) as! ResultDigitSpanCell
            cell.bindData(result: result, row: indexPath.row)
            
            return cell
        case TestName.FORWARD_SPATIAL_SPAN:
            let cell = self.tableView.dequeueReusableCell(withIdentifier: ResultDetailCell.identifier()) as! ResultDetailCell
            cell.backgroundColor = Color.color(hexString: "#F9F9F9")
            cell.bindData(result: result, row: indexPath.row)
            
            return cell
        case TestName.BACKWARD_SPATIAL_SPAN:
            let cell = self.tableView.dequeueReusableCell(withIdentifier: ResultDetailCell.identifier()) as! ResultDetailCell
            cell.backgroundColor = Color.color(hexString: "#F9F9F9")
            cell.bindData(result: result, row: indexPath.row)
            
            return cell
        default:
            let cell = self.tableView.dequeueReusableCell(withIdentifier: ResultDetailCell.identifier()) as! ResultDetailCell
            cell.bindData(result: result, row: indexPath.row)
            
            return cell
        }
    }
    
    
    func resultsHeaderSectionView(didExpand expand: Bool, at section: Int, sender: ResultsHeaderSectionView) {
        resultsArray.get(section).collapsed = !expand
        
        tableView.reloadSections([section], with: .fade)
    }
    
}

