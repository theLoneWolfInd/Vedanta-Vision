//
//  Utils.swift
//  Vedanta
//
//  Created by Dishant Rajput on 13/09/22.
//

// com.googleusercontent.apps.332203884683-i7ub3lqqg9bpv4gj67i05ucfv6emnhvu

import UIKit
import SystemConfiguration

import AVFoundation
import AVKit

// Import Swift module
import YouTubePlayer

let application_base_url = "https://app.vedantavision.org/services/index"

//"https://demo4.evirtualservices.net/vedanta/services/index"

//"https://app.vedantavision.org/services/index"

let app_BG_color = UIColor.init(red: 246.0/255.0, green: 246.0/255.0, blue: 246.0/255.0, alpha: 1)

let str_save_login_user_data = "keyLoginFullData"



// NOTIFICATION
let notification_subscription_for_audio = "notification_subscription_audio"
let notification_subscription_for_video = "notification_subscription_video"
let notification_subscription_for_article = "notification_subscription_article"

class Utils: NSObject {
    
    
    
}

extension UIViewController {
    
    @objc func please_login_to_continue() {
        
        let alert = NewYorkAlertController(title: String("Login"), message: String("Please login to use this feature."), style: .alert)
        
        let login = NewYorkButton(title: "Login", style: .default) {
            _ in
            
            self.sign_in_click_method()
        }
        let cancel = NewYorkButton(title: "dismiss", style: .cancel)
        
        alert.addButtons([login , cancel])
        self.present(alert, animated: true)
        
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func back_click_method() {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @objc func notification_v_home_click_method() {
        
        if let person = UserDefaults.standard.value(forKey: "keyLoginFullData") as? [String:Any] {
            print(person as Any)
            
            let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "v_home_notification_id")
            self.navigationController?.pushViewController(push, animated: true)
            
        } else {
            
            let alert = NewYorkAlertController(title: String("Alert"), message: String("Please login to use this feature."), style: .alert)
            
            let login = NewYorkButton(title: "login", style: .default) {
                _ in
                
                self.sign_in_click_method()
            }
            let cancel = NewYorkButton(title: "dismiss", style: .cancel)
            
            alert.addButtons([login , cancel])
            self.present(alert, animated: true)
            
        }
        
        
        
        
    }
    
    @objc func search_v_home_click_method() {
        
        let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "v_wisdom_id")
        self.navigationController?.pushViewController(push, animated: true)
//        as
    }
    
