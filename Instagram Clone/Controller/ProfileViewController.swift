//
//  ProfileViewController.swift
//  Instagram Clone
//
//  Created by lindongdong on 2017/9/5.
//  Copyright © 2017年 Ringo Lin. All rights reserved.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {
    
   
    @IBOutlet weak var profileImageView: CustomImageView!
    @IBOutlet weak var gridButton: UIButton!
    @IBOutlet weak var displayName: UILabel!
    var lastSelectedButton:UIButton!
    var databaseRef : DatabaseReference!
    lazy var nameLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 44))
        return label
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gridButton.isSelected = true
        gridButton.tintColor = UIColor(red: 36/255, green: 146/255, blue: 244/255, alpha: 1)
        lastSelectedButton = gridButton
        
        addBarButtonItems()
        
        fetchUserInfo()
        
    }
    
    func fetchUserInfo(){
        databaseRef = Database.database().reference()
        if let userID = Auth.auth().currentUser?.uid{
            databaseRef.child("Users").child(userID).observeSingleEvent(of: .value, with: { (snapshot) in
                if let dict = snapshot.value as? NSDictionary{
                    if let name = dict["name"] as? String,let profileImageURL = dict["profileImageURL"] as? String{
                        self.displayName.text = name
                        self.nameLabel.text = name
                        self.profileImageView.loadImageWithString(profileImageURL)
                    }
                }
            })
        }
        
    }
    
    @IBAction func addProfileImage(_ sender: Any) {
        
         guard let uid = Auth.auth().currentUser?.uid else { return }
         let imageName = UUID().uuidString
         let storageRef = Storage.storage().reference().child("ProfileImages").child("\(imageName).jpg")
        if let profileImage = self.profileImageView.image, let newImage = UIImageJPEGRepresentation(profileImage, 0.1) {
            storageRef.putData(newImage, metadata: nil, completion: { (metadata, error) in
                if error != nil{
                    print(error?.localizedDescription)
                    return
                }
                
                if let newImageURL = metadata?.downloadURL()?.absoluteString{
                    
                    let newValue = ["profileImageURL": newImageURL]
                    Database.database().reference().child("Users").child(uid).updateChildValues(newValue, withCompletionBlock: { (error, ref) in
                        if let error = error {
                            print(error.localizedDescription)
                            return 
                        }
                        print("update new image ")
                    })
                    
                }
                
            })
            
        }
      
    }
    @IBAction func tabButtonClick(_ sender: UIButton) {
        
        sender.isSelected = !sender.isSelected
        sender.tintColor = UIColor(red: 36/255, green: 146/255, blue: 244/255, alpha: 1)
        lastSelectedButton.isSelected = false
        lastSelectedButton.tintColor = .black
        lastSelectedButton = sender
    
    }
    
    func addBarButtonItems(){
        
        
        let saveHome = UIBarButtonItem.itemWithImage(#imageLiteral(resourceName: "bar-button-savehome"), action:#selector(ProfileViewController.saveHome))
        
        let archive = UIBarButtonItem.itemWithImage(#imageLiteral(resourceName: "bar-button-archive"), action: #selector(ProfileViewController.archive))
        
        let favorites = UIBarButtonItem.itemWithImage(#imageLiteral(resourceName: "bar-button-favorites"), action: #selector(ProfileViewController.favorites))
        
        let discover = UIBarButtonItem.itemWithImage(#imageLiteral(resourceName: "bar-button-discover-people-2"), action: #selector(ProfileViewController.discover))
        
        let more = UIBarButtonItem.itemWithImage(#imageLiteral(resourceName: "bar-button-more"), action: #selector(ProfileViewController.more))
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        spacer.width = -15
        navigationItem.rightBarButtonItems = [spacer,more,discover,favorites,archive,saveHome]
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: nameLabel)
        
    }


    
   @objc func more(){
        
    }
   @objc func discover(){
        
    }
    
   @objc func favorites(){
        
    }
    
    @objc func saveHome(){
        
    }
    
    @objc func archive(){
        
    }
   
}
