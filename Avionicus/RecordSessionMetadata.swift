//
//  RecordSessionMetadata.swift
//  Avionicus
//
//  Created by Фамил Гаджиев on 29.04.17.
//  Copyright © 2017 Park Team. All rights reserved.
//

import Foundation


class RecordSessionMetadata {
    
    weak var session: RecordSession?
    
    private struct AverageMetadata {
        var speedSum: Double
        var count: Int
    }
    
    var speed: Double = 0.0 { // meters per second
        didSet {
            session?.delegate?.speedDidChange(speed: speed)
        }
    }
    var altitude: Double = 0.0 {
        didSet {
            session?.delegate?.altitudeDidChange(altitude: altitude)
        }
    }
    var distance: Double = 0.0 {
        didSet {
            session?.delegate?.distanceDidChange(distance: distance)
        }
    }
    var maxSpeed: Double = 0.0 {
        didSet {
            session?.delegate?.maxSpeedDidChange(maxSpeed: maxSpeed)
        }
    }
    var averageSpeed: Double = 0.0 {
        didSet {
            session?.delegate?.averageSpeedDidChange(averageSpeed: averageSpeed)
        }
    }
    
    
    private var averageSpeedMetadata = AverageMetadata(speedSum: 0, count: 0)
    
    var course: Double = 0.0 { // degrees (0 - north, 90 - east)
        didSet {
            session?.delegate?.courseDidChange(course: course)
        }
    }
    var timeElapsed: Int = 0 {
        didSet {
            session?.delegate?.timeDidUpdate(timeElapsed: timeElapsed)
        }
    }
    
    func updateSpeed (speed: Double) {
        
        maxSpeed = max(self.speed, speed)
        self.speed = speed
        
        averageSpeedMetadata.count += 1
        averageSpeedMetadata.speedSum += speed
        averageSpeed = averageSpeedMetadata.speedSum / Double(averageSpeedMetadata.count)
    }
    
    func clear() {
        speed = 0
        altitude = 0
        distance = 0
        maxSpeed = 0
        averageSpeed = 0
        averageSpeedMetadata.count = 0
        averageSpeedMetadata.speedSum = 0
        course = 0
        timeElapsed = 0
    }
    
    
    
    
}
