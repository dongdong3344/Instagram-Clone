//
//  Extension.swift
//  Instagram Clone
//
//  Created by lindongdong on 2017/9/10.
//  Copyright © 2017年 Ringo Lin. All rights reserved.
//

import UIKit


extension UIBarButtonItem {
    
   static func itemWithImage(_ image:UIImage,action:Selector) -> UIBarButtonItem{
        
        let itemButton = UIButton(type: .custom)
        itemButton.setImage(image, for: [])
        itemButton.tintColor = UIColor.black
        itemButton.addTarget(self, action: action, for: .touchUpInside)
        itemButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        return UIBarButtonItem(customView: itemButton)
        
    }
}
