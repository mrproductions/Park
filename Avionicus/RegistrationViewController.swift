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
    var userRegistration: UserRegistration?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    @IBAction func Registration(_ sender: Any) {
        
        let loginText = self.loginText?.text
        let passwordText = self.passwordText?.text
        let mailText = self.mailText?.text
        
        
        apiManager.registration(login: loginText!, pass: passwordText!, mail: mailText!){ result in
        
            switch result {
            case .success:
                DispatchQueue.main.async { [weak welf = self] in
                    welf?.displayMessage(title: "Success", message: "Registration complete", dismissTitle: "Okay")
                }
                
            case .failure(_):
                DispatchQueue.main.async { [weak welf = self] in
                    welf?.displayMessage(title: "Error", message: "Try again", dismissTitle: "Okay")
                }
            }
            
            
        }
        
        
    }
    
    
    func displayMessage (title: String?, message: String?, dismissTitle: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        let action = UIAlertAction(title: dismissTitle, style: .cancel, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
  
    @IBAction func backBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
