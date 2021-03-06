//
//  RegisterViewController.swift
//  Instagram Clone
//
//  Created by lindongdong on 2017/9/5.
//  Copyright © 2017年 Ringo Lin. All rights reserved.
//

import UIKit
import Firebase


class RegisterViewController: UIViewController {
 
    @IBOutlet weak var lineLeftConstraint: NSLayoutConstraint!
    @IBOutlet weak var bgViewLeftConstraint: NSLayoutConstraint!
    @IBOutlet weak var codeButton: UIButton!
    @IBOutlet weak var mailButton: UIButton!
    @IBOutlet weak var phoneButton:UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var emailNextButton: UIButton!
    @IBOutlet weak var phoneNextButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var lastSelectedButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        phoneButton.isSelected = true
        phoneButton.isUserInteractionEnabled = false

        lastSelectedButton = phoneButton
        
        phoneNumberTextField.addTarget(self, action: #selector(textChange), for: .editingChanged)

    }

    
    @IBAction func phoneNextClick(_ sender: Any) {
        
        guard let phone = phoneNumberTextField.text,let countryCode = codeButton.currentTitle?.components(separatedBy: " ").last else { return }
    
        let phoneNumber = countryCode + phone
        
       // print(phoneNumber)

        phoneNextButton.setTitle("", for: .normal)
        activityIndicator.startAnimating()
        
        AuthService().getVerificationID(phoneNumber: phoneNumber) { (error) in
           if let error = error{
                self.displayAlert(title: "Oops!", message: error)
                self.phoneNextButton.setTitle("下一步", for: .normal)
                self.activityIndicator.stopAnimating()
                return
            }
             UserDefaults.standard.savePhoneNumber(value: phoneNumber)
             self.performSegue(withIdentifier: "ToCodeVerifyVC", sender: self)
        }
   
    }
   
    @IBAction func codeButtonClick(_ sender: Any) {
        
      
    }
 

    
    @IBAction func nextButtonClick(_ sender: Any) {
        
        if let email = emailTextField.text{
            UserDefaults.standard.saveEmail(value: email)
        }
    }
    
    
        
    @IBAction func buttonClick(_ sender: UIButton) {
        
        sender.isSelected = !sender.isSelected
        sender.isUserInteractionEnabled = !sender.isSelected
        sender.setTitleColor(UIColor.black, for: .normal)
        lastSelectedButton.isSelected = false
        lastSelectedButton.isUserInteractionEnabled = true
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
    

    
    func textChange(){
        
        if phoneNumberTextField.text!.isEmpty{
            phoneNextButton.backgroundColor = UIColor.babyBlue()
        }else{
            phoneNextButton.backgroundColor = UIColor.deepBlue()
        }
        
    }
   
}
