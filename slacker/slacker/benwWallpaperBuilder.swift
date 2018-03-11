//
//  benwWallpaperBuilder.swift
//  slacker
//
//  Created by Benjamin Walchenbach on 3/11/18.
//  Copyright © 2018 ateamhasnoname. All rights reserved.
//

import Foundation
import UIKit
extension UIView {
    
    // Add default wallpaper
    func addBackground() {
        addBackground("boxingEdited3.jpg")
    }
    
    // use specific wallpaper
    func addBackground(_ imageName: String) {
        print("Adding wallpaper from Ben W's wallpaper class.")
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        
        let imageViewBackground = UIImageView(frame: CGRect(x:0, y:0, width: width, height: height))
        imageViewBackground.image = UIImage(named: imageName)
        
        // you can change the content mode:
        imageViewBackground.contentMode = UIViewContentMode.scaleAspectFill
        
        
        addSubview(imageViewBackground)
        sendSubview(toBack: imageViewBackground)
    }
}
