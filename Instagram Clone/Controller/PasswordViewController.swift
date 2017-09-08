//
//  PasswordViewController.swift
//  Instagram Clone
//
//  Created by lindongdong on 2017/9/7.
//  Copyright © 2017年 Ringo Lin. All rights reserved.
//

import UIKit

class PasswordViewController: UIViewController {

    @IBOutlet weak var nextButton: RoundButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var fullNameTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

    
    }

    
    @IBAction func nextButtonClick(_ sender: Any) {
        if let password = passwordTextField.text ,let name = fullNameTextField.text{
            
             UserDefaults.standard.savePassword(value: password)
             UserDefaults.standard.saveName(value: name)
            
        }
    }
    
}
