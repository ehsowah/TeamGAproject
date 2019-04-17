//
//  Post.swift
//  TeamGAproject
//
//  Created by sowah on 3/26/19.
//  Copyright © 2019 sowah. All rights reserved.
//

import Foundation

struct Post {

    var id: String?
    
    let username: String
    let position: String
    let caption: String
    let creationDate: Date
    let profileImageUrl: String
    let key: String

    init(key: String, dictionary: [String: Any]) {
        self.username = dictionary["username"] as? String ?? ""
        self.position = dictionary["position"] as? String ?? ""
        self.caption = dictionary["caption"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
        let secondsFrom1970 = dictionary["creationDate"] as? Double ?? 0
        self.creationDate = Date(timeIntervalSince1970: secondsFrom1970)
        self.key = key
    }
}
