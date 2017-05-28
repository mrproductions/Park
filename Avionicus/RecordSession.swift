//
//  RecordSession.swift
//  Avionicus
//
//  Created by Фамил Гаджиев on 29.04.17.
//  Copyright © 2017 Park Team. All rights reserved.
//

import UIKit
import CoreLocation

class RecordSession {
    
    var delegate: RecordSessionDelegate?
    
    private var points = [CLLocation]()
    private var previousLocation: CLLocation?
    
    var recordInProgress = false {
        didSet {
            delegate?.statusDidChange(recording: recordInProgress)
            if !recordInProgress {
                endTime = Date()
            }
        }
    }
    var startTime: Date?
    var comment: String = ""
    var endTime: Date?
    var activityKind = ActivityKind.run
    
    
    var metadata = RecordSessionMetadata()
    
    static let sharedSession = RecordSession.init()
    
    private init() {
        metadata.session = self
    }
    
    
    func updateLocation (location: CLLocation) {
        
        if startTime == nil {
            startTime = location.timestamp
        }
        
        if let prev = previousLocation {
            let dist = location.distance(from: prev)
            metadata.distance += dist
        }
        
        points.append(location)
        metadata.altitude = location.altitude
        metadata.updateSpeed(speed: location.speed)
        metadata.course = location.course
        
        let secondsComponent: Set<Calendar.Component> = [.second]
        let diff = Calendar.current.dateComponents(secondsComponent, from: startTime!, to: location.timestamp)
        metadata.timeElapsed += diff.second ?? 0
        
        previousLocation = location
        
    }
    
    func saveCSVToDisk (completion: (NSError?, URL?) -> Void) {
        
        guard !recordInProgress else {
            completion(NSError(domain: "CSV saving", code: 1, userInfo: nil), nil)
            return
        }
        
        guard points.count > 0 else {
            completion(NSError(domain: "CSV saving", code: 2, userInfo: nil), nil)
            return
        }
        
        let fileName = "track_\(Int(startTime!.timeIntervalSince1970)).csv"
        
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            
            let path = dir.appendingPathComponent(fileName)
            
            do {
                
                guard let start = startTime else {
                    completion(NSError(domain: "CSV saving", code: 3, userInfo: nil), nil)
                    return
                }
                
                guard let end = endTime else {
                    completion(NSError(domain: "CSV saving", code: 4, userInfo: nil), nil)
                    return
                }
                
                
                
                let weight = UserDefaults.standard.integer(forKey: "weight")
                
                let startLine = "START;\(formattedStringForDate(date: start));\(activityKind.rawValue);\(weight);1;\(UIDevice.current.systemVersion);Park 1.0\n"
                try append(fileURL: path, text: startLine)
                
                let startPoint = points.first!
                
                for (index, point) in points.enumerated() {
                    let pointLine: String
                    if (index == 0) {
                        pointLine = "#;\(formattedStringForDate(date: start));\(point.coordinate.latitude);\(point.coordinate.longitude);\(comment);1;\n"
                    } else {
                        let dlat = (startPoint.coordinate.latitude - point.coordinate.latitude) * 1000000
                        let dlong = (startPoint.coordinate.longitude - point.coordinate.longitude) * 1000000
                        pointLine = "\(dlat);\(dlong);\(metadata.altitude);\(metadata.speed);\(metadata.course);\(Int(point.timestamp.timeIntervalSince1970 - startPoint.timestamp.timeIntervalSince1970));;;;;;;;;;;;;\n"
                    }
                    try append(fileURL: path, text: pointLine)
                }
                
                let endLine = "STOP;\(formattedStringForDate(date: end));\(metadata.timeElapsed);\(activityKind.rawValue);\(comment);1;\n"
                try append(fileURL: path, text: endLine)
                
                try append(fileURL: path, text: "###;\(metadata.timeElapsed)")
                
                completion(nil, path)
            }
            catch {
                completion(NSError(domain: "CSV saving", code: 5, userInfo: nil), nil)
                return
            }
            
            
        } else {
            completion(NSError(domain: "CSV saving", code: 6, userInfo: nil), nil)
            return
        }
        
    }
    
    private func formattedStringForDate (date: Date) -> String {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return df.string(from: date)
    }
    
    private func append(fileURL: URL, text: String) throws {
        if let fileHandle = FileHandle(forWritingAtPath: fileURL.path) {
            defer {
                fileHandle.closeFile()
            }
            fileHandle.seekToEndOfFile()
            fileHandle.write(text.data(using: String.Encoding.utf8)!)
        }
        else {
            try text.write(to: fileURL, atomically: false, encoding: String.Encoding.utf8)
        }
    }
    
    func clear() {
        metadata.clear()
        points.removeAll()
        previousLocation = nil
        startTime = nil
        comment = ""
        endTime = nil
    }
    
    
    
}
