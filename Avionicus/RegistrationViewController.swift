//
//  RegistrationVCViewController.swift
//  Avionicus
//
//  Created by Фамил Гаджиев on 12.02.17.
//  Copyright © 2017 Фамил Гаджиев. All rights reserved.
//

import UIKit
import Alamofire

class RegistrationViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var registrationBtn: RoundButton?
    @IBOutlet weak var nameText: RoundTextField?
    @IBOutlet weak var senameText: RoundTextField?
    @IBOutlet weak var loginText: RoundTextField?
    @IBOutlet weak var mailText: RoundTextField?
    @IBOutlet weak var passwordText: RoundTextField?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
        
    }
    

    @IBAction func Registration(_ sender: Any) {
        
        let loginText = self.loginText?.text
        let passwordText = self.passwordText?.text
        let mailText = self.mailText?.text
        
        
        apiManager.registration(login: loginText!, pass: passwordText!, mail: mailText!){ result in
        
            switch result {
            case .success (let userRegistration):
                print("succes \(userRegistration.sMsg) \(userRegistration.sMsgTitle)")
                print(Avionicus.registration(loginText! ,passwordText!,mailText!).request)
                
            case .failure(let error):
                print("error")
                print(Avionicus.registration(loginText! ,passwordText!,mailText!).request)
                
                
            }
            
            
        }
        
        
    }
    
  
    @IBAction func backBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
