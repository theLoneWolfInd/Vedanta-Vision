//
//  sign_up_form.swift
//  Vedanta
//
//  Created by Dishant Rajput on 15/09/22.
//

import UIKit
import Alamofire

import CountryList
import JNPhoneNumberView

class sign_up_form: UIViewController , UITextFieldDelegate, CountryListDelegate {

    var countryList = CountryList()
    
    @IBOutlet private weak var phoneNumberView: JNPhoneNumberView! {
        didSet {
            phoneNumberView.layer.borderColor = UIColor.lightGray.cgColor
            phoneNumberView.layer.borderWidth = 0.8
            phoneNumberView.layer.cornerRadius = 8
            phoneNumberView.clipsToBounds = true
            phoneNumberView.backgroundColor = .white
            // phoneNumberView.keyboardType = .numberPad
            // phoneNumberView.textAlignment = .center
        }
    }
    
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
    
//    @IBOutlet weak var tble_view:UITableView! {
//        didSet {
//            tble_view.delegate = self
//            tble_view.dataSource = self
//            tble_view.backgroundColor = .clear
//        }
//    }
    
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
            txt_full_name.spellCheckingType = .no
        }
        
    }
    
    @IBOutlet weak var txt_email:UITextField! {
        didSet {
            txt_email.setLeftPaddingPoints(24)
            txt_email.layer.borderColor = UIColor.lightGray.cgColor
            txt_email.layer.borderWidth = 0.8
            txt_email.layer.cornerRadius = 8
            txt_email.clipsToBounds = true
            txt_email.keyboardType = .emailAddress
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
    
    @IBOutlet weak var txt_phone_country_code:UITextField! {
        didSet {
//            txt_phone_country_code.setLeftPaddingPoints(24)
            txt_phone_country_code.layer.borderColor = UIColor.lightGray.cgColor
            txt_phone_country_code.layer.borderWidth = 0.8
            txt_phone_country_code.layer.cornerRadius = 8
            txt_phone_country_code.clipsToBounds = true
            txt_phone_country_code.keyboardType = .numberPad
            txt_phone_country_code.textAlignment = .center
            
        }
    }
    
    @IBOutlet weak var txt_phone:UITextField! {
        didSet {
            txt_phone.setLeftPaddingPoints(24)
            txt_phone.layer.borderColor = UIColor.lightGray.cgColor
            txt_phone.layer.borderWidth = 0.8
            txt_phone.layer.cornerRadius = 8
            txt_phone.clipsToBounds = true
            txt_phone.keyboardType = .numberPad
            txt_phone.placeholder = "Phone number"
        }
    }
    
    @IBOutlet weak var btn_flag:UIButton!
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard_2))
        view.addGestureRecognizer(tap)
        
        self.view.backgroundColor = .white
        self.view_full_view.backgroundColor = app_BG_color
        
        self.txt_email.delegate = self
        self.txt_password.delegate = self
         self.txt_phone.delegate = self
        self.txt_full_name.delegate = self
        self.txt_confirm_password.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow_3), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide_3), name: UIResponder.keyboardWillHideNotification, object: nil)
        
