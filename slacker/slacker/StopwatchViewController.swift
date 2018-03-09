//
//  StopwatchViewController.swift
//  slacker
//
//  Created by Kevin Tran on 3/8/18.
//  Copyright © 2018 ateamhasnoname. All rights reserved.
//

import UIKit

class StopwatchViewController: UIViewController {

    weak var timer: Timer?
    var startTime: Double = 0
    var time: Double = 0
    var elapsed: Double = 0
    var status: Bool = false


    @IBOutlet weak var minuteLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var millisecondLabel: UILabel!
    @IBOutlet weak var resetButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
    
        resetButton.isEnabled = false

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    
    }
    
    @IBAction func toggleStartStop(_ sender: UIButton!) {

        if (status) {
            stop()
            sender.setTitle("START", for: .normal)
            resetButton.isEnabled = true

        } else {
            start()
            sender.setTitle("STOP", for: .normal)
            resetButton.isEnabled = false
        }

    }
    
    @IBAction func resetStopwatch(_ sender: UIButton) {
        timer?.invalidate()
        
        startTime = 0
        time = 0
        elapsed = 0
        status = false
        
        let strReset = String("00")
        minuteLabel.text = strReset
        secondLabel.text = strReset
        millisecondLabel.text = strReset
    }

    func start() {

        startTime = Date().timeIntervalSinceReferenceDate - elapsed
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)

        status = true

    }

    func stop() {

        elapsed = Date().timeIntervalSinceReferenceDate - startTime
        timer?.invalidate()

        status = false

    }

    @objc func updateCounter() {

        time = Date().timeIntervalSinceReferenceDate - startTime

        let minutes = UInt8(time / 60.0)
        time -= (TimeInterval(minutes) * 60)

        let seconds = UInt8(time)
        time -= TimeInterval(seconds)

        let milliseconds = UInt8(time * 100)

        let strMinutes = String(format: "%02d", minutes)
        let strSeconds = String(format: "%02d", seconds)
        let strMilliseconds = String(format: "%02d", milliseconds)

        minuteLabel.text = strMinutes
        secondLabel.text = strSeconds
        millisecondLabel.text = strMilliseconds

    }
}

