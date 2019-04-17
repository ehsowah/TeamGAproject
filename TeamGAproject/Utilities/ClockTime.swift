//
//  ClockTime.swift
//  TeamGAproject
//
//  Created by sowah on 4/2/19.
//  Copyright © 2019 sowah. All rights reserved.
//

import Foundation

struct ClockTime {
    let currentDate: String
    let clockIn: String
    let clockOut: String
    let creationDate: Date
    
    init(dictionary: [String: Any]) {
        self.currentDate = dictionary["currentDate"] as? String ?? ""
        self.clockIn = dictionary["clockin"] as? String ?? ""
        self.clockOut = dictionary["clockOut"] as? String ?? ""
        let secondsFrom1970 = dictionary["creationDate"] as? Double ?? 0
        self.creationDate = Date(timeIntervalSince1970: secondsFrom1970)
    }
} 
