//
//  ViewController.swift
//  Instagram Clone
//
//  Created by lindongdong on 2017/9/3.
//  Copyright © 2017年 Ringo Lin. All rights reserved.
//

import UIKit
import Firebase
import FBSDKLoginKit

class LoginViewController: UIViewController {
   
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var accountTextField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var loginButton: RoundButton!
    @IBOutlet weak var pwdTextField: UITextField!
    @IBOutlet weak var userNameTextField: UITextField!
    override func viewDidLoad() {
        
        super.viewDidLoad()
    
       
       // fbLoginButton.delegate = self
        userNameTextField.addTarget(self, action: #selector(textChange), for: .editingChanged)
        pwdTextField.addTarget(self, action: #selector(textChange), for: .editingChanged)
      
    }
    @IBAction func fbButtonClicked(_ sender: Any) {
        
        fbButtonClick()
    }
    
    func fbButtonClick(){
        
        let fbLogin = FBSDKLoginManager()
       
        fbLogin.logIn(withReadPermissions: ["email", "public_profile", "user_friends"], from: self) { [unowned self] (result, error) in
            if let error = error {
                self.displayAlert(title: "Oops", message: error.localizedDescription)
            }else if (result?.isCancelled)!{
                print("Cancelled")
            }else{
                self.loginSuccess(result: result!)
                let tabBarVC = UIStoryboard(name: "TabBar", bundle: nil).instantiateViewController(withIdentifier: "TabBar") as! UITabBarController
                self.present(tabBarVC, animated: true, completion: {
                    UserDefaults.standard.setIsLogin(value: true)
                })
            }
        }
    }

    
    func loginSuccess(result:FBSDKLoginManagerLoginResult){
        
        guard let accessTokenString = FBSDKAccessToken.current().tokenString else {
            return
        }
        
        let credential =
            FacebookAuthProvider.credential(withAccessToken: accessTokenString)
        
        Auth.auth().signIn(with: credential) { [unowned self](user, error) in
            if let error = error {
               self.displayAlert(title: "Oops", message: error.localizedDescription)
                return
            }
        }
        
        FBSDKGraphRequest(graphPath: "/me", parameters: ["fields": "id, name, email"]).start(completionHandler: {[unowned self] (connection, result, error) in
            
            if let error = error {
                self.displayAlert(title: "Oops", message: error.localizedDescription)
            }
            else{
                print(result!)
            }
            
        })
        
    }
    

    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
       //
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
        
        if let email = accountTextField.text, let password = passwordTextField.text{
            
            AuthService().login(email: email, password: password, completion: {[unowned self] (error) in
                if let error = error {
                    self.displayAlert(title: "Oops", message: error.localizedDescription)
                    self.activityIndicator.stopAnimating()
                    self.loginButton.setTitle("登录", for: .normal)
                    return
                }
                let tabBarVC = UIStoryboard(name: "TabBar", bundle: nil).instantiateViewController(withIdentifier: "TabBar")
                self.present(tabBarVC, animated: true, completion: nil)
                
            })
            
        }
        
    }

    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
 
}