//        self.tble_view.separatorColor = .clear
        
        //
        countryList.delegate = self
        
        self.btn_sign_up.addTarget(self, action: #selector(validation_before_sign_up), for: .touchUpInside)
        
        self.btn_back.addTarget(self, action: #selector(back_click_method), for: .touchUpInside)
        
        // Set delegate
        /*self.phoneNumberView.delegate = self
        self.phoneNumberView.setDefaultCountryCode("US")
        self.phoneNumberView.backgroundColor = UIColor.gray
        self.phoneNumberView.setViewConfiguration(self.getConfigration())
        self.phoneNumberView.setPhoneNumber("")
        self.phoneNumberView.layer.cornerRadius = 5.0
        self.phoneNumberView.layer.borderColor = UIColor.lightGray.cgColor
        self.phoneNumberView.layer.borderWidth = 1.0
        self.phoneNumberView.backgroundColor = UIColor.lightGray
        
        self.phoneNumberView.layer.borderColor = UIColor.lightGray.cgColor
        self.phoneNumberView.layer.borderWidth = 0.8
        self.phoneNumberView.layer.cornerRadius = 8
        self.phoneNumberView.clipsToBounds = true
        self.phoneNumberView.backgroundColor = .clear
        self.phoneNumberView.tintColor = .black*/
        
    }
    
    @objc func keyboardWillShow_3(sender: NSNotification) {
         self.view.frame.origin.y = -150 // Move view 150 points upward
    }

    @objc func keyboardWillHide_3(sender: NSNotification) {
         self.view.frame.origin.y = 0 // Move view to original position
    }
    
    @objc func dismissKeyboard_2() {
//        self.tble_view.setContentOffset(CGPointZero, animated:true)
        self.view.endEditing(true)
    }

    @objc func validation_before_sign_up() {
        
//        let indexPath = IndexPath.init(row: 0, section: 0)
//        let cell = self.tble_view.cellForRow(at: indexPath) as! sign_up_form_table_cell
        
        if self.txt_full_name.text! == "" {
             
            let alert = NewYorkAlertController(title: String("Alert"), message: String("Name should not be empty"), style: .alert)
            let cancel = NewYorkButton(title: "Dismiss", style: .cancel)
            alert.addButtons([cancel])
            self.present(alert, animated: true)
            
        } else if self.txt_email.text! == "" {
            
           let alert = NewYorkAlertController(title: String("Alert"), message: String("Email should not be empty"), style: .alert)
           let cancel = NewYorkButton(title: "Dismiss", style: .cancel)
           alert.addButtons([cancel])
           self.present(alert, animated: true)
           
        } else if self.txt_phone_country_code.text! == "" {
            
            let alert = NewYorkAlertController(title: String("Alert"), message: String("Country code should not be empty"), style: .alert)
            let cancel = NewYorkButton(title: "Dismiss", style: .cancel)
            alert.addButtons([cancel])
            self.present(alert, animated: true)
            
         } else if self.txt_phone.text! == "" {
            
           let alert = NewYorkAlertController(title: String("Alert"), message: String("Phone should not be empty"), style: .alert)
           let cancel = NewYorkButton(title: "Dismiss", style: .cancel)
           alert.addButtons([cancel])
           self.present(alert, animated: true)
           
        } else if self.txt_password.text! == "" {
            
           let alert = NewYorkAlertController(title: String("Alert"), message: String("Password should not be empty"), style: .alert)
           let cancel = NewYorkButton(title: "Dismiss", style: .cancel)
           alert.addButtons([cancel])
           self.present(alert, animated: true)
           
        } else if self.txt_confirm_password.text! == "" {
            
           let alert = NewYorkAlertController(title: String("Alert"), message: String("Confirm Password should not be empty"), style: .alert)
           let cancel = NewYorkButton(title: "Dismiss", style: .cancel)
           alert.addButtons([cancel])
           self.present(alert, animated: true)
           
        } else if self.txt_password.text! != self.txt_confirm_password.text! {
            
            
           let alert = NewYorkAlertController(title: String("Alert"), message: String("Password not matched. Please try again"), style: .alert)
           let cancel = NewYorkButton(title: "Dismiss", style: .cancel)
           alert.addButtons([cancel])
           self.present(alert, animated: true)
           
            
        } else {
//            print( as Any)
            
            
            if isValidEmail(testStr: self.txt_email.text!) {
                print("Validate EmailID")
                
                if (self.txt_phone.text?.count == 10) {
                    //
                    if (self.txt_password.text!.count < 6) {
                        
                        let alert = NewYorkAlertController(title: String("Alert"), message: String("Password should be greater then 6 characters."), style: .alert)
                        let cancel = NewYorkButton(title: "Dismiss", style: .cancel)
                        alert.addButtons([cancel])
                        self.present(alert, animated: true)
                        
                    } else {
                        self.registeration_in_vedanta_WB()
                    }
                    
                    //
                } else {
                    let alert = NewYorkAlertController(title: String("Alert"), message: String("Please enter valid phone number"), style: .alert)
                    let cancel = NewYorkButton(title: "Dismiss", style: .cancel)
                    alert.addButtons([cancel])
                    self.present(alert, animated: true)
                }
                
            }
            else {
                
                print("invalide EmailID")
                let alert = NewYorkAlertController(title: String("Alert"), message: String("Please enter valid email address"), style: .alert)
                let cancel = NewYorkButton(title: "Dismiss", style: .cancel)
                alert.addButtons([cancel])
                self.present(alert, animated: true)
            }
            
            //
            
        }
        
        
    }
    
    // MARK: - WEBSERVICE ( REGISTRATION ) -
    @objc func registeration_in_vedanta_WB() {
        self.view.endEditing(true)
        
//        let indexPath = IndexPath.init(row: 0, section: 0)
//        let cell = self.tble_view.cellForRow(at: indexPath) as! sign_up_form_table_cell
        
        ERProgressHud.sharedInstance.showDarkBackgroundView(withTitle: "Please wait...")
        
        if IsInternetAvailable() == false {
            self.please_check_your_internet_connection()
            return
        }
    
        let parameters = [
            "action"            : "registration",
            "email"             : String(self.txt_email.text!),
            "password"          : String(self.txt_password.text!),
            "fullName"          : String(self.txt_full_name.text!),
            "contactNumber"     : String(self.txt_phone.text!)+String(self.txt_phone.text!),
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
                    ERProgressHud.sharedInstance.hide()
                    
                    print(response.error?.localizedDescription as Any, terminator: "<==== I AM ERROR")
                    
                    self.something_went_wrong_with_WB()
                    
                }
            }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // self.tble_view.setContentOffset(CGPointZero, animated:true)
        self.view.endEditing(true)
        return true
    }
    
    func isValidEmail(testStr:String) -> Bool {

    // println("validate emilId: \(testStr)")

    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"

        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)

        let result = emailTest.evaluate(with: testStr)

        return result

    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == self.txt_phone {
            let maxLength = 10
            let currentString = (textField.text ?? "") as NSString
            let newString = currentString.replacingCharacters(in: range, with: string)

            return newString.count <= maxLength
        }
        return true
        
    }
    
    func isPasswordHasNumberAndCharacter(password: String) -> Bool {
        let passRegEx = "(?=[^a-z]*[a-z])[^0-9]*[0-9].*"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passRegEx)
        return passwordTest.evaluate(with: password)
    }
    
    
    //
    @IBAction func handleCountryList(_ sender: Any) {
        let navController = UINavigationController(rootViewController: countryList)
        self.present(navController, animated: true, completion: nil)
    }
    
    func selectedCountry(country: Country) {
        
        print("\(country.flag!) \(country.name!), \(country.countryCode), \(country.phoneExtension)")
        // self.selectedCountryLabel.text = "\(country.flag!) \(country.name!), \(country.countryCode), \(country.phoneExtension)"
        
        self.txt_phone_country_code.text = "+\(country.phoneExtension)"
        
        self.btn_flag.setTitle("\(country.flag!)", for: .normal)
        
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
        
        cell.txt_email.delegate = self
        cell.txt_password.delegate = self
        cell.txt_phone.delegate = self
        cell.txt_full_name.delegate = self
        cell.txt_confirm_password.delegate = self
        
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
            txt_email.keyboardType = .emailAddress
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
    
    @IBOutlet weak var txt_phone_country_code:UITextField! {
        didSet {
            txt_phone_country_code.setLeftPaddingPoints(24)
            txt_phone_country_code.layer.borderColor = UIColor.lightGray.cgColor
            txt_phone_country_code.layer.borderWidth = 0.8
            txt_phone_country_code.layer.cornerRadius = 8
            txt_phone_country_code.clipsToBounds = true
            txt_phone_country_code.keyboardType = .numberPad
        }
    }
    
    @IBOutlet weak var txt_phone:UITextField! {
        didSet {
            txt_phone.setLeftPaddingPoints(24)
            txt_phone.layer.borderColor = UIColor.lightGray.cgColor
            txt_phone.layer.borderWidth = 0.8
            txt_phone.layer.cornerRadius = 8
            txt_phone.clipsToBounds = true
            txt_phone.keyboardType = .numberPad
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


extension sign_up_form: JNPhoneNumberViewDelegate {
    
    /**
     Get presenter view controller
     - Parameter phoneNumberView: Phone number view
     - Returns: presenter view controller
     */
    func phoneNumberView(getPresenterViewControllerFor phoneNumberView: JNPhoneNumberView) -> UIViewController {
        return self
    }
    
    /**
     Get country code picker attributes
     - Parameter phoneNumberView: Phone number view
     */
    func phoneNumberView(getCountryPickerAttributesFor phoneNumberView: JNPhoneNumberView) -> JNCountryPickerConfiguration {
        let configuration = JNCountryPickerConfiguration()
        configuration.pickerLanguage = .en
        configuration.tableCellInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
        configuration.viewBackgroundColor = UIColor.lightGray
        configuration.tableCellBackgroundColor = UIColor.white
        
        return configuration
    }
    
    /**
     Did change text
     - Parameter nationalNumber: National phone number
     - Parameter country: Number country info
     - Parameter phoneNumberView: Phone number view
     */
    func phoneNumberView(didChangeText nationalNumber: String, country: JNCountry, forPhoneNumberView phoneNumberView: JNPhoneNumberView) {
        
        // self.phoneNumberLabel.text = "International Phone Number: \n \(self.phoneNumberView.getDialCode() + nationalNumber)"
    
        print("International Phone Number: \n \(self.phoneNumberView.getDialCode() + nationalNumber)")
        
        self.phoneNumberView.setViewConfiguration(self.getConfigration())
    }
    
    /**
     Did end editing
     - Parameter nationalNumber: National phone number
     - Parameter country: Number country info
     - Parameter isValidPhoneNumber:  Is valid phone number flag as bool
     - Parameter phoneNumberView: Phone number view
     */
    func phoneNumberView(didEndEditing nationalNumber: String, country: JNCountry, isValidPhoneNumber: Bool, forPhoneNumberView phoneNumberView: JNPhoneNumberView) {
        let validationMessage = isValidPhoneNumber ? "Valid Phone Number" : "Invalid Phone Number"
        
        print("International Phone Number: \n \(self.phoneNumberView.getPhoneNumber()) \n \(validationMessage)")
        
        /*self.phoneNumberLabel.text = "International Phone Number: \n \(self.phoneNumberView.getDialCode() + nationalNumber) \n \(validationMessage)"
        
        self.phoneNumberLabel.textColor = isValidPhoneNumber ? UIColor.blue : UIColor.red*/
    }
    
    /**
     Country Did Changed
     - Parameter country: New Selected Country
     - Parameter isValidPhoneNumber: Is valid phone number flag as bool
     - Parameter phoneNumberView: Phone number view
     */
    func phoneNumberView(countryDidChanged country: JNCountry, isValidPhoneNumber: Bool, forPhoneNumberView phoneNumberView: JNPhoneNumberView) {
        let validationMessage = isValidPhoneNumber ? "Valid Phone Number" : "Invalid Phone Number"
        
        /*self.phoneNumberLabel.text = "International Phone Number: \n \(self.phoneNumberView.getPhoneNumber()) \n \(validationMessage)"
        
        self.phoneNumberLabel.textColor = isValidPhoneNumber ? UIColor.blue : UIColor.red*/
        
        print("International Phone Number: \n \(self.phoneNumberView.getPhoneNumber()) \n \(validationMessage)")

    }
    
    private func getConfigration() -> JNPhoneNumberViewConfiguration {
        
        let configrartion = JNPhoneNumberViewConfiguration()
        configrartion.phoneNumberTitleColor = UIColor.black
        configrartion.countryDialCodeTitleColor = UIColor.black
        configrartion.phoneNumberTitleFont = UIFont.systemFont(ofSize: 18.0)
        configrartion.countryDialCodeTitleFont = UIFont.systemFont(ofSize: 20.0)
        
        return configrartion
        
    }
    
}
