//
//  ViewController.swift
//  Module 4
//
//  Created by user231925 on 1/28/23.
//

import UIKit

extension Date {
    var hour: Int { return Calendar.current.component(.hour, from: self) }
}

class ViewController: UIViewController {


    @IBOutlet weak var liveClock: UILabel!
    
    @IBOutlet weak var timePicker: UIDatePicker!
    
    @IBOutlet weak var countdownTimer: UILabel!
    
    
    var Toptimer = Timer()
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        Toptimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.updateClock), userInfo: nil, repeats: true)
        
        changeBackground()
    
        
        
    }

   
    @IBAction func tappedButton(_ sender: Any) {
        print(timePicker.countDownDuration.description)
    }
    
    @objc func updateClock() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, d MMM yyyy HH:mm:ss"
      
        let date = Date()
        
        liveClock.text = dateFormatter.string(from: date)
 
    }
    
    func scheduleBackground() {
        timer = Timer(fireAt: Calendar.current.nextDate(after: Date(), matching: DateComponents(hour: 0..<12 ~= Date().hour ? 12 : 0), matchingPolicy: .nextTime)!, interval: 0, target: self, selector: #selector(changeBackground), userInfo: nil, repeats: false)
        print(timer.fireDate)
        RunLoop.main.add(timer, forMode: .common)
        print("new background change scheduled at:", timer.fireDate.description(with: .current))
    }
    
    @objc func changeBackground() {
        //check for am or pm
        self.view.backgroundColor = 0..<12 ~= Date().hour ? .yellow : .blue
        
        //schedule timer
        scheduleBackground()

            
    }
    
}

