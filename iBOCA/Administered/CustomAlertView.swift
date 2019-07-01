//
//  CustomAlerView.swift
//  iBOCA
//
//  Created by MinhLuan on 6/28/19.
//  Copyright © 2019 sunspot. All rights reserved.
//

import UIKit

enum CustomAlertItemStyle{
    case normal
    case cancel
}

//Example
/*
CustomAlertView.showAlert(withTitle: "Conset Request", andTextContent: "Please confirm your consent to\ provide test data", andItems:
    [.cre(title: "Cancel", itag: 0, istyle: .normal),                                                                                                                       .cre(title: "Approve", itag: 1, istyle: .cancel), inView: self.view) {[weak self](alert,title, itag) in
        if itag == 0{
        self?.mSwitch.isOn = false
        }
        alert.dismiss()
}
*/
 
 
 


class CustomAlertItem : NSObject{
    
    var title : String = ""
    var tag : Int = 0
    var style = CustomAlertItemStyle.normal
    
    class func cre(title:String,itag:Int,istyle:CustomAlertItemStyle)->CustomAlertItem{
        let obj = CustomAlertItem()
        obj.title = title
        obj.tag = itag
        obj.style = istyle
        return obj
    }
    
}

class CustomAlertView: UIView {
    
    fileprivate var sizeItem = CGSize.init(width: 210, height: 72)
    
    fileprivate var viewContent = UIView()
    fileprivate var heightContent : CGFloat = 360
    fileprivate var widthContent : CGFloat = 467 // default have two item
    fileprivate var items : [CustomAlertItem] = [CustomAlertItem]()
    fileprivate var mTextContent = UILabel()
    fileprivate var blockTapButtonItem : ( (CustomAlertView,String,Int)->Void )?
    
