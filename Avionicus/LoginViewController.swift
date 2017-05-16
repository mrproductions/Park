//
//  LoginVC.swift
//  avionicus
//
//  Created by Фамил Гаджиев on 02.11.16.
//  Copyright © 2016 Фамил Гаджиев. All rights reserved.
//

import UIKit
import IDZSwiftCommonCrypto


class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var loginEnter: RoundTextField!
    @IBOutlet weak var passwordEnter: RoundTextField!
    @IBOutlet weak var signIn: RoundButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var stackViewBottomConstrain: NSLayoutConstraint!
    @IBOutlet weak var sinInConst: NSLayoutConstraint!
    
    var presentedModally = false
    
    struct StoryboardConstants {
        static let goToTabSegueIdentifier = "GoToMainFromAuth"
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
       
        loginEnter.leftView = UIImageView(image: UIImage(named: "loginIcon"))
        passwordEnter.leftView = UIImageView(image: UIImage(named: "passwordIcon"))
        
        
        loginEnter.delegate = self
        registerForKeyboardNotification()
        

    }
    
    
    @IBAction func topText(_ sender: Any) {
        print("Touch")
    }
    

    @IBAction func loginAction(_ sender: AnyObject) {
        
        let loginInput = self.loginEnter.text!
        let password = self.passwordEnter.text!
            
        let md5s2: Digest = Digest(algorithm: .md5)
        md5s2.update(string: password)
        let digest = md5s2.final()
        
        apiManager.auth(login: loginInput, pass: hexString(fromArray: digest)) { result in
            
            switch result {
            case .success(let userData):
                userData.writeToUserDefaults()
                DispatchQueue.main.async { [weak welf = self] in
                    if welf != nil {
                        if welf!.presentedModally {
                            welf!.dismiss(animated: true, completion: nil)
                            print(" это ХЕШ!!  \(userData.hash!)")
                        } else {
                            welf!.performSegue(withIdentifier: StoryboardConstants.goToTabSegueIdentifier, sender: self)
                        }
                    }
                }
                
            case .failure(let err):
                
                let error = AvionicusError(rawValue: err._code)
                DispatchQueue.main.async {
                    let errorAlert = UIAlertController.errorAlert(title: "Error", message: error?.description, buttonTitle: "Try again")
                    self.present(errorAlert, animated: true, completion: nil)
                }
            }
        }
    }
    
    func registerForKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(kbWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
         NotificationCenter.default.addObserver(self, selector: #selector(kbWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    func removeKeyboardNotification()  {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
    }
    
    func kbWillShow(_ notifitacion: Notification) {
        let userInfo = notifitacion.userInfo
        let kbFrame = (userInfo?[UIKeyboardFrameEndUserInfoKey] as! NSValue ).cgRectValue
        scrollView.contentOffset = CGPoint(x: 0, y: (kbFrame.height) - 200)
        
    }
    
    func kbWillHide() {
        scrollView.contentOffset = CGPoint.zero
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let text = (loginEnter.text! as NSString).replacingCharacters(in: range, with: string)
        
        if !text.isEmpty{
            signIn.isUserInteractionEnabled = true
        } else {
            signIn.isUserInteractionEnabled = true
        }
        return true
    }
    
    
    deinit {
        removeKeyboardNotification()
    }
}
