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
    
    var login: String?
    var mail: String?
    var password: String?
    var bStateError: Bool?
    var sMsgTitle: String?
    var sMsg: String?
    var response: Bool?
    var array: [String]?
    
    
    
    convenience init?(json: JSON) {
        self.init(JSON: json)
//        if let error = self.bStateError{
//            guard !error else {
//                return nil
//            }
//        }
        
    }
    
    func mapping(map: Map) {
        
       
        mail                <- map      ["aErrors.mail.0"]
        password            <- map      ["aErrors.password.0"]
        response            <- map      [""]
        bStateError         <- map      ["bStateError"]
        sMsgTitle           <- map      ["sMsgTitle"]
        login               <- map      ["aErrors.login.0"]
        array               <- map      ["login"]
        
    }
    
    func description() -> String {
        
        return "\(login) \(mail)"
        
        
    }
    
}
