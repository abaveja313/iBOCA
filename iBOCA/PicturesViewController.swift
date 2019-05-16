//
//  NamingPicturesViewController.swift
//  Integrated test v1
//
//  Created by Seth Amarasinghe on 7/14/15.
//  Copyright (c) 2015 sunspot. All rights reserved.
//
import UIKit

class PicturesViewController: ViewController {
    
    let namingImages:[String] = ["ring", "chimney", "clover", "ladle", "piano", "eyebrow", "shovel", "lighthouse", "goggles", "horseshoe", "corkscrew", "anvil", "yarn", "llama", "skeleton"]

    
    var imageName = "House"
    var count = 0
    var corr = 0
    var back = 0
    
    @IBOutlet weak var placeLabel: UILabel!
    
    var order = [Bool]()
    var startTime2 = NSDate()
    var startTime = Foundation.Date()
    
    @IBOutlet weak var undoButton: UIButton! //"Undo" button
    
    @IBOutlet weak var resetButton: UIButton!
    
    @IBOutlet weak var homeButton: UIButton! //"Back" button
    
    @IBOutlet weak var resultsLabel: UILabel!
    
    @IBOutlet weak var lbObjectName: UILabel!
    @IBOutlet weak var tfObjectName: UITextField!
    @IBOutlet weak var btnNext: UIButton!
    
    var imageView = UIImageView()
    
    var totalCount = Int()
    
    var wrongList = [String]()
    
    var resultImage : [String] = []
    var resultStatus : [String] = []
    var resultTime : [Date] = []
    var resultObjectName : [String] = []
    var isStartNew: Bool = false
    var isUndo: Bool = false
    // MARK: - IBAction
    @IBAction func btnNextTapped(_ sender: UIButton) {
        self.view.endEditing(true)
        if isStartNew == true {
            self.startNew()
        }
        else {
            self.resumeTest()
        }
    }
    
    @IBAction func reset(_ sender: Any) {
        self.view.endEditing(true)
        resetButton.isEnabled = false
        undoButton.isEnabled = false
        self.navigationItem.setHidesBackButton(false, animated:true)
        
        done()
        
        order = [Bool]()
        wrongList = [String]()
        count = 0
        corr = 0
        back = 0
        imageName = getImageName()
        resultStatus.removeAll()
        resultTime.removeAll()
        resultImage.removeAll()
        
        let image4 = UIImage(named: imageName)
        fixDimensions(image: image4!)
        imageView.image = image4
        
//        correctButton.isEnabled = true
//        incorrectButton.isEnabled = true
        print(self.resultObjectName)
        placeLabel.text = "\(count+1)/\(namingImages.count)"
        
    }
    
    @IBAction func undoTapped(_ sender: Any) {
        
//        homeButton.isEnabled = false
//        correctButton.isEnabled = true
//        incorrectButton.isEnabled = true
//        resetButton.isEnabled = true
//        undoButton.isEnabled = true
//
//        count -= 1
//        back += 1
//        self.tfObjectName.text = self.resultObjectName[count]
//        if count == 0 {
//            resetButton.isEnabled = false
//            undoButton.isEnabled = false
//            self.navigationItem.setHidesBackButton(false, animated:true)
//        }
//        if order.count > 0 {
//            if order[order.count-1] == true {
//                corr -= 1
//            }
//            else {
//                wrongList.remove(at: wrongList.count-1)
//            }
//
//            order.remove(at: order.count-1)
//        }
//
//        imageName = getImageName()
//
//        let image3 = UIImage(named: imageName)
//        fixDimensions(image: image3!)
//        imageView.image = image3
//
//        placeLabel.text = "\(count+1)/\(namingImages.count)"
        
        
        homeButton.isEnabled = false
        resetButton.isEnabled = true
        undoButton.isEnabled = true
        isUndo = true
        count -= 1
        back = count
        self.tfObjectName.text = self.resultObjectName[count]
        if count == 0 {
            resetButton.isEnabled = false
            undoButton.isEnabled = false
            self.navigationItem.setHidesBackButton(false, animated:true)
        }
        imageName = getImageName()
        let image3 = UIImage(named: imageName)
        fixDimensions(image: image3!)
        imageView.image = image3
        placeLabel.text = "\(count+1)/\(namingImages.count)"
        print("UNDO")
        print("count: \(count)")
        print("back: \(back)")
    }
    
