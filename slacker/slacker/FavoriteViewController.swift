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
    @IBOutlet weak var editButton: UIBarButtonItem!
    
    let userDefaults = UserDefaults.standard
    
    var jsonData : NSArray = []
    var favoritedWorkouts : NSMutableArray = []
    var unfavorite : NSMutableArray = []
    var editable : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.rowHeight = 68
        self.tableView.separatorStyle = .none
        
        let fileManager = FileManager.default
        let path = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("questions.json")
        let content = NSData(contentsOf: path)
        if content != nil {
            jsonData  = NSArray(contentsOf: path)!
        }
    }
    
    
    // resets favorites every time view appears
    // ie switching back and forth between tabs
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        favoritedWorkouts = []
        unfavorite = []
        let favorites = userDefaults.object(forKey: "favorites") as! NSArray
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
    
    // removes selected cells from favorites
    @IBAction func editFavorites(_ sender: UIBarButtonItem) {
        if (editable) {
            editButton.title = "Edit"
            let favorites = userDefaults.object(forKey: "favorites") as! NSArray
            if unfavorite.count > 0 {
                let mutableFavorites = favorites.mutableCopy() as! NSMutableArray
                for index in 0...unfavorite.count - 1 {
                    let workout = unfavorite[index]
                    if favorites.contains(workout) {
                        mutableFavorites.remove(workout)
                    }
                }
                userDefaults.set(mutableFavorites, forKey: "favorites")
                userDefaults.synchronize()
                self.viewWillAppear(false)
            }
        } else {
            editButton.title = "Remove"
        }
        editable = !editable
    }
    
    // TABLE FUNCTIONS
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoritedWorkouts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteCell", for: indexPath) as! FavoriteTableViewCell
        let selectedWorkout = favoritedWorkouts[indexPath.row] as AnyObject
        cell.workoutTitle.text =  selectedWorkout.value(forKey: "workout") as? String
        cell.workoutDescription.text =  selectedWorkout.value(forKey: "desc") as? String
        
        return cell
    }

    // sends to workout view like from main view if cell is clicked
    // or allows cell selection for removal
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedWorkout = favoritedWorkouts[indexPath.row] as AnyObject
        let workoutId = selectedWorkout.value(forKey: "id") as? Int
        if (editable) {
            
            // allows multiple selection for multiple favorite removals
            self.tableView.allowsMultipleSelection = true
            if !unfavorite.contains(workoutId!) {
                unfavorite.add(workoutId!)
            }
        } else {
            self.tableView.allowsMultipleSelection = false
            let workoutView = self.storyboard?.instantiateViewController(withIdentifier: "WorkoutView") as! WorkoutViewController
            workoutView.workoutTitle = selectedWorkout.value(forKey: "workout") as? String
            workoutView.workoutDescription = selectedWorkout.value(forKey: "desc") as? String
            workoutView.workoutTag = selectedWorkout.value(forKey: "tag") as? String
            workoutView.workoutId = workoutId
            workoutView.exercises = selectedWorkout.value(forKey: "exercises") as? NSArray
            
            self.navigationController?.pushViewController(workoutView, animated: true)
        }
    }
    
    // allows for functionality on deselection of cells
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let selectedWorkout = favoritedWorkouts[indexPath.row] as AnyObject
        let workoutId = selectedWorkout.value(forKey: "id") as? Int
        if (editable) {
            self.tableView.allowsMultipleSelection = true
            if unfavorite.contains(workoutId!) {
                unfavorite.remove(workoutId!)
            }
        } else {
            self.tableView.allowsMultipleSelection = false
        }
    }
    
}
