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
    
    var startNew = false
    
    var startTime2 = Foundation.Date()
    
    let dogsAlone = "2,3,4"
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
    var breakRound = Int()
    
    // Rotate (180 degrees) or mirror (on x or y) the point
    var xt:Bool = true
    var yt:Bool = true
    
    var level = 0 //current level
    var repetition = 0
    var ended = false
    var pressed = [Int]()
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
        if self.startNew == false {
            self.startTest()
        }
        else {
            self.startNewTest()
        }
    }
    
    @IBAction func btnEndTapped(_ sender: Any) {
        self.navigationItem.setHidesBackButton(false, animated:true)
        self.ended = true
        self.btnStart.isHidden = false
        self.btnEnd.isHidden = true
        self.btnReset.isHidden = true
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
        self.startNew = false
    }
    
    @IBAction func btnBackTapped(_ sender: Any) {
        Status[TestCatsAndDogs] = TestStatus.Done
    }
    
    private func startTest() {
        print("getting to start test")
        // Dogs Alone
        let dogsAloneArr = self.dogsAlone.components(separatedBy: ",")
        print("dogsAloneArr:\n\(dogsAloneArr)")
        dogsAloneArr.forEach { (obj) in
            if let iDog = Int(obj) {
                self.dogList.append(iDog)
                self.catList.append(0)
            }
        }

        self.breakRound = dogsAloneArr.count
        // Save Data
        UserDefaults.standard.set(self.dogsAlone, forKey:"CandD-Dogs")
        UserDefaults.standard.set(self.dogsNoCats, forKey:"CandD-Dogs-no-Cats")
        UserDefaults.standard.set(self.catsNoDogs, forKey:"CandD-Cats-no-Dogs")
        UserDefaults.standard.synchronize()
        
        self.cats = self.catList[0]
        self.dogs = self.dogList[0]
        self.startAlert()
    }
    
    private func startNewTest() {
        
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
        self.alert(info: "Tap all the dogs", display: true, start: true, testType: CatsAndDogsType.TapAllDogs.rawValue)
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
    
    func alert(info:String, display: Bool, start: Bool, testType: String) {
        let alert = UIAlertController(title: "Instructions", message: info, preferredStyle: .alert)
        let str = NSMutableAttributedString(string: "\n" + info, attributes: [NSFontAttributeName : UIFont.systemFont(ofSize: 50.0)])
        alert.setValue(str, forKey: "attributedMessage")
        let header = NSMutableAttributedString(string: "Instructions", attributes: [NSFontAttributeName : UIFont.systemFont(ofSize: 30.0)])
        alert.setValue(header, forKey: "attributedTitle")
        
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { (action) -> Void in
            if(display == true) {
                if testType == CatsAndDogsType.TapAllDogs.rawValue {
                    self.displayTapAllDogs()
                }
                else if testType == CatsAndDogsType.TapDogsNotCats.rawValue {
                    
                }
                else if testType == CatsAndDogsType.TapCatsNotDogs.rawValue {
                    
                }
            }
            if(start == true) {
                self.startTime2 = Foundation.Date()
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func displayTapAllDogs() {
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
            self.enableButtonsTapAllDogs()
        }
    }
    
    // Allow buttons to be pressed
    func enableButtonsTapAllDogs() {
        for (index, _) in self.order.enumerated() {
            self.buttonList[index].addTarget(self, action: #selector(tapAllDogsAction), for: UIControlEvents.touchUpInside)
        }
        print("buttons enabled")
    }
    
    //stop buttons from being pressed
    func disableButtonsTapAllDogs() {
        for (index, _) in self.order.enumerated() {
            self.buttonList[index].removeTarget(self, action: #selector(tapAllDogsAction), for: UIControlEvents.touchUpInside)
        }
        print("buttons disabled")
    }
    
    // What happens when a user taps a button (if buttons are enabled at the time)
    @objc func tapAllDogsAction(sender: UIButton!)
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
//                if i >= self.dogs {
//                    print("Next round")
//                    self.nextRound()
//                    if self.pressed.count == self.dogs {
//                        print("Done Round")
//                        self.doneTapAllDogs()
//                    }
//                }
                if i < self.dogs {
                    
                }
            }
        }
    }
    
    func doneTapAllDogs() {
        var dogCount = 0
        for k in 0 ..< pressed.count {
            if(pressed[k] < dogs) {
                dogCount += 1
            }
        }
        self.resultTmpList[String(self.dogs)] = ["Type":"TapAllDogs", "Dogs":dogs, "Dogs found":dogCount]
        self.pressed = [Int]()
        self.nextRound()
    }
    
    func nextRound() {
        self.level += 1
        print("level: \(level)")
        print("catList count: \(catList.count)")
        if (level == catList.count) {
            self.btnEnd.isHidden = true
            self.btnReset.isHidden = false
            self.btnStart.isHidden = true
            self.doneTest()
        }
        else {
            self.cats = catList[level]
            self.dogs = dogList[level]
            self.randomizeOrder()
            for k in 0 ..< buttonList.count {
                buttonList[k].removeFromSuperview()
            }
            for k in 0 ..< imageList.count {
                imageList[k].removeFromSuperview()
            }
            for k in 0 ..< boxList.count {
                boxList[k].removeFromSuperview()
            }
            self.buttonList = [UIButton]()
            self.imageList = [UIImageView]()
            self.boxList = [UIImageView]()
            
            for i in 0 ..< order.count {
                let(a,b) = self.places[order[i]]
                
                let x : CGFloat = CGFloat(a)
                let y : CGFloat = CGFloat(b)
                
                if(i <= dogs - 1) {
                    let image = UIImage(named: "dog")!
                    let imageView = UIImageView(frame:CGRect(x: (x + (100-(100.0*(image.size.width)/(image.size.height)))/2), y: y, width: 100.0*(image.size.width)/(image.size.height), height: 100.0))
                    imageView.image = image
                    self.view.addSubview(imageView)
                    self.imageList.append(imageView)
                }
                else {
                    if(i <= cats + dogs - 1) {
                        let image = UIImage(named: "cat1")!
                        let imageView = UIImageView(frame:CGRect(x: (x + (100-(100.0*(image.size.width)/(image.size.height)))/2), y: y, width: 100.0*(image.size.width)/(image.size.height), height: 100.0))
                        imageView.image = image
                        self.view.addSubview(imageView)
                        imageList.append(imageView)
                    }
                }
                
                let box = UIImageView(frame: CGRect(x: x, y: y, width: 100, height: 100))
                boxList.append(box)
                box.layer.borderColor = UIColor.blue.cgColor
                box.layer.borderWidth = 2
                self.view.addSubview(box)
                
                let button = UIButton(type: UIButtonType.system)
                buttonList.append(button)
                button.frame = CGRect(x: x, y: y, width: 100, height: 100)
                button.backgroundColor = UIColor.blue
                self.view.addSubview(button)
            }
        }
        
//        if(level == 0) {
//            self.alert(info: "Tap all the dogs.", display: true, start: true, testType: CatsAndDogsType.TapAllDogs.rawValue)
//        }
//        if(level == breakRound) {
//            self.alert(info: "Tap all the dogs.\nDo NOT tap the cats.", display: true, start: false, testType: CatsAndDogsType.TapDogsNotCats.rawValue)
//        }
        
        if(level != 0 && level != self.breakRound) {
            self.displayTapAllDogs()
        }
    }
    
    func doneTest() {
        self.ended = true
        self.level = 0
        self.btnEnd.isHidden = true
        self.btnReset.isHidden = true
        self.btnStart.isHidden = false
        self.lbResult.isHidden = false
        self.disableButtonsTapAllDogs()
        self.buttonList.forEach{ $0.removeFromSuperview() }
        self.imageList.forEach{ $0.removeFromSuperview() }
        self.boxList.forEach{ $0.removeFromSuperview() }
        print(self.resultTmpList)
        Status[TestCatsAndDogs] = TestStatus.Done
    }
    
}

