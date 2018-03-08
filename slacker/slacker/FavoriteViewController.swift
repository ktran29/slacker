//
//  FavoriteViewController.swift
//  slacker
//
//  Created by Kevin Tran on 3/8/18.
//  Copyright © 2018 ateamhasnoname. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var tableView: UITableView!
    var jsonData : NSArray = []
    var favoritedWorkouts : NSMutableArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        let fileManager = FileManager.default
        let path = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("questions.json")
        let content = NSData(contentsOf: path)
        if content != nil {
            jsonData  = NSArray(contentsOf: path)!
        }
    }
    
    
    // resets favorites every time view appears
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        favoritedWorkouts = []
        let favorites = UserDefaults.standard.object(forKey: "favorites") as! NSArray
        for index in 0...jsonData.count - 1 {
            let workout = jsonData[index]
            let workoutId = (workout as AnyObject).value(forKey: "id") as? Int
            if (favorites.contains(workoutId!)) {
                favoritedWorkouts.add(workout)
            }
        }
        
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // TABLE FUNCTIONS
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoritedWorkouts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteCell", for: indexPath) as! FavoriteTableViewCell
        let selectedWorkout = favoritedWorkouts[indexPath.row]
        cell.workoutTitle.text =  (selectedWorkout as AnyObject).value(forKey: "workout") as? String
        cell.workoutDescription.text =  (selectedWorkout as AnyObject).value(forKey: "desc") as? String
        
        return cell
    }

    // sends to workout view like from main view if cell is clicked
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let workoutView = self.storyboard?.instantiateViewController(withIdentifier: "WorkoutView") as! WorkoutViewController
        let selectedWorkout = favoritedWorkouts[indexPath.row] as AnyObject
        workoutView.workoutTitle = selectedWorkout.value(forKey: "workout") as? String
        workoutView.workoutDescription = selectedWorkout.value(forKey: "desc") as? String
        workoutView.workoutTag = selectedWorkout.value(forKey: "tag") as? String
        workoutView.workoutId = selectedWorkout.value(forKey: "id") as? Int
        workoutView.exercises = selectedWorkout.value(forKey: "exercises") as? NSArray
        
        self.navigationController?.pushViewController(workoutView, animated: true)
    }
    
}
