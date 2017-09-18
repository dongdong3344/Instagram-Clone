//
//  AuthServices.swift
//  Instagram Clone
//
//  Created by lindongdong on 2017/9/13.
//  Copyright © 2017年 Ringo Lin. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

protocol AuthServiceProtocol {
    
    func login(email: String, password: String, completion: @escaping (_ error: String?) -> Void)
    
    func register(name: String, email: String, password: String, profileImage: UIImage, completion: @escaping (_ error: String?) -> Void)
    
    static func currentUserId() -> String!
    
    static func isUserLogIn() -> Bool
}

struct AuthService:AuthServiceProtocol {
   
    static fileprivate let currentUserIdKey = "currentUserId"
    static fileprivate let isLogInKey = "isLogIn"
    
    let auth: Auth?
    let database: Database
    let storage: Storage
    
    init() {
        auth     = Auth.auth()
        database = Database.database()
        storage  = Storage.storage()
    }
    
    func login (email: String, password: String, completion: @escaping (String?) -> Void) {
        
        auth?.signIn(withEmail: email, password: password, completion: { (user, error) in
            if let error = error {
                completion(error.localizedDescription)
                return
            }
            guard let user = user else {
                completion("An unexpect error ocurred, please try again.")
                return
            }
            self.setDefaultsWithUser(user)
            completion(nil)
            
        })
        
    }
    
   func register(name: String, email: String, password: String, profileImage:UIImage, completion: @escaping (String?) -> Void) {
        
      
        auth?.createUser(withEmail: email, password: password, completion: { (user, error) in
            if let error = error{
                completion(error.localizedDescription)
                print(error.localizedDescription)
                return
            }
            guard let user = user else {
                completion("An unexpect error ocurred, please try again.")
                return
            }
            let imageName  = UUID().uuidString
            let storgeRef  = self.storage.reference().child("Users").child("ProfileImages").child("\(imageName).jpg")
            
            if let profileImageData = UIImageJPEGRepresentation(profileImage, 0.1) {
                storgeRef.putData(profileImageData, metadata: nil, completion: { (metadata, error) in
                    if let error = error{
                        completion(error.localizedDescription)
                        return
                    }
                    if let profileImageURL = metadata?.downloadURL()?.absoluteString{
                        let values = ["name":name, "email": email, "profileImageURL": profileImageURL]
                        Router.user(id: user.uid).reference.updateChildValues(values)
                        self.setDefaultsWithUser(user)
                        completion(nil)
                    }
                })
            }
       
        })
        
    }
    
    static func currentUserId() -> String! {
        
        return UserDefaults.standard.string(forKey: currentUserIdKey)
        
    }
    
    static func isUserLogIn() -> Bool {
        return UserDefaults.standard.bool(forKey: isLogInKey)
        
    }
    
  fileprivate func setDefaultsWithUser(_ user:User){
        
    UserDefaults.standard.set(user.uid, forKey: AuthService.currentUserIdKey)
    UserDefaults.standard.set(true, forKey: AuthService.isLogInKey)
    UserDefaults.standard.synchronize()
  
    }
    
}
