//
//  sign_up_form.swift
//  Vedanta
//
//  Created by Dishant Rajput on 15/09/22.
//

import UIKit
import Alamofire

class sign_up_form: UIViewController {

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
    
    @IBOutlet weak var tble_view:UITableView! {
        didSet {
            tble_view.delegate = self
            tble_view.dataSource = self
            tble_view.backgroundColor = .clear
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.view_full_view.backgroundColor = app_BG_color
        
        self.tble_view.separatorColor = .clear
        
        self.btn_back.addTarget(self, action: #selector(back_click_method), for: .touchUpInside)
        
    }

    @objc func validation_before_sign_up() {
        
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tble_view.cellForRow(at: indexPath) as! sign_up_form_table_cell
        
        if cell.txt_full_name.text! == "" {
             
        } else if cell.txt_email.text! == "" {
            
        } else if cell.txt_phone.text! == "" {
            
        } else if cell.txt_password.text! == "" {
            
        } else if cell.txt_confirm_password.text! == "" {
            
        } else if cell.txt_password.text! != cell.txt_confirm_password.text! {
            
        } else {
        
            self.registeration_in_vedanta_WB()
            
        }
        
        
    }
    
    // MARK: - WEBSERVICE ( REGISTRATION ) -
    @objc func registeration_in_vedanta_WB() {
        self.view.endEditing(true)
        
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tble_view.cellForRow(at: indexPath) as! sign_up_form_table_cell
        
        ERProgressHud.sharedInstance.showDarkBackgroundView(withTitle: "Please wait...")
        
        if IsInternetAvailable() == false {
            self.please_check_your_internet_connection()
            return
        }
    
        let parameters = [
            "action"            : "registration",
            "email"             : String(cell.txt_email.text!),
            "password"          : String(cell.txt_password.text!),
            "fullName"          : String(cell.txt_full_name.text!),
            "contactNumber"     : String(cell.txt_phone.text!),
            "role"              : "Member"
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
                            
                            var dict: Dictionary<AnyHashable, Any>
                            dict = jsonDict["data"] as! Dictionary<AnyHashable, Any>
                            
                            let defaults = UserDefaults.standard
                            defaults.setValue(dict, forKey: str_save_login_user_data)
                            
                            self.navigationController?.popToRootViewController(animated: true)
                            /*let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "tab_bar_id") as? tab_bar
                            push!.hidesBottomBarWhenPushed = true
                            push!.selectedIndex = 0
                            self.navigationController?.pushViewController(push!, animated: true)*/
                            
                        } else {
                            
                            print("=====> no")
                            ERProgressHud.sharedInstance.hide()
                            
                            let alert = NewYorkAlertController(title: String(status_alert), message: String(str_data_message), style: .alert)
                            let cancel = NewYorkButton(title: "dismiss", style: .cancel)
                            alert.addButtons([cancel])
                            self.present(alert, animated: true)
                            
                        }
                        
                    } else {
                        
                        self.please_check_your_internet_connection()
                        
                        return
                    }
                    
                } catch _ {
                    print("Exception!")
                    ERProgressHud.sharedInstance.hide()
                    
                    print(response.error?.localizedDescription as Any, terminator: "<==== I AM ERROR")
                    
                    self.something_went_wrong_with_WB()
                    
                }
            }
    }
    
}

extension sign_up_form : UITableViewDelegate , UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:sign_up_form_table_cell = tableView.dequeueReusableCell(withIdentifier: "sign_up_form_table_cell") as! sign_up_form_table_cell
        
        cell.backgroundColor = .clear
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = .clear
        cell.selectedBackgroundView = backgroundView
        
        cell.btn_sign_up.addTarget(self, action: #selector(validation_before_sign_up), for: .touchUpInside)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 1200
    }
    
}

class sign_up_form_table_cell:UITableViewCell {
    
    @IBOutlet weak var img_view:UIImageView! {
        didSet {
            img_view.backgroundColor = .clear
        }
    }
    
    @IBOutlet weak var txt_full_name:UITextField! {
        didSet {
            txt_full_name.setLeftPaddingPoints(24)
            txt_full_name.layer.borderColor = UIColor.lightGray.cgColor
            txt_full_name.layer.borderWidth = 0.8
            txt_full_name.layer.cornerRadius = 8
            txt_full_name.clipsToBounds = true
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
    
    @IBOutlet weak var txt_phone:UITextField! {
        didSet {
            txt_phone.setLeftPaddingPoints(24)
            txt_phone.layer.borderColor = UIColor.lightGray.cgColor
            txt_phone.layer.borderWidth = 0.8
            txt_phone.layer.cornerRadius = 8
            txt_phone.clipsToBounds = true
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
    
    @IBOutlet weak var btn_sign_up:UIButton! {
        didSet {
            btn_sign_up.layer.cornerRadius = 8
            btn_sign_up.clipsToBounds = true
        }
    }
    
}
