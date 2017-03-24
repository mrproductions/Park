//
//  UserVC.swift
//  avionicus
//
//  Created by Фамил Гаджиев on 02.12.16.
//  Copyright © 2016 Фамил Гаджиев. All rights reserved.
//

import UIKit


class UserViewController: UIViewController{
    
    @IBOutlet weak var MenuButton: UIBarButtonItem!
    @IBOutlet weak var Avatar: UIImageView!
    @IBOutlet weak var Name: UILabel!
    
    @IBAction fileprivate func close() {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
    }
    
    
}
