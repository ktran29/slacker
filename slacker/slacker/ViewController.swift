//
//  ViewController.swift
//  slacker
//
//  Created by Kevin Tran on 2/28/18.
//  Copyright © 2018 ateamhasnoname. All rights reserved.
//


/*
 ----------------------- DOCUMENTATION -----------------------
 
 
 How to retrieve value in the dictionary:
 let result = (first_spot as AnyObject).value(forKey: "desc")

 
 */



import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var CATEGORIES: [String] = ["Regular", "Cardio", "HIIT"]
    var ALL_WORKOUTS: NSArray = []
    var CATEGORIZED_WORKOUTS: [[AnyObject]] = [[], [], []]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Workouts"
        self.tableView.separatorStyle = .none
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        tableView.rowHeight = 68
        
        let userDefaults = UserDefaults.standard
        
        if userDefaults.object(forKey: "favorites") == nil {
            userDefaults.set(NSMutableArray(), forKey: "favorites")
            userDefaults.synchronize()
        }
        
        downloadData()
    }
    
    
    
    
    
    // ______________ HELPER METHODS ______________
    func notifyUser(_ message : String) {
        let alert = UIAlertController(title: "Notification",
                                      message: message,
                                      preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    
    
    
    
    
    
    
    // ______________ TABLE ______________
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        print("here \(section)")
//        print("workout \(self.CATEGORIZED_WORKOUTS[section])")
        return self.CATEGORIZED_WORKOUTS[section].count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.CATEGORIES[section]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.CATEGORIES.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "workoutCell", for: indexPath) as! TableViewCell
//        cell.layer.cornerRadius = 7
//        cell.backgroundColor = UIColor.cyan

        
        if self.ALL_WORKOUTS.count > 0 {
            let workout_category = self.CATEGORIZED_WORKOUTS[indexPath.section][indexPath.row]
            cell.workoutTitle.text =  (workout_category as AnyObject).value(forKey: "workout") as? String
            cell.workoutDescription.text =  (workout_category as AnyObject).value(forKey: "desc") as? String
            return cell
            
        }
        // the stuff below is in case ALL_WORKOUTS fails to be initialized and we need a placeholder.
        // fingers crossed we won't ever have to get here.
        cell.workoutTitle.text = "Error"
        cell.workoutDescription.text = "It looks like your tableView function thinks that ALL_WORKOUTS is empty. - Ben W"
        return cell
    }
    
    //cell was clicked on
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let workoutView = self.storyboard?.instantiateViewController(withIdentifier: "WorkoutView") as! WorkoutViewController
        let selectedWorkout = CATEGORIZED_WORKOUTS[indexPath.section][indexPath.row] as AnyObject
        workoutView.workoutTitle = selectedWorkout.value(forKey: "workout") as? String
        workoutView.workoutDescription = selectedWorkout.value(forKey: "desc") as? String
        workoutView.workoutTag = selectedWorkout.value(forKey: "tag") as? String
        workoutView.workoutId = selectedWorkout.value(forKey: "id") as? Int
        workoutView.exercises = selectedWorkout.value(forKey: "exercises") as? NSArray
        
        self.navigationController?.pushViewController(workoutView, animated: true)
    }
    
    
    
    
    
    
    
    
    // ______________ DOWNLOAD JSON ______________
    
    // downdloadData helper method.
    // initializes all workouts with the downloaded json data.
    // separates workouts into groups
    func initializeAllWorkouts(_  jsonData:NSArray) {
        self.ALL_WORKOUTS = jsonData
        
        for index in 0...self.ALL_WORKOUTS.count - 1 {
            let workout = ALL_WORKOUTS[index] as AnyObject
            let workoutTag = workout.value(forKey: "tag") as! String
            switch workoutTag {
            case "regular":
                self.CATEGORIZED_WORKOUTS[0].append(workout)
            case "cardio":
                self.CATEGORIZED_WORKOUTS[1].append(workout)
            case "hiit":
                self.CATEGORIZED_WORKOUTS[2].append(workout)
            default:
                print("Invalid workout")
            }
        }
    }
    
    // Downloads, parses, and setsup all workout data from our website.
    func downloadData() -> Void {
        let urlString = URL(string: "https://con4man.github.io/SlackerJSON/slacker.json")
        if urlString == nil {
            notifyUser("The URL is wrong.")
            return;
        }
        let config = URLSessionConfiguration.default
        let session = URLSession.init(configuration: config, delegate: nil, delegateQueue: OperationQueue.current)
        let task = session.dataTask(with: urlString!) { (data, response, error) in
            var jsonData : NSArray = []
            let fileManager = FileManager.default
            let path = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("questions.json")
            let content = NSData(contentsOf: path)
            if let response = response as? HTTPURLResponse {
                if response.statusCode == 200 {
                    do {
                        jsonData  = (try JSONSerialization.jsonObject(with: data!, options: []) as? NSArray)!
                        do {
                            try jsonData.write(to: path)
                        } catch {
                            if content != nil {
                                jsonData  = NSArray(contentsOf: path)!
                            }
                        }
                    } catch {
                        self.notifyUser("Unable to write to file")
                    }
                } else {
                    if let error = error {
                        self.notifyUser(error.localizedDescription)
                    } else {
                        self.notifyUser("Request not successful. Status code: \(response.statusCode)")
                    }
                }
            } else if let error = error {
                self.notifyUser(error.localizedDescription)
            }
            DispatchQueue.main.async {
                self.initializeAllWorkouts(jsonData)
                self.tableView.reloadData()
            }
            session.invalidateAndCancel()
        }
        task.resume()
    }//end func
    
    
    
    
    
    
    // ______________ useless ______________
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
