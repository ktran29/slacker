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
    var lapTimes: [(String,String)] = []
    var lapElapsed: Double = 0
    var lapTime: Double = 0
    var lapStartTime: Double = 0

    @IBOutlet weak var stopResumeBtn: UIButton!
    @IBOutlet weak var lapResetBtn: UIButton!
    @IBOutlet weak var startBtn: UIButton!
    
    @IBOutlet weak var minuteLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var millisecondLabel: UILabel!
    
    @IBOutlet weak var lapTimerView: UIStackView!
    @IBOutlet weak var lapMinuteLabel: UILabel!
    @IBOutlet weak var lapSecondLabel: UILabel!
    @IBOutlet weak var lapMillisecondLabel: UILabel!
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.rowHeight = 68
        self.tableView.separatorStyle = .none
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
        
        // automatically scrolls to the newest lap time
        if lapTimes.count > 0 {
            let indexPath = NSIndexPath(row: lapTimes.count - 1, section: 0)
            self.tableView.scrollToRow(at: indexPath as IndexPath, at: UITableViewScrollPosition.bottom, animated: true)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    
    }
    
    @IBAction func startStopWatch(_ sender: UIButton) {
        
        UIView.animate(withDuration: 0.3, animations: {
            self.startBtn.alpha = 0
        }, completion:  {
            (value: Bool) in
            self.startBtn.isHidden = true
        })
        
        stopResumeBtn.isHidden = false
        lapResetBtn.isHidden = false
        
        UIView.animate(withDuration: 0.3, animations: {
            self.stopResumeBtn.alpha = 1
        }, completion:  nil)
        UIView.animate(withDuration: 0.3, animations: {
            self.lapResetBtn.alpha = 1
        }, completion:  nil)
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
        let st = getTime(time, startTime)
        let lt = getTime(lapTime, lapStartTime)
        lapTimerView.isHidden = false
        lapStartTime = Date().timeIntervalSinceReferenceDate - lapElapsed
        lapTimer?.invalidate()
        lapTimer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(updateLapCounter), userInfo: nil, repeats: true)
        lapElapsed = 0
        lapTimes.append(("\(st.0):\(st.1):\(st.2)", "\(lt.0):\(lt.1):\(lt.2)"))
        self.viewWillAppear(false)
    }
    
    // resets the stopwatch
    func reset() {
        timer?.invalidate()
        lapTimer?.invalidate()
        
        startTime = 0
        time = 0
        elapsed = 0
        status = false
        lapElapsed = 0
        lapTimes = []
        
        minuteLabel.text = "00"
        secondLabel.text = "00"
        millisecondLabel.text = "00"
        
        startBtn.isHidden = false
        stopResumeBtn.isHidden = true
        lapResetBtn.isHidden = true
        lapTimerView.isHidden = true
        
        UIView.animate(withDuration: 0.3, animations: {
            self.startBtn.alpha = 1
        }, completion:  nil)
        
        self.stopResumeBtn.setTitle("STOP", for: .normal)
        self.lapResetBtn.setTitle("LAP", for: .normal)
        
        self.tableView.reloadData()
        self.viewDidLoad()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lapTimes.count
    }
    
    // updates the lap log with current lap, running time, and lap time
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stopwatchCell", for: indexPath) as! StopwatchTableViewCell
        let lapTime = lapTimes[indexPath.row]
        
        cell.lapNumber.text = "\(indexPath.row + 1)"
        cell.overallTime.text = "\(lapTime.0)"
        cell.lapTime.text = "\(lapTime.1)"
        
        return cell
    }

    // updates the main time
    @objc func updateCounter() {
        let t = getTime(time, startTime)

        minuteLabel.text = t.0
        secondLabel.text = t.1
        millisecondLabel.text = t.2

    }
    
    // updates the lap time
    @objc func updateLapCounter() {
        let t = getTime(lapTime, lapStartTime)
        
        lapMinuteLabel.text = t.0
        lapSecondLabel.text = t.1
        lapMillisecondLabel.text = t.2
        
    }
    
    // converts double to a readable time
    func getTime(_ givenTime: Double, _ givenStartTime: Double) -> (String, String, String) {
        var givenTime = Date().timeIntervalSinceReferenceDate - givenStartTime
        
        let minutes = UInt8(givenTime / 60.0)
        givenTime -= (TimeInterval(minutes) * 60)
        
        let seconds = UInt8(givenTime)
        givenTime -= TimeInterval(seconds)
        
        let milliseconds = UInt8(givenTime * 100)
        
        let strMinutes = minutes < UInt8(10.0) ? String(format: "%02d", minutes) : "\(minutes)"
        let strSeconds = String(format: "%02d", seconds)
        let strMilliseconds = String(format: "%02d", milliseconds)
        
        return (strMinutes, strSeconds, strMilliseconds)
    }
}

