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
    
    
    
    // perform segue to the break scene
    func moveToBreak() {
        print("I am moving to a break view controller ") // --------------
        // pass:
        // workout time, rest time, exercises
        // changeMySets:bool , sets __you don't want to change sets if you finished a workout__
        // exercise index
    }
    
    
    
    
    func prepareViewController() -> Void {
        self.exerciseTitle.text = ((exercises[exerciseIndex]) as AnyObject).value(forKey: "name") as? String
        self.exDescription.text = ((exercises[exerciseIndex]) as AnyObject).value(forKey: "desc") as? String
        self.totalSets = (((exercises[exerciseIndex]) as AnyObject).value(forKey: "sets") as? Int)!
        self.reps = ((((exercises[exerciseIndex]) as AnyObject).value(forKey: "reps")) as? Int)!
        self.restTime = ((((exercises[exerciseIndex]) as AnyObject).value(forKey: "rest")) as? Int)!
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
        return self.restTime > 0
    }
    
    
    
    
    // ------------------ Useless ------------------
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}
