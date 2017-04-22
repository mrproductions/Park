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
    
    var id: Int?
    var token: String?
    
    convenience init?(json: JSON) {
        
        self.init(JSON: json)
        
        if let token = self.token {
            writeTokenToKeychain(token: token)
        }

        
    }
    
    func mapping(map: Map) {
        
        id               <- map      ["id"]
        token            <- map      ["token"]

    }
    
    func writeTokenToKeychain(token: String) {
        keyChain.set(token, forKey: "token")
    }
    
    func getTokenFromKeychain() -> String? {
        return keyChain.get("token")
    }

    
    
}
