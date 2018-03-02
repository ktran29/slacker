//
//  CardioViewController.swift
//  slacker
//
//  Created by Benjamin Walchenbach on 3/1/18.
//  Copyright © 2018 ateamhasnoname. All rights reserved.
//

import UIKit

class CardioViewController: UIViewController {

    var seconds = 15
    var timer = Timer()
    var workoutType = ""
    var index: Int? = nil
    var isPaused = false
    
    @IBAction func startBtnPressed(_ sender: Any) {
        if self.isPaused == true {
            runTimer()
            self.isPaused = false
        }
    }
    
    @IBAction func pauseBtnPressed(_ sender: Any) {
        if self.isPaused == false {
            timer.invalidate()
            self.isPaused = true
        }
    }
    
    @IBOutlet weak var timerLabel: UILabel!
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(CardioViewController.updateTimer)), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        seconds -= 1     //This will decrement(count down)the seconds.
        timerLabel.text = "\(seconds)"  //This will update the label.
        if (seconds == 0) {
            timer.invalidate()
            timerLabel.text = "Done!" //transition to exercise
            //if on last set move onto next exercise instead
            performSegue(withIdentifier: "segueToBreak", sender: nil)
            //performSegue(withIdentifier: "segueToLifting", sender: nil)
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToBreak" {
            let breakView = segue.destination as! BreakViewController
        } else if segue.identifier == "segueToLifting" {
            let liftingView = segue.destination as! LiftingViewController
        } else {
            print("No segue was identified")
        }
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
