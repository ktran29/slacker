//
//  CardioViewController.swift
//  slacker
//
//  Created by Connor Hawthorne on 3/4/18.
//  Copyright © 2018 ateamhasnoname. All rights reserved.
//
import UIKit

class CardioViewController: UIViewController {
    
    // local variables
    var exTime: Int = 1
    var timer = Timer()
    
    // has to be received and sent
    var exercises: NSArray = []
    var exerciseIndex: Int = 0
    var sets: Int = 1
    
    // only sent
    var restTime: Int = 99999
    var workoutType = "cardio"
    var changeMySets = true
    
    // re-calculated on view did load
    var totalSets: Int = 0
    var reps: Int = 0
    
    @IBOutlet weak var setXofY: UILabel!
    @IBOutlet weak var exerciseTitle: UILabel!
    @IBOutlet weak var exDescription: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var pauseBtn: UIButton!
    
    
    @IBAction func startBtnPressed(_ sender: Any) {
        runTimer()
        pauseBtn.isEnabled = true
        startBtn.isEnabled = false
    }
    
    @IBAction func pauseBtnPressed(_ sender: Any) {
        timer.invalidate()
        startBtn.isEnabled = true
        pauseBtn.isEnabled = false
    }
    

    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(CardioViewController.updateTimer)), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        exTime -= 1     //This will decrement(count down)the seconds.
        timerLabel.text = timeString(time: TimeInterval(exTime)) //This will update the label
        if (exTime == 0) {
            timer.invalidate()
            timerLabel.text = "Done!"
            //Could make is so that this enables the next button
        }
    }
    
    // sets content (labels, timer, buttons) of the scene
    func prepareViewController() -> Void {
        self.exerciseTitle.text = ((exercises[exerciseIndex]) as AnyObject).value(forKey: "name") as? String
        self.exDescription.text = ((exercises[exerciseIndex]) as AnyObject).value(forKey: "desc") as? String
        self.exTime = ((((exercises[exerciseIndex]) as AnyObject).value(forKey: "duration")) as? Int)!
        timerLabel.text = timeString(time: TimeInterval(exTime))
        pauseBtn.isEnabled = false
        self.totalSets = (((exercises[exerciseIndex]) as AnyObject).value(forKey: "sets") as? Int)!
        self.restTime = ((((exercises[exerciseIndex]) as AnyObject).value(forKey: "rest")) as? Int)!
        self.setXofY.text = "Set \(self.sets) of \(self.totalSets)"
//        Are these needed? Maybe for abs or something between running exercises?
//        self.reps = ((((exercises[exerciseIndex]) as AnyObject).value(forKey: "reps")) as? Int)!
//        self.repsLabel.text = "\(self.reps) Reps"
    }
    
    // puts the duration of seconds into a HH/MM/SS format
    func timeString(time:TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
    }
    
    // resets the set count
    func nextExercise() {
        self.sets = 0
    }
    
    
    @IBAction func clickedNext(_ sender: UIButton) {
       
        // done with this exercise
        if self.sets >= totalSets {
            self.changeMySets = false
            
            //check if entire workout is done
            if self.exerciseIndex >= self.exercises.count - 1 {
                self.exerciseTitle.text = "WORKOUT DONE"
                // Transition to Congrats page ____________
                performSegue(withIdentifier: "cardioToCongrats", sender: CardioViewController.self)
                
                // move on to next exercise
            } else {
                rotateToNewExercise()
            }

        // not done with this exercise, break or next set
        } else {
            self.changeMySets = true
            self.sets += 1
        }
        prepareViewController()
        if iNeedaBreak() {
            performSegue(withIdentifier: "cardioToBreak", sender: CardioViewController.self)
        }
    }
    
    // increments the exercise index
    func rotateToNewExercise() {
        self.exerciseIndex += 1
        self.sets = 1
    }
    
    // checks whether we need a break now
    func iNeedaBreak() -> Bool {
        return self.restTime > 0
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        prepareViewController()
        //runTimer()  // Enable this to have the timer start onLoad
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // passes over data to other scenes
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "cardioToBreak" {
            print("I am moving to a break view controller ") // --------------
            let destination = segue.destination as! BreakViewController
            // changeMySets:bool , sets __you don't want to change sets if you finished a workout__
            destination.workoutType = (self.workoutType)
            destination.exercises = (self.exercises)
            destination.exerciseIndex = (self.exerciseIndex)
            destination.sets = (self.sets)
            destination.restTime = (self.restTime)
        } else if segue.identifier == "cardioToCongrats" {
            print("I am moving to a congrats view controller ") // --------------
            let destination = segue.destination as! CongratsViewController
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
