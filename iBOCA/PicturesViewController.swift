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
    
    
    var order = [Bool]()
    var startTime2 = NSDate()
    var startTime = Foundation.Date()
    
    @IBOutlet weak var placeLabel: UILabel!
    
    @IBOutlet weak var resetButton: GradientButton!
    
    @IBOutlet weak var resultsLabel: UILabel!
    
    @IBOutlet weak var lbObjectName: UILabel!
    @IBOutlet weak var tfObjectName: UITextField!
    
    @IBOutlet weak var innerShadowView: UIView!
    @IBOutlet weak var namingImageView: UIImageView!
    @IBOutlet weak var arrowLeftButton: UIButton!
    @IBOutlet weak var arrowRightButton: UIButton!
    @IBOutlet weak var backTitleLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var quitButton: GradientButton!
    
    var imageView = UIImageView()
    
    var totalCount = Int()
    
    var wrongList = [String]()
    
    var resultImage : [String] = []
    var resultStatus : [String] = []
    var resultTime : [Date] = []
    var resultObjectName : [String] = []
    var isStartNew: Bool = false
    var isUndo: Bool = false
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.startNew()
    }
    
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
//        resetButton.isEnabled = false
//        self.resultsLabel.isHidden = true
//        arrowLeftButton.isHidden = false
//        arrowRightButton.isHidden = false
//        arrowLeftButton.isEnabled = false
//        namingImageView.isHidden = false
//        self.navigationItem.setHidesBackButton(false, animated:true)
        self.startNew()
//        done()
    }
    
    @IBAction func actionQuit(_ sender: Any) {
        self.view.endEditing(true)
        Status[TestNampingPictures] = TestStatus.NotStarted
        if let vc = storyboard!.instantiateViewController(withIdentifier: "main") as? MainViewController {
            vc.mode = .patient
            self.present(vc, animated: true, completion: nil)
        }
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
        
        
//        backButton.isEnabled = false
//        resetButton.isEnabled = true
        arrowLeftButton.isEnabled = true
        isUndo = true
        count -= 1
        back = count
        self.tfObjectName.text = self.resultObjectName[count]
        if count == 0 {
//            resetButton.isEnabled = false
            arrowLeftButton.isEnabled = false
            self.navigationItem.setHidesBackButton(false, animated:true)
        }
        imageName = getImageName()
        let image3 = UIImage(named: imageName)
//        fixDimensions(image: image3!)
//        imageView.image = image3
        
        namingImageView.image = image3
        
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
        
        arrowLeftButton.isHidden = true
        arrowRightButton.isHidden = true
//        resetButton.isEnabled = false
        backButton.isEnabled = true
        
        self.namingImageView.isHidden = true
        self.lbObjectName.isHidden = true
        self.tfObjectName.isHidden = true
        self.isStartNew = true
//        self.arrowRightButton.setTitle("Start New", for: .normal)
//        self.arrowRightButton.setTitle("Start New", for: .selected)

//        imageView.removeFromSuperview()
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
            result.longDescription.add("The incorrect picture\(wrongList.count > 1 ? "s were" : " was") the \(wrongList)")
        }
        result.numErrors = (count - corr)
        result.json["Answered"] = count
        result.json["Correct"] = corr
        result.shortDescription = "\(corr) correct with \(count) answered"
        resultsArray.add(result)
        
        // Show resultsLabel
        var str:String = "\(corr) correct out of \(count)"
        if wrongList.count > 0 {
            str += "\nThe incorrect picture\(wrongList.count > 1 ? "s were" : " was")  the \(wrongList)"
        }
        self.resultsLabel.text = str
        
        // Reset Data
        self.tfObjectName.text = ""
        self.resultObjectName.removeAll()
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
//        fixDimensions(image: image4!)
//        imageView.image = image4
        
        namingImageView.image = image4
        
        placeLabel.text = "\(count+1)/\(namingImages.count)"
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
        let bottomContraintButtonNext = self.bottomConstraintButtonNext()
        imageView.frame = CGRect(x: (512.0-(x/2)), y: bottomContraintButtonNext, width: x, height: y)
        
    }
    
    // Get bottom constraint of button results
    private func bottomConstraintButtonNext() -> CGFloat {
        var bottomConstraint = self.arrowRightButton.frame.origin.y + self.arrowRightButton.frame.size.height + 20
        if #available(iOS 11.0, *) { }
        else {
            bottomConstraint = self.arrowRightButton.frame.origin.y + self.arrowRightButton.frame.size.height + 40
        }
        return bottomConstraint
    }
    
    private func startNew() {
        placeLabel.isHidden = true
        placeLabel.text = "\(count+1)/\(namingImages.count)"
        print(selectedTest, terminator: "")
        self.title = "Naming Pictures"
        startTime2 = NSDate()
        totalCount = namingImages.count
        
        self.resultsLabel.text = ""
        self.tfObjectName.text = ""
        
        count = 0
        corr = 0
        back = 0
        imageName = getImageName()
        
        let image = UIImage(named: imageName)
        
//        imageView = UIImageView()
//
//        fixDimensions(image: image!)
//
//        imageView.image = image
        
        namingImageView.image = image
        
//        self.view.addSubview(imageView)
        
        arrowLeftButton.isHidden = false
        arrowRightButton.isHidden = false
        arrowLeftButton.isEnabled = false
//        resetButton.isEnabled = false
        backButton.isEnabled = true
        self.namingImageView.isHidden = false
        
        self.isStartNew = false
        self.resultObjectName.removeAll()
        self.lbObjectName.isHidden = false
        self.tfObjectName.isHidden = false
//        self.arrowRightButton.setTitle("Next", for: .normal)
//        self.arrowRightButton.setTitle("Next", for: .selected)
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
        
        backButton.isEnabled = true
//        resetButton.isEnabled = true
        arrowLeftButton.isEnabled = true
        
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
//            fixDimensions(image: image1!)
//            imageView.image = image1
            
            namingImageView.image = image1
            
            if count != namingImages.count {
                placeLabel.text = "\(count+1)/\(namingImages.count)"
            }
        }
        print(self.resultObjectName)
    }
    
}

