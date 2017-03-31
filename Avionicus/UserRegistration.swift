//
//  UserRegistration.swift
//  Avionicus
//
//  Created by Фамил Гаджиев on 16.02.17.
//  Copyright © 2017 Фамил Гаджиев. All rights reserved.
//

import Foundation
import ObjectMapper

class UserRegistration: Mappable {
    public required init?(map: Map) {}
    
    var hash: String?
    var id: String?
    var login: String?
    var name: String?
    var bStateError: Bool?
    var sMsgTitle: String?
    var sMsg: String?
    
    convenience init?(json: JSON) {
        self.init(JSON: json)
        if let error = self.bStateError{
            guard !error else {
                return nil
            }
        }
    }
    
    func mapping(map: Map) {
        hash                <- map   ["response.hash"]
        id                  <- map   ["response.id"]
        login               <- map   ["response.login"]
    }
    
}
