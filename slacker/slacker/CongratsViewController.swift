//
//  CongratsViewController.swift
//  slacker
//
//  Created by Benjamin Walchenbach on 3/3/18.
//  Copyright © 2018 ateamhasnoname. All rights reserved.
//

import UIKit

class CongratsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = ""
        view.addBackground("WORKOUT.jpg")
        
        let myBackButton:UIButton = UIButton(type: UIButtonType.custom) as UIButton
        myBackButton.addTarget(self, action: #selector(popToRoot), for: UIControlEvents.touchUpInside)
        myBackButton.setTitle("Back", for: .normal)
        myBackButton.setTitleColor(UIColor.blue, for: .normal)
        myBackButton.sizeToFit()
        let myCustomBackButtonItem:UIBarButtonItem = UIBarButtonItem(customView: myBackButton)
        self.navigationItem.leftBarButtonItem  = myCustomBackButtonItem
    }
    
    @objc func popToRoot(sender:UIBarButtonItem){
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}
