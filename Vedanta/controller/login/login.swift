//
//  login.swift
//  Vedanta
//
//  Created by Dishant Rajput on 15/09/22.
//

import UIKit
import Alamofire
import GoogleSignIn

import RxSwift
import RxCocoa

import FBSDKLoginKit
 
class login: UIViewController , UITextFieldDelegate {
    
//    func loginButtonDidLogOut(_ loginButton: FBSDKLoginKit.FBLoginButton) {
//        print("logout")
//    }
    
    
//    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
//        if let error = error {
//          print("Facebook login with error: \(error.localizedDescription)")
//        } else if let result = result {
//          let declinedPermissionSet = result.declinedPermissions
//          let grantedPermissionSet = result.grantedPermissions
//          let isCancelled = result.isCancelled
//          let facebookToken = result.token?.tokenString ?? ""
//        }
//      }
//
//      func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
//        print("User has logged out Facebook")
//      }
    
    var str_user_device_token:String!
    
    var googleSignIn = GIDSignIn.sharedInstance
    
    // MARK: - Variable -
    let rxbag = DisposeBag()
    
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
    
    @IBOutlet weak var img_view:UIImageView! {
        didSet {
            img_view.backgroundColor = .clear
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
    
    @IBOutlet weak var btn_forgot_password:UIButton! {
        didSet {
            
        }
    }
    
    @IBOutlet weak var btn_sign_up:UIButton! {
        didSet {
            
        }
    }
    
    @IBOutlet weak var btn_sign_in:UIButton! {
        didSet {
            btn_sign_in.layer.cornerRadius = 8
            btn_sign_in.clipsToBounds = true
            btn_sign_in.dropShadow()
        }
    }
    
    @IBOutlet weak var btn_continue_with_facebook:UIButton! {
        didSet {
            btn_continue_with_facebook.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            btn_continue_with_facebook.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            btn_continue_with_facebook.layer.shadowOpacity = 1.0
            btn_continue_with_facebook.layer.shadowRadius = 4
            btn_continue_with_facebook.layer.masksToBounds = false
            btn_continue_with_facebook.layer.cornerRadius = 12
        }
    }
    
    @IBOutlet weak var btn_continue_with_google:UIButton! {
        didSet {
            btn_continue_with_google.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            btn_continue_with_google.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            btn_continue_with_google.layer.shadowOpacity = 1.0
            btn_continue_with_google.layer.shadowRadius = 4
            btn_continue_with_google.layer.masksToBounds = false
            btn_continue_with_google.layer.cornerRadius = 12
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.view_full_view.backgroundColor = app_BG_color
        
        self.btn_back.addTarget(self, action: #selector(back_click_method), for: .touchUpInside)

//        self.tble_view.separatorColor = .clear
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow_2), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide_2), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        let stringValue = "Don't have an account - Sign Up"
        
        // 230 40 36
        let attText = NSMutableAttributedString(string: stringValue)
        attText.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.init(red: 220.0/255.0, green: 80.0/255.0, blue: 59.0/255.0, alpha: 1), range: NSRange(
            location:24,
            length:7))
 
        self.btn_sign_up.setAttributedTitle(attText, for: .normal)
        
        self.btn_sign_in.addTarget(self, action: #selector(login_in_vedanta_WB), for: .touchUpInside)
        
        self.btn_sign_up.addTarget(self, action: #selector(sign_up_click_method), for: .touchUpInside)
        
        self.btn_forgot_password.addTarget(self, action: #selector(forgot_password_click_method), for: .touchUpInside)
        self.txt_email.delegate = self
        self.txt_password.delegate = self
        
        // social buttons
//        self.btn_continue_with_facebook.rx.tap.bind{ [weak self] _ in
//            guard let strongSelf = self else {return}
//            RRFBLogin.shared.fbLogin(viewController: strongSelf)
//        }.disposed(by: rxbag)
        
        // FACEBOOK
        self.btn_continue_with_facebook.addTarget(self, action: #selector(loginButtonClicked), for: .touchUpInside)
        
        // google
        self.btn_continue_with_google.addTarget(self, action: #selector(continue_with_google_click_method), for: .touchUpInside)
        
        NotificationCenter.default.addObserver(forName: .AccessTokenDidChange, object: nil, queue: OperationQueue.main) { (notification) in

            debugPrint("Facebook Access Token: \(String(describing: AccessToken.current?.tokenString))")
        }
        
    }
    
    @objc override func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    @objc func loginButtonClicked() {
            let loginManager = LoginManager()
        loginManager.logIn(permissions: ["public_profile","email"], from: self) { [self] result, error in
                if let error = error {
                    print("Encountered Erorr: \(error)")
                } else if let result = result, result.isCancelled {
                    print("Cancelled")
                } else {
                    print("Logged In")
                    print("result \(result)")

                    showEmail()
                    
                }
            }
        }
    
    func showEmail()
        {
            GraphRequest(graphPath: "/me", parameters: ["fields": "email, id, name, picture.width(480).height(480)"]).start {
                (connection, result, err) in
                
              if(err == nil) {
//                  print(result[""] as! String)
                  
                  if let res = result {
                      if let response = res as? [String: Any] {
                          let username = response["name"]
                          let email = response["email"]
                          let id = response["id"]
                          let image = response["picture"]
                          
                          print(username as Any)
                          print(email as Any)
                          print(id as Any)
                          print(image as Any)
//
//                          let for_image = image as? [String: Any]
//                          let get_data = for_image!["data"] as? [String: Any]
//                          print(get_data as Any)
//                          let get_url = get_data!["url"] as? [String: Any]
//                          print(get_url as Any)
//                          print(get_url as Any)
//
                          
                          ERProgressHud.sharedInstance.showDarkBackgroundView(withTitle: "Please wait...")
                          
                          self.social_login_in_vedanta_WB(str_email: (email as! String),
                                                          str_full_name: (username as! String),
                                                          str_image: "",
                                                          str_social_id: (id as! String),
                                                          type: "F"
                          
                          )
                          
                      }
                  }

                }
               else {
                    print("error \(err!)")
                }
            }

        }
 
    
    
    // MARK: - LOGIN VIA GOOGLE -
    @objc func continue_with_google_click_method() {
        
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { signInResult, error in
           guard error == nil else { return }

            let googleProfilePicURL = signInResult?.user.profile?.imageURL(withDimension: 150)?.absoluteString ?? ""

            self.social_login_in_vedanta_WB(str_email: (signInResult?.user.profile!.email)!,
                                            str_full_name: (signInResult?.user.profile?.name)!,
                                            str_image: "\(googleProfilePicURL)",
                                            str_social_id: (signInResult?.user.userID)!,
                                            type: "G"
            
            
            )
            
         }
    
    }
    
    
    // MARK: - WEBSERVICE ( LOGIN ) -
    @objc func social_login_in_vedanta_WB(
        str_email:String,str_full_name:String,str_image:String,str_social_id:String,type:String) {
        self.view.endEditing(true)
        
        
        
        if IsInternetAvailable() == false {
            self.please_check_your_internet_connection()
            return
        }
        
        var device_token:String!
        if self.str_user_device_token == nil {
            device_token = ""
        } else {
            device_token = String(self.str_user_device_token)
        }
        
//        [action] => socialLoginAction
//            [email] => satishdhakar17@gmail.com
//            [fullName] => Satish Dhakar
//            [image] => https://lh3.googleusercontent.com/a/ALm5wu0sBOwD-nhr4RqpE9LUIRo9NrXpzVqFroF7ersz
//            [socialId] => 118029733234090846820
//            [socialType] => G
//            [device] => Android
//            [deviceToken] =>
        
        let parameters = [
            "action"        : "socialLoginAction",
            "email"         : String(str_email),
            "fullName"      : String(str_full_name),
            "image"         : String(str_image),
            "socialId"      : String(str_social_id),
            "socialType"    : String(type),
            "device"        : "iOS",
            "deviceToken"   : String(device_token),
            
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
                            // self.navigationController?.popViewController(animated: true)
                            
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
    
    @objc func facebook_login_setup() {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tble_view.cellForRow(at: indexPath) as! login_table_cell
        
        // social buttons
        cell.btn_continue_with_facebook.rx.tap.bind{ [weak self] _ in
            guard let strongSelf = self else {return}
            RRFBLogin.shared.fbLogin(viewController: strongSelf)
        }.disposed(by: rxbag)
        
    }
    
    @objc func sign_up_with_google_init() {
        
//        let googleConfig = GIDConfiguration(clientID: "332203884683-i7ub3lqqg9bpv4gj67i05ucfv6emnhvu.apps.googleusercontent.com")
//            self.googleSignIn.signIn(with: googleConfig, presenting: self) { user, error in
//                if error == nil {
//                    guard let user = user else {
//                        print("Uh oh. The user cancelled the Google login.")
//                        return
//                    }
//
//                    let userId = user.userID ?? ""
//                    print("Google User ID: \(userId)")
//
//                    let userIdToken = user.authentication.idToken ?? ""
//                    print("Google ID Token: \(userIdToken)")
//
//                    let userFirstName = user.profile?.givenName ?? ""
//                    print("Google User First Name: \(userFirstName)")
//
//                    let userLastName = user.profile?.familyName ?? ""
//                    print("Google User Last Name: \(userLastName)")
//
//                    let userEmail = user.profile?.email ?? ""
//                    print("Google User Email: \(userEmail)")
//
//                    let googleProfilePicURL = user.profile?.imageURL(withDimension: 150)?.absoluteString ?? ""
//                    print("Google Profile Avatar URL: \(googleProfilePicURL)")
//
//                }
//            }
        
        /*GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: self) { user, error in
             guard error == nil else { return }

            // If sign in succeeded, display the app's main content View.
            
            print("If sign in succeeded, display the app's main content View.")
            
            user!.authentication.do { authentication, error in
                    guard error == nil else { return }
                    guard let authentication = authentication else { return }

                    let idToken = authentication.idToken
                    // Send ID token to backend (example below).
                print(idToken as Any)
                
                }
            
            
          }*/
        
    }
    
    @objc func sign_out_via_google() {
        
        GIDSignIn.sharedInstance.signOut()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        let defaults = UserDefaults.standard
        if let myString = defaults.string(forKey: "key_my_device_token") {
            
            print("defaults savedString: \(myString)")
            self.str_user_device_token = "\(myString)"
            
        } else {
            
            print("user disable notification")
            
        }
        
    }
    
    @objc func forgot_password_click_method() {
        
        let push = self.storyboard?.instantiateViewController(withIdentifier: "forgot_password_id") as! forgot_password
        self.navigationController?.pushViewController(push, animated: true)
        
//        let alert = UIAlertController(title:"Forgot password", message: "Please Enter your Registered Email address.", preferredStyle:UIAlertController.Style.alert)
//
//        //ADD TEXT FIELD (YOU CAN ADD MULTIPLE TEXTFILED AS WELL)
//        alert.addTextField { (textField : UITextField!) in
//            textField.placeholder = "email address..."
//            textField.delegate = self
//        }
//
//        // SAVE BUTTON
//        let save = UIAlertAction(title: "Submit", style: .default, handler: { saveAction -> Void in
//
//            let textField = alert.textFields![0] as UITextField
//            print("\(textField.text!)")
//
//            // push to forgot password screen
//            let push = self.storyboard?.instantiateViewController(withIdentifier: "forgot_password_id") as! forgot_password
//
//            self.navigationController?.pushViewController(push, animated: true)
////            self.forgot_password_click_method_WB(str_email_address: "\(textField.text!)")
//
//        })
//        // CANCEL BUTTON
//        let cancel = UIAlertAction(title: "Cancel", style: .default, handler: {
//            (action : UIAlertAction!) -> Void in })
//
//
//        alert.addAction(save)
//        alert.addAction(cancel)
//
//        present(alert, animated: true)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
    }
    
    
    
    // MARK: - WEBSERVICE ( LOGIN ) -
    @objc func login_in_vedanta_WB() {
        self.view.endEditing(true)
        
//        let indexPath = IndexPath.init(row: 0, section: 0)
//        let cell = self.tble_view.cellForRow(at: indexPath) as! login_table_cell
        
        
        if (self.txt_email.text == "") {
            
            let alert = NewYorkAlertController(title: String("Alert"), message: String("Email should not be empty"), style: .alert)
            
            let cancel = NewYorkButton(title: "Dismiss", style: .cancel)
            alert.addButtons([cancel])
            self.present(alert, animated: true)
            
        } else if (self.txt_password.text == "") {
            
            let alert = NewYorkAlertController(title: String("Alert"), message: String("Password should not be empty"), style: .alert)
            
            let cancel = NewYorkButton(title: "Dismiss", style: .cancel)
            alert.addButtons([cancel])
            self.present(alert, animated: true)
            
        } else {
            
            if isValidEmail(testStr: self.txt_email.text!) {
                print("Validate EmailID")
                
                self.login_WB()
                
            } else {
                
                let alert = NewYorkAlertController(title: String("Alert"), message: String("Please enter valid email address"), style: .alert)
                let cancel = NewYorkButton(title: "Dismiss", style: .cancel)
                alert.addButtons([cancel])
                self.present(alert, animated: true)
                
            }
            
        
        }
    }
    
    
    func login_WB() {
        ERProgressHud.sharedInstance.showDarkBackgroundView(withTitle: "Please wait...")
        
        if IsInternetAvailable() == false {
            self.please_check_your_internet_connection()
            return
        }
        
        var device_token:String!
        if self.str_user_device_token == nil {
            device_token = ""
        } else {
            device_token = String(self.str_user_device_token)
        }
        
        let parameters = [
            "action"    : "login",
            "email"     : String(self.txt_email.text!),
            "password"  : String(self.txt_password.text!),
            "deviceToken" : String(device_token)
            
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
                            // self.navigationController?.popViewController(animated: true)
                            
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
    
    func isValidEmail(testStr:String) -> Bool {

    // println("validate emilId: \(testStr)")

    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"

        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)

        let result = emailTest.evaluate(with: testStr)

        return result

    }
    
}

// MARK: - Social Login -
extension login {
    
    private func googleLogin() {
        RRGoogleLogin.shared.googleUserDetails.asObservable()
        .subscribe(onNext: { [weak self] (userDetails) in
            guard let strongSelf = self else {return}
            strongSelf.socialLogin(user: userDetails)
        }, onError: { [weak self] (error) in
            guard let strongSelf = self else {return}
            strongSelf.showAlert(title: nil, message: error.localizedDescription)
        }).disposed(by: rxbag)
    }
    
    private func facebookLogin() {
        RRFBLogin.shared.fbUserDetails.asObservable()
        .subscribe(onNext: { [weak self] (userDetails) in
            guard let strongSelf = self else {return}
            strongSelf.socialLogin(user: userDetails)
        }, onError: { [weak self] (error) in
            guard let strongSelf = self else {return}
            strongSelf.showAlert(title: nil, message: error.localizedDescription)
        }).disposed(by: rxbag)
    }
    
    fileprivate func socialLogin(user :SocialUserDetails) {
        // lblType.text = user.type.rawValue
        // lblEmail.text = user.email
        // lblName.text = user.name
        
        print(user.name as Any)
        print(user.type as Any)
        print(user.email as Any)
        print(user.userId as Any)
        print(user.profilePic as Any)
        print(type(of: user.profilePic))
        
        let url = URL(string: user.profilePic)
        let data = try? Data(contentsOf: url!)

        if let imageData = data {
            let image = UIImage(data: imageData)
            // imgProfile.image = image
        }
        
        // self.loginViaFB(strEmail: user.email, strType: user.type.rawValue, strName: user.name, strSocialId: user.userId, strProfileImage: user.profilePic)
    }
    
    func showAlert(title : String?, message : String?, handler: ((UIAlertController) -> Void)? = nil){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
            handler?(alertController)
        }))
        self.present(alertController, animated: true, completion: nil)
    }
}

extension login : UITableViewDelegate , UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:login_table_cell = tableView.dequeueReusableCell(withIdentifier: "login_table_cell") as! login_table_cell
        
        cell.backgroundColor = .clear
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = .clear
        cell.selectedBackgroundView = backgroundView
        
        cell.btn_sign_in.addTarget(self, action: #selector(login_in_vedanta_WB), for: .touchUpInside)
        
        cell.btn_sign_up.addTarget(self, action: #selector(sign_up_click_method), for: .touchUpInside)
        
        cell.btn_forgot_password.addTarget(self, action: #selector(forgot_password_click_method), for: .touchUpInside)
        cell.txt_email.delegate = self
        cell.txt_password.delegate = self
        
        // social buttons
//        cell.btn_continue_with_facebook.rx.tap.bind{ [weak self] _ in
//            guard let strongSelf = self else {return}
//            RRFBLogin.shared.fbLogin(viewController: strongSelf)
//        }.disposed(by: rxbag)
        
        // google
        cell.btn_continue_with_google.addTarget(self, action: #selector(continue_with_google_click_method), for: .touchUpInside)
        
        let stringValue = "Don't have an account - Sign Up"
        
        // 230 40 36
        let attText = NSMutableAttributedString(string: stringValue)
        attText.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.init(red: 220.0/255.0, green: 80.0/255.0, blue: 59.0/255.0, alpha: 1), range: NSRange(
            location:24,
            length:7))
 
        cell.btn_sign_up.setAttributedTitle(attText, for: .normal)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 900
    }
    
}

class login_table_cell:UITableViewCell {
    
    @IBOutlet weak var img_view:UIImageView! {
        didSet {
            img_view.backgroundColor = .clear
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
    
    @IBOutlet weak var btn_forgot_password:UIButton! {
        didSet {
            
        }
    }
    
    @IBOutlet weak var btn_sign_up:UIButton! {
        didSet {
            
        }
    }
    
    @IBOutlet weak var btn_sign_in:UIButton! {
        didSet {
            btn_sign_in.layer.cornerRadius = 8
            btn_sign_in.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var btn_continue_with_facebook:UIButton! {
        didSet {
            btn_continue_with_facebook.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            btn_continue_with_facebook.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            btn_continue_with_facebook.layer.shadowOpacity = 1.0
            btn_continue_with_facebook.layer.shadowRadius = 4
            btn_continue_with_facebook.layer.masksToBounds = false
            btn_continue_with_facebook.layer.cornerRadius = 12
        }
    }
    
    @IBOutlet weak var btn_continue_with_google:UIButton! {
        didSet {
            btn_continue_with_google.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            btn_continue_with_google.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            btn_continue_with_google.layer.shadowOpacity = 1.0
            btn_continue_with_google.layer.shadowRadius = 4
            btn_continue_with_google.layer.masksToBounds = false
            btn_continue_with_google.layer.cornerRadius = 12
        }
    }

    
    
}
