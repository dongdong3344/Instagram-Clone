//
//  UIViewX.swift
//  Instagram Clone
//
//  Created by lindongdong on 2017/9/3.
//  Copyright © 2017年 Ringo Lin. All rights reserved.
//



import UIKit

@IBDesignable
class UIViewX:UIView {
    
     @IBInspectable var firstColor :UIColor = UIColor.white{
        didSet{
            updateView()
        }
    }
    
    @IBInspectable var secondColor :UIColor = UIColor.white{
        didSet{
            updateView()
        }
    }
    
    override class var layerClass :AnyClass{
        get{
            return CAGradientLayer.self
        }
    }
    
    @IBInspectable var horizontalGradient:Bool = false{
        didSet{
            updateView()
        }
    }
    
    func updateView(){
        
        let layer = self.layer as!CAGradientLayer
        layer.colors = [firstColor.cgColor,secondColor.cgColor]
        if horizontalGradient {
            layer.startPoint = CGPoint(x: 0, y: 0.5)
            layer.endPoint = CGPoint(x: 1, y: 0.5)
        }else{
            layer.startPoint = CGPoint(x: 0, y: 0)
            layer.endPoint = CGPoint(x: 0, y: 1)
        }
        
    }
    
}
