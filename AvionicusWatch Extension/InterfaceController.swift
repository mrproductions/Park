//
//  InterfaceController.swift
//  Park (WatchKit Alpha) WatchKit Extension
//
//  Created by Roman Mogutnov on 09/04/2017.
//  Copyright © 2017 Roman Mogutnov. All rights reserved.
//
import UIKit
import WatchKit
import Foundation
import MapKit
import HealthKit

class InterfaceController: WKInterfaceController {

    let healthStore = HKHealthStore()
    let heartRateUnit = HKUnit(from: "count/min")

    var workoutActive = false
    var session: HKWorkoutSession?
    var currenQuery: HKQuery?
    var timer = Timer()
    var workoutTime: TimeInterval = 0.0
    var intervalTime: TimeInterval = 0.0
    var isWorkingOut = false

    @IBOutlet var positionLabel: WKInterfaceLabel!
    @IBOutlet weak var label: WKInterfaceLabel!
    @IBOutlet weak var heart: WKInterfaceImage!
    @IBOutlet var actionTimer: WKInterfaceTimer!
    @IBOutlet var mapOutlet: WKInterfaceMap!
    @IBOutlet var actionButtonOutlet: WKInterfaceButton!
    @IBOutlet var actionStopOutlet: WKInterfaceButton!

    @IBAction func actionButton() {

        if (self.workoutActive) {
            //finish the current workout
            self.workoutActive = false
            if let workout = self.session {
                healthStore.end(workout)
            }
        } else {
            //start a new workout
            self.workoutActive = true
            startWorkout()
        }

        isWorkingOut = !isWorkingOut
        if isWorkingOut {
            perform(#selector(self.justPause), with: nil)

        } else {
            perform(#selector(self.justContinue), with: nil)
        }
    }

    @IBAction func actionStop() {
        perform(#selector(self.justStop), with: nil)
        presentController(withName: "FinalVC", context: ["segue": "FinalVC",
                                                        "data": "Passed through FinalVC navigation"])
    }

    func justPause() {
        actionTimer.start()
        actionButtonOutlet.setTitle("Pause")
        actionButtonOutlet.setBackgroundColor(UIColor.orange)

    }

    func justContinue() {

        actionTimer.stop()
        actionButtonOutlet.setTitle("Continue")
        actionButtonOutlet.setBackgroundColor(UIColor.green)
    }

    func justStart() {

        wkTimerReset(timer: actionTimer, interval: 0.0)
        actionButtonOutlet.setTitle("Stop")
        actionButtonOutlet.setBackgroundColor(UIColor.red)
    }

    func justStop() {
        actionTimer.stop()
        actionStopOutlet.setTitle("Stop")
        actionStopOutlet.setBackgroundColor(UIColor.red)

    }

    func wkTimerReset(timer: WKInterfaceTimer, interval: TimeInterval) {
        timer.stop()
        let time  = NSDate(timeIntervalSinceNow: interval)
        timer.setDate(time as Date)
        timer.start() //srat display of WKInterfaceTimer
    }

    func loopTimer1(interval: TimeInterval) { //NSTimer to end at event.
        if timer.isValid { //kill a running timer before starting a time
            timer.invalidate()
        }
        timer = Timer.scheduledTimer(timeInterval: interval,
                                                       target: self,
            selector: Selector(("loopTimer1DidEnd:")),
            userInfo: nil,
            repeats: false)
        wkTimerReset(timer: actionTimer, interval: 0)

    }

    func loopTimer1DidEnd(timer: Timer) {
        actionButtonOutlet.setTitle("Start")
        isWorkingOut = false
        actionTimer.stop()
        timer.invalidate()
    }

    func formatTimeInterval(timeInterval: TimeInterval) -> String {
        let secondsInHour = 3600
        let secondsInMinute = 60
        var time = Int(timeInterval)
        let hours = time / secondsInHour
        time = time % secondsInHour
        let minutes = time / secondsInMinute
        let seconds = time % secondsInMinute
        return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
    }

    func displayNotAllowed() {
        label.setText("not allowed")
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
        // Do nothing for now
        print("Workout error")
    }

    func workoutDidStart(_ date: Date) {
        if let query = createHeartRateStreamingQuery(date) {
            self.currenQuery = query
            healthStore.execute(query)
        } else {
            label.setText("cannot start")
        }
    }

    func workoutDidEnd(_ date: Date) {
        healthStore.stop(self.currenQuery!)
        label.setText("---")
        session = nil
    }

    func startWorkout() {

        // If we have already started the workout, then do nothing.
        if (session != nil) {
            return
        }

        // Configure the workout session.
        let workoutConfiguration = HKWorkoutConfiguration()
        workoutConfiguration.activityType = .crossTraining
        workoutConfiguration.locationType = .indoor

        do {
            session = try HKWorkoutSession(configuration: workoutConfiguration)
            session?.delegate = self as? HKWorkoutSessionDelegate
        } catch {
            fatalError("Unable to create the workout session!")
        }

        healthStore.start(self.session!)
    }

    func createHeartRateStreamingQuery(_ workoutStartDate: Date) -> HKQuery? {

        guard let quantityType = HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.heartRate) else { return nil }
        let datePredicate = HKQuery.predicateForSamples(withStart: workoutStartDate, end: nil, options: .strictEndDate )
        //let devicePredicate = HKQuery.predicateForObjects(from: [HKDevice.local()])
        let predicate = NSCompoundPredicate(andPredicateWithSubpredicates:[datePredicate])

        let heartRateQuery = HKAnchoredObjectQuery(type: quantityType, predicate: predicate, anchor: nil, limit: Int(HKObjectQueryNoLimit)) { (_, sampleObjects, _, _, _) -> Void in
            //guard let newAnchor = newAnchor else {return}
            //self.anchor = newAnchor
            self.updateHeartRate(sampleObjects)
        }

        heartRateQuery.updateHandler = {(query, samples, deleteObjects, newAnchor, error) -> Void in
            //self.anchor = newAnchor!
            self.updateHeartRate(samples)
        }
        return heartRateQuery
    }

    func updateHeartRate(_ samples: [HKSample]?) {
        guard let heartRateSamples = samples as? [HKQuantitySample] else {
            return
        }

        DispatchQueue.main.async {
            guard let sample = heartRateSamples.first else {return}
            let value = sample.quantity.doubleValue(for: self.heartRateUnit)
            self.label.setText(String(UInt16(value)))

            // retrieve source from sample
            let name = sample.sourceRevision.source.name
            self.animateHeart()
        }
    }

    func animateHeart() {
        self.animate(withDuration: 0.5) {
            self.heart.setWidth(60)
            self.heart.setHeight(90)
        }

        let when = DispatchTime.now() + Double(Int64(0.5 * double_t(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)

        DispatchQueue.global(qos: .default).async {
            DispatchQueue.main.asyncAfter(deadline: when) {
                self.animate(withDuration: 0.5, animations: {
                    self.heart.setWidth(50)
                    self.heart.setHeight(80)
                })            }

        }
    }

    override func willActivate() {

        guard HKHealthStore.isHealthDataAvailable() == true else {
            label.setText("not available")
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

        actionStopOutlet.setTitle("Stop")
        actionStopOutlet.setBackgroundColor(UIColor.red)
        justPause()

            let mapLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(37, -122)
            let coordinateSpan: MKCoordinateSpan = MKCoordinateSpanMake(1, 1)

                mapOutlet.addAnnotation(mapLocation, with: .purple)
                mapOutlet.setRegion(MKCoordinateRegionMake(mapLocation, coordinateSpan))

        super.willActivate()
    }

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)

    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
