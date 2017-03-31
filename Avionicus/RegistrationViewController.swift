//
//  RegistrationVCViewController.swift
//  Avionicus
//
//  Created by Фамил Гаджиев on 12.02.17.
//  Copyright © 2017 Фамил Гаджиев. All rights reserved.
//

import UIKit

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
                DispatchQueue.main.async {
                    print("succes \(userRegistration.sMsg) \(userRegistration.sMsgTitle)")
                    print(Avionicus.registration(loginText! ,passwordText!,mailText!).request)
                    print(userRegistration.sMsgTitle!)
                    let errorAlert = UIAlertController(title: "Succes", message: "\(userRegistration.sMsgTitle)", preferredStyle: UIAlertControllerStyle.alert)
                    let actionError = UIAlertAction(title: "Fine", style: .cancel, handler: nil)
                    errorAlert.addAction(actionError)
                    self.present(errorAlert, animated: true, completion: nil)
                    
                }
                
            case .failure( _):
                DispatchQueue.main.async {
                    let errorAlert = UIAlertController(title: "Error", message: "Registration Fail", preferredStyle: UIAlertControllerStyle.alert)
                    let actionError = UIAlertAction(title: "Try Again", style: .cancel, handler: nil)
                    errorAlert.addAction(actionError)
                    self.present(errorAlert, animated: true, completion: nil)
                }
            }
            
            
        }
        
        
    }
    
  
    @IBAction func backBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
