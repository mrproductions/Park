//
//  TrackList.swift
//  Avionicus
//
//  Created by Фамил Гаджиев on 06.03.17.
//  Copyright © 2017 Фамил Гаджиев. All rights reserved.
//

import Foundation
import ObjectMapper
import Alamofire
import AlamofireObjectMapper

class TrackList: Mappable{
    
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
        
    }
    
}
