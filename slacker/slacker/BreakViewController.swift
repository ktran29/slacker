//
//  BreakViewController.swift
//  slacker
//
//  Created by Kevin Tran on 2/28/18.
//  Copyright © 2018 ateamhasnoname. All rights reserved.
//

import UIKit

class BreakViewController: UIViewController {
    
    // local variables
    var timer = Timer()
    
    // has to be received
    var restTime: Int = 1
    var workoutType = ""
    
    // has to be received and sent
    var exercises: NSArray = []
    var exerciseIndex: Int = 0
    var sets: Int = 1
    
    @IBAction func motivationButton(_ sender: Any) {
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "sbPopUpID") as! MotivationViewController
        self.addChildViewController(popOverVC)
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParentViewController: self) // might need to be popOverVC.didMoveToParentViewController(self)
    }
    
    
    @IBOutlet weak var timerLabel: UILabel!
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(BreakViewController.updateTimer)), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        restTime -= 1     //This will decrement(count down)the seconds.
        timerLabel.text = timeString(time: TimeInterval(restTime))  //This will update the label.
        if (restTime == 0) {
            timer.invalidate()
            timerLabel.text = "Done!"
            if (workoutType == "lift") {
                performSegue(withIdentifier: "breakToLifting", sender: self) //transition to lift screen
            } else if (workoutType == "cardio") {
                performSegue(withIdentifier: "breakToCardio", sender: self) //transition to cardio
            }
        }
    }
    
    func timeString(time:TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "breakToLifting" {
            print("I am moving to a lifting view controller ") // --------------
            let destination = segue.destination as! LiftingViewController
            destination.exercises = (self.exercises)
            destination.exerciseIndex = (self.exerciseIndex)
            destination.sets = (self.sets)
        } else if segue.identifier == "breakToCardio" {
            print("I am moving to a cardio view controller ") // --------------
            let destination = segue.destination as! CardioViewController
            destination.exercises = (self.exercises)
            destination.exerciseIndex = (self.exerciseIndex)
            destination.sets = (self.sets)
        } else {
            print("No segue was identified")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        timerLabel.text = timeString(time: TimeInterval(restTime))
        runTimer()
        view.addBackground()
        
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
