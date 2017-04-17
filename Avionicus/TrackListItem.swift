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
    
    var var_max: String?
    var description: String?
    var weight: Int?
    var manual: String?
    var dt_end: String?
    var alt_max: String?
    var sp_avg_movement: String?
    var os_version: String?
    var igc_pilot: String?
    var hr_avg: String?
    var sp_avg: Double?
    var task_status: String?
    var sp_max: Double?
    var serial_num: String?
    var cardio: String?
    var boat: String?
    var complete: String?
    var echo: String?
    var distance: Double?
    var app_version: String?
    var id_user: Int?
    var alt_min: String?
    var mongodb: String?
    var geo: String?
    var server_last_dt: String?
    var calories: String?
    var dt_start: String?
    var id_task: String?
    var id_track: Int?
    var access: Int?
    var id_device: String?
    var baro: String?
    var time: Int?
    var count_comment: String?
    var hr_max: String?
    var type: String?
    var var_min: String?
    var user_hr_max: String?
    var delete: Int?
    
    func mapping(map: Map) {
        var_max         <- map["var_max"]
        description     <- map["description"]
        weight          <- map["weight"]
        manual          <- map["manual"]
        dt_end          <- map["dt_end"]
        alt_max         <- map["alt_max"]
        sp_avg_movement <- map["sp_avg_movement"]
        os_version      <- map["os_version"]
        igc_pilot       <- map["igc_pilot"]
        hr_avg          <- map["hr_avg"]
        sp_avg          <- map["sp_avg"]
        task_status     <- map["task_status"]
        sp_max          <- map["sp_max"]
        serial_num      <- map["serial_num"]
        cardio          <- map["cardio"]
        boat            <- map["boat"]
        complete        <- map["complete"]
        echo            <- map["echo"]
        distance        <- map["distance"]
        app_version     <- map["app_version"]
        id_user         <- map["id_user"]
        alt_min         <- map["alt_min"]
        mongodb         <- map["mongodb"]
        geo             <- map["geo"]
        server_last_dt  <- map["server_last_dt"]
        calories        <- map["calories"]
        dt_start        <- map["dt_start"]
        id_task         <- map["id_task"]
        id_track        <- map["id_track"]
        access          <- map["access"]
        id_device       <- map["id_device"]
        baro            <- map["baro"]
        time            <- map["time"]
        count_comment   <- map["count_comment"]
        hr_max          <- map["hr_max"]
        type            <- map["type"]
        var_min         <- map["var_min"]
        user_hr_max     <- map["user_hr_max"]
        delete          <- map["delete"]
    }
    
    var viewModel: TrackerItem {
        get {
            let kind = type ?? "unknown"
            let df = DateFormatter()
            df.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let date = df.date(from: dt_start!) ?? Date()
            let endDate = df.date(from: dt_end!) ?? Date()
            let speed = sp_avg ?? 0.0
            let routeLength = (distance ?? 0.0) / 1000
            let id = id_track ?? -1
            let cal = Calendar.current
            let comps = cal.dateComponents([.hour, .minute, .second], from: cal.dateComponents([.hour, .minute, .second], from: date), to: cal.dateComponents([.hour, .minute, .second], from: endDate))
            let time = TrackerItem.Time(hours: comps.hour!, minutes: comps.minute!, seconds: comps.second!)
            return TrackerItem(kind: kind, time: time, date: date, speed: speed, routeLength: routeLength, id: id)
        }
    }
    
}
