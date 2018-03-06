//
//  LiftingViewController.swift
//  slacker
//
//  Created by Benjamin Walchenbach on 3/1/18.
//  Copyright © 2018 ateamhasnoname. All rights reserved.
//

import UIKit

class LiftingViewController: UIViewController {
    
    
    // ------------------ Fields ------------------
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.hidesBackButton = true
        
        // sets all the labels and fields.
        prepareViewController()
    }
    
    
    // has to be received and sent
    var exercises: NSArray = []
    var exerciseIndex: Int = 0
    var sets: Int = 1
    // only sent
    var restTime: Int = 99999
    
    
    // re-calculated on view did load
    var totalSets: Int = 0
    var reps: Int = 0
    
    var workoutType = "lift"
    var changeMySets = true
    
    
    @IBOutlet weak var exerciseTitle: UILabel!
    @IBOutlet weak var setXofY: UILabel!
    @IBOutlet weak var repsLabel: UILabel!
    @IBOutlet weak var exDescription: UILabel!
    @IBOutlet weak var Next: UIButton!
    
    
    
    // ------------------ Functions ------------------
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        print("Moving to \(String(describing: segue.identifier))")
        
        if segue.identifier == "liftingToBreak" {
           let destination = segue.destination as! BreakViewController
            
            // all of this data is the data for the next exercise we will be doing.
            // sets are reset to 0 and all variables are updated for the next one
            destination.exercises = (self.exercises)
            destination.workoutType = (self.workoutType)
            destination.exerciseIndex = (self.exerciseIndex)
            destination.sets = (self.sets)
            
            // we need to pass over the old rest time from the current exercise that we're finishing
            // because that's what the break view controller uses for its timer.
            var restIndex:Int = self.exerciseIndex - 1
            if restIndex < 0 {
                restIndex = 0
            }
            destination.restTime = ((((exercises[ restIndex ]) as AnyObject).value(forKey: "rest")) as? Int)!
            
            print("Rest index = \(restIndex)")
        }
    }
    
    
    
    // perform segue to the break scene
    func moveToBreak() {
        performSegue(withIdentifier: "liftingToBreak", sender: LiftingViewController.self)
    }
    
    
    
    
    func prepareViewController() -> Void {
        self.exerciseTitle.text = ((exercises[exerciseIndex]) as AnyObject).value(forKey: "name") as? String
        self.exDescription.text = ((exercises[exerciseIndex]) as AnyObject).value(forKey: "desc") as? String
        self.totalSets = (((exercises[exerciseIndex]) as AnyObject).value(forKey: "sets") as? Int)!
        self.reps = ((((exercises[exerciseIndex]) as AnyObject).value(forKey: "reps")) as? Int)!
        self.restTime = ((((exercises[exerciseIndex]) as AnyObject).value(forKey: "rest")) as? Int)!
        
        self.setXofY.text = "Set \(self.sets) of \(self.totalSets)     | "
        self.repsLabel.text = "\(self.reps) Reps"
    }
    
    func nextExercise() {
        self.sets = 0
        
    }
    
    
    @IBAction func clickedNext(_ sender: UIButton) {
        
        // rest time that needs to be sent over
        
        
        // done with this exercise
        if self.sets >= totalSets {
            self.changeMySets = false
            //check if entire workout is done
            if self.exerciseIndex >= self.exercises.count - 1 {
                self.exerciseTitle.text = "WORKOUT DONE"
                // Trasnition to Congrats page ____________
                performSegue(withIdentifier: "liftToCongrats", sender: LiftingViewController.self)
            
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
            moveToBreak()
        }
        
    }
    

    
    // rotates us to the new exercise
    func rotateToNewExercise() {
        self.exerciseIndex += 1
        self.sets = 1
    }
    
    // checks whether we need a break now
    func iNeedaBreak() -> Bool {
        return (self.restTime > 0)
    }
    
    
    
    
    // ------------------ Useless ------------------
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}
