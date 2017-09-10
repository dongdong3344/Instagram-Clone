//
//  Extension.swift
//  Instagram Clone
//
//  Created by lindongdong on 2017/9/10.
//  Copyright © 2017年 Ringo Lin. All rights reserved.
//

import UIKit


extension UIBarButtonItem {
    
   static func itemWithImage(_ image:UIImage,action:Selector) -> UIBarButtonItem{
        
        let itemButton = UIButton(type: .custom)
        itemButton.setImage(image, for: [])
        itemButton.tintColor = UIColor.black
        itemButton.addTarget(self, action: action, for: .touchUpInside)
        itemButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        return UIBarButtonItem(customView: itemButton)
        
    }
  
}


let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView{

      static var imageUrlString :String?
    
        func loadImageWithString(_ urlString:String){
            
            UIImageView.imageUrlString = urlString
            
            let request = URLRequest(url: URL(string:urlString)!)
            
            self.image = nil
            
            //imageCache exist,and use it directly
            if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
                
                self.image = imageFromCache
            }
            
            //imageCache doesn't exist,then download the image and save it
            URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                
                guard let data = data, error == nil else {
                    print(error?.localizedDescription as Any)
                    return
                }
                
                DispatchQueue.main.async() {
                    
                    let imageToCache = UIImage(data: data)
                    
                    imageCache.setObject(imageToCache!, forKey: urlString as String as AnyObject )
                    
                    if UIImageView.imageUrlString == urlString{
                        
                        self.image = imageToCache
                    }
                }
                
            }).resume()
            
    }
}
