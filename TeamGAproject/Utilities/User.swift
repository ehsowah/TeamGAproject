//
//  User.swift
//  TeamGAproject
//
//  Created by sowah on 3/23/19.
//  Copyright © 2019 sowah. All rights reserved.
//

import Foundation

struct User {
    let uid: String
    let username: String
    let position: String
    let phone: String
    let email: String
    let office: String
    let profileImageUrl: String
    
    init(uid: String, dictionary: [String: Any]) {
        self.uid = uid
        self.username = dictionary["username"] as? String ?? ""
        self.position = dictionary["position"] as? String ?? ""
        self.phone = dictionary["phone"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
        self.office = dictionary["office"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
    }
}
