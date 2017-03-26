//
//  TrackerItem.swift
//  Avionicus
//
//  Created by David Zukhbaia on 26.03.17.
//  Copyright © 2017 Park Team. All rights reserved.
//

import Foundation

class TrackerItem {
    
    enum Kind: Int {
        case running
        case bike
    }
    
    struct Time {
        let hours: Int
        let minutes: Int
        let seconds: Int
    }
    
    let kind: Kind
    let date: Date
    let speed: Double
    let routeLength: Double
    let totalTime: Time
    
    var formattedTime: String {
        return String(format: "%02d:%02d:%02d", totalTime.hours, totalTime.minutes, totalTime.seconds)
    }
    
    var formattedDate: String {
        let df = DateFormatter()
        df.dateStyle = .medium
        return df.string(from: date)
    }
    
    init(kind: Kind, time: Time, date: Date, speed: Double, routeLength: Double) {
        self.kind = kind
        self.totalTime = time
        self.routeLength = routeLength
        self.date = date
        self.speed = speed
    }
    
    
}
