//
//  ViewController.swift
//  Module 4
//
//  Created by user231925 on 1/28/23.
//

import UIKit
import AVFoundation

extension Date {
    var hour: Int { return Calendar.current.component(.hour, from: self) }
}

class ViewController: UIViewController {
    
    
    @IBOutlet weak var imageView: UIStackView!
    @IBOutlet weak var liveClock: UILabel!
    
    @IBOutlet weak var timePicker: UIDatePicker!
    
    @IBOutlet weak var countdownTimer: UILabel!
    
    @IBOutlet weak var buttonText: UIButton!
    
    var sound: AVAudioPlayer?

    var hours: Int = 0
    var mins: Int = 0
    var secs: Int = 0
    var timeLeft: Int = 1
    
    var hoursTag : String = ""
    var minsTag : String = ""
    var secsTag : String = ""
    
    var Toptimer = Timer()
    var timer:Timer?
    var backTimer = Timer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        Toptimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.updateClock), userInfo: nil, repeats: true)
        
        changeBackground()
        
        
        
    }
    
    var launchBool: Bool = false {
        didSet {
            if launchBool == true {
                 startTimer()

                
                }
                    
            
            
             else {
                buttonText.setTitle("Start Timer", for: .normal)
                timer?.invalidate()
                timer = nil
                //stop sound
                sound?.stop()
                timeLeft = 1
                 
                
            }
        }
    }
    
    
    @IBAction func tappedButton(_ sender: Any) {
        launchBool = !launchBool
        
    }
    
    func startTimer() {
        let time = floor((timePicker.countDownDuration))
        
        if time > 0 {
            let initialHours: Int = Int(time) / 3600
            let remainder: Int = Int(time) - (initialHours * 3600)
            let minutes: Int = remainder / 60
            let seconds: Int = Int(time) - (initialHours * 3600) - (minutes * 60)
            
            hours = initialHours
            mins = minutes
            secs = seconds
            
            timeLeft = Int(time)
 
            
            updateLabel()
            
            startCountdown()
        }
        
       
    }
    
    func startSound() {
        buttonText.setTitle("Stop Music", for: .normal)
        //play sound
        guard let url = Bundle.main.url(forResource: "cartoon", withExtension: ".mp3") else { return }
            
        do {
            sound = try AVAudioPlayer(contentsOf: url)
            sound?.play()
        } catch let error {
            print("Error playing sound. \(error.localizedDescription)")
        }
    }
        
            
        
        func startCountdown() {
            Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { _ in
                if self.secs > 0 {
                    self.secs = self.secs - 1
                    self.timeLeft = self.timeLeft - 1
                }
                else if self.mins > 0 && self.secs == 0 {
                    self.mins = self.mins - 1
                    self.secs = 59
                    self.timeLeft = self.timeLeft - 1
                }
                else if self.hours > 0 && self.mins == 0 && self.secs == 0 {
                    self.hours = self.hours - 1
                    self.mins = 59
                    self.secs = 59
                    self.timeLeft = self.timeLeft - 1
                    
                }
                
                
                self.updateLabel()
                
                if self.timeLeft < 1 {
                    self.startSound()
                }
            })
            
        }
        
    
        
        func updateLabel() {
        
            if hours < 10{
                hoursTag = "0"
            }
            else {
               hoursTag = ""
            }
            
            if mins < 10 {
                minsTag = "0"
            }
            else {
                minsTag = ""
            }
            
            if secs < 10 {
                secsTag = "0"
            }
            else {
                secsTag = ""
            }
                
            countdownTimer.text = "Time Remaining: \(hoursTag)\(hours):\(minsTag)\(mins):\(secsTag)\(secs)"
           
            
            
        }

        
        
        
        @objc func updateClock() {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "E, d MMM yyyy HH:mm:ss"
            
            let date = Date()
            
            liveClock.text = dateFormatter.string(from: date)
            
        }
        
        func scheduleBackground() {
            backTimer = Timer(fireAt: Calendar.current.nextDate(after: Date(), matching: DateComponents(hour: 0..<12 ~= Date().hour ? 12 : 0), matchingPolicy: .nextTime)!, interval: 0, target: self, selector: #selector(changeBackground), userInfo: nil, repeats: false)
            //print(backTimer.fireDate)
            RunLoop.main.add(backTimer, forMode: .common)
            //print("new background change scheduled at:", backTimer.fireDate.description(with: .current))
        }
        
        @objc func changeBackground() {
            //check for am or pm
            self.view.backgroundColor = 0..<12 ~= Date().hour ? UIColor(patternImage: UIImage(named: "am")!) : UIColor(patternImage: UIImage(named: "pm")!)
            
            //schedule timer
            scheduleBackground()
            
            
        }
        
    }
    

