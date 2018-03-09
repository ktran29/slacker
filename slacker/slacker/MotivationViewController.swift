//
//  MotivationViewController.swift
//  slacker
//
//  Created by Ben Nogawa on 3/6/18.
//  Copyright © 2018 ateamhasnoname. All rights reserved.
//

import UIKit

class MotivationViewController: UIViewController {

    var videos: [String] = ["ZXsQAXx_ao0", "LPD0z6K0VQY", "-sUKoKQlEC4", "R1JBQMXbN2k", "EyhOmBPtGNM", "mgmVOuLgFB0" ]
    
    //closes the popup
    @IBAction func closePopUp(_ sender: Any) {
        self.view.removeFromSuperview()
    }
    
    
    @IBOutlet weak var myWebView: UIWebView!
    
    
    func getVideo(videoCode:String)
    {
        guard
            let url = URL(string:"https://www.youtube.com/embed/\(videoCode)")
            else { return }
        myWebView.loadRequest( URLRequest(url: url))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.gray.withAlphaComponent(0.7)
        
        getVideo(videoCode: videos[Int(arc4random_uniform(6))]) //loads random video from videos array
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
