//
//  sign_up.swift
//  Vedanta
//
//  Created by Dishant Rajput on 15/09/22.
//

import UIKit
import RxSwift
import RxCocoa
import Alamofire
import GoogleSignIn

import FBSDKLoginKit

import AuthenticationServices

class sign_up: UIViewController , ASAuthorizationControllerDelegate {

    // MARK: - Variable -
    // let rxbag = DisposeBag()
    
    
    var str_user_device_token:String!
    
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
    
    @IBOutlet weak var btn_continue_with_apple:ASAuthorizationAppleIDButton! {
        didSet {
            btn_continue_with_apple.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            btn_continue_with_apple.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            btn_continue_with_apple.layer.shadowOpacity = 1.0
            btn_continue_with_apple.layer.shadowRadius = 4
            btn_continue_with_apple.layer.masksToBounds = false
            btn_continue_with_apple.layer.cornerRadius = 12
        }
    }
    
    @IBOutlet weak var btn_sign_in:UIButton! {
        didSet {
            btn_sign_in.setTitleColor(UIColor.init(red: 220.0/255.0, green: 80.0/255.0, blue: 59.0/255.0, alpha: 1), for: .normal)
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.view_full_view.backgroundColor = app_BG_color
        
        self.btn_back.addTarget(self, action: #selector(back_click_method), for: .touchUpInside)
        self.btn_sign_in.addTarget(self, action: #selector(back_click_method), for: .touchUpInside)
        
        self.btn_continue_with_email.addTarget(self, action: #selector(sign_up_via_email_click_method), for: .touchUpInside)
        
        // FACEBOOK
        self.btn_continue_with_facebook.addTarget(self, action: #selector(loginButtonClicked), for: .touchUpInside)
        
        // google
        self.btn_continue_with_google.addTarget(self, action: #selector(continue_with_google_click_method), for: .touchUpInside)
        
        // apple
        self.setUpSignInAppleButton()
        
    }
    
    // MARK: - SIGN IN VIA APPLE -
    @objc func setUpSignInAppleButton() {

        let authorizationButton = ASAuthorizationAppleIDButton()

        authorizationButton.addTarget(self, action: #selector(handleAppleIdRequest), for: .touchUpInside)
        authorizationButton.cornerRadius = 10
        
        authorizationButton.frame = CGRect(x: 0, y: 0, width: self.btn_continue_with_apple.frame.size.width-20, height: 56)

        self.btn_continue_with_apple.addSubview(authorizationButton)
        
         
    }
    
    @objc func handleAppleIdRequest() {
        
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        
        request.requestedScopes = [
            .fullName,
            .email
        ]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.performRequests()
        
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as?  ASAuthorizationAppleIDCredential {
            let userIdentifier = appleIDCredential.user
            let fullName = appleIDCredential.fullName
            let email = appleIDCredential.email
            
             print(userIdentifier)
             print(fullName)
             print(email)
            
            var strName:String! = ""
            if "\(fullName!)" == "" {
                strName = " "
            } else {
                strName = "\(fullName!)"
            }
            
            // email
            var email_2:String! = ""
            
            if (email) == nil {
                email_2 = " "
            } else {
                email_2 = (email)
            }
            
            //
            // email
            var id_2:String! = ""
            
            if (userIdentifier) == "" {
                id_2 = ""
            } else {
                id_2 = (userIdentifier)
            }
            
            ERProgressHud.sharedInstance.showDarkBackgroundView(withTitle: "Please wait...")
            self.social_login_in_vedanta_WB(str_email: (email_2!),
                                            str_full_name: String(strName),
                                            str_image: "",
                                            str_social_id: String(id_2),
                                            type: "A"
            
            )
            
        }
    }
    
    /*@objc func actionHandleAppleSignin() {

        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()

    }*/
    
    /*@objc func actionHandleAppleSignin() {

        let appleIDProvider = ASAuthorizationAppleIDProvider()

        let request = appleIDProvider.createRequest()

        request.requestedScopes = [.fullName, .email]

        let authorizationController = ASAuthorizationController(authorizationRequests: [request])

        authorizationController.delegate = self

        authorizationController.presentationContextProvider = self

        authorizationController.performRequests()

    }

    
    @objc func handleAppleIdRequest() {
    let appleIDProvider = ASAuthorizationAppleIDProvider()
    let request = appleIDProvider.createRequest()
    request.requestedScopes = [.fullName, .email]
    let authorizationController = ASAuthorizationController(authorizationRequests: [request])
    authorizationController.delegate = self
    authorizationController.performRequests()
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as?  ASAuthorizationAppleIDCredential {
            let userIdentifier = appleIDCredential.user
            let fullName = appleIDCredential.fullName
            let email = appleIDCredential.email
    // print(“User id is \(userIdentifier) \n Full Name is \(String(describing: fullName)) \n Email id is \(String(describing: email))”)
        
            
            let appleIDProvider = ASAuthorizationAppleIDProvider()
            appleIDProvider.getCredentialState(forUserID: appleIDCredential.user) {  (credentialState, error) in
                 switch credentialState {
                    case .authorized:
                        // The Apple ID credential is valid.
                        break
                    case .revoked:
                        // The Apple ID credential is revoked.
                        break
                 case .notFound: break
                        // No credential was found, so show the sign-in UI.
                    default:
                        break
                 }
            }
            
            
            
        }
    }
    
    // error
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
    // Handle error.
        print("error while sign in via apple")
    }*/
    
    @objc func get_data_after_success_sign_in() {
        
       
        
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
                print("result \(result!)")

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
    
//    @objc func phone_number() {
//        let flags: [String: String] = [
//          "AD": "🇦🇩", "AE": "🇦🇪", "AF": "🇦🇫", "AG": "🇦🇬", "AI": "🇦🇮", "AL": "🇦🇱", "AM": "🇦🇲", "AO": "🇦🇴", "AQ": "🇦🇶", "AR": "🇦🇷", "AS": "🇦🇸", "AT": "🇦🇹", "AU": "🇦🇺", "AW": "🇦🇼", "AX": "🇦🇽", "AZ": "🇦🇿", "BA": "🇧🇦", "BB": "🇧🇧", "BD": "🇧🇩", "BE": "🇧🇪", "BF": "🇧🇫", "BG": "🇧🇬", "BH": "🇧🇭", "BI": "🇧🇮", "BJ": "🇧🇯", "BL": "🇧🇱", "BM": "🇧🇲", "BN": "🇧🇳", "BO": "🇧🇴", "BQ": "🇧🇶", "BR": "🇧🇷", "BS": "🇧🇸", "BT": "🇧🇹", "BV": "🇧🇻", "BW": "🇧🇼", "BY": "🇧🇾", "BZ": "🇧🇿", "CA": "🇨🇦", "CC": "🇨🇨", "CD": "🇨🇩", "CF": "🇨🇫", "CG": "🇨🇬", "CH": "🇨🇭", "CI": "🇨🇮", "CK": "🇨🇰", "CL": "🇨🇱", "CM": "🇨🇲", "CN": "🇨🇳", "CO": "🇨🇴", "CR": "🇨🇷", "CU": "🇨🇺", "CV": "🇨🇻", "CW": "🇨🇼", "CX": "🇨🇽", "CY": "🇨🇾", "CZ": "🇨🇿", "DE": "🇩🇪", "DJ": "🇩🇯", "DK": "🇩🇰", "DM": "🇩🇲", "DO": "🇩🇴", "DZ": "🇩🇿", "EC": "🇪🇨", "EE": "🇪🇪", "EG": "🇪🇬", "EH": "🇪🇭", "ER": "🇪🇷", "ES": "🇪🇸", "ET": "🇪🇹", "FI": "🇫🇮", "FJ": "🇫🇯", "FK": "🇫🇰", "FM": "🇫🇲", "FO": "🇫🇴", "FR": "🇫🇷", "GA": "🇬🇦", "GB": "🇬🇧", "GD": "🇬🇩", "GE": "🇬🇪", "GF": "🇬🇫", "GG": "🇬🇬", "GH": "🇬🇭", "GI": "🇬🇮", "GL": "🇬🇱", "GM": "🇬🇲", "GN": "🇬🇳", "GP": "🇬🇵", "GQ": "🇬🇶", "GR": "🇬🇷", "GS": "🇬🇸", "GT": "🇬🇹", "GU": "🇬🇺", "GW": "🇬🇼", "GY": "🇬🇾", "HK": "🇭🇰", "HM": "🇭🇲", "HN": "🇭🇳", "HR": "🇭🇷", "HT": "🇭🇹", "HU": "🇭🇺", "ID": "🇮🇩", "IE": "🇮🇪", "IL": "🇮🇱", "IM": "🇮🇲", "IN": "🇮🇳", "IO": "🇮🇴", "IQ": "🇮🇶", "IR": "🇮🇷", "IS": "🇮🇸", "IT": "🇮🇹", "JE": "🇯🇪", "JM": "🇯🇲", "JO": "🇯🇴", "JP": "🇯🇵", "KE": "🇰🇪", "KG": "🇰🇬", "KH": "🇰🇭", "KI": "🇰🇮", "KM": "🇰🇲", "KN": "🇰🇳", "KP": "🇰🇵", "KR": "🇰🇷", "KW": "🇰🇼", "KY": "🇰🇾", "KZ": "🇰🇿", "LA": "🇱🇦", "LB": "🇱🇧", "LC": "🇱🇨", "LI": "🇱🇮", "LK": "🇱🇰", "LR": "🇱🇷", "LS": "🇱🇸", "LT": "🇱🇹", "LU": "🇱🇺", "LV": "🇱🇻", "LY": "🇱🇾", "MA": "🇲🇦", "MC": "🇲🇨", "MD": "🇲🇩", "ME": "🇲🇪", "MF": "🇲🇫", "MG": "🇲🇬", "MH": "🇲🇭", "MK": "🇲🇰", "ML": "🇲🇱", "MM": "🇲🇲", "MN": "🇲🇳", "MO": "🇲🇴", "MP": "🇲🇵", "MQ": "🇲🇶", "MR": "🇲🇷", "MS": "🇲🇸", "MT": "🇲🇹", "MU": "🇲🇺", "MV": "🇲🇻", "MW": "🇲🇼", "MX": "🇲🇽", "MY": "🇲🇾", "MZ": "🇲🇿", "NA": "🇳🇦", "NC": "🇳🇨", "NE": "🇳🇪", "NF": "🇳🇫", "NG": "🇳🇬", "NI": "🇳🇮", "NL": "🇳🇱", "NO": "🇳🇴", "NP": "🇳🇵", "NR": "🇳🇷", "NU": "🇳🇺", "NZ": "🇳🇿", "OM": "🇴🇲", "PA": "🇵🇦", "PE": "🇵🇪", "PF": "🇵🇫", "PG": "🇵🇬", "PH": "🇵🇭", "PK": "🇵🇰", "PL": "🇵🇱", "PM": "🇵🇲", "PN": "🇵🇳", "PR": "🇵🇷", "PS": "🇵🇸", "PT": "🇵🇹", "PW": "🇵🇼", "PY": "🇵🇾", "QA": "🇶🇦", "RE": "🇷🇪", "RO": "🇷🇴", "RS": "🇷🇸", "RU": "🇷🇺", "RW": "🇷🇼", "SA": "🇸🇦", "SB": "🇸🇧", "SC": "🇸🇨", "SD": "🇸🇩", "SE": "🇸🇪", "SG": "🇸🇬", "SH": "🇸🇭", "SI": "🇸🇮", "SJ": "🇸🇯", "SK": "🇸🇰", "SL": "🇸🇱", "SM": "🇸🇲", "SN": "🇸🇳", "SO": "🇸🇴", "SR": "🇸🇷", "SS": "🇸🇸", "ST": "🇸🇹", "SV": "🇸🇻", "SX": "🇸🇽", "SY": "🇸🇾", "SZ": "🇸🇿", "TC": "🇹🇨", "TD": "🇹🇩", "TF": "🇹🇫", "TG": "🇹🇬", "TH": "🇹🇭", "TJ": "🇹🇯", "TK": "🇹🇰", "TL": "🇹🇱", "TM": "🇹🇲", "TN": "🇹🇳", "TO": "🇹🇴", "TR": "🇹🇷", "TT": "🇹🇹", "TV": "🇹🇻", "TW": "🇹🇼", "TZ": "🇹🇿", "UA": "🇺🇦", "UG": "🇺🇬", "UM": "🇺🇲", "US": "🇺🇸", "UY": "🇺🇾", "UZ": "🇺🇿", "VA": "🇻🇦", "VC": "🇻🇨", "VE": "🇻🇪", "VG": "🇻🇬", "VI": "🇻🇮", "VN": "🇻🇳", "VU": "🇻🇺", "WF": "🇼🇫", "WS": "🇼🇸", "YE": "🇾🇪", "YT": "🇾🇹", "ZA": "🇿🇦", "ZM": "🇿🇲", "ZW": "🇿🇼"
//        ]
//    }
    
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

/*extension sign_up: ASAuthorizationControllerDelegate {

     // ASAuthorizationControllerDelegate function for authorization failed

    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {

        print(error.localizedDescription)

    }

       // ASAuthorizationControllerDelegate function for successful authorization

    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {

        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {

            // Create an account as per your requirement

            let appleId = appleIDCredential.user

            let appleUserFirstName = appleIDCredential.fullName?.givenName

            let appleUserLastName = appleIDCredential.fullName?.familyName

            let appleUserEmail = appleIDCredential.email

            //Write your code

        } else if let passwordCredential = authorization.credential as? ASPasswordCredential {

            let appleUsername = passwordCredential.user

            let applePassword = passwordCredential.password

            //Write your code

        }

    }

}

extension sign_up: ASAuthorizationControllerPresentationContextProviding {

    //For present window

    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {

        return self.view.window!

    }

}*/
