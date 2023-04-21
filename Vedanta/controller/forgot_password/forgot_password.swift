//
//  forgot_password.swift
//  Vedanta
//
//  Created by Dishant Rajput on 17/03/23.
//

import UIKit
import Alamofire

class forgot_password: UIViewController , UITextFieldDelegate {

    @IBOutlet weak var btn_back:UIButton! {
        didSet {
            btn_back.tintColor = .black
        }
    }
    
    @IBOutlet weak var view_full_view:UIView! {
        didSet {
            view_full_view.backgroundColor = UIColor.init(red: 246.0/255.0, green: 246.0/255.0, blue: 246.0/255.0, alpha: 1)
        }
    }
    
    @IBOutlet weak var txt_email_address:UITextField! {
        didSet {
            txt_email_address.setLeftPaddingPoints(24)
            txt_email_address.layer.borderColor = UIColor.lightGray.cgColor
            txt_email_address.layer.borderWidth = 0.8
            txt_email_address.layer.cornerRadius = 8
            txt_email_address.clipsToBounds = true
            txt_email_address.isSecureTextEntry = false
            txt_email_address.placeholder = "Email address"
            txt_email_address.keyboardType = .emailAddress
        }
    }
    
    @IBOutlet weak var btn_sign_up:UIButton! {
        didSet {
            btn_sign_up.layer.cornerRadius = 8
            btn_sign_up.clipsToBounds = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow_2), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide_2), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        self.view.backgroundColor = .white
        self.view_full_view.backgroundColor = app_BG_color
         
        self.btn_back.addTarget(self, action: #selector(back_click_method), for: .touchUpInside)
        
        self.btn_sign_up.addTarget(self, action: #selector(validation_before_forgot), for: .touchUpInside)
        
    }

    
    @objc func validation_before_forgot() {
        
         
        
        if self.txt_email_address.text! == "" {
            
           let alert = NewYorkAlertController(title: String("Alert"), message: String("Email should not be empty"), style: .alert)
           let cancel = NewYorkButton(title: "Dismiss", style: .cancel)
           alert.addButtons([cancel])
           self.present(alert, animated: true)
           
        } else {
        
            self.forgot_password_click_method_WB()
            
        }
        
        
    }
    
    
    // MARK: - WEBSERVICE ( LOGIN ) -
    @objc func forgot_password_click_method_WB() {
        self.view.endEditing(true)
        
        ERProgressHud.sharedInstance.showDarkBackgroundView(withTitle: "Please wait...")
        
        if IsInternetAvailable() == false {
            self.please_check_your_internet_connection()
            return
        }
        
        let parameters = [
            "action"    : "forgotpassword",
            "email"     : String(self.txt_email_address.text!)
        ]
        
        print(parameters as Any)
        
        AF.request(application_base_url, method: .post, parameters: parameters)
        
            .response { response in
                
                do {
                    if response.error != nil{
                        print(response.error as Any, terminator: "")
                    }
                    
                    if let jsonDict = try JSONSerialization.jsonObject(with: (response.data as Data?)!, options: []) as? [String: AnyObject]{
                        
                        print(jsonDict as Any, terminator: "")
                        
                        // for status alert
                        var status_alert : String!
                        status_alert = (jsonDict["status"] as? String)
                        
                        // for message alert
                        var str_data_message : String!
                        str_data_message = jsonDict["msg"] as? String
                        
                        if status_alert.lowercased() == "success" {
                            
                            print("=====> yes")
                            ERProgressHud.sharedInstance.hide()
                            
                            
                            let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "reset_password_id") as? reset_password
                            
                            push!.str_email = String(self.txt_email_address.text!)
                            
                            self.navigationController?.pushViewController(push!, animated: true)
                            
                            
                            let alert = NewYorkAlertController(title: String("Alert"), message: String(str_data_message), style: .alert)
                            
                            let cancel = NewYorkButton(title: "Dismiss", style: .cancel)
                            
                            alert.addButtons([cancel])
                            self.present(alert, animated: true)
                            
                        } else {
                            
                            print("=====> no")
                            ERProgressHud.sharedInstance.hide()
                            
                            let alert = NewYorkAlertController(title: String(status_alert), message: String(str_data_message), style: .alert)
                            let cancel = NewYorkButton(title: "Dismiss", style: .cancel)
                            alert.addButtons([cancel])
                            self.present(alert, animated: true)
                            
                        }
                        
                    } else {
                        
                        self.please_check_your_internet_connection()
                        
                        return
                    }
                    
                } catch _ {
                    print("Exception!")
                }
            }
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
    }
    
}
