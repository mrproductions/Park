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
        case Other = "Other"
        
        var description: String {
            switch self {
            case .Male:
                return "Male"
            case .Female:
                return "Female"
            case .Other:
                return "Other"
            }
        }
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
        email                       <- map ["email"]
        height                      <- map ["height"]
        login                       <- map ["login"]
        max_hr                      <- map ["max_hr"]
        name                        <- map ["name"]
        sex                         <- map ["sex"]
        sport_club                  <- map ["sport_club"]
        weight                      <- map ["weight"]
        
        UserDefaults.standard.set(weight, forKey: "weight")
        
        var birthdayString: String?
        birthdayString <- map["birthday"]
        
        if birthdayString != nil {
            let df = DateFormatter()
            df.dateFormat = "yyyy-MM-dd HH:mm:ss"
            birthday = df.date(from: birthdayString!)
        }
    }
    
    
    required convenience init?() {
        self.init()
    }
    
}
