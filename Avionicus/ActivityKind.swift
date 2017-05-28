//
//  ActivityKind.swift
//  Avionicus
//
//  Created by Фамил Гаджиев on 08.05.17.
//  Copyright © 2017 Park Team. All rights reserved.
//

import Foundation

enum ActivityKind: String {
    case aerostat = "aerostat"
    case airplane = "airplane"
    case autogyro = "autogyro"
    case bike = "bike"
    case car = "car"
    case dogwalking = "dogwalking"
    case downhillski = "downhillski"
    case elliptical = "elliptical"
    case ellipticalTrainer = "elliptical_trainer"
    case excerciseBicycle = "excercise_bicycle"
    case exercycle = "exercycle"
    case fishingboat = "fishingboat"
    case gliding = "gliding"
    case hanggliding = "hanggliding"
    case hangglidingTrike = "hanggliding_trike"
    case helicopter = "helicopter"
    case hiking = "hiking"
    case horseriding = "horseriding"
    case kitesurfing = "kitesurfing"
    case kiting = "kiting"
    case kitingWinter = "kiting_winter"
    case motorboat = "motorboat"
    case motorcycle = "motorcycle"
    case nordicwalking = "nordicwalking"
    case other = "other"
    case paragliding = "paragliding"
    case pokemon = "pokemon"
    case powerboat = "powerboat"
    case ppg = "ppg"
    case pramwalking = "pramwalking"
    case riding = "riding"
    case rollerSkiing = "roller_skiing"
    case rollerski = "rollerski"
    case rowing = "rowing"
    case run = "run"
    case sailboat = "sailboat"
    case shorefishing = "shorefishing"
    case skiing = "skiing"
    case snowboard = "snowboard"
    case snowkiting = "snowkiting"
    case swimming = "swimming"
    case treadmill = "treadmill"
    case ultralight = "ultralight"
    case walk = "walk"
    case waterscooter = "waterscooter"
    
    var description: String {
        switch self {
        case .aerostat:
            return "Aerostat"
        case .airplane:
            return "Airplane"
        case .autogyro:
            return "Autogyro"
        case .bike:
            return "Bike"
        case .car:
            return "Car"
        case .dogwalking:
            return "Dogwalking"
        case .downhillski:
            return "Downhillski"
        case .elliptical:
            return "Elliptical"
        case .ellipticalTrainer:
            return "Elliptical trainer"
        case .excerciseBicycle:
            return "Excercise bicycle"
        case .exercycle:
            return "Exercycle"
        case .fishingboat:
            return "Fishing boat"
        case .gliding:
            return "Gliding"
        case .hanggliding:
            return "Hanggliding"
        case .hangglidingTrike:
            return "Hanggliding trike"
        case .helicopter:
            return "Helicopter"
        case .hiking:
            return "Hiking"
        case .horseriding:
            return "Horseriding"
        case .kitesurfing:
            return "Kitesurfing"
        case .kiting:
            return "Kiting"
        case .kitingWinter:
            return "KitingWinter"
        case .motorboat:
            return "Motorboat"
        case .motorcycle:
            return "Motorcycle"
        case .nordicwalking:
            return "Nordic walking"
        case .other:
            return "Other"
        case .paragliding:
            return "Paragliding"
        case .pokemon:
            return "Pokemon"
        case .powerboat:
            return "Powerboat"
        case .ppg:
            return "PPG"
        case .pramwalking:
            return "Pramwalking"
        case .riding:
            return "Riding"
        case .rollerSkiing:
            return "Roller skiing"
        case .rollerski:
            return "Roller ski"
        case .rowing:
            return "Rowing"
        case .run:
            return "Run"
        case .sailboat:
            return "Sailboat"
        case .shorefishing:
            return "Shore fishing"
        case .skiing:
            return "Skiing"
        case .snowboard:
            return "Snowboard"
        case .snowkiting:
            return "Snowkiting"
        case .swimming:
            return "Swimming"
        case .treadmill:
            return "Treadmill"
        case .ultralight:
            return "Ultralight"
        case .walk:
            return "Walk"
        case .waterscooter:
            return "Waterscooter"
        }
    }
    
}
