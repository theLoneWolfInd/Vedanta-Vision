//
//  sign_up.swift
//  Vedanta
//
//  Created by Dishant Rajput on 15/09/22.
//

import UIKit
// import RxSwift
// import RxCocoa
import Alamofire
import GoogleSignIn

class sign_up: UIViewController {

    // MARK: - Variable -
    // let rxbag = DisposeBag()
    
    var str_user_device_token:String!
    
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
    
    @IBOutlet weak var btn_continue_with_email:UIButton! {
        didSet {
            btn_continue_with_email.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            btn_continue_with_email.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            btn_continue_with_email.layer.shadowOpacity = 1.0
            btn_continue_with_email.layer.shadowRadius = 4
            btn_continue_with_email.layer.masksToBounds = false
            btn_continue_with_email.layer.cornerRadius = 12
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
    
    @IBOutlet weak var btn_sign_in:UIButton! {
        didSet {
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.view_full_view.backgroundColor = app_BG_color
        
        self.btn_back.addTarget(self, action: #selector(back_click_method), for: .touchUpInside)
        self.btn_sign_in.addTarget(self, action: #selector(back_click_method), for: .touchUpInside)
        
        self.btn_continue_with_email.addTarget(self, action: #selector(sign_up_via_email_click_method), for: .touchUpInside)
        
        // GIDSignIn.sharedInstance.presentingViewController = self
        
//        NotificationCenter.default.addObserver(self,
//                                                   selector: #selector(userDidSignInGoogle(_:)),
//                                                   name: .signInGoogleCompleted,
//                                                   object: nil)
        
        // self.set_up_social_login_init()
        
        // GIDSignIn.sharedInstance.signIn()
        
        // let signInConfig = GIDConfiguration.init(clientID: "332203884683-i7ub3lqqg9bpv4gj67i05ucfv6emnhvu.apps.googleusercontent.com")
        // GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: self)
        
        let signInConfig = GIDConfiguration(clientID: "332203884683-i7ub3lqqg9bpv4gj67i05ucfv6emnhvu.apps.googleusercontent.com")
        
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
            if let error = error {
                if (error as NSError).code == GIDSignInError.hasNoAuthInKeychain.rawValue {
                    debugPrint("The user has not signed in before or they have since signed out.")
                } else {
                    debugPrint("\(error.localizedDescription)")
                }
                return
            }
            debugPrint(user.profile!.email)
            debugPrint(user.profile!.name)
            debugPrint(user.profile!.givenName ?? "")
            debugPrint(user.profile!.familyName ?? "")
            // showAlert(title: "SUCCESS", message: "Thanks for signing in with google")
              
        }
    
    private func updateScreen() {
        
        
        /*if let user = GIDSignIn.sharedInstance()?.currentUser {
            // User signed in
            
            /*// Show greeting message
            greetingLabel.text = "Hello \(user.profile.givenName!)! ✌️"
            
            // Hide sign in button
            signInButton.isHidden = true
            
            // Show sign out button
            signOutButton.isHidden = false*/
            
        } else {
            // User signed out
            
            print("signed out")
            
            // Show sign in message
             /*greetingLabel.text = "Please sign in... 🙂"
             
             // Show sign in button
             signInButton.isHidden = false
             
             // Hide sign out button
             signOutButton.isHidden = true*/
        }*/
    }
    
    @objc func set_up_social_login_init() {
        
        // google call
        /*googleLogin()
        
        // facebook call
        facebookLogin()
        
        
        // social buttons
        btn_continue_with_facebook.rx.tap.bind{ [weak self] _ in
            guard let strongSelf = self else {return}
            RRFBLogin.shared.fbLogin(viewController: strongSelf)
        }.disposed(by: rxbag)
        
        btn_continue_with_google.rx.tap.bind{ [weak self] _ in
            guard let strongSelf = self else {return}
            RRGoogleLogin.shared.googleSignIn(viewController: strongSelf)
        }.disposed(by: rxbag)*/
        
    }

    
    
    @objc func loginViaFB(strEmail:String,strType:String,strName:String,strSocialId:String,strProfileImage:String) {
          
        // indicator.startAnimating()
        // self.disableService()
        // Utils.RiteVetIndicatorShow()
           
        let urlString = application_base_url
               
        // var parameters:Dictionary<AnyHashable, Any>!
           
        let defaults = UserDefaults.standard
        if let myString = defaults.string(forKey: "key_my_device_token") {
            
            print("defaults savedString: \(myString)")
            self.str_user_device_token = "\(myString)"
            
        } else {
            
            print("user disable notification")
            
        }
        
        let parameters = [
            "action"        :   "socialLoginAction",
            "email"         :   String(strEmail),
            "socialId"      :   String(strSocialId),
            "fullName"      :   String(strName),
            "socialType"    :   String(strType),
            "device"        :   String("iOS"),
            "deviceToken"   :   String(self.str_user_device_token),
            "image"         :   String(strProfileImage)
        ]
              
                
        print("parameters-------\(String(describing: parameters))")
          
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
                        
                        var ar : NSArray!
                        ar = (jsonDict["data"] as! Array<Any>) as NSArray
                        // self.arr_mut_ask_me.addObjects(from: ar as! [Any])
                        
                        ERProgressHud.sharedInstance.hide()
                        
                        if ar.count == 0 {
                          
                            let alert = NewYorkAlertController(title: String("Alert").uppercased(), message: String("No event found on this date."), style: .alert)
                            let cancel = NewYorkButton(title: "dismiss", style: .cancel)
                            alert.addButtons([cancel])
                            self.present(alert, animated: true)
                            
                        } else {
                            
                            let alert = NewYorkAlertController(title: String("Event"), message: nil, style: .actionSheet)
                            
                            for indexx in 0..<ar.count {
                                
                                 let item = ar[indexx] as? [String:Any]
                                
                                
                                let india = NewYorkButton(title: (item!["eventDate"] as! String), style: .default) {
                                    _ in
                                    
                                    if let url = URL(string: (item!["URL"] as! String)) {
                                        UIApplication.shared.open(url)
                                    }
                                    
                                }

                                alert.addButtons([india])
                            }

                            self.present(alert, animated: true)
                            
                        }
                        
                        
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


/*// MARK: - Social Login -
extension sign_up {
    
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
        
        self.loginViaFB(strEmail: user.email, strType: user.type.rawValue, strName: user.name, strSocialId: user.userId, strProfileImage: user.profilePic)
    }
    
    func showAlert(title : String?, message : String?, handler: ((UIAlertController) -> Void)? = nil){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
            handler?(alertController)
        }))
        self.present(alertController, animated: true, completion: nil)
    }
}*/
