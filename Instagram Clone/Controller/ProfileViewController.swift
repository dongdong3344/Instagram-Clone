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
        
        
        let saveHome = UIBarButtonItem.itemWithImage(#imageLiteral(resourceName: "bar-button-savehome"), action:#selector(ProfileViewController.saveHome))
        
        let archive = UIBarButtonItem.itemWithImage(#imageLiteral(resourceName: "bar-button-archive"), action: #selector(ProfileViewController.archive))
        
        let favorites = UIBarButtonItem.itemWithImage(#imageLiteral(resourceName: "bar-button-favorites"), action: #selector(ProfileViewController.favorites))
        
        let discover = UIBarButtonItem.itemWithImage(#imageLiteral(resourceName: "bar-button-discover-people-2"), action: #selector(ProfileViewController.discover))
        
        let more = UIBarButtonItem.itemWithImage(#imageLiteral(resourceName: "bar-button-more"), action: #selector(ProfileViewController.more))
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        spacer.width = -15
        navigationItem.rightBarButtonItems = [spacer,more,discover,favorites,archive,saveHome]
        
        
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
