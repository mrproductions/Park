//
//  FinalViewController.swift
//  Park (WatchKit Alpha) WatchKit Extension
//
//  Created by Roman Mogutnov on 09/04/2017.
//  Copyright © 2017 Roman Mogutnov. All rights reserved.
//
import UIKit
import WatchKit
import Foundation

class FinalViewController: WKInterfaceController {

    var saveTitle : String = "Save"
    
    
    @IBOutlet var resultOutlet: WKInterfaceLabel!
    @IBOutlet var saveButton: WKInterfaceButton!
    @IBAction func saveAction() {
        
    }
    
    override func willActivate() {
        
        resultOutlet.setTextColor(UIColor.green)
        saveButton.setBackgroundColor(UIColor.green)
        saveButton.setTitle("Save")
        
    }
}
