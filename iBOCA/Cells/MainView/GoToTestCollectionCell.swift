//
//  GoToTestCollectionCell.swift
//  iBOCA
//
//  Created by MinhLuan on 6/27/19.
//  Copyright © 2019 sunspot. All rights reserved.
//

import UIKit

class GoToTestCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var mSTMain: UIStackView!
    @IBOutlet weak var mImg: UIImageView!
    @IBOutlet weak var mTitle: UILabel!
    
    private var shadowLayer : CAShapeLayer?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    private func setupUI(){
        self.backgroundColor = UIColor.clear
        self.clipsToBounds = false
        mTitle.lineBreakMode = .byWordWrapping
        mTitle.numberOfLines = 2
        mTitle.font = Font.font(name: Font.Montserrat.semiBold, size: 16)
        mTitle.textColor = Color.color(hexString: "0039A7")
        mTitle.textAlignment = .center
        
        addCornerLayer()
    }
    
    private func addCornerLayer(){
        self.shadowLayer = CAShapeLayer()
        self.shadowLayer?.path = UIBezierPath(roundedRect: self.bounds, cornerRadius: 8).cgPath
        self.shadowLayer?.fillColor = UIColor.white.cgColor
        self.shadowLayer?.shadowColor = Color.color(hexString: "649BFF").withAlphaComponent(0.32).cgColor
        self.shadowLayer?.shadowPath = self.shadowLayer!.path
        self.shadowLayer?.shadowOffset = CGSize(width: 0.0, height: 2.0)
        self.shadowLayer?.shadowOpacity = 1
        self.shadowLayer?.shadowRadius = 5
        self.layer.insertSublayer(shadowLayer!, at: 0)
    }
    
    func setupInfo(model:GoToTestCellModel){
        mTitle.text = model.title
        mImg.image =  UIImage.init(named: model.icon)
        if model.isComplete == false{
            self.shadowLayer?.opacity = 1
            self.shadowLayer?.fillColor = UIColor.white.cgColor
            mTitle.alpha = 1
            mImg.alpha = 1
        }
        else{
            self.shadowLayer?.opacity = 0
            self.shadowLayer?.fillColor = Color.color(hexString: "E9F0F9").cgColor
            mTitle.alpha = 0.2
            mImg.alpha = 0.2
        }
    }
    

}
