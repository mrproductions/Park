//
//  TrackDetails.swift
//  Avionicus
//
//  Created by David Zukhbaya on 21.04.17.
//  Copyright © 2017 Park Team. All rights reserved.
//

import Foundation
import ObjectMapper
import SwiftyJSON

class TrackDetails: Mappable {
    
   
    public required init?(map: Map) {}
    
    
    var activityKind: ActivityKind = .run
    var startDate: Date?
    var endDate: Date?
    var duration: TimeInterval?
    var distance: Double?
    var averageSpeed: Double?
    var maxSpeed: Double?
    var comment: String?
    
    var points: [Point]?
    
    
    func mapping(map: Map) {
        
        var type = ""
        type <- map["aTrack.type"]
        if TrackerItem.activities.contains(type) {
            activityKind = ActivityKind(rawValue: type)!
        }
        var startDateString = ""
        startDateString <- map["aTrack.dt_start"]
        var endDateString = ""
        endDateString <- map["aTrack.dt_end"]
        
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm:ss"
        startDate = df.date(from: startDateString)
        endDate = df.date(from: endDateString)
        
        duration <- map["aTrack.time"]
        distance <- map["aTrack.distance"]
        averageSpeed <- map["aTrack.sp_avg"]
        maxSpeed <- map["aTrack.sp_max"]
        comment <- map["aTrack.description"]
        points <- map["aPoints"]
        
        
        
    }
    
    
    struct Point {
        let latitude: Double
        let longitude: Double
        let altitude: Double
        let date: Date
        let pulse: Double
        let speed: Double
        let course: Double
    }
    
}