    @IBAction func btnBackTapped(_ sender: Any) {
        self.view.endEditing(true)
        Status[TestNampingPictures] = TestStatus.NotStarted
    }
    
    
    func done() {
        
//        print("getting here")
//        undoButton.isEnabled = false
//        correctButton.isEnabled = false
//        incorrectButton.isEnabled = false
//        resetButton.isEnabled = false
//        homeButton.isEnabled = true
//
//        self.lbObjectName.isHidden = true
//        self.tfObjectName.isHidden = true
//        self.isStartNew = true
//        self.btnNext.setTitle("Start New", for: .normal)
//        self.btnNext.setTitle("Start New", for: .selected)
//
//        imageView.removeFromSuperview()
//        placeLabel.text = ""
//
//        let result = Results()
//        result.name = self.title
//        result.startTime = startTime2 as Date
//        result.endTime = NSDate() as Date
//        result.longDescription.add("\(corr) correct out of \(count)")
//        if wrongList.count > 0  {
//            result.longDescription.add("The incorrect pictures were the \(wrongList)")
//        }
//        result.numErrors = wrongList.count
//
//        var js : [String:Any] = [:]
//        for (index, element) in resultStatus.enumerated() {
//            let val = ["image":resultImage[index], "status":element, "time (msec)":Int(1000*resultTime[index].timeIntervalSince(startTime))] as [String : Any]
//            js[String(index)] = val
//        }
//        result.json["Results"] = js
//        result.json["Answered"] = count
//        result.json["Correct"] = corr
//        result.json["Gone Back"] = back
//
//        result.shortDescription = "\(corr) correct with \(count) answered"
//
//        resultsArray.add(result)
//        Status[TestNampingPictures] = TestStatus.Done
//
//        var str:String = "\(corr) correct out of \(count)"
//        if wrongList.count > 0 {
//            str += "\nThe incorrect pictures were the \(wrongList)"
//        }
//        self.resultsLabel.text = str
        
        undoButton.isEnabled = false
        resetButton.isEnabled = false
        homeButton.isEnabled = true

        self.lbObjectName.isHidden = true
        self.tfObjectName.isHidden = true
        self.isStartNew = true
        self.btnNext.setTitle("Start New", for: .normal)
        self.btnNext.setTitle("Start New", for: .selected)

        imageView.removeFromSuperview()
        placeLabel.text = ""
        self.wrongList.removeAll()
        corr = 0
        let _resultObjectName = self.resultObjectName.map{ $0.lowercased() }
        
        _resultObjectName.forEach { (obj) in
            if self.namingImages.contains(obj) {
                corr += 1
            }
        }
        
        self.namingImages.forEach { (nameImg) in
            if !_resultObjectName.contains(nameImg) {
                wrongList.append(nameImg)
            }
        }
        
        count = self.resultObjectName.count
        
        Status[TestNampingPictures] = TestStatus.Done
        
        // Save Results
        let result = Results()
        result.name = self.title
        result.startTime = startTime2 as Date
        result.endTime = NSDate() as Date
        result.longDescription.add("\(corr) correct out of \(count)")
        if wrongList.count > 0  {
            result.longDescription.add("The incorrect picture\(wrongList.count > 1 ? "s" : "") were the \(wrongList)")
        }
        result.numErrors = (count - corr)
        result.json["Answered"] = count
        result.json["Correct"] = corr
        result.shortDescription = "\(corr) correct with \(count) answered"
        resultsArray.add(result)
        
        // Show resultsLabel
        var str:String = "\(corr) correct out of \(count)"
        if wrongList.count > 0 {
            str += "\nThe incorrect picture\(wrongList.count > 1 ? "s" : "") were the \(wrongList)"
        }
        self.resultsLabel.text = str
    }
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.startNew()
    }
    
    func getImageName()->String{
        
        print(count)
            
        return namingImages[count]
        
    }
    
    func fixDimensions(image:UIImage){
        
        var x = CGFloat()
        var y = CGFloat()
        if 0.56*image.size.width < image.size.height {
            y = 575.0
            x = (575.0*(image.size.width)/(image.size.height))
        }
        else {
            x = 575.0
            y = (575.0*(image.size.height)/(image.size.width))
        }
        
        imageView.frame = CGRect(x: (512.0-(x/2)), y: (471.0-(y/2)), width: x, height: y)
        
    }
    
    private func startNew() {
        print(selectedTest, terminator: "")
        self.title = "Naming Pictures"
        startTime2 = NSDate()
        totalCount = namingImages.count
        
        self.resultsLabel.text = ""
        
        count = 0
        corr = 0
        back = 0
        imageName = getImageName()
        
        let image = UIImage(named: imageName)
        
        imageView = UIImageView()
        
        fixDimensions(image: image!)
        
        imageView.image = image
        self.view.addSubview(imageView)
        
        undoButton.isEnabled = false
        resetButton.isEnabled = false
        homeButton.isEnabled = true
        
        self.isStartNew = false
        self.resultObjectName.removeAll()
        self.lbObjectName.isHidden = false
        self.tfObjectName.isHidden = false
        self.btnNext.setTitle("Next", for: .normal)
        self.btnNext.setTitle("Next", for: .selected)
    }
    
    private func resumeTest() {
        guard let strObjName = self.tfObjectName.text, !strObjName.isEmpty else {
            let warningAlert = UIAlertController(title: "Warning", message: "Please enter Object Name fields.", preferredStyle: .alert)
            warningAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) -> Void in
                warningAlert.dismiss(animated: true, completion: nil)
            }))
            self.present(warningAlert, animated: true, completion: nil)
            return
        }
        
        homeButton.isEnabled = true
        resetButton.isEnabled = true
        undoButton.isEnabled = true
        
        if isUndo == true, self.resultObjectName.count != count {
            self.resultObjectName[count] = strObjName
        }
        else {
            self.resultObjectName.append(strObjName)
        }
        count += 1
        if isUndo == true, self.resultObjectName.count != count {
           self.tfObjectName.text = self.resultObjectName[count]
        }
        else {
            self.tfObjectName.text = ""
        }
        
        let currTime = Foundation.Date()
        resultTime.append(currTime)
        
        if(count==totalCount){
            done()
        }
        else {
            imageName = getImageName()
            let image1 = UIImage(named: imageName)
            fixDimensions(image: image1!)
            imageView.image = image1
            if count != namingImages.count {
                placeLabel.text = "\(count+1)/\(namingImages.count)"
            }
        }
        print(self.resultObjectName)
    }
    
}

