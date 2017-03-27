//
//  TrackerItem.swift
//  Avionicus
//
//  Created by David Zukhbaia on 26.03.17.
//  Copyright © 2017 Park Team. All rights reserved.
//

import Foundation

class TrackerItem {
    
    static let activities: Set<String> = ["aerostat", "airplane", "autogyro", "bike", "car", "dogwalking", "downhillski", "elliptical", "elliptical_trainer", "excercise_bicycle", "exercycle", "fishingboat", "gliding", "hanggliding", "hanggliding_trike", "helicopter", "hiking", "horseriding", "kitesurfing", "kiting", "kiting_winter", "motorboat", "motorcycle", "nordicwalking", "other", "paragliding", "pokemon", "powerboat", "ppg", "pramwalking", "riding", "roller_skiing", "rollerski", "rowing", "run", "sailboat", "shorefishing", "skiing", "snowboard", "snowkiting", "swimming", "treadmill", "ultralight", "walk", "waterscooter"]
    
    struct Time {
        let hours: Int
        let minutes: Int
        let seconds: Int
    }
    
    let kind: String
    let id: String
    let date: Date
    let speed: Double
    let routeLength: Double
    let totalTime: Time
    
    var formattedTime: String {
        return String(format: "%02d:%02d:%02d", totalTime.hours, totalTime.minutes, totalTime.seconds)
    }
    
    var formattedDate: String {
        let df = DateFormatter()
        df.dateFormat = "d MMMM"
        return df.string(from: date)
    }
    
    init(kind: String, time: Time, date: Date, speed: Double, routeLength: Double, id: String) {
        if TrackerItem.activities.contains(kind) {
            self.kind = kind
        } else {
            self.kind = "unknown"
        }
        self.totalTime = time
        self.routeLength = routeLength
        self.date = date
        self.speed = speed
        self.id = id
    }
    
    
}
