//
//  RecordSessionMetadata.swift
//  Avionicus
//
//  Created by Фамил Гаджиев on 29.04.17.
//  Copyright © 2017 Park Team. All rights reserved.
//

import Foundation


class RecordSessionMetadata {
    
    struct AverageMetadata {
        var speedSum: Double
        var count: Int
    }
    
    var speed: Double = 0.0 // meters per second
    var altitude: Double = 0.0
    var distance: Double = 0.0
    var maxSpeed: Double = 0.0
    var averageSpeed: Double = 0.0
    private var averageSpeedMetadata = AverageMetadata(speedSum: 0, count: 0)
    
    var course: Double = 0.0 // degrees (0 - north, 90 - east)
    var timeElapsed: Int = 0
    
    func updateSpeed (speed: Double) {
        
        maxSpeed = max(self.speed, speed)
        self.speed = speed
        
        averageSpeedMetadata.count += 1
        averageSpeedMetadata.speedSum += speed
        averageSpeed = averageSpeedMetadata.speedSum / Double(averageSpeedMetadata.count)
    }
    
    
}
