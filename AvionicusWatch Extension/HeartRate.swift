//
//  HeartRate.swift
//  Park (WatchKit Alpha) WatchKit Extension
//
//  Created by Roman Mogutnov on 09/04/2017.
//  Copyright © 2017 Roman Mogutnov. All rights reserved.
//
import Foundation
import HealthKit
import WatchKit

class HeartRate: WKInterfaceController, HKWorkoutSessionDelegate {

    let healthStore = HKHealthStore()
    var workoutActive = false
    var session: HKWorkoutSession?
    let heartRateUnit = HKUnit(from: "count/min")
    //var anchor = HKQueryAnchor(fromValue: Int(HKAnchoredObjectQueryNoAnchor))
    var currenQuery: HKQuery?

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
    }

    override func willActivate() {
        super.willActivate()

        guard HKHealthStore.isHealthDataAvailable() == true else {
            InterfaceController().label.setText("not available")
            return
        }

        guard let quantityType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.heartRate) else {
            displayNotAllowed()
            return
        }

        let dataTypes = Set(arrayLiteral: quantityType)
        healthStore.requestAuthorization(toShare: nil, read: dataTypes) { (success, _) -> Void in
            if success == false {
                self.displayNotAllowed()
            }
        }
    }

    func displayNotAllowed() {
        InterfaceController().label.setText("not allowed")
    }

    func workoutSession(_ workoutSession: HKWorkoutSession, didChangeTo toState: HKWorkoutSessionState, from fromState: HKWorkoutSessionState, date: Date) {
        switch toState {
        case .running:
            workoutDidStart(date)
        case .ended:
            workoutDidEnd(date)
        default:
            print("Unexpected state \(toState)")
        }
    }

    func workoutSession(_ workoutSession: HKWorkoutSession, didFailWithError error: Error) {
        print("Workout error")
    }

    func workoutDidStart(_ date: Date) {
        if let query = createHeartRateStreamingQuery(date) {
            self.currenQuery = query
            healthStore.execute(query)
        } else {
            InterfaceController().label.setText("cannot start")
        }
    }

    func workoutDidEnd(_ date: Date) {
            healthStore.stop(self.currenQuery!)
            InterfaceController().label.setText("---")
            session = nil
    }

//    func startWorkout() {
//        
//        if (session != nil) {
//            return
//        }
//        
//        let workoutConfiguration = HKWorkoutConfiguration()
//        workoutConfiguration.activityType = .crossTraining
//        workoutConfiguration.locationType = .indoor
//        
//        do {
//            session = try HKWorkoutSession(configuration: workoutConfiguration)
//            session?.delegate = self
//        } catch {
//            fatalError("Unable to create the workout session!")
//        }
//        
//        healthStore.start(self.session!)
//    }

    func createHeartRateStreamingQuery(_ workoutStartDate: Date) -> HKQuery? {

        guard let quantityType = HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.heartRate) else { return nil }
        let datePredicate = HKQuery.predicateForSamples(withStart: workoutStartDate, end: nil, options: .strictEndDate )
        //let devicePredicate = HKQuery.predicateForObjects(from: [HKDevice.local()])
        let predicate = NSCompoundPredicate(andPredicateWithSubpredicates:[datePredicate])

        let heartRateQuery = HKAnchoredObjectQuery(type: quantityType, predicate: predicate, anchor: nil, limit: Int(HKObjectQueryNoLimit)) { (_, sampleObjects, _, _, _) -> Void in
            //guard let newAnchor = newAnchor else {return}
            //self.anchor = newAnchor
            InterfaceController().self.updateHeartRate(sampleObjects)
        }

        heartRateQuery.updateHandler = {(query, samples, deleteObjects, newAnchor, error) -> Void in
            //self.anchor = newAnchor!
            InterfaceController().self.updateHeartRate(samples)
        }
        return heartRateQuery
    }

//    
//    func updateDeviceName(_ deviceName: String) {
//        deviceLabel.setText(deviceName)
//    }

    }
