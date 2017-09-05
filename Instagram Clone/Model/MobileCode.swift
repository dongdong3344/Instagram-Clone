//
//  MobileCode.swift
//  Instagram Clone
//
//  Created by lindongdong on 2017/9/5.
//  Copyright © 2017年 Ringo Lin. All rights reserved.
//

import Foundation
typealias JSON = [String:Any]

class MobileCode: NSObject {
    var name      : String!
    var dial_code : String!
    var code      : String!
    
    init(json:JSON) {
        super.init()
        setValuesForKeys(json)
     
    }
    
    override func setValuesForKeys(_ keyedValues: [String : Any]) {
        super.setValuesForKeys(keyedValues)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
    
   static func getMobileCodes(completion:@escaping([MobileCode]) -> Void){
        
        var mobileCodes = [MobileCode]()
       
        if let filePath = Bundle.main.path(forResource: "MobileCodes", ofType: "json"){
            
            if let jsonData = NSData(contentsOfFile: filePath){
                
                do{
                    let json = try JSONSerialization.jsonObject(with: jsonData as Data, options:[]) as! JSON
                    
                    if let dicts = json["countries"] as? [JSON]{
                       mobileCodes = dicts.map({
                            return MobileCode.init(json: $0)
                        })
                    }
                    
                    completion(mobileCodes)
                    
                }catch let error as NSError{
                    print("解析出错: \(error.localizedDescription)")
                }
                
            }
         
        }
       
        
    }
}
