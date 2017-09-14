//
//  UserDefalutsHelper.swift
//  MusicPlayer
//
//  Created by Ringo on 2017/8/16.
//  Copyright © 2017年 com.omni. All rights reserved.
//

import Foundation

extension UserDefaults{
    
     // 枚举
    enum UserDefaultsKeys : String {
            case name     //用户名
            case email    //邮箱
            case password //密码
        }
    
    //保存用户名
    func saveName(value:String) {
        
        set(value, forKey: UserDefaultsKeys.name.rawValue)
        synchronize()
        
    }
    
    // 获取用户名
    func getName() -> String{
        guard let name  = object(forKey: UserDefaultsKeys.name.rawValue)as? String else{ return "" }
        return name
    }
    
    
    //保存邮箱
    func saveEmail(value:String) {
        
        set(value, forKey: UserDefaultsKeys.email.rawValue)
        synchronize()
        
    }
    
    // 获取邮箱
    func getEmail() -> String{
        guard let email  = object(forKey: UserDefaultsKeys.email.rawValue)as? String else{ return "" }
        return email
    }
    
    //保存密码
    func savePassword(value:String) {
        
        set(value, forKey: UserDefaultsKeys.password.rawValue)
        synchronize()
        
    }
    
    // 获取密码
    func getPassword() -> String{
        guard let password  = object(forKey: UserDefaultsKeys.password.rawValue)as? String else{ return "" }
        return password
    }
 
}
