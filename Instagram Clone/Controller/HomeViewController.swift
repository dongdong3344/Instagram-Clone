//
//  HomeViewController.swift
//  Instagram Clone
//
//  Created by lindongdong on 2017/9/5.
//  Copyright © 2017年 Ringo Lin. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationbar()
        view.backgroundColor = UIColor.lightGray
        let imageView = UIImageView(frame: CGRect(x: 100, y: 100, width: 103, height: 30))
        imageView.image = #imageLiteral(resourceName: "logotype-feed")
        imageView.tintColor = .white
        view.addSubview(imageView)
    }

    func setupNavigationbar(){
      
        let logoImageView = UIImageView()
        logoImageView.image = #imageLiteral(resourceName: "logotype-feed")
        logoImageView.tintColor = .black
        navigationItem.titleView = logoImageView
        
        
        
    }
    

}
