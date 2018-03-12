//
//  MotivationViewController.swift
//  slacker
//
//  Created by Ben Nogawa on 3/6/18.
//  Copyright © 2018 ateamhasnoname. All rights reserved.
//

import UIKit

class MotivationViewController: UIViewController {
    
    //array containing the video identifier for each video
    var videos: [String] = ["ZXsQAXx_ao0", "1H_fL_IFUgw", "-sUKoKQlEC4", "oSDhhZtRwFU", "EyhOmBPtGNM", "VZ2HcRl4wSk" ]
    
    //closes the popup and stops the video
    @IBAction func closePopUp(_ sender: Any) {
        self.view.removeFromSuperview()
    }
    
    //the webview which plays the video
    @IBOutlet var myWebView: UIWebView!
    
    func getVideo(videoCode:String)
    {
            //alows the video to play without entering the video player
            myWebView.allowsInlineMediaPlayback = true
        
            
            //loads the video in the popup
            myWebView.loadHTMLString("<iframe width=\"\(myWebView.frame.width)\" height=\"\(myWebView.frame.height)\" src=\"https://www.youtube.com/embed/\(videoCode)?&playsinline=1\" frameborder=\"0\" allow=\"autoplay; encrypted-media\" allowfullscreen></iframe>", baseURL: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.gray.withAlphaComponent(0.7) //dims the background
        
        getVideo(videoCode: videos[Int(arc4random_uniform(6))]) //picks random video from the video array
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
