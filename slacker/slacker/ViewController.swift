//
//  ViewController.swift
//  slacker
//
//  Created by Kevin Tran on 2/28/18.
//  Copyright © 2018 ateamhasnoname. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    @IBOutlet weak var tableView: UITableView!
    
    var ALL_WORKOUTS: NSArrayI = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        
        //        getJsonFromUrl()
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
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "workoutCell", for: indexPath) as! TableViewCell
        cell.workoutTitle.text = "Curls"
        cell.workoutDescription.text = "Let's do some curls, maybe like 30 for about half an hour and get some big gains #workoutpowder"
        
        return cell
    }
    
    //cell was clicked on
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let workoutIndex = indexPath
        //        let workoutName = appdata.quizzes[indexPath.row][0]
        //        print("We Selected: \(categoryName)")
        //        currentCategory = categoryName
        
        //        performSegue(withIdentifier: "segueToQuestions", sender: nil)
    }
    
    
    
    
    
    
    
    
    // ______________ DOWNLOAD JSON ______________
    
    func downloadData() -> Void {
        
        //you only want to do this if appData content is empty
        //            NSURL(string: "https://tednewardsandbox.site44.com/questions.json")
        let urlString = URL(string: "https://con4man.github.io/SlackerJSON/slacker.json")
        
        if urlString == nil {
            notifyUser("The URL is wrong.")
            return;
        }
        UserDefaults.standard.set(nil, forKey: "URL")
        
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
                        jsonData = (try JSONSerialization.jsonObject(with: data!, options: []) as? NSArray)!
                        do {
                            try jsonData.write(to: path)
                        } catch {
                            if content != nil {
                                jsonData = NSArray(contentsOf: path)!
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
            
            
            // ---- Filtering JSON file into an Appdata object
            
            let data = jsonData // DATA IS OF TYPE NSArrayI
            //                    print(data)
            print(type(of: data))
            print(data[0])
            
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
                //                        UserDefaults.standard.set(self.appdata.quizzes, forKey: "quizzes")
                //                        UserDefaults.standard.set(self.appdata.quizQuestions, forKey: "quizQuestions")
            }
            session.invalidateAndCancel()
        }
        
        task.resume()
    }//end func
    
    
    
    // ______________ useless ______________
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

