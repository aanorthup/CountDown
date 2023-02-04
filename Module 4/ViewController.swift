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
    
    @IBOutlet weak var buttonText: UIButton!
    
    var hours: Int = 0
    var mins: Int = 0
    var secs: Int = 0
    
    var Toptimer = Timer()
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        Toptimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.updateClock), userInfo: nil, repeats: true)
        
        changeBackground()
        
        
        
    }
    
    
    @IBAction func tappedButton(_ sender: Any) {
        
        let time = floor((timePicker.countDownDuration))
        
        if time > 0 {
            let initialHours: Int = Int(time) / 3600
            let remainder: Int = Int(time) - (initialHours * 3600)
            let minutes: Int = remainder / 60
            let seconds: Int = Int(time) - (initialHours * 3600) - (minutes * 60)
            
            hours = initialHours
            mins = minutes
            secs = seconds
            
            updateLabel()
            
            startCountdown()
            
            
        }
        
        func startCountdown() {
            Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { _ in
                if self.secs > 0 {
                    self.secs = self.secs - 1
                }
                else if self.mins > 0 && self.secs == 0 {
                    self.mins = self.mins - 1
                    self.secs = 59
                }
                else if self.hours > 0 && self.mins == 0 && self.secs == 0 {
                    self.hours = self.hours - 1
                    self.mins = 59
                    self.secs = 59
                    
                }
                
                self.updateLabel()
            })
        }
        
    }
        
        func updateLabel() {
            
            countdownTimer.text = "Time Remaining: \(hours):\(mins):\(secs)"
            
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
    

