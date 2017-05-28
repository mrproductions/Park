//
//  UserFriend.swift
//  Avionicus
//
//  Created by Фамил Гаджиев on 29.04.17.
//  Copyright © 2017 Park Team. All rights reserved.
//

import Foundation
import ObjectMapper

class UserFriend: Mappable {
    
    public required init?(map: Map){}
    
    
    var id: Int?
    var login: String?
    
    var name: String?
    var sex: String?
    var sportClub: String?
    var avatarUrl: String?
    var birthday: String?
    
    var statusFriend: String?
    
    func mapping(map: Map){
        
        id                  <- map   ["id"]
        login               <- map   ["login"]
        name                <- map   ["name"]
        sportClub           <- map   ["sport_club"]
        avatarUrl           <- map   ["avatar_url"]
        sex                 <- map   ["sex"]
        birthday            <- map   ["birthday"]
        statusFriend        <- map   ["status"]
        
    }
    required convenience init?() {
        self.init()
    }
    
}
