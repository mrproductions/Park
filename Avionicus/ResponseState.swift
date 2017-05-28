//
//  ResponseState.swift
//  Avionicus
//
//  Created by Фамил Гаджиев on 14.05.17.
//  Copyright © 2017 Park Team. All rights reserved.
//

import Foundation
import ObjectMapper

class ResponseState: Mappable {
    
    required init?(map: Map) {
        
    }
    
    init (state: State) {
        self.state = state
    }
    
    enum State {
        case success
        case error
    }
    
    var state: State = .success
    
    func mapping(map: Map) {
        
        var errorNum: Int = 0
        errorNum <- map["bStateError"]
        
        if errorNum == 1 {
            state = .error
        }
    }
    
}