    // push : - LIST OF ALL VIDEOS -
    @objc func see_more_click_method() {
        
        let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "v_videos_id") as? v_videos
        push!.hidesBottomBarWhenPushed = false
        self.navigationController?.pushViewController(push!, animated: true)
        
    }
    
    // push : - LIST OF ALL AUDIOS -
    @objc func see_more_audio_click_method() {
        
        let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "v_audio_id") as? v_audio
        push!.hidesBottomBarWhenPushed = false
        self.navigationController?.pushViewController(push!, animated: true)
        
    }
    
    // push : - LIST OF ALL ARTICLES -
    @objc func see_more_article_click_method() {
        
        let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "v_article_id") as? v_article
        push!.hidesBottomBarWhenPushed = false
        self.navigationController?.pushViewController(push!, animated: true)
        
    }
    
    @objc func explore_click_method() {
        
//        let alert = NewYorkAlertController(title: String("Vedanta Unlimited"), message: String("Please Subscribe to get access."), style: .alert)
//
//
//        let yes_subscribe = NewYorkButton(title: "Subscribe", style: .default) {
//            _ in
//
//            self.subscribe_click_method()
//
//        }
//        let cancel = NewYorkButton(title: "dismiss", style: .cancel)
//
//        yes_subscribe.setDynamicColor(.pink)
//
//        alert.addButtons([yes_subscribe,cancel])
//        self.present(alert, animated: true)
        
        if let person = UserDefaults.standard.value(forKey: "keyLoginFullData") as? [String:Any] {
            print(person as Any)
            
            if (person["subscriptionDate"] as! String) == "" {
                
                let alert = NewYorkAlertController(title: String("Vedanta Unlimited"), message: String("Please Subscribe to get access."), style: .alert)
                
                
                let yes_subscribe = NewYorkButton(title: "Subscribe", style: .default) {
                    _ in
                    
                    self.subscribe_click_method()
                    
                }
                
                let cancel = NewYorkButton(title: "dismiss", style: .cancel)
                
                yes_subscribe.setDynamicColor(.pink)
                
                alert.addButtons([yes_subscribe,cancel])
                self.present(alert, animated: true)
                
            } else {
                
                let pushVC = self.storyboard?.instantiateViewController(withIdentifier: "explore_more_id") as! explore_more
                
                pushVC.hidesBottomBarWhenPushed = true
                
                self.navigationController?.pushViewController(pushVC, animated: true)
                
            }

        } else {
            
            self.please_login_to_continue()
        }
        
    }
    
    @objc func push_to_video_screen(str_video_file_link:String , str_video_title:String) {
        
        
//        let pushVC = self.storyboard?.instantiateViewController(withIdentifier: "play_videos_id") as! play_videos
//
//        pushVC.hidesBottomBarWhenPushed = true
//        pushVC.str_video_link = String(str_video_file_link)
//        pushVC.str_video_header = String(str_video_title)
//
//        self.navigationController?.pushViewController(pushVC, animated: true)
        
        
//        print(str_video_file_link)
        
        let fullNameArr = str_video_file_link.components(separatedBy: "://")
//        print(fullNameArr)
        
        let first_8 = "\(fullNameArr[1])".prefix(8)
//        print(first_8)
        
        if first_8 == "youtu.be" {
            
            let pushVC = self.storyboard?.instantiateViewController(withIdentifier: "youtube_video_id") as! youtube_video

            pushVC.hidesBottomBarWhenPushed = true
            pushVC.strVideoTitle = String(str_video_title)
            pushVC.strVideoLink = String(str_video_file_link)
            
            self.navigationController?.pushViewController(pushVC, animated: true)
            
            
        } else {
            
            let videoURL = URL(string: str_video_file_link)
            let player = AVPlayer(url: videoURL!)
            let playerViewController = AVPlayerViewController()
            playerViewController.player = player
            self.present(playerViewController, animated: true) {
                playerViewController.player!.play()
            }
            
        }
        
        
        
        
        
        
        
        
        
        
        
        
    }
    
    @objc func push_to_article_screen(str_description:String, str_navigation_title:String) {
        
        let pushVC = self.storyboard?.instantiateViewController(withIdentifier: "read_article_id") as! read_article
        
        pushVC.hidesBottomBarWhenPushed = true
        pushVC.str_description = String(str_description)
        pushVC.str_navigation_title = String(str_navigation_title)
        
        self.navigationController?.pushViewController(pushVC, animated: true)
        
    }
    
    // push : - WELCOME PAGE -
    @objc func subscribe_click_method() {

        if let person = UserDefaults.standard.value(forKey: "keyLoginFullData") as? [String:Any] {
            print(person as Any)
            
            let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "subscription_id") as? subscription
            push!.hidesBottomBarWhenPushed = false
            self.navigationController?.pushViewController(push!, animated: true)
            
        } else {
            
            let alert = NewYorkAlertController(title: String("Alert"), message: String("Please login to use this feature."), style: .alert)
            
            let login = NewYorkButton(title: "login", style: .default) {
                _ in
                
                self.sign_in_click_method()
            }
            let cancel = NewYorkButton(title: "dismiss", style: .cancel)
            
            alert.addButtons([login , cancel])
            self.present(alert, animated: true)
            
        }
        
        
    }
    
    // push : - LOGIN -
    @objc func sign_in_click_method() {
        
        let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "login_id") as? login
        push!.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(push!, animated: true)
        
    }
    
    // push : - SIGN UP -
    @objc func sign_up_click_method() {
        
        let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "sign_up_id") as? sign_up
        push!.hidesBottomBarWhenPushed = false
        self.navigationController?.pushViewController(push!, animated: true)
        
    }
    
    // push : - SIGN UP VIA EMAIL -
    @objc func sign_up_via_email_click_method() {
        
        let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "sign_up_form_id") as? sign_up_form
        push!.hidesBottomBarWhenPushed = false
        self.navigationController?.pushViewController(push!, animated: true)
        
    }
    
    // push : - CHANGE PASSWORD -
    @objc func change_password_click_method() {
        
        if let person = UserDefaults.standard.value(forKey: "keyLoginFullData") as? [String:Any] {
            print(person as Any)
            
            if (person["socialType"] as! String) == "" {
                let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "change_password_id") as? change_password
                push!.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(push!, animated: true)
            }
            
            
            
        } else {
        
            let alert = NewYorkAlertController(title: String("Alert"), message: String("Please login to use this feature."), style: .alert)
            
            let login = NewYorkButton(title: "login", style: .default) {
                _ in
                
                self.sign_in_click_method()
            }
            let cancel = NewYorkButton(title: "dismiss", style: .cancel)
            
            alert.addButtons([login , cancel])
            self.present(alert, animated: true)
            
        }
        
        
    }
    
    
    @objc func please_subscribe_to_access_this_feature(str_title:String , str_message:String) {
        
        let alert = NewYorkAlertController(title: String(str_title), message: String(str_message), style: .alert)
        
        let login = NewYorkButton(title: "login", style: .default) {
            _ in
            
            self.sign_in_click_method()
        }
        let cancel = NewYorkButton(title: "dismiss", style: .cancel)
        
        alert.addButtons([login , cancel])
        self.present(alert, animated: true)
        
    }
    
    // push : - EDIT PROFILE -
    @objc func edit_profile_click_method() {
        
        if let person = UserDefaults.standard.value(forKey: "keyLoginFullData") as? [String:Any] {
            print(person as Any)
            
            let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "edit_profile_id") as? edit_profile
            push!.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(push!, animated: true)
            
        } else {
            
            let alert = NewYorkAlertController(title: String("Alert"), message: String("Please login to use this feature."), style: .alert)
            
            let login = NewYorkButton(title: "login", style: .default) {
                _ in
                
                self.sign_in_click_method()
            }
            let cancel = NewYorkButton(title: "dismiss", style: .cancel)
            
            alert.addButtons([login , cancel])
            self.present(alert, animated: true)
            
        }
        
    }
    
    
    @objc func scroll_to_top(table_view:UITableView) {
        
        let topRow = IndexPath(row: 0, section: 0)
        table_view.scrollToRow(at: topRow, at: .top, animated: true)
        
    }
    
    @objc func scroll_to_bottom(table_view:UITableView) {
        
        let topRow = IndexPath(row: 0, section: 0)
        table_view.scrollToRow(at: topRow, at: .bottom, animated: true)
        
    }
    
    @objc func please_check_your_internet_connection() {
        
        let alert = NewYorkAlertController(title: String("Error").uppercased(), message: String("Please check your internet connection."), style: .alert)
        let cancel = NewYorkButton(title: "dismiss", style: .cancel)
        alert.addButtons([cancel])
        self.present(alert, animated: true)
        
    }
    
    // MARK: - SOMETHING WENT WRONG WITH YOUR WEBSERVICE -
    @objc func something_went_wrong_with_WB() {
        
        let alert = NewYorkAlertController(title: String("Error").uppercased(), message: String("Server issue. Please wait or contact admin."), style: .alert)
        let cancel = NewYorkButton(title: "dismiss", style: .cancel)
        alert.addButtons([cancel])
        self.present(alert, animated: true)
        
    }
    
    @objc func all_category_v_home_click_method() {
        
        let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "category_list_id")
        self.navigationController?.pushViewController(push, animated: true)
        
    }
    
    // For check Internet Connection
    func IsInternetAvailable () -> Bool {
        
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        return (isReachable && !needsConnection)
        
    }
    
    
    @objc func keyboardWillShow_2(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide_2(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
        
    }
    
}

