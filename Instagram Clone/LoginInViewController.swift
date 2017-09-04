//
//  ViewController.swift
//  Instagram Clone
//
//  Created by lindongdong on 2017/9/3.
//  Copyright © 2017年 Ringo Lin. All rights reserved.
//

import UIKit

class LoginInViewController: UIViewController {
    
    @IBOutlet weak var bgView: UIViewX!
    var colorArray :[(colorOne:UIColor,colorTwo:UIColor)] = []
    var currentColorArrayIndex = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //元组
        colorArray.append((colorOne: #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1), colorTwo:#colorLiteral(red: 0.6679437118, green: 0.6232269987, blue: 0.9686274529, alpha: 1) ))
        colorArray.append((colorOne: #colorLiteral(red: 0.6679437118, green: 0.6232269987, blue: 0.9686274529, alpha: 1), colorTwo:#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1) ))
        colorArray.append((colorOne: #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), colorTwo:#colorLiteral(red: 0.8726018439, green: 0.4296181168, blue: 0.9771573604, alpha: 1) ))
        colorArray.append((colorOne: #colorLiteral(red: 0.8726018439, green: 0.4296181168, blue: 0.9771573604, alpha: 1), colorTwo:#colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1) ))
        colorArray.append((colorOne: #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1), colorTwo:#colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1) ))
        
        animateBackgroundColor()
        
    }

    func animateBackgroundColor(){

        currentColorArrayIndex = currentColorArrayIndex == (colorArray.count - 1) ? 0 : currentColorArrayIndex + 1
        
        UIView.transition(with: bgView, duration: 2, options: [.transitionCrossDissolve], animations: {
            self.bgView.firstColor = self.colorArray[self.currentColorArrayIndex].colorOne
            self.bgView.secondColor = self.colorArray[self.currentColorArrayIndex].colorTwo
            
        }) { (success) in
            self.animateBackgroundColor()
        }
    }

    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
}

