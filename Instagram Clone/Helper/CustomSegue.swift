//
//  SegueFromLeft.swift
//  Instagram Clone
//
//  Created by lindongdong on 2017/9/4.
//  Copyright © 2017年 Ringo Lin. All rights reserved.
//

import Foundation
import UIKit

class SegueFromLeft: UIStoryboardSegue {
    override func perform(){
        let src = source
        let dst = destination
        src.view.superview?.insertSubview(dst.view, aboveSubview: src.view)
        dst.view.transform = CGAffineTransform(translationX: src.view.frame.size.width, y: 0)
        UIView.animate(withDuration: 0.25, delay: 0, options: [.curveEaseInOut], animations: {
            dst.view.transform = .identity
        }, completion: { (fnished) in
            src.present(dst, animated: false, completion: nil)
            
        })
        
    }
   
}

class SegueFromRight: UIStoryboardSegue {
    override func perform(){
        let src = source
        let dst = destination
        src.view.superview?.insertSubview(dst.view, aboveSubview: src.view)
        dst.view.transform = CGAffineTransform(translationX: -src.view.frame.size.width, y: 0)
           UIView.animate(withDuration: 0.25, delay: 0, options: [.curveEaseInOut], animations: {
                dst.view.transform = .identity
            }, completion: { (fnished) in
                src.present(dst, animated: false, completion: nil)
               
            })
            
        }
}
