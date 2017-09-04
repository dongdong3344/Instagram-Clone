//
//  CustomSlider.swift
//  MusicPlayer
//
//  Created by Ringo on 2017/8/4.
//  Copyright © 2017年 com.omni. All rights reserved.
//

import UIKit

@IBDesignable

class CustomSlider: UISlider {
    
    var isShown :Bool!
    // thumbImage中心点
    var thumbCenterX: CGFloat {
        
        let trackRect = self.trackRect(forBounds: frame)
        let thumbRect = self.thumbRect(forBounds: bounds, trackRect: trackRect, value: value)
        return thumbRect.midX
    }
    
//    override func thumbRect(forBounds bounds: CGRect, trackRect rect: CGRect, value: Float) -> CGRect {
//        let newRect = CGRect(x: rect.origin.x - 5, y: rect.origin.y, width: rect.size.width, height: rect.size.height)
//        
//        return super.thumbRect(forBounds: bounds, trackRect: newRect, value: value).insetBy(dx: 10, dy: 10)
//    }
    
    
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
