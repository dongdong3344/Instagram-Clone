//
//  ViewController.swift
//  Instagram Clone
//
//  Created by lindongdong on 2017/9/3.
//  Copyright © 2017年 Ringo Lin. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MobileCode.getMobileCodes { (mobileCodes) in
            print("数量: \(mobileCodes.count)")
        }
    
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
 
}

