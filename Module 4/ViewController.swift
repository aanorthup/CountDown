//
//  ViewController.swift
//  Module 4
//
//  Created by user231925 on 1/28/23.
//

import UIKit

class ViewController: UIViewController {


    @IBOutlet weak var liveClock: UILabel!
    
    var Toptimer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        Toptimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.updateClock), userInfo: nil, repeats: true)
        
    }


    @objc func updateClock() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, d MMM yyyy HH:mm:ss"
      
        let date = Date()
        
        liveClock.text = dateFormatter.string(from: date)
 
    }
    
    func changeBackground() {
        
            
    }
    
}

