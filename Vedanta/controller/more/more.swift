//
//  more.swift
//  Vedanta
//
//  Created by Dishant Rajput on 16/09/22.
//

import UIKit
import Alamofire
import SDWebImage
import GoogleSignIn

import FBSDKLoginKit

class more: UIViewController {
    
    var arr_social_list:NSMutableArray! = []
    
    var dummy_social_media = ["instagram","facebook","youtube","linked-in","spotify","twitter"]
    
    @IBOutlet weak var view_full_view:UIView! {
        didSet {
            view_full_view.backgroundColor = UIColor.init(red: 246.0/255.0, green: 246.0/255.0, blue: 246.0/255.0, alpha: 1)
        }
    }
    
    @IBOutlet weak var tble_view:UITableView! {
        didSet {
            
            tble_view.backgroundColor = .clear
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.view_full_view.backgroundColor = app_BG_color
        
        self.tble_view.separatorColor = .clear
        
        
//        if UserDefaults.standard.value(forKey: str_save_login_user_data) is [String:Any] {
//
//            self.btn_sign_out.isHidden = false
//
//        } else {
//            self.btn_sign_out.isHidden = true
//        }
//
//        self.btn_sign_out.addTarget(self, action: #selector(sign_out_click_method), for: .touchUpInside)
//
        self.home_bhagwat_gita_categories_WB()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
//        self.tble_view.delegate = self
//        self.tble_view.dataSource = self
        self.tble_view.reloadData()
        
//        let indexPath = IndexPath.init(row: 0, section: 0)
//        let cell = self.tble_view.cellForRow(at: indexPath) as! more_table_cell
//
//
        self.tabBarController?.tabBar.backgroundColor = UIColor.init(red: 250.0/255.0, green: 250.0/255.0, blue: 255.0/255.0, alpha: 1)
        
       
        
//        self.home_bhagwat_gita_categories_WB()
        
    }
    
    // notification click
    @objc
    func tap_app_details(sender:UITapGestureRecognizer) {
        print("tap working")
            
        if let person = UserDefaults.standard.value(forKey: str_save_login_user_data) as? [String:Any] {
            // let str:String = person["role"] as! String
            print(person as Any)
            
            let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "more_app_settings_id")
            self.navigationController?.pushViewController(push, animated: true)
            
        } else {
         
            let alert = NewYorkAlertController(title: String("Alert"), message: String("Please login to check notification settings."), style: .alert)
            
            let login = NewYorkButton(title: "Login", style: .default) {
                _ in
                
                self.sign_in_click_method()
            }
            let cancel = NewYorkButton(title: "Dismiss", style: .cancel)
            
            alert.addButtons([login , cancel])
            self.present(alert, animated: true)
            
        }
        
    }
    
    // MARK: - URL ( events ) -
    @objc func events_click_method() {
        
        let pushVC = self.storyboard?.instantiateViewController(withIdentifier: "play_videos_id") as! play_videos
        
        pushVC.hidesBottomBarWhenPushed = true
        pushVC.str_video_link = "https://vedantavision.org/events/"
        pushVC.str_video_header = "Events"
        
        self.navigationController?.pushViewController(pushVC, animated: true)
        
    }
    
    // MARK: - URL ( donate ) -
    @objc func donate_click_method() {
        
        let pushVC = self.storyboard?.instantiateViewController(withIdentifier: "play_videos_id") as! play_videos
        
        pushVC.hidesBottomBarWhenPushed = true
        pushVC.str_video_link = "https://vedantavision.org/donate/"
        pushVC.str_video_header = "Donate"
        
        self.navigationController?.pushViewController(pushVC, animated: true)
        
    }
    
    // MARK: - URL ( vision ) -
    @objc func vision_click_method() {
        
        let pushVC = self.storyboard?.instantiateViewController(withIdentifier: "play_videos_id") as! play_videos
        
        pushVC.hidesBottomBarWhenPushed = true
        pushVC.str_video_link = "https://vedantavision.org/our-vision/"
        pushVC.str_video_header = "Our Vision"
        
        self.navigationController?.pushViewController(pushVC, animated: true)
        
    }
    
