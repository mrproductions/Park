//
//  FileDetailViewController.swift
//  Avionicus
//
//  Created by Фамил Гаджиев on 06.05.17.
//  Copyright © 2017 Park Team. All rights reserved.
//

import UIKit

class FileDetailViewController: UIViewController {
    
    var file: FilesTableViewController.File?
    
    
    @IBOutlet weak var contentWebView: UIWebView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        if file != nil {
            do {
                let text = try String(contentsOf: file!.url)
                contentWebView.loadHTMLString(text.replacingOccurrences(of: "\n", with: "<br />"), baseURL: file!.url)
            } catch {
                print("Couldn't load file...")
            }
        }
        
        navigationItem.title = file?.name
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
