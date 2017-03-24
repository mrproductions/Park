//
//  UserProfile.swift
//  Avionicus
//
//  Created by Фамил Гаджиев on 13.02.17.
//  Copyright © 2017 Фамил Гаджиев. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import AlamofireObjectMapper

class UserProfile: Mappable{
    
    public required init?(map: Map) {}
    
    
    var profile_mail: String?
    var profile_name: String?
    var profile_weight: String?
    var profile_height: String?
    var profile_birthday: String?
    var profile_hr_max: String?
    var profile_sex: String?
    var profile_boat: String?
    var profile_avatar: String?
    var profile_photo: String?
    var profile_bib: String?
    var profile_sport_club: String?
    var last_date_profile: String?
    
    convenience init?(json: JSON) {
        self.init(JSON: json)
    }
    
    func mapping(map: Map) {
        
        profile_mail                <- map  ["response.profile_mail"]
        profile_name                <- map  ["response.profile_name"]
        profile_weight              <- map  ["response.profile_weight"]
        profile_height              <- map  ["response.profile_height"]
        profile_birthday            <- map  ["response.profile_birthday"]
        profile_hr_max              <- map  ["response.profile_hr_max"]
        profile_sex                 <- map  ["response.profile_sex"]
        profile_boat                <- map  ["response.profile_boat"]
        profile_avatar              <- map  ["response.profile_avatar"]
        profile_photo               <- map  ["response.profile_photo"]
        profile_bib                 <- map  ["response.profile_bib"]
        profile_sport_club          <- map  ["response.profile_sport_club"]
        last_date_profile           <- map  ["response.last_date_profile"]
        
    }
    
    

}
