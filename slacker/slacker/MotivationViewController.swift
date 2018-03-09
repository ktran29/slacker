//
//  MotivationViewController.swift
//  slacker
//
//  Created by Ben Nogawa on 3/6/18.
//  Copyright © 2018 ateamhasnoname. All rights reserved.
//

import UIKit

class MotivationViewController: UIViewController {

    var videos: [String] = ["ZXsQAXx_ao0", "LPD0z6K0VQY", "-sUKoKQlEC4", "", "EyhOmBPtGNM", "VZ2HcRl4wSk" ]
    
    //closes the popup
    @IBAction func closePopUp(_ sender: Any) {
        self.view.removeFromSuperview()
    }
    
    @IBOutlet var myWebView: UIWebView!
    
    func getVideo(videoCode:String)
    {
            myWebView.allowsInlineMediaPlayback = true
        
            myWebView.loadHTMLString("<iframe width=\"\(myWebView.frame.width)\" height=\"\(myWebView.frame.height)\" src=\"https://www.youtube.com/embed/\(videoCode)?&playsinline=1\" frameborder=\"0\" allow=\"autoplay; encrypted-media\" allowfullscreen></iframe>", baseURL: nil)
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