extension UIView {
    enum Corner:Int {
        case bottomRight = 0,
             topRight,
             bottomLeft,
             topLeft
    }
    
    private func parseCorner(corner: Corner) -> CACornerMask.Element {
        let corners: [CACornerMask.Element] = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner]
        return corners[corner.rawValue]
    }
    
    private func createMask(corners: [Corner]) -> UInt {
        return corners.reduce(0, { (a, b) -> UInt in
            return a + parseCorner(corner: b).rawValue
        })
    }
    
    func roundCorners(corners: [Corner], amount: CGFloat = 30) {
        layer.cornerRadius = amount
        let maskedCorners: CACornerMask = CACornerMask(rawValue: createMask(corners: corners))
        layer.maskedCorners = maskedCorners
    }
}

extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}

extension UIView {
    @discardableResult
    func addLineDashedStroke(pattern: [NSNumber]?, radius: CGFloat, color: CGColor) -> CALayer {
        let borderLayer = CAShapeLayer()
        
        borderLayer.strokeColor = color
        borderLayer.lineDashPattern = pattern
        borderLayer.frame = bounds
        borderLayer.fillColor = nil
        borderLayer.path = UIBezierPath(roundedRect: bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: radius, height: radius)).cgPath
        
        layer.addSublayer(borderLayer)
        return borderLayer
    }
}


extension Date {
    
    func dateString(_ format: String = "MMM-dd-YYYY, hh:mm a") -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        
        return dateFormatter.string(from: self)
    }
    
    func dateByAddingYears(_ dYears: Int) -> Date {
        
        var dateComponents = DateComponents()
        dateComponents.year = dYears
        
        return Calendar.current.date(byAdding: dateComponents, to: self)!
    }
}
