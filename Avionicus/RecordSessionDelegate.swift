//
//  RecordSessionDelegate.swift
//  Avionicus
//
//  Created by Фамил Гаджиев on 14.05.17.
//  Copyright © 2017 Park Team. All rights reserved.
//

import Foundation

protocol RecordSessionDelegate {
    
    func statusDidChange (recording: Bool)
    func speedDidChange (speed: Double)
    func altitudeDidChange (altitude: Double)
    func distanceDidChange (distance: Double)
    func maxSpeedDidChange (maxSpeed: Double)
    func averageSpeedDidChange (averageSpeed: Double)
    func courseDidChange (course: Double)
    func timeDidUpdate (timeElapsed: Int)
    
}
