//
//  CustomSlider.swift
//  MusicPlayer
//
//  Created by Ringo on 2017/8/4.
//  Copyright © 2017年 com.omni. All rights reserved.
//

import UIKit

@IBDesignable

class LeftPaddedTextField: UITextField {
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        
        return CGRect(x: bounds.origin.x + 100, y: bounds.origin.y, width: bounds.width , height: bounds.height)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        
        return CGRect(x: bounds.origin.x + 100, y: bounds.origin.y, width: bounds.width , height: bounds.height)
    }
    
}

class CustomView:UIView {
    
    var colorArray :[(colorOne:UIColor,colorTwo:UIColor)] = []
    
    var currentColorArrayIndex = -1
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        colorArray.append((colorOne: #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1), colorTwo:#colorLiteral(red: 0.6679437118, green: 0.6232269987, blue: 0.9686274529, alpha: 1) ))
        colorArray.append((colorOne: #colorLiteral(red: 0.6679437118, green: 0.6232269987, blue: 0.9686274529, alpha: 1), colorTwo:#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1) ))
        colorArray.append((colorOne: #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), colorTwo:#colorLiteral(red: 0.8726018439, green: 0.4296181168, blue: 0.9771573604, alpha: 1) ))
        colorArray.append((colorOne: #colorLiteral(red: 0.8726018439, green: 0.4296181168, blue: 0.9771573604, alpha: 1), colorTwo:#colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1) ))
        colorArray.append((colorOne: #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1), colorTwo:#colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1) ))
        
        animateBackgroundColor()
 
    }
    
   
    
    func animateBackgroundColor(){
        
        currentColorArrayIndex = currentColorArrayIndex == (colorArray.count - 1) ? 0 : currentColorArrayIndex + 1
        
        UIView.transition(with: self, duration: 2, options: [.transitionCrossDissolve], animations: {
            self.firstColor = self.colorArray[self.currentColorArrayIndex].colorOne
            self.secondColor = self.colorArray[self.currentColorArrayIndex].colorTwo
            
        }) { (success) in
            self.animateBackgroundColor()
        }
    }
    
    
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
class CustomSlider: UISlider {
    
    var isShown :Bool!
    // thumbImage中心点
    var thumbCenterX: CGFloat {
        
        let trackRect = self.trackRect(forBounds: frame)
        let thumbRect = self.thumbRect(forBounds: bounds, trackRect: trackRect, value: value)
        return thumbRect.midX
    }
    

    @IBInspectable var thumbImage:UIImage?{
        
        didSet{
            setThumbImage(thumbImage, for: .normal)
      }
    }
    
    @IBInspectable var thumbHighlightedImage:UIImage?{
        didSet{
            setThumbImage(thumbHighlightedImage, for: .highlighted)
        }
    }
    
    @IBInspectable var thumbColor:UIColor?{
        didSet{
            self.thumbTintColor = thumbColor
        }
    }
}

@IBDesignable

class CustomImageView: UIImageView {
    
    @IBInspectable var cornerRadius:CGFloat = 0.0{
        didSet{
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = true
        }
    }
    
    @IBInspectable var borderWidth:CGFloat = 0.0{
        didSet{
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor : UIColor?{
        
        didSet{
            layer.borderColor = borderColor?.cgColor
        }
    }
}

class RoundButton: UIButton {
    
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet{
            
            self.layer.cornerRadius = cornerRadius
        }
        
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.clear {
        didSet{
            
            self.layer.borderColor = borderColor.cgColor
        }
        
    }
    @IBInspectable var borderWitdh: CGFloat  = 0.0  {
        didSet{
            
            self.layer.borderWidth = borderWitdh
        }
        
    }
    
}
