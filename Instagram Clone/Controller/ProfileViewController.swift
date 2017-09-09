//
//  ProfileViewController.swift
//  Instagram Clone
//
//  Created by lindongdong on 2017/9/5.
//  Copyright © 2017年 Ringo Lin. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

       addRightBarButtonItems()
        
    }
    
    
    func addRightBarButtonItems(){
        
        let saveHome = createButtonItemWithImage(#imageLiteral(resourceName: "bar-button-savehome"), action:#selector(ProfileViewController.saveHome))
        let archive = createButtonItemWithImage(#imageLiteral(resourceName: "bar-button-archive"), action: #selector(ProfileViewController.archive))
        let favorites = createButtonItemWithImage(#imageLiteral(resourceName: "bar-button-favorites"), action: #selector(ProfileViewController.favorites))
        let discover = createButtonItemWithImage(#imageLiteral(resourceName: "bar-button-discover-people-2"), action: #selector(ProfileViewController.discover))
        let more = createButtonItemWithImage(#imageLiteral(resourceName: "bar-button-more"), action: #selector(ProfileViewController.more))
        
        navigationItem.rightBarButtonItems = [more,discover,favorites,archive,saveHome]
        
        
    }

    func createButtonItemWithImage(_ image:UIImage,action:Selector) ->UIBarButtonItem{
        
        let itemButton = UIButton(type: .custom)
        itemButton.setImage(image, for: [])
        itemButton.tintColor = UIColor.black
        itemButton.addTarget(self, action: action, for: .touchUpInside)
        itemButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        return UIBarButtonItem(customView: itemButton)
        
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
