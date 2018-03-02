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
    
    // gets data from overall workout view
    var workoutTitle : String?
    var workoutDescription : String?
    var exercises : NSArray?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        name.text = workoutTitle!
        workoutDesc.text = workoutDescription!
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
        cell.exerciseInfo.text = "\(exerciseName), \(numSets) sets, \(numReps) reps"

        return cell
    }
    
    // for ben to work on
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let exerciseView = self.storyboard?.instantiateViewController(withIdentifier: "ExerciseView") as! ExerciseViewController
//        let selectedExercise = exercises![indexPath.row] as AnyObject
//        exerciseView.selectedExercise = selectedExercise
//
//        self.navigationController?.pushViewController(exerciseView, animated: true)
//    }


}