    var title : String = ""
    var textContent : String = ""

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    private func setupUI(withParent parent:UIView){
        self.backgroundColor = UIColor.black.withAlphaComponent(0.43)
        parent.addSubview(self)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.topAnchor.constraint(equalTo: parent.topAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: parent.bottomAnchor).isActive = true
        self.leadingAnchor.constraint(equalTo: parent.leadingAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: parent.trailingAnchor).isActive = true
        //
        viewContent = UIView()
        viewContent.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(viewContent)
        viewContent.widthAnchor.constraint(equalToConstant: self.widthContent).isActive = true
        viewContent.heightAnchor.constraint(equalToConstant: self.heightContent).isActive = true
        viewContent.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        viewContent.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        viewContent.backgroundColor = UIColor.white
        viewContent.layer.cornerRadius = 5
        viewContent.layer.masksToBounds = true
        // header content
        let headerContent = UIView()
        headerContent.translatesAutoresizingMaskIntoConstraints = false
        viewContent.addSubview(headerContent)
        headerContent.leadingAnchor.constraint(equalTo: viewContent.leadingAnchor).isActive = true
        headerContent.trailingAnchor.constraint(equalTo: viewContent.trailingAnchor).isActive = true
        headerContent.topAnchor.constraint(equalTo: viewContent.topAnchor).isActive = true
        headerContent.heightAnchor.constraint(equalToConstant: 72).isActive = true
        headerContent.backgroundColor = Color.color(hexString: "649BFF")
        // title header
        let lbHeader = UILabel()
        lbHeader.translatesAutoresizingMaskIntoConstraints = false
        headerContent.addSubview(lbHeader)
        lbHeader.centerYAnchor.constraint(equalTo: headerContent.centerYAnchor).isActive = true
        lbHeader.centerXAnchor.constraint(equalTo: headerContent.centerXAnchor).isActive = true
        lbHeader.font = Font.font(name: Font.Montserrat.bold, size: 22)
        lbHeader.textColor = UIColor.white
        lbHeader.text = title.uppercased()
        //
        let btnClose = UIButton()
        btnClose.translatesAutoresizingMaskIntoConstraints = false
        headerContent.addSubview(btnClose)
        btnClose.heightAnchor.constraint(equalToConstant: 27).isActive = true
        btnClose.widthAnchor.constraint(equalToConstant: 27).isActive = true
        btnClose.trailingAnchor.constraint(equalTo: headerContent.trailingAnchor, constant: -30).isActive = true
        btnClose.centerYAnchor.constraint(equalTo: headerContent.centerYAnchor).isActive = true
        btnClose.setImage(UIImage.init(named: "close-alert"), for: .normal)
        btnClose.transform = CGAffineTransform.init(rotationAngle: CGFloat.pi / 4 )
        //
        mTextContent.translatesAutoresizingMaskIntoConstraints = false
        viewContent.addSubview(mTextContent)
        mTextContent.topAnchor.constraint(equalTo: headerContent.bottomAnchor, constant: 33).isActive = true
        mTextContent.leadingAnchor.constraint(equalTo: viewContent.leadingAnchor, constant: 68).isActive = true
        mTextContent.trailingAnchor.constraint(equalTo: viewContent.trailingAnchor, constant: -68).isActive = true
        mTextContent.text = textContent
        mTextContent.font = Font.font(name: Font.Montserrat.medium, size: 18)
        mTextContent.textColor = UIColor.black
        mTextContent.numberOfLines = 0
        mTextContent.lineBreakMode = .byWordWrapping
        mTextContent.addTextSpacing(-0.36)
        mTextContent.addLineSpacing(34 * 0.5)
        mTextContent.textAlignment = .center
        //
        setupItems()
        //add actions
        btnClose.addTarget(self, action: #selector(tapClose), for: .touchUpInside)
        
        
    }
    
    private func setupItems(){
        if items.count == 1{
            renderOneItem()
        }
        else if items.count == 2{
            renderTwoItem()
        }
        else if items.count == 3{
            renderThreeItem()
        }
    }
    
    private func renderOneItem(){
        guard let item = items.first else{
            return
        }
        
    }
    
    private func renderTwoItem(){
        let first = items[0]
        let second = items[1]
        
        let btn1 = UIButton()
        btn1.translatesAutoresizingMaskIntoConstraints = false
        viewContent.addSubview(btn1)
        btn1.widthAnchor.constraint(equalToConstant: sizeItem.width).isActive = true
        btn1.heightAnchor.constraint(equalToConstant: sizeItem.height).isActive = true
        btn1.leadingAnchor.constraint(equalTo: viewContent.leadingAnchor, constant: 18).isActive = true
        btn1.bottomAnchor.constraint(equalTo: viewContent.bottomAnchor, constant: -60).isActive = true
        btn1.setTitle(first.title.uppercased(), for: .normal)
        btn1.tag = 0
        setStyleForButton(btn: btn1, istyle: first.style)
        //
        let btn2 = UIButton()
        btn2.translatesAutoresizingMaskIntoConstraints = false
        viewContent.addSubview(btn2)
        btn2.widthAnchor.constraint(equalToConstant: sizeItem.width).isActive = true
        btn2.heightAnchor.constraint(equalToConstant: sizeItem.height).isActive = true
        btn2.trailingAnchor.constraint(equalTo: viewContent.trailingAnchor, constant: -18).isActive = true
        btn2.bottomAnchor.constraint(equalTo: viewContent.bottomAnchor, constant: -60).isActive = true
        btn2.setTitle(second.title.uppercased(), for: .normal)
        btn2.tag = 1
        setStyleForButton(btn: btn2, istyle: second.style)
        //
        btn1.addTarget(self, action: #selector(tapButtonItem(sender:)), for: .touchUpInside)
        btn2.addTarget(self, action: #selector(tapButtonItem(sender:)), for: .touchUpInside)
    }
    
    private func setStyleForButton(btn:UIButton,istyle:CustomAlertItemStyle){
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 8
        if istyle == .cancel{
            btn.setBackgroundColor(Color.color(hexString: "E9E9E9"), forState: .normal)
            btn.setTitleColor(Color.color(hexString: "505259"), for: .normal)
            btn.titleLabel?.font = Font.font(name: Font.Montserrat.bold, size: 22)
        }
        else if istyle == .normal{
            btn.setBackgroundColor(Color.color(hexString: "EEF3F9"), forState: .normal)
            btn.setTitleColor(Color.color(hexString: "013AA5"), for: .normal)
            btn.titleLabel?.font = Font.font(name: Font.Montserrat.bold, size: 22)
        }
    }
    
    private func renderThreeItem(){
        let first = items[0]
        let second = items[1]
        let three = items[2]
        
        let btn2 = UIButton()
        btn2.translatesAutoresizingMaskIntoConstraints = false
        viewContent.addSubview(btn2)
        btn2.widthAnchor.constraint(equalToConstant: sizeItem.width).isActive = true
        btn2.heightAnchor.constraint(equalToConstant: sizeItem.height).isActive = true
        btn2.centerXAnchor.constraint(equalTo: viewContent.centerXAnchor, constant: 0).isActive = true
        btn2.bottomAnchor.constraint(equalTo: viewContent.bottomAnchor, constant: -60).isActive = true
        btn2.setTitle(second.title.uppercased(), for: .normal)
        btn2.tag = second.tag
        setStyleForButton(btn: btn2, istyle: second.style)
        //
        let btn1 = UIButton()
        btn1.translatesAutoresizingMaskIntoConstraints = false
        viewContent.addSubview(btn1)
        btn1.widthAnchor.constraint(equalToConstant: sizeItem.width).isActive = true
        btn1.heightAnchor.constraint(equalToConstant: sizeItem.height).isActive = true
        btn1.trailingAnchor.constraint(equalTo: btn2.leadingAnchor, constant: -11).isActive = true
        btn1.bottomAnchor.constraint(equalTo: viewContent.bottomAnchor, constant: -60).isActive = true
        btn1.setTitle(first.title.uppercased(), for: .normal)
        btn1.tag = 1
        setStyleForButton(btn: btn1, istyle: first.style)
        //
        let btn3 = UIButton()
        btn3.translatesAutoresizingMaskIntoConstraints = false
        viewContent.addSubview(btn3)
        btn3.widthAnchor.constraint(equalToConstant: sizeItem.width).isActive = true
        btn3.heightAnchor.constraint(equalToConstant: sizeItem.height).isActive = true
        btn3.leadingAnchor.constraint(equalTo: btn2.trailingAnchor, constant: 11).isActive = true
        btn3.bottomAnchor.constraint(equalTo: viewContent.bottomAnchor, constant: -60).isActive = true
        btn3.setTitle(three.title.uppercased(), for: .normal)
        btn3.tag = 2
        setStyleForButton(btn: btn3, istyle: three.style)
        //
        btn1.addTarget(self, action: #selector(tapButtonItem(sender:)), for: .touchUpInside)
        btn2.addTarget(self, action: #selector(tapButtonItem(sender:)), for: .touchUpInside)
        btn3.addTarget(self, action: #selector(tapButtonItem(sender:)), for: .touchUpInside)
    }
    
    ///tap action: String is title of Item, Int is tag of Item
    class func showAlert(withTitle title:String,andTextContent content:String, andItems items: [CustomAlertItem],inView parent:UIView,tapAction:@escaping(CustomAlertView,String,Int)->Void){
        let alert = CustomAlertView()
        alert.widthContent = alert.getWidthFrom(countItem: items.count)
        alert.title = title
        alert.items = items
        alert.textContent = content
        alert.setupUI(withParent: parent)
        alert.blockTapButtonItem = tapAction
    }
    
    
    
    private func getWidthFrom(countItem:Int)->CGFloat{
        switch countItem {
        case 3:
            return 688
        default:
            return 467
        }
    }
    
    func dismiss(){
        UIView.animate(withDuration: 0.3, animations: {
            self.alpha = 0
        }) { (isok) in
            self.removeFromSuperview()
        }
    }
    
    
    //MARK: - Action Method
    
    @objc func tapClose(){
       dismiss()
    }
    
    @objc func tapButtonItem(sender:UIButton){
        let index = sender.tag
        let item = items[index]
        blockTapButtonItem?(self,item.title,item.tag)
    }
    

}
