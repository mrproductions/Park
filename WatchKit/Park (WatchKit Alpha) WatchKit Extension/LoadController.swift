//
//  LoadController.swift
//  Park (WatchKit Alpha) WatchKit Extension
//
//  Created by Roman Mogutnov on 09/04/2017.
//  Copyright © 2017 Roman Mogutnov. All rights reserved.
//

import UIKit
import WatchKit
import Foundation
import HealthKit



class LoadController: WKInterfaceController {
    
    @IBOutlet var buttonLabel: WKInterfaceLabel!
    @IBOutlet var backgroundGroup: WKInterfaceGroup!
    
    @IBAction func checkInButtonTapped() {
        
        let duration = 2.0
        let delay = DispatchTime.now() + Double(Int64((duration + 0.15) * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        
        buttonLabel.setText("Start")
//        buttonLabel.setText("3")
//        buttonLabel.setText("2")
//        buttonLabel.setText("1")
//        buttonLabel.setText("GO")
        
        backgroundGroup.setBackgroundImageNamed("Progress")
        backgroundGroup.startAnimatingWithImages(in: NSRange(location: 0, length: 10), duration: duration, repeatCount: 1)
        
       DispatchQueue.main.asyncAfter(deadline: delay) { () -> Void in
        
        
        
        self.pushController(withName: "MainVC", context: ["segue": "MainVC",
                                                          "data":"Passed through MainVC navigation"])

        
        }
         //InterfaceController().justStart()
    }

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
    }
}


