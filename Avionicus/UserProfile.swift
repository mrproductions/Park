//
//  UserProfile.swift
//  Avionicus
//
//  Created by Фамил Гаджиев on 13.02.17.
//  Copyright © 2017 Фамил Гаджиев. All rights reserved.
//

import Foundation
import ObjectMapper

class UserProfile: Mappable{
    
    enum Sex: String {
        case Male = "man"
        case Female = "woman"
    }
    
    public required init?(map: Map) {}
 
    var login: String?
    var avatar_url: String?
    var name: String?
    var birthday: Date?
    var email: String?
    var height: Int?
    
   
    var max_hr: String?
    var sex: Sex?
    var sport_club: String?
    var weight: Int?
    
    var bib: String?
    

    
    func mapping(map: Map) {
        
        avatar_url                  <- map ["avatar_url"]
        bib                         <- map ["bib"]
        birthday                    <- (map ["birthday"], DateTransform())
        email                       <- map ["email"]
        height                      <- map ["height"]
        login                       <- map ["login"]
        max_hr                      <- map ["max_hr"]
        name                        <- map ["name"]
        sex                         <- map ["sex"]
        sport_club                  <- map ["sport_club"]
        weight                      <- map ["weight"]
        
    }
    
    required convenience init?() {
        self.init()
    }
    
}
