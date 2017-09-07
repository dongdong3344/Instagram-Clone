//
//  ViewController.swift
//  Instagram Clone
//
//  Created by lindongdong on 2017/9/3.
//  Copyright © 2017年 Ringo Lin. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
   
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var loginButton: RoundButton!
    @IBOutlet weak var pwdTextField: UITextField!
    @IBOutlet weak var userNameTextField: UITextField!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
   
        userNameTextField.addTarget(self, action: #selector(textChange), for: .editingChanged)
        pwdTextField.addTarget(self, action: #selector(textChange), for: .editingChanged)
      
    }
    
    @objc func textChange(){
        
        if (userNameTextField.text!.isEmpty) || (pwdTextField.text!.isEmpty){
            loginButton.backgroundColor = UIColor(red: 135/255, green: 200/255, blue: 250/200, alpha: 1)
        }else{
            loginButton.backgroundColor = UIColor(red: 0, green: 143/255, blue: 255/200, alpha: 1)
        }
    }
    
    @IBAction func loginClick(_ sender: RoundButton) {
        loginButton.setTitle("", for: .normal)
        activityIndicator.startAnimating()
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
 
}

