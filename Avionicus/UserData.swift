//
//  UserData.swift
//  avionicus
//
//  Created by Фамил Гаджиев on 02.12.16.
//  Copyright © 2016 Фамил Гаджиев. All rights reserved.
//

import Foundation
import ObjectMapper
import KeychainSwift

class UserData: Mappable {
    
    
    /// This function can be used to validate JSON prior to mapping. Return nil to cancel mapping at this point
    public required init?(map: Map) {}
    
    var id: Int?
    var login: String?
    var email: String?
    var name: String?
    var weight: Int?
    var height: Int?
    var birthday: String?
    var hrMax: Int?
    var sex: String?
    var profileAvatarUrl: String?
    var token: String?
    var error: Int?
    
    let keyChain = KeychainSwift()
    
    convenience init?(json: JSON) {
        self.init(JSON: json)
        
        if let token = self.token {
            writeTokenToKeychain(token: token)
        }
    }
    
    func mapping(map: Map) {
    
        token               <- map   ["token"]
        id                  <- map   ["id"]
        login               <- map   ["login"]
        email               <- map   ["email"]
        name                <- map   ["name"]
        weight              <- map   ["weight"]
        height              <- map   ["height"]
        hrMax               <- map   ["max_hr"]
        birthday            <- map   ["birthday"]
        profileAvatarUrl    <- map   ["avatar_url"]
        sex                 <- map   ["sex"]
     
    }
    

    func writeTokenToKeychain(token: String) {
        keyChain.set(token, forKey: "token")
    }
    
    func getTokenFromKeychain() -> String? {
        return keyChain.get("token")
    }

    func writeToUserDefaults() {
        UserDefaults.standard.set(id, forKey: "id")
        UserDefaults.standard.set(login, forKey: "login")
        
    }

}
