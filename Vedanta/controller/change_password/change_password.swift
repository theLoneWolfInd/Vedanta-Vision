//
//  change_password.swift
//  Vedanta
//
//  Created by Dishant Rajput on 20/10/22.
//

import UIKit
import Alamofire

class change_password: UIViewController , UITextFieldDelegate {
    
    
    @IBOutlet weak var viewNavigationbar:UIView!
    @IBOutlet weak var btnDashboardMenu:UIButton! {
        didSet {
            btnDashboardMenu.tintColor = .black
        }
    }
    
    @IBOutlet weak var lblNavationbar:UILabel!{
        didSet {
            
            lblNavationbar.text = "CHANGE PASSWORD"
        }
    }
    
    @IBOutlet weak var btn_eye_old_pass:UIButton!
    @IBOutlet weak var btn_eye_pass:UIButton!
    @IBOutlet weak var btn_eye_confirm_pass:UIButton!
    
    @IBOutlet weak var txtCurrentPassword:UITextField! {
        didSet {
            txtCurrentPassword.setLeftPaddingPoints(24)
            txtCurrentPassword.layer.borderColor = UIColor.lightGray.cgColor
            txtCurrentPassword.layer.borderWidth = 0.8
            txtCurrentPassword.layer.cornerRadius = 8
            txtCurrentPassword.clipsToBounds = true
            txtCurrentPassword.delegate = self
            txtCurrentPassword.isSecureTextEntry = true
        }
    }
    
    @IBOutlet weak var txtNewPassword:UITextField! {
        didSet {
            txtNewPassword.setLeftPaddingPoints(24)
            txtNewPassword.layer.borderColor = UIColor.lightGray.cgColor
            txtNewPassword.layer.borderWidth = 0.8
            txtNewPassword.layer.cornerRadius = 8
            txtNewPassword.clipsToBounds = true
            txtNewPassword.delegate = self
            txtNewPassword.isSecureTextEntry = true
        }
    }
    
    @IBOutlet weak var txtConfirmNewPassword:UITextField! {
        didSet {
            txtConfirmNewPassword.setLeftPaddingPoints(24)
            txtConfirmNewPassword.layer.borderColor = UIColor.lightGray.cgColor
            txtConfirmNewPassword.layer.borderWidth = 0.8
            txtConfirmNewPassword.layer.cornerRadius = 8
            txtConfirmNewPassword.clipsToBounds = true
            txtConfirmNewPassword.delegate = self
            txtConfirmNewPassword.isSecureTextEntry = true
        }
    }
    
    @IBOutlet weak var btnUpdatePassword:UIButton!{
        didSet {
            btnUpdatePassword.layer.cornerRadius = 26
            btnUpdatePassword.clipsToBounds = true
            btnUpdatePassword.setTitle("Update password", for: .normal)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow_2), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide_2), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        self.navigationController?.isNavigationBarHidden = true
        self.view.backgroundColor = .white
        
        self.btnUpdatePassword.addTarget(self, action: #selector(validationBeforeChangePassword), for: .touchUpInside)
        
        self.btn_eye_old_pass.addTarget(self, action: #selector(old_pass_eye_click_method), for: .touchUpInside)
        
        self.btn_eye_pass.addTarget(self, action: #selector(pass_eye_click_method), for: .touchUpInside)
        
        self.btn_eye_confirm_pass.addTarget(self, action: #selector(pass_confirm_eye_click_method), for: .touchUpInside)
        
        
        self.btnDashboardMenu.addTarget(self, action: #selector(back_click_method), for: .touchUpInside)
        
    }
    
    @objc func old_pass_eye_click_method() {
        
        if self.btn_eye_old_pass.tag == 0 {
            
            self.btn_eye_old_pass.tag = 1
            self.txtCurrentPassword.isSecureTextEntry = false
            self.btn_eye_old_pass.setImage(UIImage(systemName: "eye.slash"), for: .normal)
            
        } else {
            
            self.btn_eye_old_pass.tag = 0
            self.txtCurrentPassword.isSecureTextEntry = true
            self.btn_eye_old_pass.setImage(UIImage(systemName: "eye"), for: .normal)
            
        }
        
    }
    
    @objc func pass_eye_click_method() {
        
        if self.btn_eye_pass.tag == 0 {
            
            self.btn_eye_pass.tag = 1
            self.txtNewPassword.isSecureTextEntry = false
            self.btn_eye_pass.setImage(UIImage(systemName: "eye.slash"), for: .normal)
            
        } else {
            
            self.btn_eye_pass.tag = 0
            self.txtNewPassword.isSecureTextEntry = true
            self.btn_eye_pass.setImage(UIImage(systemName: "eye"), for: .normal)
            
        }
        
    }
    
    @objc func pass_confirm_eye_click_method() {
        
        if self.btn_eye_confirm_pass.tag == 0 {
            
            self.btn_eye_confirm_pass.tag = 1
            self.txtConfirmNewPassword.isSecureTextEntry = false
            self.btn_eye_confirm_pass.setImage(UIImage(systemName: "eye.slash"), for: .normal)
            
        } else {
            
            self.btn_eye_confirm_pass.tag = 0
            self.txtConfirmNewPassword.isSecureTextEntry = true
            self.btn_eye_confirm_pass.setImage(UIImage(systemName: "eye"), for: .normal)
            
        }
        
    }
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.view.endEditing(true)
    }
    
    
    
    @objc func validationBeforeChangePassword() {
        
        if self.txtCurrentPassword.text == "" {
            
            let alert = UIAlertController(title: String("Error!"), message: String("Current Password should not be Empty."), preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { action in
                
            }))
            self.present(alert, animated: true, completion: nil)
            
        } else if self.txtNewPassword.text == "" {
            
            let alert = UIAlertController(title: String("Error!"), message: String("New Password should not be Empty."), preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { action in
                
            }))
            self.present(alert, animated: true, completion: nil)
            
        } else if self.txtConfirmNewPassword.text == "" {
            
            let alert = UIAlertController(title: String("Error!"), message: String("Confirm Password should not be Empty."), preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { action in
                
            }))
            self.present(alert, animated: true, completion: nil)
            
        } else if self.txtNewPassword.text != self.txtConfirmNewPassword.text {
            
            let alert = UIAlertController(title: String("Error!"), message: String("Password not match."), preferredStyle: UIAlertController.Style.alert)
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
        
        if let person = UserDefaults.standard.value(forKey: "keyLoginFullData") as? [String:Any] {
            // let str:String = person["role"] as! String
            
            let x : Int = person["userId"] as! Int
            let myString = String(x)
            
            let parameters = [
                "action"        : "changePassword",
                "userId"        : String(myString),
                "oldPassword"   : String(self.txtCurrentPassword.text!),
                "newPassword"   : String(self.txtNewPassword.text!),
                
            ]
            
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
                        
                        let alert = UIAlertController(title: String(strSuccess), message: String(strSuccess2), preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { action in
                            
                            self.txtCurrentPassword.text = ""
                            self.txtNewPassword.text = ""
                            self.txtConfirmNewPassword.text = ""
                            
                        }))
                        self.present(alert, animated: true, completion: nil)
                        
                        
                        
                        
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
    
}