extension PicturesViewController {
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
        
        self.lbObjectName.font = Font.font(name: Font.Montserrat.medium, size: 18.0)
        self.lbObjectName.textColor = Color.color(hexString: "#8A9199")
        self.lbObjectName.addTextSpacing(-0.36)
        self.lbObjectName.text = "Object Name"
        
        self.tfObjectName.font = Font.font(name: Font.Montserrat.medium, size: 18.0)
        self.tfObjectName.backgroundColor = Color.color(hexString: "#F7F7F7")
        self.tfObjectName.layer.borderWidth = 1
        self.tfObjectName.layer.borderColor = Color.color(hexString: "#EAEAEA").cgColor
        self.tfObjectName.layer.cornerRadius = 8
        self.tfObjectName.layer.masksToBounds = true
        
        self.arrowLeftButton.backgroundColor = Color.color(hexString: "#EEF3F9")
        self.arrowLeftButton.layer.cornerRadius = self.arrowLeftButton.frame.size.height / 2.0
        self.arrowRightButton.backgroundColor = Color.color(hexString: "#EEF3F9")
        self.arrowRightButton.layer.cornerRadius = self.arrowRightButton.frame.size.height / 2.0
        
        self.resetButton.setTitle(title: "RESET", withFont: Font.font(name: Font.Montserrat.bold, size: 18))
        self.resetButton.setupShadow(withColor: UIColor.clear, sketchBlur: 0, opacity: 0)
        self.resetButton.setupGradient(arrColor: [Color.color(hexString: "#FFDC6E"),Color.color(hexString: "#FFC556")], direction: .topToBottom)
        self.resetButton.render()
        self.resetButton.addTextSpacing(-0.36)
        
        self.quitButton.setTitle(title: "QUIT", withFont: Font.font(name: Font.Montserrat.bold, size: 18))
        self.quitButton.setupShadow(withColor: UIColor.clear, sketchBlur: 0, opacity: 0)
        self.quitButton.setupGradient(arrColor: [Color.color(hexString: "FFAFA6"),Color.color(hexString: "FE786A")], direction: .topToBottom)
        self.quitButton.render()
        self.quitButton.addTextSpacing(-0.36)
    }
}

