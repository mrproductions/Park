//
//  TrackListItem.swift
//  Avionicus
//
//  Created by David Zukhbaia on 27.03.17.
//  Copyright © 2017 Park Team. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift
import ObjectMapper_Realm

class TrackListItem: Object, Mappable{
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    dynamic var var_max = ""
    dynamic var trackDescription = ""
    dynamic var weight = 0
    dynamic var manual = ""
    dynamic var dt_end = ""
    dynamic var alt_max = ""
    dynamic var sp_avg_movement = ""
    dynamic var os_version = ""
    dynamic var igc_pilot = ""
    dynamic var hr_avg = ""
    dynamic var sp_avg = 0.0
    dynamic var task_status = ""
    dynamic var sp_max = 0.0
    dynamic var serial_num = ""
    dynamic var cardio = ""
    dynamic var boat = ""
    dynamic var complete = ""
    dynamic var echo = ""
    dynamic var distance = 0.0
    dynamic var app_version = ""
    dynamic var id_user = 0
    dynamic var alt_min = ""
    dynamic var mongodb = ""
    dynamic var geo = ""
    dynamic var server_last_dt = ""
    dynamic var calories = ""
    dynamic var dt_start = ""
    dynamic var id_task = ""
    dynamic var id_track = 0
    dynamic var access = 0
    dynamic var id_device = ""
    dynamic var baro = ""
    dynamic var time = 0
    dynamic var count_comment = ""
    dynamic var hr_max = ""
    dynamic var type = ""
    dynamic var var_min = ""
    dynamic var user_hr_max = ""
    dynamic var delete = 0
    
    override class func primaryKey() -> String? {
        return "id_track"
    }



    
    func mapping(map: Map) {
        
        var_max         <- map["var_max"]
        trackDescription <- map["description"]
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
    
    func viewModel() -> TrackerItem {
            let kind = type 
            let df = DateFormatter()
            df.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let date = df.date(from: dt_start) ?? Date()
            let endDate = df.date(from: dt_end) ?? Date()
            let speed = sp_avg 
            let routeLength = (distance ) / 1000
            let id = id_track 
            let cal = Calendar.current
            let comps = cal.dateComponents([.hour, .minute, .second], from: cal.dateComponents([.hour, .minute, .second], from: date), to: cal.dateComponents([.hour, .minute, .second], from: endDate))
            let time = TrackerItem.Time(hours: comps.hour!, minutes: comps.minute!, seconds: comps.second!)
            return TrackerItem(kind: kind, time: time, date: date, speed: speed, routeLength: routeLength, id: id)
    }
    
    func saveToDatabase () {
        let realm = DatabaseManager.realm
        try! realm.write {
            realm.add(self, update: true)
        }
    }
    
}