    // MARK: - URL ( shop ) -
    @objc func shop_click_method() {
        
        let alert = NewYorkAlertController(title: String("Shop"), message: nil, style: .actionSheet)
        
        let india = NewYorkButton(title: "India", style: .default) {
            _ in
            
            let pushVC = self.storyboard?.instantiateViewController(withIdentifier: "play_videos_id") as! play_videos
            
            pushVC.hidesBottomBarWhenPushed = true
            pushVC.str_video_link = "https://vedantavision.org/shopindia/"
            pushVC.str_video_header = "India"
            
            self.navigationController?.pushViewController(pushVC, animated: true)
            
        }
        let international = NewYorkButton(title: "International", style: .default) {
            _ in
            
            let pushVC = self.storyboard?.instantiateViewController(withIdentifier: "play_videos_id") as! play_videos
            
            pushVC.hidesBottomBarWhenPushed = true
            pushVC.str_video_link = "https://vedantavision.org/shopworld/"
            pushVC.str_video_header = "International"
            
            self.navigationController?.pushViewController(pushVC, animated: true)
            
        }
        
        let cancel = NewYorkButton(title: "Dismiss", style: .cancel)
        
        alert.addButtons([india,international,cancel])
        self.present(alert, animated: true)
        
    }
    
    // MARK: - URL ( programme ) -
    @objc func programme_click_method() {
        
        let pushVC = self.storyboard?.instantiateViewController(withIdentifier: "play_videos_id") as! play_videos
        
        pushVC.hidesBottomBarWhenPushed = false
        pushVC.str_video_link = "https://vedantavision.org/programmes/"
        pushVC.str_video_header = "Programmes"
        
        self.navigationController?.pushViewController(pushVC, animated: true)
        
    }
    
    // MARK: - URL ( founders ) -
    @objc func founders_click_method() {
        
        let pushVC = self.storyboard?.instantiateViewController(withIdentifier: "play_videos_id") as! play_videos
        
        pushVC.hidesBottomBarWhenPushed = true
        pushVC.str_video_link = "https://vedantavision.org/our-founder/"
        pushVC.str_video_header = "Our Founders"
        
        self.navigationController?.pushViewController(pushVC, animated: true)
        
    }
    
    // MARK: - URL ( contact us ) -
    @objc func contact_us_click_method() {
        
        let pushVC = self.storyboard?.instantiateViewController(withIdentifier: "play_videos_id") as! play_videos
        
        pushVC.hidesBottomBarWhenPushed = true
        pushVC.str_video_link = "https://vedantavision.org/contact-us/"
        pushVC.str_video_header = "Contact Us"
        
        self.navigationController?.pushViewController(pushVC, animated: true)
        
    }
    
    // MARK: - URL ( terms ) -
    @objc func terms_click_method() {
        
        
        
    }
    
    // MARK: - URL ( rate us ) -
    @objc func rate_us_click_method() {
        
        
        
    }
    
