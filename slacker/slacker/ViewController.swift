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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "workoutCell", for: indexPath) as! TableViewCell
        cell.workoutTitle.text = "Curls"
        cell.workoutDescription.text = "Let's do some curls, maybe like 30 for about half an hour and get some big gains #workoutpowder"
        
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

