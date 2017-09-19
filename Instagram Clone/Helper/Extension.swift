//
//  Extension.swift
//  Instagram Clone
//
//  Created by lindongdong on 2017/9/10.
//  Copyright © 2017年 Ringo Lin. All rights reserved.
//

import UIKit

extension UILocalizedIndexedCollation{
    
    func partitionObjects(array:[AnyObject], collationStringSelector:Selector) -> ([AnyObject], [String]) {
        var unsortedSections = [[AnyObject]]()
        
        //1. Create a array to hold the data for each section
        for _ in self.sectionTitles {
            unsortedSections.append([]) //appending an empty array
        }
        
        //2. Put each objects into a section
        for item in array {
            let index:Int = self.section(for: item, collationStringSelector:collationStringSelector)
            unsortedSections[index].append(item)
        }
        //3. sorting the array of each sections
        var sectionTitles = [String]()
        var sections = [AnyObject]()
        for index in 0 ..< unsortedSections.count { if unsortedSections[index].count > 0 {
            sectionTitles.append(self.sectionTitles[index])
            sections.append(self.sortedArray(from: unsortedSections[index], collationStringSelector: collationStringSelector) as AnyObject)
            }
        }
        return (sections, sectionTitles)
    }
}


extension UIViewController{
    
    func displayAlert(title:String,message:String){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "我知道了", style: .cancel, handler: nil)
        alert.addAction(alertAction)
        present(alert, animated: true, completion: nil)
    }
    
}

extension UIColor {
    
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
    
    //浅蓝色
    static func babyBlue() -> UIColor{
       return UIColor(red: 135/255, green: 200/255, blue: 250/200, alpha: 1)
    }
    //深蓝色
    static func deepBlue() -> UIColor{
        
      return UIColor(red: 0, green: 143/255, blue: 255/200, alpha: 1)
    }
    
}

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
