//
//  MotivationViewController.swift
//  slacker
//
//  Created by Ben Nogawa on 3/6/18.
//  Copyright © 2018 ateamhasnoname. All rights reserved.
//

import UIKit

class MotivationViewController: UIViewController {

   
    @IBAction func closePopUp(_ sender: Any) {
        self.view.removeFromSuperview()
    }
    
    
    @IBOutlet weak var myWebView: UIWebView!
    
    func getVideo(videoCode:String)
    {
        let url = URL(string:"https://www.youtube.com/embed/\(videoCode)")
        myWebView.loadRequest(URLRequest(url: url!))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.gray.withAlphaComponent(0.7)
        
        getVideo(videoCode: "ZXsQAXx_ao0")
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
