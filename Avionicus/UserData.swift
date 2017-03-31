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
    
    var hash: String?
    var userId: String?
    var login: String?
    var name: String?
    var profile_avatar: String?
    var profile_weight: String?
    var profile_height: String?
    var profile_birthday: String?
    var profile_hr_max: String?
    var profile_sex: String?
    var profile_screens: String?
    var last_date_profile: String?
    var bStateError: Bool?
    var sMsgTitle: String?
    var sMsg: String?
    
    let keyChain = KeychainSwift()
    
    convenience init?(json: JSON) {
        self.init(JSON: json)
        if let error = self.bStateError {
            guard !error else {
                return nil
            }
        }
        if let hash = self.hash {
            writeHashToKeyChain(string: hash)
            
        }
        
//        if let hash = json["hash"] as? String? {
//            self.hash = hash
//        } else {
//            return nil
//        }
        
 
    }
    
    func mapping(map: Map) {
    
        hash                <- map   ["response.hash"]
        userId              <- map   ["response.id"]
        login               <- map   ["response.login"]
        profile_avatar      <- map   ["response.profile_avatar"]
        profile_weight      <- map   ["response.profile_weight"]
        profile_height      <- map   ["response.profile_height"]
        profile_birthday    <- map   ["response.profile_birthday"]
        profile_hr_max      <- map   ["response.profile_hr_max"]
        profile_sex         <- map   ["response.profile_sex"]
        profile_screens     <- map   ["response.profile_screens"]
        last_date_profile   <- map   ["response.last_date_profile"]
        bStateError         <- map   ["bStateError"]
        sMsgTitle           <- map   ["sMsgTitle"]
        sMsg                <- map   ["sMsg"]
    
    }
    
    // [User withDefaults]
    // [User saveToDefaults:dictionary]U

    func writeHashToKeyChain(string: String) {
        keyChain.set( string, forKey: "hash")
    }
    
    func getHashFromKeychain() -> String? {
        return keyChain.get("hash")
    }

    
    func writeToUserDefaults() {
        UserDefaults.standard.set(userId, forKey: "id")
        UserDefaults.standard.set(login, forKey: "login")
        
    }

}
