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
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginKit.FBLoginButton) {
        print("logout")
    }
    
    
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
    
    @IBOutlet weak var img_view:UIImageView! {
        didSet {
            img_view.backgroundColor = .clear
        }
    }
    
    @IBOutlet weak var view_full_view:UIView! {
        didSet {
            view_full_view.backgroundColor = UIColor.init(red: 246.0/255.0, green: 246.0/255.0, blue: 246.0/255.0, alpha: 1)
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.view_full_view.backgroundColor = app_BG_color
        
        self.btn_back.addTarget(self, action: #selector(back_click_method), for: .touchUpInside)
        
        self.btn_sign_in.addTarget(self, action: #selector(login_in_vedanta_WB), for: .touchUpInside)
        
        self.btn_sign_up.addTarget(self, action: #selector(sign_up_click_method), for: .touchUpInside)
        
        self.btn_forgot_password.addTarget(self, action: #selector(forgot_password_click_method), for: .touchUpInside)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow_2), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide_2), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        self.txt_email.delegate = self
        self.txt_password.delegate = self
        
        
        /*if let token = AccessToken.current,
                !token.isExpired {
                // User is logged in, do work such as go to next view controller.
        }*/
        
        // self.sign_up_with_google_init()
        
        // google call
//        googleLogin()
        
        // facebook call
        facebookLogin()
        
        
        // social buttons
        btn_continue_with_facebook.rx.tap.bind{ [weak self] _ in
            guard let strongSelf = self else {return}
            RRFBLogin.shared.fbLogin(viewController: strongSelf)
        }.disposed(by: rxbag)
        
        // google old
//        btn_continue_with_google.rx.tap.bind{ [weak self] _ in
//            guard let strongSelf = self else {return}
//            RRGoogleLogin.shared.googleSignIn(viewController: strongSelf)
//        }.disposed(by: rxbag)
        
        
//        let loginButton = FBLoginButton()
//                loginButton.center = view.center
//                view.addSubview(loginButton)

        NotificationCenter.default.addObserver(forName: .AccessTokenDidChange, object: nil, queue: OperationQueue.main) { (notification) in

            debugPrint("Facebook Access Token: \(String(describing: AccessToken.current?.tokenString))")
        }
        
        
        // facebook
//        btn_continue_with_facebook.delegate = self
//        btn_continue_with_facebook.permissions = ["public_profile", "email"]
//        btn_continue_with_facebook.addTarget(self, action: #selector(continue_with_facebook_click_method), for: .touchUpInside)
        
        // google
        btn_continue_with_google.addTarget(self, action: #selector(continue_with_google_click_method), for: .touchUpInside)
        
//        let loginButton = FBLoginButton()
//        loginButton.delegate = self
//        loginButton.center = view.center
//                        view.addSubview(loginButton)
        
    }
    
    func loginButton(_ loginButton: FBLoginButton!, didCompleteWith result: LoginManagerLoginResult!, error: Error!) {

        if(AccessToken.current != nil)
        {
            //print permissions, such as public_profile
            print(AccessToken.current!.permissions)
            let graphRequest = GraphRequest(graphPath: "me", parameters: ["fields" : "id, name, email"])
            let connection = GraphRequestConnection()

            connection.add(graphRequest, completion: { (connection, result, error) -> Void in

                let data = result as! [String : AnyObject]

//                self.lbluser.text = data["name"] as? String

                let FBid = data["id"] as? String
//                self.lblEmail.text = data["email"] as? String

                let url = NSURL(string: "https://graph.facebook.com/\(FBid!)/picture?type=large&return_ssl_resources=1")
//                self.imageView.image = UIImage(data: NSData(contentsOf: url! as URL)! as Data)
            })
            connection.start()
        }
    }
    
    @objc(loginButton:didCompleteWithResult:error:) func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
      if let error = error {
        print(error.localizedDescription)
        return
      }
      // ...
    }
    
    // facebook
    @objc func continue_with_facebook_click_method() {
        let fbLoginManager : LoginManager = LoginManager()
                                                                                                   
                                     fbLoginManager.logIn(permissions:["email","public_profile"], from: self, handler: {(result, error) -> Void in
                                         
                                         print("\n\n result: \(String(describing: result))")
                                         print("\n\n Error: \(String(describing: error))")
                                         
                                         if (error == nil)
                                         {
                                             if let fbloginresult = result
                                             {
                                                 if(fbloginresult.isCancelled)
                                                                {
                                                                    //Show Cancel alert to the user
                                                                  let alert = UIAlertController(title: "Facebook login", message: "User pressed cancel button", preferredStyle: UIAlertController.Style.alert)
                                                                  alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {    (action:UIAlertAction!) in
                                                                      //print("you have pressed the ok button")
                                                                      
                                                                  }))
                                                                  
                                                                  self.present(alert, animated: true, completion: nil)
                                                                }
                                                                else
                                                                
                                                                {
                                                                 print("going to getFBLoggedInUserData.. ")
                                                                    
                                                                    
//                                                                    self.getFBLoggedInUserData()
                                                                    
                                                                }
                                             }
                                            
                                         }
                                     })
    }
    
    @objc func continue_with_google_click_method() {
        GIDSignIn.sharedInstance.signIn(with: GIDConfiguration(clientID: "857008698478-6bhro43tnihn0n9i80g012o3712fohfd.apps.googleusercontent.com"), presenting: self) { signInResult, error in
            guard error == nil else { return }

            ERProgressHud.sharedInstance.showDarkBackgroundView(withTitle: "Please wait...")
            
            print("success google sign in")
//            print(signInResult?.userID)
//            print(signInResult?.profile?.email)
//            print(signInResult?.profile?.name)
//            print(signInResult?.profile?.givenName)
//            print(signInResult?.profile?.familyName)
//            print(signInResult?.profile?.hasImage)
            let googleProfilePicURL = signInResult?.profile?.imageURL(withDimension: 150)?.absoluteString ?? ""
            print("Google Profile Avatar URL: \(googleProfilePicURL)")
            // If sign in succeeded, display the app's main content View.
            
            
            self.social_login_in_vedanta_WB(str_email: (signInResult?.profile!.email)!,
                                            str_full_name: (signInResult?.profile?.name)!,
                                            str_image: "\(googleProfilePicURL)", str_social_id: (signInResult?.userID)!)
          }
    }
    
    // MARK: - WEBSERVICE ( LOGIN ) -
    @objc func social_login_in_vedanta_WB(
        str_email:String,str_full_name:String,str_image:String,str_social_id:String) {
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
            "socialType"    : "G",
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
                }
            }
    }
    
    @objc func facebook_login_setup() {
        
        // social buttons
        self.btn_continue_with_facebook.rx.tap.bind{ [weak self] _ in
            guard let strongSelf = self else {return}
            RRFBLogin.shared.fbLogin(viewController: strongSelf)
        }.disposed(by: rxbag)
        
    }
    
    @objc func sign_up_with_google_init() {
        
        let googleConfig = GIDConfiguration(clientID: "332203884683-i7ub3lqqg9bpv4gj67i05ucfv6emnhvu.apps.googleusercontent.com")
            self.googleSignIn.signIn(with: googleConfig, presenting: self) { user, error in
                if error == nil {
                    guard let user = user else {
                        print("Uh oh. The user cancelled the Google login.")
                        return
                    }

                    let userId = user.userID ?? ""
                    print("Google User ID: \(userId)")
                    
                    let userIdToken = user.authentication.idToken ?? ""
                    print("Google ID Token: \(userIdToken)")
                    
                    let userFirstName = user.profile?.givenName ?? ""
                    print("Google User First Name: \(userFirstName)")
                    
                    let userLastName = user.profile?.familyName ?? ""
                    print("Google User Last Name: \(userLastName)")
                    
                    let userEmail = user.profile?.email ?? ""
                    print("Google User Email: \(userEmail)")
                    
                    let googleProfilePicURL = user.profile?.imageURL(withDimension: 150)?.absoluteString ?? ""
                    print("Google Profile Avatar URL: \(googleProfilePicURL)")
                    
                }
            }
        
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
        
        let alert = UIAlertController(title:"Forgot password", message: "Please Enter your Registered Email address.", preferredStyle:UIAlertController.Style.alert)
        
        //ADD TEXT FIELD (YOU CAN ADD MULTIPLE TEXTFILED AS WELL)
        alert.addTextField { (textField : UITextField!) in
            textField.placeholder = "email address..."
            textField.delegate = self
        }
        
        // SAVE BUTTON
        let save = UIAlertAction(title: "Submit", style: .default, handler: { saveAction -> Void in
            
            let textField = alert.textFields![0] as UITextField
            print("\(textField.text!)")
            
            self.forgot_password_click_method_WB(str_email_address: "\(textField.text!)")
            
        })
        // CANCEL BUTTON
        let cancel = UIAlertAction(title: "Cancel", style: .default, handler: {
            (action : UIAlertAction!) -> Void in })
        
        
        alert.addAction(save)
        alert.addAction(cancel)
        
        present(alert, animated: true)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
    }
    
    // MARK: - WEBSERVICE ( LOGIN ) -
    @objc func forgot_password_click_method_WB(str_email_address:String) {
        self.view.endEditing(true)
        
        ERProgressHud.sharedInstance.showDarkBackgroundView(withTitle: "Please wait...")
        
        if IsInternetAvailable() == false {
            self.please_check_your_internet_connection()
            return
        }
        
        let parameters = [
            "action"    : "forgotpassword",
            "email"     : String(str_email_address)
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
                            
                            
                            let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "reset_password_id")
                            self.navigationController?.pushViewController(push, animated: true)
                            
                            
                            let alert = NewYorkAlertController(title: String("Alert"), message: String(str_data_message), style: .alert)
                            
                            let cancel = NewYorkButton(title: "dismiss", style: .cancel)
                            
                            alert.addButtons([cancel])
                            self.present(alert, animated: true)
                            
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
                }
            }
    }
    
    // MARK: - WEBSERVICE ( LOGIN ) -
    @objc func login_in_vedanta_WB() {
        self.view.endEditing(true)
        
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
                }
            }
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
