//
//  Friend.swift
//  Avionicus
//
//  Created by Фамил Гаджиев on 30.04.17.
//  Copyright © 2017 Park Team. All rights reserved.
//

import Foundation
import ObjectMapper

class UserFriendList: Mappable {

    public required init?(map: Map){}
    
    var arrayFriend: [UserFriend]?
    
    func mapping(map: Map) {
        arrayFriend     <- map["data"]
    }
    
//    convenience init?(json: JSON) {
//        self.init(JSON: json)
//    }
    
}
