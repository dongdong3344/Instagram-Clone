//
//  PickImageViewController.swift
//  Instagram Clone
//
//  Created by lindongdong on 2017/9/7.
//  Copyright © 2017年 Ringo Lin. All rights reserved.
//

import UIKit
import Firebase
import Fusuma


class PickImageViewController: UIViewController,FusumaDelegate {
   
    var name:      String?
    var email:     String?
    var password:  String?

    @IBOutlet weak var profileImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileImageView.layer.cornerRadius = profileImageView.frame.size.width / 2
        
        profileImageView.layer.masksToBounds = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(selectProfileImage))
        profileImageView.addGestureRecognizer(tapGesture)
        
        name  = UserDefaults.standard.getName()
        email = UserDefaults.standard.getEmail()
        password = UserDefaults.standard.getPassword()
    
       // print(name!,email!,password!)
 
    }
    
    @IBAction func registerButtonClick(_ sender: UIButton) {
        
        handleRegister()
        
    }
    
    @objc func selectProfileImage(){
        
        let attributedString = NSAttributedString(string: "添加头像", attributes: [
            NSFontAttributeName : UIFont.systemFont(ofSize: 18),
            NSForegroundColorAttributeName:UIColor.black])
      
        let alert:UIAlertController = UIAlertController(title: "", message:nil, preferredStyle: .actionSheet)
         alert.setValue(attributedString, forKey: "attributedTitle")
        
        let fbAction = UIAlertAction(title: "从Facebook导入", style: .default, handler: nil)
        let twAction = UIAlertAction(title: "从Twitter导入", style: .default, handler: nil)
        let cameraAction  =  UIAlertAction(title: "拍照", style: .default) { (action) in
            let picker = FusumaViewController()
            picker.delegate = self
            self.present(picker, animated: true, completion: nil)
        }
        
        let albumAction = UIAlertAction(title: "从相册中选择", style: .default) { (action) in
            //
        }
        
        let cancel = UIAlertAction(title: "取消", style: .cancel, handler: nil)
   
        alert.addAction(fbAction)
        alert.addAction(twAction)
        alert.addAction(cameraAction)
        alert.addAction(albumAction)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
        
        
    }
    
    
    func fusumaImageSelected(_ image: UIImage, source: FusumaMode) {
        
        profileImageView.image = image
        
    }
    
    func fusumaMultipleImageSelected(_ images: [UIImage], source: FusumaMode) {
        
    }
    
    func fusumaVideoCompleted(withFileURL fileURL: URL) {
        
    }
    
    func fusumaCameraRollUnauthorized() {
        
    }
    

    func handleRegister(){
        
        guard let name = name,let email = email,let password = password,let profileImage = profileImageView.image else {
            return
        }
      
        AuthService().register(name: name, email: email, password: password, profileImage: profileImage) {[unowned self] (error) in
            if let error = error {
                self.displayAlert(title: "Oops", message: error)
                return
            }
            let tabBarVC = UIStoryboard(name: "TabBar", bundle: nil).instantiateViewController(withIdentifier: "TabBar")
            self.present(tabBarVC, animated: true, completion: nil)
        }
        
    }
  
}
