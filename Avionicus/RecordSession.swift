//
//  RecordSession.swift
//  Avionicus
//
//  Created by Фамил Гаджиев on 29.04.17.
//  Copyright © 2017 Park Team. All rights reserved.
//

import Foundation
import CoreLocation

class RecordSession {
    
    private var points = [CLLocationCoordinate2D]()
    private var previousLocation: CLLocation?
    var recordInProgress = false
    var startTime: Date?
    
    var metadata = RecordSessionMetadata()
    
    static let sharedSession = RecordSession.init()
    
    private init() {
        
    }
    
    
    func updateLocation (location: CLLocation) {
        
        if startTime == nil {
            startTime = location.timestamp
        }
        
        if let prev = previousLocation {
            let dist = location.distance(from: prev)
            metadata.distance += dist
        }
        
        points.append(location.coordinate)
        metadata.altitude = location.altitude
        metadata.updateSpeed(speed: location.speed)
        metadata.course = location.course
        
        let secondsComponent: Set<Calendar.Component> = [.second]
        let diff = Calendar.current.dateComponents(secondsComponent, from: startTime!, to: location.timestamp)
        metadata.timeElapsed += diff.second ?? 0
        
        previousLocation = location
        
    }
    
    func generateCSV () {
        
        guard !recordInProgress else {
            return
        }
        
        let fileName = "track_\(startTime!.timeIntervalSince1970).csv"
        
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {

        }
        
    }
    
    
}
