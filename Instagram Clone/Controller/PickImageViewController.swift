//
//  PickImageViewController.swift
//  Instagram Clone
//
//  Created by lindongdong on 2017/9/7.
//  Copyright © 2017年 Ringo Lin. All rights reserved.
//

import UIKit
import Firebase

class PickImageViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        var selectedImage: UIImage?
        
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            selectedImage = editedImage
        } else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            
            selectedImage = originalImage
        }
        
        if let image = selectedImage {
            profileImageView.image = image
        }
        
        dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
       
        dismiss(animated: true, completion: nil)
    }
    
    @objc func selectProfileImage(){
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
        
    }
    
    func handleRegister(){
        guard let name = name,let email = email,let password = password else { return }
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if error != nil{
                self.presentErrorMessage(error!.localizedDescription)
            }
            guard let uid = user?.uid else { return }
            let imageName = UUID().uuidString
            let storageRef = Storage.storage().reference().child("ProfileImages").child("\(imageName).jpg")
            if let profileImage = self.profileImageView.image, let uploadData = UIImageJPEGRepresentation(profileImage, 0.1) {
                
                storageRef.putData(uploadData, metadata: nil, completion: { (metadata, error) in
                    if error != nil{
                       self.presentErrorMessage(error!.localizedDescription)
                       return
                    }
                    if let profileImageURL = metadata?.downloadURL()?.absoluteString{
                        
                      //  print(profileImageURL)
                        
                        let values = ["name":name, "email": email, "profileImageURL": profileImageURL]
                        
                        self.registerUserIntoDatabaseWithUID(uid, values: values as [String : AnyObject])
                        
                      
                    }
                })
                
            }
        }
        
    }
    
    func registerUserIntoDatabaseWithUID(_ uid: String, values: [String: AnyObject]) {
        
        let databaseRef = Database.database().reference().child("Users").child(uid)
        
       databaseRef.updateChildValues(values, withCompletionBlock: { (error, ref) in
            
            if error != nil {
               print("———————————出错啦——————————")
               self.presentErrorMessage(error!.localizedDescription)
               return
            }
            
            print("——————————成功啦——————————————")
            let tabBarVC = UIStoryboard(name: "TabBar", bundle: nil).instantiateViewController(withIdentifier: "TabBar") as! UITabBarController
            self.present(tabBarVC, animated: true, completion: {
            UserDefaults.standard.setIsLogin(value: true)
                
            })
        })
    }
    
    func presentErrorMessage(_ message:String){
        
        let alert = UIAlertController(title: "Oops", message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "我知道了", style: .cancel, handler: nil)
        alert.addAction(alertAction)
        present(alert, animated: true, completion: nil)
    }

}
