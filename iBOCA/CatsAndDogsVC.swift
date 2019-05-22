//
//  CatsAndDogsVC.swift
//  iBOCA
//
//  Created by Macintosh HD on 5/20/19.
//  Copyright © 2019 sunspot. All rights reserved.
//

import UIKit

enum CatsAndDogsType: String {
    case TapAllDogs = "TapAllDogs"
    case TapDogsNotCats = "TapDogsNotCats"
    case TapCatsNotDogs = "TapCatsNotDogs"
}

class CatsAndDogsVC: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var btnStart: UIButton!
    @IBOutlet weak var btnEnd: UIButton!
    @IBOutlet weak var btnReset: UIButton!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var lbResult: UILabel!
    
    var startTime2 = Foundation.Date()
    
    let dogsAlone = "2,3"//,4
    let dogsNoCats = "(2,2),(3,2),(4,2)"//,(2,4),(3,4),(4,4)
    let catsNoDogs = "(2,2),(2,3),(2,4)"//,(4,2),(4,3),(4,4)
    
    var buttonList = [UIButton]()
    var imageList = [UIImageView]()
    var boxList = [UIImageView]()
    
    var places:[(Int,Int)] = [(150, 250), (450, 300), (350, 500), (600, 450), (800, 200), (700, 650), (850, 550), (250, 350), (150, 600), (300, 650)]
    //SHORTER LIST FOR TESTING: var places:[(Int,Int)] = [(100, 200), (450, 250), (350, 450), (600, 400)]
    var order = [Int]() //randomized order of buttons
    
    var cats = Int() //# cats
    var dogs = Int() //# dogs
    var dogList = [Int]()
    var catList = [Int]()
    var break1 = Int()
    var break2 = Int()
    
    // Rotate (180 degrees) or mirror (on x or y) the point
    var xt:Bool = true
    var yt:Bool = true
    
    var level = 0 //current level
    var repetition = 0
    var ended = false
    var pressed = [Int]()
    var correctDogs = [Int]()
    var missedDogs = [Int]()
    var incorrectCats = [Int]()
    var missedCats = [Int]()
    var incorrectRandom = [Int]()
    var resultTmpList : [String:Any] = [:]
    
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setupUI()
    }
    
    private func setupUI() {
        self.navigationItem.title = "Cats And Dogs"
        self.btnEnd.isHidden = true
        self.btnReset.isHidden = true
        self.lbResult.isHidden = true
    }
    
    // MARK: - IBAction
    @IBAction func btnStartTapped(_ sender: Any) {
        self.btnStart.isHidden = true
        self.startTest()
    }
    
    @IBAction func btnEndTapped(_ sender: Any) {
        self.ended = true
        self.btnStart.isHidden = false
        self.btnEnd.isHidden = true
        self.btnReset.isHidden = true
        self.lbResult.isHidden = false
        self.doneTest()
    }
    
    @IBAction func btnResetTapped(_ sender: Any) {
        print("in reset")
        for k in 0 ..< buttonList.count {
            buttonList[k].removeFromSuperview()
        }
        
        for j in 0 ..< imageList.count {
            imageList[j].removeFromSuperview()
        }
        
        for j in 0 ..< boxList.count {
            boxList[j].removeFromSuperview()
        }
        
        self.dogList = [Int]()
        self.catList = [Int]()
        self.buttonList = [UIButton]()
        self.imageList = [UIImageView]()
        self.boxList = [UIImageView]()
        self.order = [Int]()
        self.pressed = [Int]()
        level = 0 //current level
        repetition = 0
        ended = false
        self.btnStart.isHidden = false
        self.btnEnd.isHidden = true
        self.btnReset.isHidden = true
        self.lbResult.isHidden = true
    }
    
    @IBAction func btnBackTapped(_ sender: Any) {
        Status[TestCatsAndDogs] = TestStatus.NotStarted
    }
    
    private func startTest() {
        print("getting to start test")
        self.lbResult.text = ""
        self.lbResult.isHidden = true
        
        // Dogs Alone
        let dogsAloneArr = self.dogsAlone.components(separatedBy: ",")
        dogsAloneArr.forEach { (obj) in
            if let iDog = Int(obj) {
                self.dogList.append(iDog)
                self.catList.append(0)
            }
        }

        // Dogs Not Cats
        let dogsNotCatsArr = self.dogsNoCats.components(separatedBy: String("),("))
        for i in 0...dogsNotCatsArr.count - 1 {
            let split1 = dogsNotCatsArr[i].components(separatedBy: ",")
            var x1: String = String()
            var y1: Int = Int()
            var x2: String = String()
            var y2: Int = Int()
            
            if i == 0 {
                x1 = split1[0].replacingOccurrences(of: "(", with: "", options: NSString.CompareOptions.literal, range:nil)
                y1 = Int(x1) ?? 1
                x2 = split1[1]
                y2 = Int(x2) ?? 1
            }
            else if i == dogsNotCatsArr.count - 1 {
                x1 = split1[0]
                y1 = Int(x1) ?? 1
                x2 = split1[1].replacingOccurrences(of: ")", with: "", options: NSString.CompareOptions.literal, range:nil)
                y2 = Int(x2) ?? 1
            }
            else {
                x1 = split1[0]
                y1 = Int(x1) ?? 1
                x2 = split1[1]
                y2 = Int(x2) ?? 1
            }
            self.dogList.append(y1)
            self.catList.append(y2)
        }
        
        // Cats No Dogs
        let catsNoDogsArr = self.catsNoDogs.components(separatedBy: String("),("))
        for i in 0...catsNoDogsArr.count - 1 {
            let split2 = catsNoDogsArr[i].components(separatedBy: ",")
            var x1: String = String()
            var y1: Int = Int()
            var x2: String = String()
            var y2: Int = Int()
            
            if i == 0 {
                x1 = split2[0].replacingOccurrences(of: "(", with: "", options: NSString.CompareOptions.literal, range:nil)
                y1 = Int(x1) ?? 1
                x2 = split2[1]
                y2 = Int(x2) ?? 1
            }
            else if i == catsNoDogsArr.count - 1 {
                x1 = split2[0]
                y1 = Int(x1) ?? 1
                x2 = split2[1].replacingOccurrences(of: ")", with: "", options: NSString.CompareOptions.literal, range:nil)
                y2 = Int(x2) ?? 1
            }
            else {
                x1 = split2[0]
                y1 = Int(x1) ?? 1
                x2 = split2[1]
                y2 = Int(x2) ?? 1
            }
            self.dogList.append(y1)
            self.catList.append(y2)
        }
        
        self.break1 = dogsAloneArr.count
        self.break2 = dogsAloneArr.count + dogsNotCatsArr.count
        // Save Data
        UserDefaults.standard.set(self.dogsAlone, forKey:"CandD-Dogs")
        UserDefaults.standard.set(self.dogsNoCats, forKey:"CandD-Dogs-no-Cats")
        UserDefaults.standard.set(self.catsNoDogs, forKey:"CandD-Cats-no-Dogs")
        UserDefaults.standard.synchronize()
        
        self.cats = self.catList[0]
        self.dogs = self.dogList[0]
        self.startAlert()
    }
    
    private func startAlert() {
        print("getting to start alert")
        let alert = UIAlertController(title: "Start", message: "Follow instructions to tap cats and dogs behind the boxes.", preferredStyle: .alert)
        let str = NSMutableAttributedString(string: "\nFollow instructions to tap cats and dogs behind the boxes.", attributes: [NSFontAttributeName : UIFont.systemFont(ofSize: 30.0)])
        alert.setValue(str, forKey: "attributedMessage")
        let header = NSMutableAttributedString(string: "Start", attributes: [NSFontAttributeName : UIFont.systemFont(ofSize: 25.0)])
        alert.setValue(header, forKey: "attributedTitle")
        alert.addAction(UIAlertAction(title: "Start", style: .cancel, handler: { (action) -> Void in
            self.start()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func start() {
        self.btnEnd.isHidden = false
        self.btnReset.isHidden = false
        self.randomizeBoard()
        self.randomizeOrder()
        for i in 0 ..< self.order.count {
            let(a,b) = self.places[self.order[i]]
            let x : CGFloat = CGFloat(a)
            let y : CGFloat = CGFloat(b)
            if(i <= self.dogs - 1) {
                let image = UIImage(named: "dog")!
                let imageView = UIImageView(frame:CGRect(x: (x + (100-(100.0*(image.size.width)/(image.size.height)))/2), y: y, width: 100.0*(image.size.width)/(image.size.height), height: 100.0))
                imageView.image = image
                self.view.addSubview(imageView)
                self.imageList.append(imageView)
            }
            else {
                if(i <= self.cats + self.dogs - 1) {
                    let image = UIImage(named: "cat1")!
                    let imageView = UIImageView(frame:CGRect(x: (x + (100-(100.0*(image.size.width)/(image.size.height)))/2), y: y, width: 100.0*(image.size.width)/(image.size.height), height: 100.0))
                    imageView.image = image
                    self.view.addSubview(imageView)
                    self.imageList.append(imageView)
                }
            }
            let box = UIImageView(frame: CGRect(x: x, y: y, width: 100, height: 100))
            self.boxList.append(box)
            box.layer.borderColor = UIColor.blue.cgColor
            box.layer.borderWidth = 2
            self.view.addSubview(box)

            let button = UIButton(type: UIButtonType.system)
            self.buttonList.append(button)
            button.frame = CGRect(x: x, y: y, width: 100, height: 100)
            button.backgroundColor = UIColor.blue
            self.view.addSubview(button)
        }
        
        ended = false
        self.level = 0
        self.cats = self.catList[0]
        self.dogs = self.dogList[0]
        self.alert(info: "Tap all the dogs", display: true, start: true)
    }
    
    private func randomizeBoard() {
        xt = arc4random_uniform(2000) < 1000
        yt = arc4random_uniform(2000) < 1000
        places = places.map(self.transform)
    }
    
    private func transform(coord:(Int, Int)) -> (Int, Int) {
        var x = coord.0
        var y = coord.1
        if xt  {
            x  = 950 - x
        }
        if yt {
            y = 850 - y
        }
        //return (Int(CGFloat(x)*screenSize!.maxX/1024.0), Int(CGFloat(y)*screenSize!.maxY/768.0))
        return (x, y)
    }
    
    // Changes 'order' and 'buttonList' arrays, adds buttons; called in next, reset and viewDidLoad
    func randomizeOrder() {
        print("randomizing order")
        self.order = [Int]()
        // numplaces = 0
        var array = [Int]()
        for i in 0...places.count-1 {
            array.append(i)
        }
        //IDK IF THIS WILL WORK BACKWARDS???
        for k in 0...places.count-1 {
            let j = places.count-1-k
            let random = Int(arc4random_uniform(UInt32(j)))
            order.append(array[random])
            array.remove(at: random)
        }
        print("order is \(order)")
    }
    
    func alert(info:String, display: Bool, start: Bool) {
        let alert = UIAlertController(title: "Instructions", message: info, preferredStyle: .alert)
        let str = NSMutableAttributedString(string: "\n" + info, attributes: [NSFontAttributeName : UIFont.systemFont(ofSize: 50.0)])
        alert.setValue(str, forKey: "attributedMessage")
        let header = NSMutableAttributedString(string: "Instructions", attributes: [NSFontAttributeName : UIFont.systemFont(ofSize: 30.0)])
        alert.setValue(header, forKey: "attributedTitle")
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { (action) -> Void in
            if(display == true){
                self.display()
            }
            if(start == true){
                self.startTime2 = Foundation.Date()
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func display() {
        print("Displaying...")
        self.btnEnd.isHidden = true
        self.btnReset.isHidden = true
        for index in 0 ..< order.count {
            UIView.animate(withDuration: 0.2, animations:{
                self.buttonList[index].alpha = 0.0
            })
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.8){
            for index in 0 ..< self.order.count {
                UIView.animate(withDuration: 0.2, animations:{
                    self.buttonList[index].alpha = 1.0
                })
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
            self.btnEnd.isHidden = false
            self.btnReset.isHidden = false
            self.enableButtons()
        }
    }
    
    // Allow buttons to be pressed
    func enableButtons() {
        for (index, _) in self.order.enumerated() {
            self.buttonList[index].addTarget(self, action: #selector(buttonAction), for: UIControlEvents.touchUpInside)
        }
        print("buttons enabled")
    }
    
    //stop buttons from being pressed
    func disableButtons() {
        for (index, _) in self.order.enumerated() {
            self.buttonList[index].removeTarget(self, action: #selector(buttonAction), for: UIControlEvents.touchUpInside)
        }
        print("buttons disabled")
    }
    
    // What happens when a user taps a button (if buttons are enabled at the time)
    @objc func buttonAction(sender: UIButton!)
    {
        // Find which button user has tapped
        for i in 0...self.buttonList.count-1 {
            if sender == self.buttonList[i] {
                print("dogs: \(dogs)")
                print("In button \(i)")
                //change color to indicate tap
                sender.backgroundColor = UIColor.darkGray
                sender.isEnabled = false
                self.pressed.append(i)
            }
        }
        // Check it's choose dog or cat
        if self.level < self.break2 {
            if self.pressed.count == self.dogs {
                self.selectionDone()
            }
        }
        else {
            if self.pressed.count == self.cats {
                self.selectionDone()
            }
        }
    }
    
    func selectionDone(){
        self.disableButtons()
        print("selection done; dogs = \(dogs), cats = \(cats)")
        var dogCount = 0
        var catCount = 0
        var otherCount = 0
        for k in 0 ..< self.pressed.count {
            if(self.pressed[k] < self.dogs){
                dogCount += 1
            }
            else {
                if(self.pressed[k] < self.dogs + self.cats) {
                    catCount += 1
                }
                else {
                    otherCount += 1
                }
            }
        }
        resultTmpList[String(level)] = ["Dogs":dogs, "Cats":cats, "Dogs found":dogCount, "Cats found":catCount]
        self.pressed = [Int]()
        
        print("catCount = \(catCount), dogCount = \(dogCount), otherCount = \(otherCount)")
        self.correctDogs.append(dogCount)
        self.missedDogs.append(dogs-dogCount)
        self.incorrectCats.append(catCount)
        self.missedCats.append(cats-catCount)
        self.incorrectRandom.append(otherCount)
        self.next()
    }
    
    func next() {
        self.level += 1
        print("next; level = \(self.level)")
        if (self.level == self.catList.count) {
            if(self.repetition<0) {
                self.level = 0
                self.repetition += 1
            }
            else {
                self.btnEnd.isHidden = true
                self.btnReset.isHidden = false
                self.btnStart.isHidden = false
                self.lbResult.isHidden = false
                self.doneTest()
            }
        }
        else {
            print("level: \(level)")
            print("dogList[level]: \(self.dogList[level])")
            print("catList[level]: \(self.catList[level])")
            self.cats = self.catList[level]
            self.dogs = self.dogList[level]
            self.randomizeOrder()
            print("order randomized; cats = \(cats), dogs = \(dogs)")
            for k in 0 ..< self.buttonList.count {
                self.buttonList[k].removeFromSuperview()
            }
            for k in 0 ..< self.imageList.count {
                self.imageList[k].removeFromSuperview()
            }
            for k in 0 ..< boxList.count {
                self.boxList[k].removeFromSuperview()
            }
            self.buttonList = [UIButton]()
            self.imageList = [UIImageView]()
            self.boxList = [UIImageView]()
            
            for i in 0 ..< self.order.count {
                let(a,b) = self.places[self.order[i]]
                let x : CGFloat = CGFloat(a)
                let y : CGFloat = CGFloat(b)
                if(i <= self.dogs - 1) {
                    let image = UIImage(named: "dog")!
                    let imageView = UIImageView(frame:CGRect(x: (x + (100-(100.0*(image.size.width)/(image.size.height)))/2), y: y, width: 100.0*(image.size.width)/(image.size.height), height: 100.0))
                    imageView.image = image
                    self.view.addSubview(imageView)
                    self.imageList.append(imageView)
                } else {
                    if(i <= self.cats + self.dogs - 1) {
                        let image = UIImage(named: "cat1")!
                        let imageView = UIImageView(frame:CGRect(x: (x + (100-(100.0*(image.size.width)/(image.size.height)))/2), y: y, width: 100.0*(image.size.width)/(image.size.height), height: 100.0))
                        imageView.image = image
                        self.view.addSubview(imageView)
                        self.imageList.append(imageView)
                    }
                }
                
                let box = UIImageView(frame: CGRect(x: x, y: y, width: 100, height: 100))
                self.boxList.append(box)
                box.layer.borderColor = UIColor.blue.cgColor
                box.layer.borderWidth = 2
                self.view.addSubview(box)
                
                let button = UIButton(type: UIButtonType.system)
                self.buttonList.append(button)
                button.frame = CGRect(x: x, y: y, width: 100, height: 100)
                button.backgroundColor = UIColor.blue
                self.view.addSubview(button)
            }
            
            if(level == 0){
                alert(info: "Tap all the dogs.", display: true, start: true)
            }
            if(level == break1){
                alert(info: "Tap all the dogs.\nDo NOT tap the cats.", display: true, start: false)
            }
            if(level == break2){
                alert(info: "Tap all the cats.\nDo NOT tap the dogs.", display: true, start: false)
            }
            
            if(level != 0 && level != break1 && level != break2){
                display()
            }
            
        }
    }
    
    func doneTest() {
        self.ended = true
        let result = Results()
        result.name = "Cats and Dogs"
        result.startTime = startTime2 as Date
        result.endTime = Foundation.Date()
        
        self.buttonList.forEach{ $0.removeFromSuperview() }
        self.imageList.forEach{ $0.removeFromSuperview() }
        self.boxList.forEach{ $0.removeFromSuperview() }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.navigationItem.setHidesBackButton(false, animated:true)
            for (index, _) in self.order.enumerated() {
                self.buttonList[index].backgroundColor = UIColor.darkGray
            }
            
            var resulttxt = ""
            result.numErrors = 0
            var reslist : [String:Any] = [:]
            for k in 0 ..< self.level {
                var r = ""
                if k < self.break2 {
                    r = "\(self.correctDogs[k]) dogs - Correct selected out of \(self.missedDogs[k]+self.correctDogs[k]) dogs; \(self.incorrectCats[k]) cats - Incorrect selected out of \(self.incorrectCats[k]+self.missedCats[k]) cats; \(self.incorrectRandom[k]) empty places - Incorrect selected.\n"
                    let errors = self.missedDogs[k] + self.incorrectCats[k] + self.incorrectRandom[k]
                    result.numErrors += errors
                    var rl:[String:Any] = [:]
                    rl["Dogs Correct"] = self.correctDogs[k]
                    rl["Dogs Total"]  = self.missedDogs[k]+self.correctDogs[k]
                    rl["Cats Incorrect"] = self.incorrectCats[k]
                    rl["Cats Total"] = self.incorrectCats[k]+self.missedCats[k]
                    rl["Empty Incorrect"] = self.incorrectRandom[k]
                    rl["Num Errors"] = errors
                    reslist[String(k)] = rl
                }
                else {
                    r = "\(self.correctDogs[k]) dogs - Incorrect selected out of \(self.missedDogs[k]+self.correctDogs[k]) dogs; \(self.incorrectCats[k]) cats - Correct selected out of \(self.incorrectCats[k]+self.missedCats[k]) cats; \(self.incorrectRandom[k]) empty places - Incorrect selected.\n"
                    let errors = self.correctDogs[k] + self.missedCats[k] + self.incorrectRandom[k]
                    result.numErrors += errors
                    var rl:[String:Any] = [:]
                    rl["Dogs inorrect"] = self.correctDogs[k]
                    rl["Dogs Total"]  = self.missedDogs[k]+self.correctDogs[k]
                    rl["Cats correct"] = self.incorrectCats[k]
                    rl["Cats Total"] = self.incorrectCats[k]+self.missedCats[k]
                    rl["Empty Incorrect"] = self.incorrectRandom[k]
                    rl["Num Errors"] = errors
                    reslist[String(k)] = rl
                }
                
                if k == 0 {
                    resulttxt.append(contentsOf: "Tap all the dogs.\n")
                }
                else if k == self.break1 {
                    resulttxt.append(contentsOf: "\nTap all the dogs. Do not tap the cats.\n")
                }
                else if k == self.break2 {
                    resulttxt.append(contentsOf: "\nTap all the cats.Do not tap the dogs.\n")
                }
                resulttxt.append(r)
                result.longDescription.add(r)
            }
            
            print(resulttxt)
            self.lbResult.text = resulttxt
            
            result.json = ["Passes":self.resultTmpList, "Score":reslist]
            resultsArray.add(result)
            
            Status[TestCatsAndDogs] = TestStatus.Done
        }
    }
}

