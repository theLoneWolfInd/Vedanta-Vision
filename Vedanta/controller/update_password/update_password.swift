//
//  update_password.swift
//  Vedanta
//
//  Created by Dishant Rajput on 29/03/23.
//

import UIKit
import Alamofire

class update_password: UIViewController , UITextFieldDelegate {

    var str_get_email:String!
    var str_get_OTP:String!
    
    @IBOutlet weak var btn_back:UIButton! {
        didSet {
            btn_back.tintColor = .black
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
            txt_password.placeholder = "Password"
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
            txt_confirm_password.placeholder = "Confirm Password"
        }
    }
    
    @IBOutlet weak var btnUpdatePassword:UIButton! {
        didSet {
            btnUpdatePassword.layer.cornerRadius = 27.5
            btnUpdatePassword.clipsToBounds = true
            btnUpdatePassword.setTitle("Update", for: .normal)
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
        
        self.txt_password.delegate = self
        self.txt_confirm_password.delegate = self
        
        self.btnUpdatePassword.addTarget(self, action: #selector(validationBeforeChangePassword), for: .touchUpInside)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.view.endEditing(true)
    }

    @objc func validationBeforeChangePassword() {
        
        if self.txt_password.text == "" {
            
            let alert = UIAlertController(title: String("Error!"), message: String("Password should not be Empty."), preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { action in
                
            }))
            self.present(alert, animated: true, completion: nil)
            
        } else if self.txt_confirm_password.text == "" {
            
            let alert = UIAlertController(title: String("Error!"), message: String("Confirm Password should not be Empty."), preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { action in
                
            }))
            self.present(alert, animated: true, completion: nil)
            
        }  else if self.txt_confirm_password.text != self.txt_confirm_password.text {
            
            let alert = UIAlertController(title: String("Error!"), message: String("Password not matched."), preferredStyle: UIAlertController.Style.alert)
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
            "email"     : String(self.str_get_email),
            "OTP"       : String(self.str_get_OTP),
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
                        // self.navigationController?.popViewController(animated: true)
                        
                        
                        let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "tab_bar_id") as? tab_bar
                        push!.hidesBottomBarWhenPushed = true
                        push!.selectedIndex = 0
                        self.navigationController?.pushViewController(push!, animated: true)
                        
                        
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
