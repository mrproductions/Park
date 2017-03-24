//
//  LoginVC.swift
//  avionicus
//
//  Created by Фамил Гаджиев on 02.11.16.
//  Copyright © 2016 Фамил Гаджиев. All rights reserved.
//

import UIKit
import Alamofire
import IDZSwiftCommonCrypto


class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var loginEnter: RoundTextField!
    @IBOutlet weak var passwordEnter: RoundTextField!
    @IBOutlet weak var signIn: RoundButton!
    @IBOutlet weak var scrollView: UIScrollView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginEnter.delegate = self
        registerForKeyboardNotification()
        
    }
    deinit {
        removeKeyboardNotification()
    }
    
    @IBAction func topText(_ sender: Any) {
        print("Touch")
    }
    

    @IBAction func loginAction(_ sender: AnyObject) {
        
        let loginInput = "famil"//self.loginEnter.text!
        let password = "12786978"//self.passwordEnter.text!
        
        let md5s2: Digest = Digest(algorithm: .md5)
        md5s2.update(string: password)
        let digest = md5s2.final()
        
        apiManager.auth(login: loginInput, pass: hexString(fromArray: digest)) { result in
            
            switch result {
            case .success(let userData):
                userData.writeToUserDefaults()
                print("Hash is \(userData.hash)")
                print(userData.sMsgTitle!)
                
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: AvionicusSegues.goToTab, sender: self)
                }
                
            case .failure(let error):
                
                print("ERROR! \(error.localizedDescription)")
                DispatchQueue.main.async {
                    let errorAlert = UIAlertController(title: "Error", message: " Что то пошло не так, попробуй снова =( ", preferredStyle: UIAlertControllerStyle.alert)
                    let actionError = UIAlertAction(title: "Try Again", style: .cancel, handler: nil)
                    errorAlert.addAction(actionError)
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
        scrollView.contentOffset = CGPoint(x: 0, y: (kbFrame.height) - 30.0)
        
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
}
