//
//  Extension.swift
//  TeamGAproject
//
//  Created by sowah on 3/22/19.
//  Copyright © 2019 sowah. All rights reserved.
//

import UIKit
import Firebase

extension UIView {
    func anchor(top: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, right: NSLayoutXAxisAnchor?, padddingTop: CGFloat, paddingLeft: CGFloat, paddingBottom: CGFloat, paddingRight: CGFloat, width: CGFloat, height: CGFloat) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: padddingTop).isActive = true
        }
        
        if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        
        if width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
}

extension Date {
    func timeAgoDisplay() -> String {
        let secondAgo = Int(Date().timeIntervalSince(self))
        
        let minute = 60
        let hour = 60 * minute
        let day = 24 * hour
        let week = 7 * day
        let month = 4 * week
        
        let quotient: Int
        let Unit: String
        if secondAgo < minute {
            quotient = secondAgo
            Unit = "second"
        } else if secondAgo < hour {
            quotient = secondAgo / minute
            Unit = "min"
        } else if secondAgo < day {
            quotient = secondAgo / hour
            Unit = "hour"
        } else if secondAgo < week {
            quotient = secondAgo / day
            Unit = "day"
        } else if secondAgo < month {
            quotient = secondAgo / week
            Unit = "week"
        } else {
            quotient = secondAgo / month
            Unit = "month"
        }
        
        return "\(quotient) \(Unit)\(quotient == 1 ? "" : "s") ago"
    }
}

extension Database {
    static func fetchUserWithUID(uid: String, completion: @escaping (User) -> ()) {
        print("Fetching user with uid:", uid)
        
        Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            
            guard let userDictionary = snapshot.value as? [String: Any] else { return }
            let user = User(uid: uid, dictionary: userDictionary)
            
            print(user.username)
            completion(user)
            
        }) { (err) in
            
            print("Failed to fetch user for posts:", err)
        }
        
    }
}
