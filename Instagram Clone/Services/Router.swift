//
//  Router.swift
//  Instagram Clone
//
//  Created by lindongdong on 2017/9/13.
//  Copyright © 2017年 Ringo Lin. All rights reserved.
//

import FirebaseDatabase

enum Router {
    
    static fileprivate let dataDaseRef = Database.database().reference()
    
    case myProfile
    case users
    case user(id: String)
    case posts
    case post(id: String)
    
    var reference: DatabaseReference {
        switch self {
        case .myProfile:
            return Router.user(id: AuthService.currentUserId()).reference
        case .users:
            return Router.dataDaseRef.child("Users")
        case .user(let id):
            return Router.users.reference.child(id)
        case .posts:
            return Router.dataDaseRef.child("Posts")
        case .post(let id):
            return Router.posts.reference.child(id)
        }
    }
}
