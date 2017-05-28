//
//  ProfileItem.swift
//  Avionicus
//
//  Created by Фамил Гаджиев on 22.04.17.
//  Copyright © 2017 Park Team. All rights reserved.
//

import UIKit

class ProfileItem {
    
    enum CellKind {
        case Field (String?) // field value
        case Action (String) // storyboard segue identifier
    }
    
    var cellKind: CellKind
    let title: String
    
    init(kind: CellKind, title: String) {
        self.cellKind = kind
        self.title = title
    }
    
    
    
}
