//
//  TrackList.swift
//  Avionicus
//
//  Created by Фамил Гаджиев on 06.03.17.
//  Copyright © 2017 Фамил Гаджиев. All rights reserved.
//

import Foundation
import ObjectMapper

class TrackList: Mappable{
    
    public required init?(map: Map) {}
    
    convenience init?(json: JSON) {
        self.init(JSON: json)
    }
    
    var tracks: [String:TrackListItem]?
     

    func mapping(map: Map) {
        tracks <- map ["tracks"]
    }
    
}
