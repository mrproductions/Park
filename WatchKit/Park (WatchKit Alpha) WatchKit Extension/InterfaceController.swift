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


class InterfaceController: WKInterfaceController {
    
    var timer = Timer()
    var workoutTime:TimeInterval = 0.0
    var intervalTime:TimeInterval = 0.0
    var isWorkingOut = false
    
    
    @IBOutlet var actionTimer: WKInterfaceTimer!
    @IBOutlet var mapOutlet: WKInterfaceMap!
    @IBOutlet var actionButtonOutlet: WKInterfaceButton!
    @IBOutlet var actionStopOutlet: WKInterfaceButton!
    
    
    
    @IBAction func actionButton() {
        
        isWorkingOut = !isWorkingOut
        if isWorkingOut{
            perform(#selector(self.justPause), with: nil)

        } else {
            perform(#selector(self.justContinue), with: nil)
        }
    }
    
    @IBAction func actionStop() {
        perform(#selector(self.justStop), with: nil)
        presentController(withName: "FinalVC", context: ["segue": "FinalVC",
                                                        "data":"Passed through FinalVC navigation"])

    }
    
    func justPause(){
        actionTimer.start()
        actionButtonOutlet.setTitle("Pause")
        actionButtonOutlet.setBackgroundColor(UIColor.orange)
        
    }
    
    func justContinue(){
        
        actionTimer.stop()
        actionButtonOutlet.setTitle("Continue")
        actionButtonOutlet.setBackgroundColor(UIColor.green)
    }
    
    func justStart() {
        
        wkTimerReset(timer: actionTimer,interval: 0.0)
        actionButtonOutlet.setTitle("Stop")
        actionButtonOutlet.setBackgroundColor(UIColor.red)
    }
    
    func justStop(){
        actionTimer.stop()
        actionStopOutlet.setTitle("Stop")
        actionStopOutlet.setBackgroundColor(UIColor.red)
        
    }
    
    func wkTimerReset(timer:WKInterfaceTimer,interval:TimeInterval){
        timer.stop()
        let time  = NSDate(timeIntervalSinceNow: interval)
        timer.setDate(time as Date)
        timer.start() //srat display of WKInterfaceTimer
    }
    
    func loopTimer1(interval:TimeInterval){ //NSTimer to end at event.
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
    
    func loopTimer1DidEnd(timer: Timer){
        actionButtonOutlet.setTitle("Start")
        isWorkingOut = false
        actionTimer.stop()
        timer.invalidate()
    }
    

    func formatTimeInterval(timeInterval:TimeInterval) -> String {
        let secondsInHour = 3600
        let secondsInMinute = 60
        var time = Int(timeInterval)
        let hours = time / secondsInHour
        time = time % secondsInHour
        let minutes = time / secondsInMinute
        let seconds = time % secondsInMinute
        return String(format:"%02i:%02i:%02i",hours,minutes,seconds)
    }
    
    override func willActivate() {
        
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
