//
//  RegisterViewController.swift
//  Instagram Clone
//
//  Created by lindongdong on 2017/9/5.
//  Copyright © 2017年 Ringo Lin. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
 
    @IBOutlet weak var lineLeftConstraint: NSLayoutConstraint!
    @IBOutlet weak var bgViewLeftConstraint: NSLayoutConstraint!
    @IBOutlet weak var codeButton: UIButton!
    @IBOutlet weak var mailButton: UIButton!
    @IBOutlet weak var phoneButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    
    var lastSelectedButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        phoneButton.isSelected = true

        lastSelectedButton = phoneButton
       
    }

    @IBAction func buttonClick(_ sender: UIButton) {
        
        sender.isSelected = !sender.isSelected
        sender.setTitleColor(UIColor.black, for: .normal)
        lastSelectedButton.isSelected = false
        lastSelectedButton.setTitleColor(UIColor.lightGray, for: .normal)
        lastSelectedButton = sender
        //改变约束
        lineLeftConstraint.constant = sender.frame.origin.x + 20
        phoneButton.isSelected ? (bgViewLeftConstraint.constant = 0):(bgViewLeftConstraint.constant = -view.frame.size.width)
        
        //动画效果
        UIView.animate(withDuration: 0.25) {
            self.view.layoutIfNeeded()
        }
     
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
        if let title = UserDefaults.standard.object(forKey: "CodeButtonTitle") as? String {
            codeButton.setTitle(title, for: .normal)
        }
    }
   
}
