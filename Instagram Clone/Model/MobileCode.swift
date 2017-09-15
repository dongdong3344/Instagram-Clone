//
//  MobileCode.swift
//  Instagram Clone
//
//  Created by lindongdong on 2017/9/5.
//  Copyright © 2017年 Ringo Lin. All rights reserved.
//

import Foundation

typealias JSON = [String:Any]

/**Method one*/
//struct MobileCode {
//    let name, dialCode, code : String
//}
//
//struct MobileCodeFetcher{
//
//    static func getMobileCodes() -> [MobileCode] {
//        let fileURL = Bundle.main.url(forResource: "MobileCodes", withExtension: "json")
//        let jsonData = try! Data(contentsOf: fileURL!)
//        let json = try! JSONSerialization.jsonObject(with: jsonData) as! JSON
//        let countries = json["countries"] as! [[String:String]]
//        return countries.map { MobileCode(name: $0["name"]!, dialCode: $0["dial_code"]!, code: $0["code"]!) }
//    }
//}

class MobileCode:NSObject{

   var name,dialCode,code: String!

   init(dictionary: JSON) {
        self.name = dictionary["name"] as! String
        self.dialCode = dictionary["dial_code"] as! String
        self.code = dictionary["code"] as! String

    }
}

struct MobileCodeFetcher {
    
  static func getMobileCodes() -> [MobileCode] {

        var mobileCodes = [MobileCode]()

        if let filePath = Bundle.main.path(forResource: "MobileCodes", ofType: "json"){

            if  let jsonData = try? Data(contentsOf: URL(fileURLWithPath: filePath)){

                do{
                    let json = try JSONSerialization.jsonObject(with: jsonData, options:[]) as! JSON

                    if  let dicts = json["countries"] as? [JSON] {

                        mobileCodes = dicts.map({
                            return MobileCode.init(dictionary: $0)
                        })
                    }

                }catch let error as NSError{
                    print("解析出错: \(error.localizedDescription)")
                }
            }

          }
        return mobileCodes
    }
}

