//
//  BreakViewController.swift
//  slacker
//
//  Created by Kevin Tran on 2/28/18.
//  Copyright © 2018 ateamhasnoname. All rights reserved.
//

import UIKit

class BreakViewController: UIViewController {

    var seconds = 15
    
    var timer = Timer()
    
    var workoutType = ""
    
    var index = 100
    
    var exercises: NSArray = []
    
    var set = 100
    
    @IBOutlet weak var timerLabel: UILabel!
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(BreakViewController.updateTimer)), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        seconds -= 1     //This will decrement(count down)the seconds.
        timerLabel.text = "\(seconds)"  //This will update the label.
        if (seconds == 0) {
            timer.invalidate()
            timerLabel.text = "Done!"
            if (workoutType == "lift") {
                performSegue(withIdentifier: "toLifting", sender: self) //transition to lift screen
            } else {
                performSegue(withIdentifier: "toCardio", sender: self) //transition to cardio
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        runTimer()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
