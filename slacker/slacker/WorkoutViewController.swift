//
//  WorkoutViewController.swift
//  slacker
//
//  Created by Kevin Tran on 3/1/18.
//  Copyright © 2018 ateamhasnoname. All rights reserved.
//

import UIKit

class WorkoutViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var workoutDesc: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var favoriteButton: UIButton!
    
    // gets data from overall workout view
    var workoutTitle : String?
    var workoutDescription : String?
    var workoutTag : String?
    var workoutId : Int?
    var exercises : NSArray?
    
    // this will be modified by clickedBegin and used
    // to determine where to go next
    var nextSegue: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.separatorStyle = .none
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 60.0
        
        name.text = workoutTitle!
        workoutDesc.text = workoutDescription!
        
    }
    
    @IBAction func clickedBegin(_ sender: UIButton) {
        let restTime = (self.exercises![0] as AnyObject).value(forKey: "rest")
//        let tag = self.exercises?.value(forKey: "rest")
        
//        print("\n\n")
//        print(self.exercises)
//        print("\n\n")
        
        
        //if restTime as? Int == 0 {
        if self.workoutTag == "regular" {
            // move to lifting scene
            self.nextSegue = "LiftingViewController"
            performSegue(withIdentifier: "overviewToLifting", sender: WorkoutViewController.self)
            
            
        } else {
            // move to cardio scene ______________
            self.nextSegue = "CardioViewController"
            performSegue(withIdentifier: "overviewToCardio", sender: CardioViewController.self)
        }
    }
    
    @IBAction func favoriteClicked(_ sender: UIButton) {
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if self.nextSegue == "LiftingViewController" {
            let destination = segue.destination as! LiftingViewController
            destination.exercises = (self.exercises)!
            print("Seguing to LiftViewController --------")
            
        } else if self.nextSegue == "CardioViewController"{
            // CONNOR ---- choose what data to pass over here
            let destination = segue.destination as! CardioViewController
            destination.exercises = (self.exercises)!
            print("Seguing to CardioViewController --------")
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.exercises!.count
    }
    
    // loads each exercise in a workout
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "exerciseCell", for: indexPath) as! ExerciseTableViewCell
        let singleExercise = self.exercises![indexPath.row] as AnyObject
        let exerciseName = singleExercise.value(forKey: "name") as! String
        let numSets = singleExercise.value(forKey: "sets") as! Int
        let numReps = singleExercise.value(forKey: "reps") as! Int
        let setText = numSets == 1 ? "set" : "sets"
        let repText = numReps == 1 ? "rep" : "reps"

        
        cell.exerciseInfo.text = "\(exerciseName), \(numSets) \(setText), \(numReps) \(repText)"
        return cell
    }

}
