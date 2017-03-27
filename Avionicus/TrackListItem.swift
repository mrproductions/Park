//
//  TrackListItem.swift
//  Avionicus
//
//  Created by David Zukhbaia on 27.03.17.
//  Copyright © 2017 Park Team. All rights reserved.
//

import Foundation
import ObjectMapper

class TrackListItem: Mappable{
    
    public required init?(map: Map) {}
    
    var type: String?
    var dt_start: String?
    var dt_end: String?
    var time: String?
    var distance: String?
    var id_track: String?
    var sp_avg: String?
    var sp_max: String?
    var calories: String?
    var description: String?
    var weight: String?
    var var_max: String?
    var var_min: String?
    
    func mapping(map: Map) {
        type        <- map["type"]
        dt_start    <- map["dt_start"]
        dt_end      <- map["dt_end"]
        time        <- map["time"]
        distance    <- map["distance"]
        id_track    <- map["id_track"]
        sp_avg      <- map["sp_avg"]
        sp_max      <- map["sp_max"]
        calories    <- map["calories"]
        description <- map["description"]
        weight      <- map["weight"]
        var_max     <- map["var_max"]
        var_min     <- map["var_min"]
    }
    
    var viewModel: TrackerItem {
        get {
            let kind = type ?? "unknown"
            let df = DateFormatter()
            df.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let date = df.date(from: dt_start!) ?? Date()
            let endDate = df.date(from: dt_end!) ?? Date()
            let speed = Double(sp_avg!) ?? 0.0
            let routeLength = (Double(distance!) ?? 0.0) / 1000
            let id = id_track ?? ""
            let cal = Calendar.current
            let comps = cal.dateComponents([.hour, .minute, .second], from: cal.dateComponents([.hour, .minute, .second], from: date), to: cal.dateComponents([.hour, .minute, .second], from: endDate))
            let time = TrackerItem.Time(hours: comps.hour!, minutes: comps.minute!, seconds: comps.second!)
            return TrackerItem(kind: kind, time: time, date: date, speed: speed, routeLength: routeLength, id: id)
        }
    }
    
}
