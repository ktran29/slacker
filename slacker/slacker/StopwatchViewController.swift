//
//  StopwatchViewController.swift
//  slacker
//
//  Created by Kevin Tran on 3/8/18.
//  Copyright © 2018 ateamhasnoname. All rights reserved.
//

import UIKit

class StopwatchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    weak var timer: Timer?
    weak var lapTimer: Timer?
    var startTime: Double = 0
    var time: Double = 0
    var elapsed: Double = 0
    var status: Bool = false
    var lapTimes: [String] = []
    var lapElapsed: Double = 0
    var lapTime: Double = 0
    var lapStartTime: Double = 0


    @IBOutlet weak var minuteLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var millisecondLabel: UILabel!
    @IBOutlet weak var stopResumeBtn: UIButton!
    @IBOutlet weak var lapResetBtn: UIButton!
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var lapTimerView: UIStackView!
    
    @IBOutlet weak var lapMinuteLabel: UILabel!
    @IBOutlet weak var lapSecondLabel: UILabel!
    @IBOutlet weak var lapMillisecondLabel: UILabel!
    
    
    @IBOutlet weak var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        startBtn.isHidden = false
        stopResumeBtn.isHidden = true
        lapResetBtn.isHidden = true
        lapTimerView.isHidden = true

    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    
    }
    
    @IBAction func startStopWatch(_ sender: UIButton) {
        startBtn.isHidden = true
        stopResumeBtn.isHidden = false
        lapResetBtn.isHidden = false
        start()
    }
    
    @IBAction func stopResume(_ sender: UIButton) {
        if status {
            stop()
        } else {
            start()
        }
    }
    
    @IBAction func lapReset(_ sender: UIButton) {
        if status {
            lap()
        } else {
            reset()
        }
    }
    
    func stop() {
        elapsed = Date().timeIntervalSinceReferenceDate - startTime
        timer?.invalidate()
        lapTimer?.invalidate()
        status = false
        
        self.stopResumeBtn.setTitle("RESUME", for: .normal)
        self.lapResetBtn.setTitle("RESET", for: .normal)
    }
    
    func start() {
        startTime = Date().timeIntervalSinceReferenceDate - elapsed
        lapStartTime = Date().timeIntervalSinceReferenceDate - lapElapsed
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
        lapTimer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(updateLapCounter), userInfo: nil, repeats: true)
        status = true
        
        self.stopResumeBtn.setTitle("STOP", for: .normal)
        self.lapResetBtn.setTitle("LAP", for: .normal)
    }
    
    func lap() {
        lapTimerView.isHidden = false
        lapStartTime = Date().timeIntervalSinceReferenceDate - lapElapsed
        lapTimer?.invalidate()
        lapTimer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(updateLapCounter), userInfo: nil, repeats: true)
        lapElapsed = 0
        let t = getTime(lapTime, lapStartTime)
        lapTimes.append("\(t.0):\(t.1):\(t.2)")
        self.viewWillAppear(false)
    }
    
    func reset() {
        timer?.invalidate()
        lapTimer?.invalidate()
        
        startTime = 0
        time = 0
        elapsed = 0
        status = false
        lapElapsed = 0
        lapTimes = []
        
        let strReset = String("00")
        minuteLabel.text = strReset
        secondLabel.text = strReset
        millisecondLabel.text = strReset
        
        self.viewDidLoad()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(section)
        print(lapTimes.count)
        return lapTimes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("here2")
        let cell = tableView.dequeueReusableCell(withIdentifier: "stopwatchCell", for: indexPath) as! StopwatchTableViewCell
        let lapTime = lapTimes[indexPath.row]
        
        cell.lapNumber.text = "\(indexPath.row)"
        cell.lapTime.text = "\(lapTime)"
        
        let t = getTime(time, startTime)
        
        cell.overallTime.text = "\(t.0):\(t.1):\(t.2)"
        
        return cell
    }

    @objc func updateCounter() {
        let t = getTime(time, startTime)

        minuteLabel.text = t.0
        secondLabel.text = t.1
        millisecondLabel.text = t.2

    }
    
    @objc func updateLapCounter() {
        let t = getTime(lapTime, lapStartTime)
        
        lapMinuteLabel.text = t.0
        lapSecondLabel.text = t.1
        lapMillisecondLabel.text = t.2
        
    }
    
    func getTime(_ givenTime: Double, _ givenStartTime: Double) -> (String, String, String) {
        var givenTime = Date().timeIntervalSinceReferenceDate - givenStartTime
        
        let minutes = UInt8(givenTime / 60.0)
        givenTime -= (TimeInterval(minutes) * 60)
        
        let seconds = UInt8(givenTime)
        givenTime -= TimeInterval(seconds)
        
        let milliseconds = UInt8(givenTime * 100)
        
        let strMinutes = String(format: "%02d", minutes)
        let strSeconds = String(format: "%02d", seconds)
        let strMilliseconds = String(format: "%02d", milliseconds)
        
        return (strMinutes, strSeconds, strMilliseconds)
    }
}

