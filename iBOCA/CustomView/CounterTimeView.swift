//
//  CounterTimeView.swift
//  iBOCA
//
//  Created by MinhLuan on 7/5/19.
//  Copyright © 2019 sunspot. All rights reserved.
//

import UIKit

class CounterTimeView: UIView {

    // size of this view
    private var mSize = CGSize.init(width: 90, height: 34)
    //
    private var mLbCounterTime = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    private func setupUI(){
        //
        self.translatesAutoresizingMaskIntoConstraints = false
        self.widthAnchor.constraint(equalToConstant: mSize.width).isActive = true
        self.heightAnchor.constraint(equalToConstant: mSize.height).isActive = true
        //
        self.addSubview(mLbCounterTime)
        mLbCounterTime.translatesAutoresizingMaskIntoConstraints = false
        mLbCounterTime.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        mLbCounterTime.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        mLbCounterTime.font = Font.font(name: Font.Montserrat.semiBold, size: 28)
        mLbCounterTime.textAlignment = .center
        mLbCounterTime.textColor = UIColor.black
        mLbCounterTime.addTextSpacing(1.34)
        mLbCounterTime.text = "--:--"
    }
    
    /// Convert total seconds to: hour, minute, seconds
    private func secondsToHoursMinutesSeconds (seconds : Int) -> (hour:Int,minute:Int,seconds:Int) {
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
    /// Set text for Label with attribute label
    private func setTextForAttributeLabel(title: String) {
        if let att = mLbCounterTime.attributedText{
            let values = att.attributes(at: 0, longestEffectiveRange: nil, in: .init(location: 0, length: att.string.count))
            let attResult = NSAttributedString.init(string: title, attributes: values)
            mLbCounterTime.attributedText = attResult
            debugPrint("UPDATE TEXT OK")
        }
        else{
            debugPrint("CANNOT")
        }
    }
    
    
    /// show seconds with format hh:mm
    ///
    /// - Parameter seconds: total seconds
    func setSeconds(seconds:Int){
        let timeComp = secondsToHoursMinutesSeconds(seconds: seconds)
        var textTime = "--:--"
        if timeComp.hour == 0{
            textTime = String.init(format: "%02d:%02d", timeComp.minute,timeComp.seconds)
        }
        else{
            textTime = String.init(format: "%02d:%02d:%02d",timeComp.hour,timeComp.minute,timeComp.seconds)
        }
        setTextForAttributeLabel(title: textTime)
    }
}