    @objc func favourite_click_method() {
        
        if let person = UserDefaults.standard.value(forKey: str_save_login_user_data) as? [String:Any] {
            // let str:String = person["role"] as! String
            print(person as Any)
            
            let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "favourite_list_id")
            
            push.hidesBottomBarWhenPushed = false
            
            self.navigationController?.pushViewController(push, animated: true)
            
        } else {
         
            let alert = NewYorkAlertController(title: String("Alert"), message: String("Please login to check all favourites."), style: .alert)
            
            let login = NewYorkButton(title: "Login", style: .default) {
                _ in
                
                self.sign_in_click_method()
            }
            let cancel = NewYorkButton(title: "Dismiss", style: .cancel)
            
            alert.addButtons([login , cancel])
            self.present(alert, animated: true)
            
        }
        
    }
    
    
    
    @objc func home_bhagwat_gita_categories_WB() {
        self.view.endEditing(true)
        
        ERProgressHud.sharedInstance.showDarkBackgroundView(withTitle: "Please wait...")
        
        if IsInternetAvailable() == false {
            self.please_check_your_internet_connection()
            return
        }
        
        let parameters = [
            "action"    : "home",
            // "type"      : String("Video")
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
                            
                            var ar : NSArray!
                            ar = (jsonDict["social"] as! Array<Any>) as NSArray
                            
                            self.arr_social_list.addObjects(from: ar as! [Any])
                            
                            self.tble_view.delegate = self
                            self.tble_view.dataSource = self
                            self.tble_view.reloadData()
                            
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
    
    @objc func sign_out_click_method() {
        
        let alert = NewYorkAlertController(title: String("Logout").uppercased(), message: String("Are you sure you want to logout ?"), style: .alert)
        
        let yes_logout = NewYorkButton(title: "Logout", style: .default) {
            _ in
            
            self.check_login_status()
            
        }
        let cancel = NewYorkButton(title: "Dismiss", style: .cancel)
        
        alert.addButtons([yes_logout , cancel])
        self.present(alert, animated: true)
        
    }
    
    func check_login_status() {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tble_view.cellForRow(at: indexPath) as! more_table_cell
        
        if let person = UserDefaults.standard.value(forKey: str_save_login_user_data) as? [String:Any] {
            // let str:String = person["role"] as! String
            print(person as Any)
            
            if (person["socialType"] as! String) == "G" {
                
                // sign out via google
                GIDSignIn.sharedInstance.signOut()
                
                // clear all default values
                let defaults = UserDefaults.standard
                defaults.setValue("", forKey: str_save_login_user_data)
                defaults.setValue(nil, forKey: str_save_login_user_data)
                
                // adjust local UI
                cell.btn_sign_out.isHidden = true
                self.tble_view.reloadData()
                
            } else if (person["socialType"] as! String) == "F" {
                
                // sign out via FACEBOOK
                LoginManager().logOut()
//                FBSession.activeSession().closeAndClearTokenInformation()
//                LoginManager()
                
                // clear all default values
                let defaults = UserDefaults.standard
                defaults.setValue("", forKey: str_save_login_user_data)
                defaults.setValue(nil, forKey: str_save_login_user_data)
                
                // adjust local UI
                cell.btn_sign_out.isHidden = true
                self.tble_view.reloadData()
                
            } else {
                
                // clear all default values
                let defaults = UserDefaults.standard
                defaults.setValue("", forKey: str_save_login_user_data)
                defaults.setValue(nil, forKey: str_save_login_user_data)
                
                // adjust local UI
                cell.btn_sign_out.isHidden = true
                self.tble_view.reloadData()
                
            }
            
        }
       
    }
    
}

extension more : UITableViewDelegate , UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:more_table_cell = tableView.dequeueReusableCell(withIdentifier: "more_table_cell") as! more_table_cell
        
        cell.backgroundColor = .clear
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = .clear
        cell.selectedBackgroundView = backgroundView
        
        cell.cl_view_social_media.delegate = self
        cell.cl_view_social_media.dataSource = self
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(more.tap_app_details))
        cell.lbl_app_setting.isUserInteractionEnabled = true
        cell.lbl_app_setting.addGestureRecognizer(tap)
        
        cell.btn_favourite.addTarget(self, action: #selector(favourite_click_method), for: .touchUpInside)
        
        cell.btn_edit_profile.addTarget(self, action: #selector(edit_profile_click_method), for: .touchUpInside)
        
        if let person = UserDefaults.standard.value(forKey: str_save_login_user_data) as? [String:Any] {
            // let str:String = person["role"] as! String
            print(person as Any)
            
            cell.lbl_app_edit_profile.text = "Edit profile"
            cell.btn_sign_out.isHidden = false
            
        } else {
            
            cell.lbl_app_edit_profile.text = "Login"
            cell.btn_sign_out.isHidden = true
            
        }
        
        cell.btn_sign_out.addTarget(self, action: #selector(sign_out_click_method), for: .touchUpInside)
        
//        cell.btn_change_password.addTarget(self, action: #selector(change_password_click_method), for: .touchUpInside)
        
        cell.btn_events.addTarget(self, action: #selector(events_click_method), for: .touchUpInside)
        cell.btn_donate.addTarget(self, action: #selector(donate_click_method), for: .touchUpInside)
        cell.btn_shop.addTarget(self, action: #selector(shop_click_method), for: .touchUpInside)
        cell.btn_programmes.addTarget(self, action: #selector(programme_click_method), for: .touchUpInside)
        
        cell.btn_our_vision.addTarget(self, action: #selector(vision_click_method), for: .touchUpInside)
        cell.btn_our_founders.addTarget(self, action: #selector(founders_click_method), for: .touchUpInside)
        
        cell.btn_contact_us.addTarget(self, action: #selector(contact_us_click_method), for: .touchUpInside)
        cell.btn_terms_condition.addTarget(self, action: #selector(terms_click_method), for: .touchUpInside)
        cell.btn_rate_app.addTarget(self, action: #selector(rate_us_click_method), for: .touchUpInside)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if let person = UserDefaults.standard.value(forKey: str_save_login_user_data) as? [String:Any] {
            
            print(person as Any)
            
            return 1160
            
        } else {
            
            return 1100
            
        }
        
    }
    
}

class more_table_cell:UITableViewCell {
    
    @IBOutlet weak var btn_sign_out:UIButton!
    
    @IBOutlet weak var view_bg:UIView! {
        didSet {
            view_bg.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            view_bg.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            view_bg.layer.shadowOpacity = 1.0
            view_bg.layer.shadowRadius = 4
            view_bg.layer.masksToBounds = false
            view_bg.layer.cornerRadius = 8
            view_bg.backgroundColor = .white
        }
    }
    
    @IBOutlet weak var view_support:UIView! {
        didSet {
            view_support.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            view_support.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            view_support.layer.shadowOpacity = 1.0
            view_support.layer.shadowRadius = 4
            view_support.layer.masksToBounds = false
            view_support.layer.cornerRadius = 8
            view_support.backgroundColor = .white
        }
    }
    
    @IBOutlet weak var view_about:UIView! {
        didSet {
            view_about.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            view_about.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            view_about.layer.shadowOpacity = 1.0
            view_about.layer.shadowRadius = 4
            view_about.layer.masksToBounds = false
            view_about.layer.cornerRadius = 8
            view_about.backgroundColor = .white
        }
    }
    
    @IBOutlet weak var view_other:UIView! {
        didSet {
            view_other.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            view_other.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            view_other.layer.shadowOpacity = 1.0
            view_other.layer.shadowRadius = 4
            view_other.layer.masksToBounds = false
            view_other.layer.cornerRadius = 8
            view_other.backgroundColor = .white
        }
    }
    
    @IBOutlet weak var img_view:UIImageView! {
        didSet {
            img_view.layer.cornerRadius = 8
            img_view.clipsToBounds = true
            img_view.backgroundColor = UIColor.init(red: 208.0/255.0, green: 208.0/255.0, blue: 208.0/255.0, alpha: 1)
        }
    }
    
    // collection view social media
    @IBOutlet weak var cl_view_social_media:UICollectionView! {
        didSet {
            cl_view_social_media.backgroundColor = .clear
            
        }
    }
    
    @IBOutlet weak var lbl_app_setting:UILabel! {
        didSet {
            lbl_app_setting.textColor = .black
        }
    }
    
    @IBOutlet weak var lbl_app_edit_profile:UILabel! {
        didSet {
            lbl_app_edit_profile.textColor = .black
        }
    }
    
    @IBOutlet weak var btn_events:UIButton!
    @IBOutlet weak var btn_donate:UIButton!
    @IBOutlet weak var btn_shop:UIButton!
    @IBOutlet weak var btn_programmes:UIButton!
    
    @IBOutlet weak var btn_our_vision:UIButton!
    @IBOutlet weak var btn_our_founders:UIButton!
    
    @IBOutlet weak var btn_contact_us:UIButton!
    @IBOutlet weak var btn_terms_condition:UIButton!
    @IBOutlet weak var btn_rate_app:UIButton!
    
    @IBOutlet weak var btn_favourite:UIButton!
    
    @IBOutlet weak var btn_change_password:UIButton!
    
    @IBOutlet weak var btn_edit_profile:UIButton!
    
    @IBOutlet weak var btn_logout:UIButton!
    
}


// collection view
extension more: UICollectionViewDataSource , UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.arr_social_list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "more_collection_social_media_view_cell", for: indexPath as IndexPath) as! more_collection_social_media_view_cell
        
        cell.backgroundColor = app_BG_color
        
        
        
        
        let item = self.arr_social_list[indexPath.row] as? [String:Any]
        
        if (item!["name"] as! String) == "Linkedin" {
            
            cell.img_social_media.image = UIImage(named: "linked-in")
            
        } else if (item!["name"] as! String) == "Youtube" {
            
            cell.img_social_media.image = UIImage(named: "youtube")
            
        } else if (item!["name"] as! String) == "spotify" {
            
            cell.img_social_media.image = UIImage(named: "spotify")
            
        } else if (item!["name"] as! String) == "facebook" {
            
            cell.img_social_media.image = UIImage(named: "facebook")
            
        } else if (item!["name"] as! String) == "Instagram" {
            
            cell.img_social_media.image = UIImage(named: "instagram")
            
        } else {
            
            cell.img_social_media.image = UIImage(named: "logo")
            
        }
        
        cell.layer.cornerRadius = 8
        
        return cell
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let item = self.arr_social_list[indexPath.row] as? [String:Any]
        
        let pushVC = self.storyboard?.instantiateViewController(withIdentifier: "play_videos_id") as! play_videos
        
        pushVC.hidesBottomBarWhenPushed = false
        pushVC.str_video_link = (item!["media_link"] as! String)
        pushVC.str_video_header = (item!["name"] as! String)
        
        self.navigationController?.pushViewController(pushVC, animated: true)
        
    }
    
    
}

extension more: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView.tag == 1000 {
            return CGSize(width: 50,height: 80)
        } else if collectionView.tag == 2000 {
            return CGSize(width: 50,height: 80)
        } else {
            return CGSize(width: 120,height: 130)
        }
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        
        
        return 10
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout
                        collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        if collectionView.tag == 1000 {
            return 16
        } else if collectionView.tag == 2000 {
            return 20
        } else {
            return 10
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
    
}



// MARK: - COLLECTION CELL ( SOCIAL MEDIA ) -
class more_collection_social_media_view_cell: UICollectionViewCell {
    
    @IBOutlet weak var img_social_media:UIImageView! {
        didSet {
            
        }
    }
    
}
