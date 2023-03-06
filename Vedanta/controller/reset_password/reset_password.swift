//
//  reset_password.swift
//  Vedanta
//
//  Created by Dishant Rajput on 21/10/22.
//

import UIKit
import Alamofire

class reset_password: UIViewController , UITextFieldDelegate {
    
    @IBOutlet weak var btn_back:UIButton! {
        didSet {
            btn_back.tintColor = .black
        }
    }
    
    @IBOutlet weak var txt_email:UITextField! {
        didSet {
            txt_email.setLeftPaddingPoints(24)
            txt_email.layer.borderColor = UIColor.lightGray.cgColor
            txt_email.layer.borderWidth = 0.8
            txt_email.layer.cornerRadius = 8
            txt_email.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var txt_opt:UITextField! {
        didSet {
            txt_opt.setLeftPaddingPoints(24)
            txt_opt.layer.borderColor = UIColor.lightGray.cgColor
            txt_opt.layer.borderWidth = 0.8
            txt_opt.layer.cornerRadius = 8
            txt_opt.clipsToBounds = true
            txt_opt.isSecureTextEntry = true
        }
    }
    
    @IBOutlet weak var txt_password:UITextField! {
        didSet {
            txt_password.setLeftPaddingPoints(24)
            txt_password.layer.borderColor = UIColor.lightGray.cgColor
            txt_password.layer.borderWidth = 0.8
            txt_password.layer.cornerRadius = 8
            txt_password.clipsToBounds = true
            txt_password.isSecureTextEntry = true
        }
    }
    
    @IBOutlet weak var txt_confirm_password:UITextField! {
        didSet {
            txt_confirm_password.setLeftPaddingPoints(24)
            txt_confirm_password.layer.borderColor = UIColor.lightGray.cgColor
            txt_confirm_password.layer.borderWidth = 0.8
            txt_confirm_password.layer.cornerRadius = 8
            txt_confirm_password.clipsToBounds = true
            txt_confirm_password.isSecureTextEntry = true
        }
    }
    
    @IBOutlet weak var btn_eye_pass:UIButton!
    @IBOutlet weak var btn_eye_confirm_pass:UIButton!
    
    @IBOutlet weak var btnUpdatePassword:UIButton! {
        didSet {
            btnUpdatePassword.layer.cornerRadius = 27.5
            btnUpdatePassword.clipsToBounds = true
            btnUpdatePassword.setTitle("Edit", for: .normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
 
        self.navigationController?.isNavigationBarHidden = true
        self.view.backgroundColor = .white
        
        self.btn_back.addTarget(self, action: #selector(back_click_method), for: .touchUpInside)
        
        self.hideKeyboardWhenTappedAround()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow_2), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide_2), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        self.btnUpdatePassword.addTarget(self, action: #selector(validationBeforeChangePassword), for: .touchUpInside)
        
        self.btn_eye_pass.addTarget(self, action: #selector(pass_eye_click_method), for: .touchUpInside)
        
        self.btn_eye_confirm_pass.addTarget(self, action: #selector(pass_confirm_eye_click_method), for: .touchUpInside)
        
    }
    
    @objc func pass_eye_click_method() {
        
        if self.btn_eye_pass.tag == 0 {
            
            self.btn_eye_pass.tag = 1
            self.txt_password.isSecureTextEntry = false
            self.btn_eye_pass.setImage(UIImage(systemName: "eye.slash"), for: .normal)
            
        } else {
            
            self.btn_eye_pass.tag = 0
            self.txt_password.isSecureTextEntry = true
            self.btn_eye_pass.setImage(UIImage(systemName: "eye"), for: .normal)
            
        }
        
    }
    
    @objc func pass_confirm_eye_click_method() {
        
        if self.btn_eye_confirm_pass.tag == 0 {
            
            self.btn_eye_confirm_pass.tag = 1
            self.txt_confirm_password.isSecureTextEntry = false
            self.btn_eye_confirm_pass.setImage(UIImage(systemName: "eye.slash"), for: .normal)
            
        } else {
            
            self.btn_eye_confirm_pass.tag = 0
            self.txt_confirm_password.isSecureTextEntry = true
            self.btn_eye_confirm_pass.setImage(UIImage(systemName: "eye"), for: .normal)
            
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.view.endEditing(true)
    }
    
    @objc func validationBeforeChangePassword() {
        
        if self.txt_email.text == "" {
            
            let alert = UIAlertController(title: String("Error!"), message: String("Email address should not be Empty."), preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { action in
                
            }))
            self.present(alert, animated: true, completion: nil)
            
        } else if self.txt_opt.text == "" {
            
            let alert = UIAlertController(title: String("Error!"), message: String("OTP should not be Empty."), preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { action in
                
            }))
            self.present(alert, animated: true, completion: nil)
            
        } else if self.txt_password.text == "" {
            
            let alert = UIAlertController(title: String("Error!"), message: String("Password should not be Empty."), preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { action in
                
            }))
            self.present(alert, animated: true, completion: nil)
            
        } else if self.txt_password.text != self.txt_confirm_password.text {
            
            let alert = UIAlertController(title: String("Error!"), message: String("password not matched."), preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { action in
                
            }))
            self.present(alert, animated: true, completion: nil)
            
        } else {
            
            self.changePasswordWB()
        }
        
        
    }
    
    
    @objc func changePasswordWB() {
        ERProgressHud.sharedInstance.showDarkBackgroundView(withTitle: "Please wait...")
        
        self.view.endEditing(true)
        
        
        
        let parameters = [
            "action"    : "resetpassword",
            "email"     : String(self.txt_email.text!),
            "OTP"       : String(self.txt_opt.text!),
            "password"  : String(self.txt_password.text!),
        ]
        
        print(parameters as Any)
        
        AF.request(application_base_url,
                   method: .post,
                   parameters: parameters,
                   encoder: JSONParameterEncoder.default).responseJSON { response in
            // debugPrint(response.result)
            
            switch response.result {
            case let .success(value):
                
                let JSON = value as! NSDictionary
                print(JSON as Any)
                
                var strSuccess : String!
                strSuccess = JSON["status"]as Any as? String
                
                var strSuccess2 : String!
                strSuccess2 = JSON["msg"]as Any as? String
                
                if strSuccess == String("success") {
                    print("yes")
                    ERProgressHud.sharedInstance.hide()
                    
                    let alert = NewYorkAlertController(title: String("Success"), message: String(strSuccess2), style: .alert)
                    let cancel = NewYorkButton(title: "Done", style: .cancel) {
                        _ in
                        self.navigationController?.popViewController(animated: true)
                    }
                    alert.addButtons([cancel])
                    self.present(alert, animated: true)
                    
                } else {
                    
                    print("no")
                    ERProgressHud.sharedInstance.hide()
                    
                    var strSuccess2 : String!
                    strSuccess2 = JSON["msg"]as Any as? String
                    
                    let alert = UIAlertController(title: String(strSuccess), message: String(strSuccess2), preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    
                }
                
            case let .failure(error):
                print(error)
                ERProgressHud.sharedInstance.hide()
                
                let alert = UIAlertController(title: String("Error!"), message: String("Server Issue"), preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
            }
        }
        
    }
    
}
