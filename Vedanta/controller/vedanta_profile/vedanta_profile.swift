//
//  vedanta_profile.swift
//  Vedanta
//
//  Created by Dishant Rajput on 16/09/22.
//

import UIKit
import Alamofire
import SDWebImage

class vedanta_profile: UIViewController {
    
    
    
    var arr_demistify_bhagwat_gita:NSMutableArray! = []
    
    var arr_mut_video_list:NSMutableArray! = []
    var arr_mut_audio_list:NSMutableArray! = []
    var arr_quotation_list:NSMutableArray! = []
    var arr_article_list:NSMutableArray! = []
    var arr_advertisement:NSMutableArray! = []
    var arr_social_list:NSMutableArray! = []
    var arr_mut_category:NSMutableArray! = []
    
    var arr_save_names:NSMutableArray! = []
    var arr_show_1_video:NSMutableArray! = []
    var arr_show_2_video:NSMutableArray! = []
    var arr_show_3_video:NSMutableArray! = []
    var arr_show_4_video:NSMutableArray! = []
    var arr_show_5_video:NSMutableArray! = []
    
    var str_is_membership_expired:String!
    
    @IBOutlet weak var view_full_view:UIView! {
        didSet {
            view_full_view.backgroundColor = UIColor.init(red: 246.0/255.0, green: 246.0/255.0, blue: 246.0/255.0, alpha: 1)
        }
    }
    
    @IBOutlet weak var tble_view:UITableView! {
        didSet {
            // tble_view.delegate = self
            // tble_view.dataSource = self
            tble_view.backgroundColor = .clear
        }
    }
    
    @IBOutlet weak var btn_subscribe:UIButton! {
        didSet {
            btn_subscribe.setTitle("Subscribe Now", for: .normal)
            btn_subscribe.setTitleColor(.white, for: .normal)
            
            btn_subscribe.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            btn_subscribe.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            btn_subscribe.layer.shadowOpacity = 1.0
            btn_subscribe.layer.shadowRadius = 4
            btn_subscribe.layer.masksToBounds = false
            btn_subscribe.layer.cornerRadius = 20
            btn_subscribe.backgroundColor = UIColor.init(red: 230.0/255.0, green: 40.0/255.0, blue: 36.0/255.0, alpha: 1)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.view_full_view.backgroundColor = app_BG_color
        
        self.tble_view.separatorColor = .clear
        
        /*let sender = PushNotificationSender()
         sender.sendPushNotification(to: "/topics/notification_for_audio", title: "New audio", body: "Vedanta added new Audio")*/
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if let person = UserDefaults.standard.value(forKey: str_save_login_user_data) as? [String:Any] {
            // let str:String = person["role"] as! String
            print(person as Any)
            
            if (person["expiryDate"] as! String) != "" {
                
                // cell.btn_subscribe.isHidden = true
                // cell.btn_login.isHidden = true
                
                let start = (person["expiryDate"] as! String)
                let end = "2017-11-12"
                let dateFormat = "yyyy-MM-dd"

                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = dateFormat

                let startDate = dateFormatter.date(from: start)
                let endDate = dateFormatter.date(from: end)

                let currentDate = Date()

                guard let startDate = startDate, let endDate = endDate else {
                  fatalError("Date Format does not match ⚠️")
                }

                print(startDate)
                print(currentDate)
                print(endDate)
                
                if startDate > currentDate {
                    print("✅")
                    
                    self.str_is_membership_expired = "active"
                    
                    self.home_bhagwat_gita_categories_WB()
                    
                } else {
                    
                    print("❌")
                    self.str_is_membership_expired = "expired"
                    self.home_bhagwat_gita_categories_WB()
                    
                }
                
            } else {
                
                self.self.str_is_membership_expired = "na"
                self.home_bhagwat_gita_categories_WB()
                
            }
            
            
        } else {
            
            self.self.str_is_membership_expired = "na"
            
            self.home_bhagwat_gita_categories_WB()
            
        }
        
        print(self.str_is_membership_expired as Any)
        
    }
    
    func daysBetween(start: Date, end: Date) -> Int {
            return Calendar.current.dateComponents([.day], from: start, to: end).day!
        }
    
    @objc func home_bhagwat_gita_categories_WB() {
        self.view.endEditing(true)

        if IsInternetAvailable() == false {
            self.please_check_your_internet_connection()
            return
        }
        
//        var device_token:String!
//        if self.str_user_device_token == nil {
//            device_token = ""
//        } else {
//            device_token = String(self.str_user_device_token)
//        }
        
//        [action] => socialLoginAction
//            [email] => satishdhakar17@gmail.com
//            [fullName] => Satish Dhakar
//            [image] => https://lh3.googleusercontent.com/a/ALm5wu0sBOwD-nhr4RqpE9LUIRo9NrXpzVqFroF7ersz
//            [socialId] => 118029733234090846820
//            [socialType] => G
//            [device] => Android
//            [deviceToken] =>
        
        let parameters = [
//            "action"        : "socialLoginAction",
//            "email"         : String(str_email),
//            "fullName"      : String(str_full_name),
//            "image"         : String(str_image),
//            "socialId"      : String(str_social_id),
//            "socialType"    : "G",
//            "device"        : "iOS",
//            "deviceToken"   : String(device_token),
            
            "action"            : "unlimited",
            "videoCategoryId"   : "36,24,6,8",
            "articleCategoryId" : "",
            "audioCategoryId"   : "",
            
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
                            
                            // print("=====> yes")
                            //
                            
                            var dict: Dictionary<AnyHashable, Any>
                            dict = jsonDict["data"] as! Dictionary<AnyHashable, Any>
                            // print(dict as Any)
                            
                            
                            
                            var ar_video_main : NSArray!
                            ar_video_main = (dict["VIDEO"] as! Array<Any>) as NSArray
                            
                            // print(ar_video_main as Any)
                            // print(ar_video_main.count as Any)
                            
                            for indexx in 0..<ar_video_main.count {
                                
                                let item_get_video_list = ar_video_main[indexx] as? [String:Any]
                                // print(item_get_video_list as Any)
                                
                                var ar_video_data : NSArray!
                                ar_video_data = (item_get_video_list!["VIDEO_Data"] as! Array<Any>) as NSArray
                                // print(ar_video_data as Any)
                                
                                if indexx == 0 {
                                    
                                    for indexx_2 in 0..<ar_video_data.count {
                                        
                                        let item_get_video_list_2 = ar_video_data[indexx_2] as? [String:Any]
                                        
                                        let custom_dict_video_1 = [
                                            "categoryId"    : "\(item_get_video_list_2!["categoryId"]!)",
                                            "description"   : (item_get_video_list_2!["description"] as! String),
                                            "file_link"     : (item_get_video_list_2!["file_link"] as! String),
                                            "image"         : (item_get_video_list_2!["image"] as! String),
                                            "title"         : (item_get_video_list_2!["title"] as! String),
                                            "videoFile"     : (item_get_video_list_2!["videoFile"] as! String),
                                        ]
                                        
                                        self.arr_show_1_video.add(custom_dict_video_1)
                                        
                                    }
                                    // print(self.arr_show_1_video as Any)
                                    
                                } else if indexx == 1 {
                                    
                                    // print(ar_video_data as Any)
                                    for indexx_2 in 0..<ar_video_data.count {
                                        
                                        let item_get_video_list_2 = ar_video_data[indexx_2] as? [String:Any]
                                        // print(item_get_video_list_2)
                                        let custom_dict_video_1 = [
                                            "categoryId"    : "\(item_get_video_list_2!["categoryId"]!)",
                                            "description"   : (item_get_video_list_2!["description"] as! String),
                                            "file_link"     : (item_get_video_list_2!["file_link"] as! String),
                                            "image"         : (item_get_video_list_2!["image"] as! String),
                                            "title"         : (item_get_video_list_2!["title"] as! String),
                                            "videoFile"     : (item_get_video_list_2!["videoFile"] as! String),
                                        ]
                                        
                                        self.arr_show_2_video.add(custom_dict_video_1)
                                        
                                    }
                                    
                                } else if indexx == 2 {
                                    
                                    for indexx_2 in 0..<ar_video_data.count {
                                        
                                        let item_get_video_list_2 = ar_video_data[indexx_2] as? [String:Any]
                                        
                                        let custom_dict_video_1 = [
                                            "categoryId"    : "\(item_get_video_list_2!["categoryId"]!)",
                                            "description"   : (item_get_video_list_2!["description"] as! String),
                                            "file_link"     : (item_get_video_list_2!["file_link"] as! String),
                                            "image"         : (item_get_video_list_2!["image"] as! String),
                                            "title"         : (item_get_video_list_2!["title"] as! String),
                                            "videoFile"     : (item_get_video_list_2!["videoFile"] as! String),
                                        ]
                                        
                                        self.arr_show_3_video.add(custom_dict_video_1)
                                        
                                    }
                                    
                                } else if indexx == 3 {
                                    
                                    for indexx_2 in 0..<ar_video_data.count {
                                        
                                        let item_get_video_list_2 = ar_video_data[indexx_2] as? [String:Any]
                                        
                                        let custom_dict_video_1 = [
                                            "categoryId"    : "\(item_get_video_list_2!["categoryId"]!)",
                                            "description"   : (item_get_video_list_2!["description"] as! String),
                                            "file_link"     : (item_get_video_list_2!["file_link"] as! String),
                                            "image"         : (item_get_video_list_2!["image"] as! String),
                                            "title"         : (item_get_video_list_2!["title"] as! String),
                                            "videoFile"     : (item_get_video_list_2!["videoFile"] as! String),
                                        ]
                                        
                                        self.arr_show_4_video.add(custom_dict_video_1)
                                        
                                    }
                                    
                                } else if indexx == 4 {
                                    
                                    for indexx_2 in 0..<ar_video_data.count {
                                        
                                        let item_get_video_list_2 = ar_video_data[indexx_2] as? [String:Any]
                                        
                                        let custom_dict_video_1 = [
                                            "categoryId"    : "\(item_get_video_list_2!["categoryId"]!)",
                                            "description"   : (item_get_video_list_2!["description"] as! String),
                                            "file_link"     : (item_get_video_list_2!["file_link"] as! String),
                                            "image"         : (item_get_video_list_2!["image"] as! String),
                                            "title"         : (item_get_video_list_2!["title"] as! String),
                                            "videoFile"     : (item_get_video_list_2!["videoFile"] as! String),
                                        ]
                                        
                                        self.arr_show_5_video.add(custom_dict_video_1)
                                        
                                    }
                                    
                                }
                                
                                
                            }
                            
                            /*print(self.arr_show_1_video as Any)
                             print(self.arr_show_2_video as Any)
                             print(self.arr_show_3_video as Any)
                             print(self.arr_show_4_video as Any)
                             print(self.arr_show_5_video as Any)*/
                            
                            ERProgressHud.sharedInstance.hide()
                            
                            self.tble_view.delegate = self
                            self.tble_view.dataSource = self
                            self.tble_view.reloadData()
                            
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
    
    /*{
        self.view.endEditing(true)
        
        ERProgressHud.sharedInstance.showDarkBackgroundView(withTitle: "Please wait...")
        
        if IsInternetAvailable() == false {
            self.please_check_your_internet_connection()
            return
        }
        
        let parameters = [
            
            "action"            : "unlimited",
            "videoCategoryId"   : "36,24,6,8",
            "articleCategoryId" : "",
            "audioCategoryId"   : "",
            
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
                            
                            // print("=====> yes")
                            //
                            
                            var dict: Dictionary<AnyHashable, Any>
                            dict = jsonDict["data"] as! Dictionary<AnyHashable, Any>
                            // print(dict as Any)
                            
                            
                            
                            var ar_video_main : NSArray!
                            ar_video_main = (dict["VIDEO"] as! Array<Any>) as NSArray
                            
                            // print(ar_video_main as Any)
                            // print(ar_video_main.count as Any)
                            
                            for indexx in 0..<ar_video_main.count {
                                
                                let item_get_video_list = ar_video_main[indexx] as? [String:Any]
                                // print(item_get_video_list as Any)
                                
                                var ar_video_data : NSArray!
                                ar_video_data = (item_get_video_list!["VIDEO_Data"] as! Array<Any>) as NSArray
                                // print(ar_video_data as Any)
                                
                                if indexx == 0 {
                                    
                                    for indexx_2 in 0..<ar_video_data.count {
                                        
                                        let item_get_video_list_2 = ar_video_data[indexx_2] as? [String:Any]
                                        
                                        let custom_dict_video_1 = [
                                            "categoryId"    : "\(item_get_video_list_2!["categoryId"]!)",
                                            "description"   : (item_get_video_list_2!["description"] as! String),
                                            "file_link"     : (item_get_video_list_2!["file_link"] as! String),
                                            "image"         : (item_get_video_list_2!["image"] as! String),
                                            "title"         : (item_get_video_list_2!["title"] as! String),
                                            "videoFile"     : (item_get_video_list_2!["videoFile"] as! String),
                                        ]
                                        
                                        self.arr_show_1_video.add(custom_dict_video_1)
                                        
                                    }
                                    // print(self.arr_show_1_video as Any)
                                    
                                } else if indexx == 1 {
                                    
                                    // print(ar_video_data as Any)
                                    for indexx_2 in 0..<ar_video_data.count {
                                        
                                        let item_get_video_list_2 = ar_video_data[indexx_2] as? [String:Any]
                                        // print(item_get_video_list_2)
                                        let custom_dict_video_1 = [
                                            "categoryId"    : "\(item_get_video_list_2!["categoryId"]!)",
                                            "description"   : (item_get_video_list_2!["description"] as! String),
                                            "file_link"     : (item_get_video_list_2!["file_link"] as! String),
                                            "image"         : (item_get_video_list_2!["image"] as! String),
                                            "title"         : (item_get_video_list_2!["title"] as! String),
                                            "videoFile"     : (item_get_video_list_2!["videoFile"] as! String),
                                        ]
                                        
                                        self.arr_show_2_video.add(custom_dict_video_1)
                                        
                                    }
                                    
                                } else if indexx == 2 {
                                    
                                    for indexx_2 in 0..<ar_video_data.count {
                                        
                                        let item_get_video_list_2 = ar_video_data[indexx_2] as? [String:Any]
                                        
                                        let custom_dict_video_1 = [
                                            "categoryId"    : "\(item_get_video_list_2!["categoryId"]!)",
                                            "description"   : (item_get_video_list_2!["description"] as! String),
                                            "file_link"     : (item_get_video_list_2!["file_link"] as! String),
                                            "image"         : (item_get_video_list_2!["image"] as! String),
                                            "title"         : (item_get_video_list_2!["title"] as! String),
                                            "videoFile"     : (item_get_video_list_2!["videoFile"] as! String),
                                        ]
                                        
                                        self.arr_show_3_video.add(custom_dict_video_1)
                                        
                                    }
                                    
                                } else if indexx == 3 {
                                    
                                    for indexx_2 in 0..<ar_video_data.count {
                                        
                                        let item_get_video_list_2 = ar_video_data[indexx_2] as? [String:Any]
                                        
                                        let custom_dict_video_1 = [
                                            "categoryId"    : "\(item_get_video_list_2!["categoryId"]!)",
                                            "description"   : (item_get_video_list_2!["description"] as! String),
                                            "file_link"     : (item_get_video_list_2!["file_link"] as! String),
                                            "image"         : (item_get_video_list_2!["image"] as! String),
                                            "title"         : (item_get_video_list_2!["title"] as! String),
                                            "videoFile"     : (item_get_video_list_2!["videoFile"] as! String),
                                        ]
                                        
                                        self.arr_show_4_video.add(custom_dict_video_1)
                                        
                                    }
                                    
                                } else if indexx == 4 {
                                    
                                    for indexx_2 in 0..<ar_video_data.count {
                                        
                                        let item_get_video_list_2 = ar_video_data[indexx_2] as? [String:Any]
                                        
                                        let custom_dict_video_1 = [
                                            "categoryId"    : "\(item_get_video_list_2!["categoryId"]!)",
                                            "description"   : (item_get_video_list_2!["description"] as! String),
                                            "file_link"     : (item_get_video_list_2!["file_link"] as! String),
                                            "image"         : (item_get_video_list_2!["image"] as! String),
                                            "title"         : (item_get_video_list_2!["title"] as! String),
                                            "videoFile"     : (item_get_video_list_2!["videoFile"] as! String),
                                        ]
                                        
                                        self.arr_show_5_video.add(custom_dict_video_1)
                                        
                                    }
                                    
                                }
                                
                                
                            }
                            
                            /*print(self.arr_show_1_video as Any)
                             print(self.arr_show_2_video as Any)
                             print(self.arr_show_3_video as Any)
                             print(self.arr_show_4_video as Any)
                             print(self.arr_show_5_video as Any)*/
                            
                            ERProgressHud.sharedInstance.hide()
                            
                            self.tble_view.delegate = self
                            self.tble_view.dataSource = self
                            self.tble_view.reloadData()
                            
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
            }*/
    
    
    @objc func get_profile_data() {
        self.view.endEditing(true)
        
        ERProgressHud.sharedInstance.showDarkBackgroundView(withTitle: "Please wait...")
        
        if IsInternetAvailable() == false {
            self.please_check_your_internet_connection()
            return
        }
        
        if let person = UserDefaults.standard.value(forKey: str_save_login_user_data) as? [String:Any] {
            // let str:String = person["role"] as! String
            print(person as Any)
            
            let x : Int = person["userId"] as! Int
            let myString = String(x)
            
            let parameters = [
                "action"    : "profile",
                "userId"   : String(myString)
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
                                
                                self.tble_view.delegate = self
                                self.tble_view.dataSource = self
                                self.tble_view.reloadData()
                                
                                
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
    
    @objc func view_more_1_click_method() {
        
        //        let item = self.arr_show_1_video[0] as? [String:Any]
        //
        //        let pushVC = self.storyboard?.instantiateViewController(withIdentifier: "show_paid_category_id") as! show_paid_category
        //
        //        pushVC.hidesBottomBarWhenPushed = true
        //
        //        pushVC.str_catgory_id = "\(item!["categoryId"]!)"
        //
        //        self.navigationController?.pushViewController(pushVC, animated: true)
        
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
                
                let item = self.arr_show_1_video[0] as? [String:Any]
                
                let pushVC = self.storyboard?.instantiateViewController(withIdentifier: "show_paid_category_id") as! show_paid_category
                
                pushVC.hidesBottomBarWhenPushed = true
                
                pushVC.str_catgory_id = "\(item!["categoryId"]!)"
                
                self.navigationController?.pushViewController(pushVC, animated: true)
                
            }
            
        } else {
            
            self.please_login_to_continue()
        }
        
        
    }
    
    @objc func view_more_2_click_method() {
        
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
                
                let item = self.arr_show_2_video[0] as? [String:Any]
                
                let pushVC = self.storyboard?.instantiateViewController(withIdentifier: "show_paid_category_id") as! show_paid_category
                
                pushVC.hidesBottomBarWhenPushed = true
                
                pushVC.str_catgory_id = "\(item!["categoryId"]!)"
                
                self.navigationController?.pushViewController(pushVC, animated: true)
                
            }
            
        } else {
            
            self.please_login_to_continue()
        }
        
        
    }
    
    @objc func view_more_3_click_method() {
        
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
                
                let item = self.arr_show_3_video[0] as? [String:Any]
                
                let pushVC = self.storyboard?.instantiateViewController(withIdentifier: "show_paid_category_id") as! show_paid_category
                
                pushVC.hidesBottomBarWhenPushed = true
                
                pushVC.str_catgory_id = "\(item!["categoryId"]!)"
                
                self.navigationController?.pushViewController(pushVC, animated: true)
                
            }
            
        } else {
            
            self.please_login_to_continue()
        }
        
        
    }
    
    @objc func view_more_4_click_method() {
        
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
                
                let item = self.arr_show_4_video[0] as? [String:Any]
                
                let pushVC = self.storyboard?.instantiateViewController(withIdentifier: "show_paid_category_id") as! show_paid_category
                
                pushVC.hidesBottomBarWhenPushed = true
                
                pushVC.str_catgory_id = "\(item!["categoryId"]!)"
                
                self.navigationController?.pushViewController(pushVC, animated: true)
                
            }
            
        } else {
            
            self.please_login_to_continue()
        }
        
    }
    
}

extension vedanta_profile : UITableViewDelegate , UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:vedanta_profile_table_cell = tableView.dequeueReusableCell(withIdentifier: "vedanta_profile_table_cell") as! vedanta_profile_table_cell
        
        cell.backgroundColor = .clear
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = .clear
        cell.selectedBackgroundView = backgroundView
        
        cell.cl_view_bhagwat_gita.delegate = self
        cell.cl_view_bhagwat_gita.dataSource =  self
        
        cell.cl_view_series_1.delegate = self
        cell.cl_view_series_1.dataSource = self
        
        cell.cl_view_series_2.delegate = self
        cell.cl_view_series_2.dataSource = self
        
        cell.cl_view_series_3.delegate = self
        cell.cl_view_series_3.dataSource = self
        
          
        
        
        
        
        
        
        
        
        self.btn_subscribe.addTarget(self, action: #selector(subscribe_click_method_2), for: .touchUpInside)
            
        if UserDefaults.standard.value(forKey: str_save_login_user_data) is [String:Any] {
                
            cell.btn_login.isHidden = true
            
            if self.str_is_membership_expired == "active" {
                self.btn_subscribe.isHidden = true
            } else {
                self.btn_subscribe.isHidden = false
            }
            
        } else {
            
            cell.btn_login.isHidden = false
            self.btn_subscribe.isHidden = false
            
        }
            
        
        cell.btn_login.addTarget(self, action: #selector(sign_in_click_method), for: .touchUpInside)
        
        
        cell.btn_view_more_1.addTarget(self, action: #selector(view_more_1_click_method), for: .touchUpInside)
        cell.btn_view_more_2.addTarget(self, action: #selector(view_more_2_click_method), for: .touchUpInside)
        cell.btn_view_more_3.addTarget(self, action: #selector(view_more_3_click_method), for: .touchUpInside)
        cell.btn_view_more_4.addTarget(self, action: #selector(view_more_4_click_method), for: .touchUpInside)
        
        cell.btn_explore_more.addTarget(self, action: #selector(explore_click_method), for: .touchUpInside)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 1300
    }
    
}

class vedanta_profile_table_cell:UITableViewCell {
    
    @IBOutlet weak var img_profile:UIImageView! {
        didSet {
            img_profile.layer.cornerRadius = 0
            img_profile.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var btn_login:UIButton! {
        didSet {
            btn_login.backgroundColor = UIColor.init(red: 230.0/255.0, green: 40.0/255.0, blue: 36.0/255.0, alpha: 1)
            btn_login.setTitle("Login", for: .normal)
            btn_login.setTitleColor(.white, for: .normal)
            btn_login.layer.cornerRadius = 20
            btn_login.clipsToBounds = true
        }
    }
    
    
    
    @IBOutlet weak var btn_explore_more:UIButton! {
        didSet {
            btn_explore_more.setTitle("explore more >>", for: .normal)
            btn_explore_more.setTitleColor(.systemOrange, for: .normal)
            
            btn_explore_more.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            btn_explore_more.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            btn_explore_more.layer.shadowOpacity = 1.0
            btn_explore_more.layer.shadowRadius = 4
            btn_explore_more.layer.masksToBounds = false
            btn_explore_more.layer.cornerRadius = 20
            btn_explore_more.backgroundColor = .clear
        }
    }
    
    // collection view bhagwat gita
    @IBOutlet weak var cl_view_bhagwat_gita:UICollectionView! {
        didSet {
            cl_view_bhagwat_gita.backgroundColor = .clear
            
        }
    }
    
    // collection view series 1
    @IBOutlet weak var cl_view_series_1:UICollectionView! {
        didSet {
            cl_view_series_1.backgroundColor = .clear
            
        }
    }
    
    // collection view series 1
    @IBOutlet weak var cl_view_series_2:UICollectionView! {
        didSet {
            cl_view_series_2.backgroundColor = .clear
            
        }
    }
    
    // collection view series 1
    @IBOutlet weak var cl_view_series_3:UICollectionView! {
        didSet {
            cl_view_series_3.backgroundColor = .clear
            
        }
    }
    
    
    
    
    @IBOutlet weak var btn_view_more_1:UIButton! {
        didSet {
            btn_view_more_1.isUserInteractionEnabled = true
            btn_view_more_1.backgroundColor = .clear
            btn_view_more_1.layer.cornerRadius = 6
            btn_view_more_1.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var btn_view_more_2:UIButton! {
        didSet {
            btn_view_more_2.isUserInteractionEnabled = true
            btn_view_more_2.backgroundColor = .clear
            btn_view_more_2.layer.cornerRadius = 6
            btn_view_more_2.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var btn_view_more_3:UIButton! {
        didSet {
            btn_view_more_3.isUserInteractionEnabled = true
            btn_view_more_3.backgroundColor = .clear
            btn_view_more_3.layer.cornerRadius = 6
            btn_view_more_3.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var btn_view_more_4:UIButton! {
        didSet {
            btn_view_more_4.isUserInteractionEnabled = true
            btn_view_more_4.backgroundColor = .clear
            btn_view_more_4.layer.cornerRadius = 6
            btn_view_more_4.clipsToBounds = true
        }
    }
    
    
    
}

// collection view
extension vedanta_profile: UICollectionViewDataSource , UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView.tag == 1000 {
            return self.arr_show_1_video.count
        } else if collectionView.tag == 2000 {
            return self.arr_show_2_video.count
        } else if collectionView.tag == 3000 {
            return self.arr_show_3_video.count
        } else {
            return self.arr_show_4_video.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView.tag == 1000 {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "vedanta_profile_bhagwat_gita_collection_view_cell", for: indexPath as IndexPath) as! vedanta_profile_collection_view_cell
            
            cell.backgroundColor = app_BG_color
            
            let item = self.arr_show_1_video[indexPath.row] as? [String:Any]
            // print(item as Any)
            
            cell.lbl_bhagwat_gita_title.text = (item!["title"] as! String)
            
            cell.btn_play_lock.tintColor = .white
            
            if let person = UserDefaults.standard.value(forKey: str_save_login_user_data) as? [String:Any] {
                // let str:String = person["role"] as! String
                print(person as Any)
                
                if self.str_is_membership_expired == "active" {
                    
                    cell.btn_play_lock.setImage(UIImage(systemName: "play"), for: .normal)
                    
                } else {
                    
                    if indexPath.row == 0 {
                        cell.btn_play_lock.setImage(UIImage(systemName: "play"), for: .normal)
                    } else {
                        cell.btn_play_lock.setImage(UIImage(systemName: "lock"), for: .normal)
                    }
                    
                }
                
            } else {
                
                if indexPath.row == 0 {
                    cell.btn_play_lock.setImage(UIImage(systemName: "play"), for: .normal)
                } else {
                    cell.btn_play_lock.setImage(UIImage(systemName: "lock"), for: .normal)
                }
                
            }
            
            
            
            
            cell.img_bhagwat_gita_list.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
            cell.img_bhagwat_gita_list.sd_setImage(with: URL(string: (item!["image"] as! String)), placeholderImage: UIImage(named: "logo"))
            
            cell.layer.cornerRadius = 8
            
            return cell
            
        } else if collectionView.tag == 2000 {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "vedanta_profile_collection_series_1_view_cell", for: indexPath as IndexPath) as! vedanta_profile_collection_series_1_view_cell
            
            cell.backgroundColor = app_BG_color
            
            cell.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            cell.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            cell.layer.shadowOpacity = 1.0
            cell.layer.shadowRadius = 8
            cell.layer.masksToBounds = false
            cell.layer.cornerRadius = 8
            cell.backgroundColor = .white
            
            let item = self.arr_show_2_video[indexPath.row] as? [String:Any]
            // print(item as Any)
            
            cell.lbl_latest_video.text = (item!["title"] as! String)
            
            cell.btn_play_lock_2.tintColor = .white
            // cell.btn_play_lock_2.setImage(UIImage(systemName: "lock"), for: .normal)
            
            if let person = UserDefaults.standard.value(forKey: str_save_login_user_data) as? [String:Any] {
                // let str:String = person["role"] as! String
                print(person as Any)
                
                if self.str_is_membership_expired == "active" {
                    
                    cell.btn_play_lock_2.setImage(UIImage(systemName: "play"), for: .normal)
                    
                } else {
                    
                    if indexPath.row == 0 {
                        cell.btn_play_lock_2.setImage(UIImage(systemName: "play"), for: .normal)
                    } else {
                        cell.btn_play_lock_2.setImage(UIImage(systemName: "lock"), for: .normal)
                    }
                    
                }
                
            } else {
                
                if indexPath.row == 0 {
                    cell.btn_play_lock_2.setImage(UIImage(systemName: "play"), for: .normal)
                } else {
                    cell.btn_play_lock_2.setImage(UIImage(systemName: "lock"), for: .normal)
                }
                
            }
            
            cell.img_latest_video.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
            cell.img_latest_video.sd_setImage(with: URL(string: (item!["image"] as! String)), placeholderImage: UIImage(named: "logo"))
            
            return cell
            
        } else if collectionView.tag == 3000 {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "vedanta_profile_collection_series_2_view_cell", for: indexPath as IndexPath) as! vedanta_profile_collection_series_2_view_cell
            
            cell.backgroundColor = app_BG_color
            
            cell.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            cell.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            cell.layer.shadowOpacity = 1.0
            cell.layer.shadowRadius = 8
            cell.layer.masksToBounds = false
            cell.layer.cornerRadius = 8
            cell.backgroundColor = .white
            
            let item = self.arr_show_3_video[indexPath.row] as? [String:Any]
            // print(item as Any)
            
            cell.lbl_latest_audio.text = (item!["title"] as! String)
            
            cell.btn_play_lock_3.tintColor = .white
            // cell.btn_play_lock_3.setImage(UIImage(systemName: "lock"), for: .normal)
            
            if let person = UserDefaults.standard.value(forKey: str_save_login_user_data) as? [String:Any] {
                // let str:String = person["role"] as! String
                print(person as Any)
                
                if self.str_is_membership_expired == "active" {
                    
                    cell.btn_play_lock_3.setImage(UIImage(systemName: "play"), for: .normal)
                    
                } else {
                    
                    if indexPath.row == 0 {
                        cell.btn_play_lock_3.setImage(UIImage(systemName: "play"), for: .normal)
                    } else {
                        cell.btn_play_lock_3.setImage(UIImage(systemName: "lock"), for: .normal)
                    }
                    
                }
                
            } else {
                
                if indexPath.row == 0 {
                    cell.btn_play_lock_3.setImage(UIImage(systemName: "play"), for: .normal)
                } else {
                    cell.btn_play_lock_3.setImage(UIImage(systemName: "lock"), for: .normal)
                }
                
            }
            
            cell.img_latest_audio.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
            cell.img_latest_audio.sd_setImage(with: URL(string: (item!["image"] as! String)), placeholderImage: UIImage(named: "logo"))
            
            return cell
            
        } else if collectionView.tag == 4000 {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "vedanta_profile_collection_series_3_view_cell", for: indexPath as IndexPath) as! vedanta_profile_collection_series_3_view_cell
            
            cell.backgroundColor = app_BG_color
            
            cell.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            cell.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            cell.layer.shadowOpacity = 1.0
            cell.layer.shadowRadius = 8
            cell.layer.masksToBounds = false
            cell.layer.cornerRadius = 8
            cell.backgroundColor = .white
            
            let item = self.arr_show_4_video[indexPath.row] as? [String:Any]
            // print(item as Any)
            
            cell.lbl_latest_article.text = (item!["title"] as! String)
            
            cell.btn_play_lock_4.tintColor = .white
            // cell.btn_play_lock_4.setImage(UIImage(systemName: "lock"), for: .normal)
            
            if let person = UserDefaults.standard.value(forKey: str_save_login_user_data) as? [String:Any] {
                // let str:String = person["role"] as! String
                print(person as Any)
                
                if self.str_is_membership_expired == "active" {
                    
                    cell.btn_play_lock_4.setImage(UIImage(systemName: "play"), for: .normal)
                    
                } else {
                    
                    if indexPath.row == 0 {
                        cell.btn_play_lock_4.setImage(UIImage(systemName: "play"), for: .normal)
                    } else {
                        cell.btn_play_lock_4.setImage(UIImage(systemName: "lock"), for: .normal)
                    }
                    
                }
                
            } else {
                
                if indexPath.row == 0 {
                    cell.btn_play_lock_4.setImage(UIImage(systemName: "play"), for: .normal)
                } else {
                    cell.btn_play_lock_4.setImage(UIImage(systemName: "lock"), for: .normal)
                }
                
            }
            
            cell.img_latest_article.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
            cell.img_latest_article.sd_setImage(with: URL(string: (item!["image"] as! String)), placeholderImage: UIImage(named: "logo"))
            
            return cell
            
        } else {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "vedanta_profile_bhagwat_gita_collection_view_cell", for: indexPath as IndexPath) as! vedanta_profile_collection_view_cell
            
            cell.backgroundColor = app_BG_color
            
            cell.lbl_bhagwat_gita_title.text = "Chapter 1 Day \(indexPath.item+1)"
            
            cell.layer.cornerRadius = 8
            
            return cell
            
        }
        
        
    }
    
    @objc func subscribe_click_method_2() {
        let alert = NewYorkAlertController(title: String("Vedanta Unlimited"), message: String("Please Subscribe to get access."), style: .alert)
        
        
        let yes_subscribe = NewYorkButton(title: "Subscribe", style: .default) {
            _ in
            
            let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "subscription_id") as? subscription
            push!.hidesBottomBarWhenPushed = false
            self.navigationController?.pushViewController(push!, animated: true)
            
        }
        let cancel = NewYorkButton(title: "dismiss", style: .cancel)
        
        yes_subscribe.setDynamicColor(.pink)
        
        alert.addButtons([yes_subscribe,cancel])
        self.present(alert, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView.tag == 1000 {
            
            let item = self.arr_show_1_video[indexPath.row] as? [String:Any]
            
            /*if indexPath.row == 0 {
                
                self.push_to_video_screen(str_video_file_link: (item!["file_link"] as! String),
                                          str_video_title: (item!["title"] as! String))
                
            } else {*/
                
                if let person = UserDefaults.standard.value(forKey: str_save_login_user_data) as? [String:Any] {
                    
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
                        
                        // Subscribe DONE , Play Video
                        self.push_to_video_screen(str_video_file_link: (item!["file_link"] as! String),
                                                  str_video_title: (item!["title"] as! String))
                        
                    }
                    
                } else {
                    
                    self.please_login_to_continue()
                    
                }
                
            // }
            
        } else if collectionView.tag == 2000 {
            
            let item = self.arr_show_2_video[indexPath.row] as? [String:Any]
            
            if let person = UserDefaults.standard.value(forKey: str_save_login_user_data) as? [String:Any] {
                
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
                    
                    // Subscribe DONE , Play Video
                    self.push_to_video_screen(str_video_file_link: (item!["file_link"] as! String),
                                              str_video_title: (item!["title"] as! String))
                    
                }
                
            } else {
                
                self.please_login_to_continue()
                
            }
            
            
            
        } else if collectionView.tag == 3000 {
            
            let item = self.arr_show_3_video[indexPath.row] as? [String:Any]
            
            if let person = UserDefaults.standard.value(forKey: str_save_login_user_data) as? [String:Any] {
                
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
                    
                    // Subscribe DONE , Play Video
                    self.push_to_video_screen(str_video_file_link: (item!["file_link"] as! String),
                                              str_video_title: (item!["title"] as! String))
                    
                }
                
            } else {
                
                self.please_login_to_continue()
                
            }
            
            
            
        } else if collectionView.tag == 4000 {
            
            let item = self.arr_show_4_video[indexPath.row] as? [String:Any]
            
            if let person = UserDefaults.standard.value(forKey: str_save_login_user_data) as? [String:Any] {
                
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
                    
                    // Subscribe DONE , Play Video
                    self.push_to_video_screen(str_video_file_link: (item!["file_link"] as! String),
                                              str_video_title: (item!["title"] as! String))
                    
                }
                
            } else {
                
                self.please_login_to_continue()
                
            }
            
            
            
        } else {
            
        }
        
        
    }
    
    
}

extension vedanta_profile: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        return CGSize(width: 120,height: 130)
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 10
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout
                        collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
    
}

class vedanta_profile_collection_view_cell: UICollectionViewCell {
    
    
    @IBOutlet weak var img_bhagwat_gita_list:UIImageView! {
        didSet {
            img_bhagwat_gita_list.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            img_bhagwat_gita_list.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            img_bhagwat_gita_list.layer.shadowOpacity = 1.0
            img_bhagwat_gita_list.layer.shadowRadius = 4
            img_bhagwat_gita_list.layer.masksToBounds = false
            img_bhagwat_gita_list.layer.cornerRadius = 0
            img_bhagwat_gita_list.backgroundColor = .lightGray
        }
    }
    
    @IBOutlet weak var lbl_bhagwat_gita_title:UILabel! {
        didSet {
            lbl_bhagwat_gita_title.textColor = .black
        }
    }
    
    @IBOutlet weak var btn_play_lock:UIButton! {
        didSet {
            btn_play_lock.isUserInteractionEnabled = false
            btn_play_lock.backgroundColor = .lightGray
            btn_play_lock.layer.cornerRadius = 15
            btn_play_lock.clipsToBounds = true
        }
    }
    
    
    
    
}

// MARK: - COLLECTION CELL ( LATEST VIDEOS ) -
class vedanta_profile_collection_series_1_view_cell: UICollectionViewCell {
    
    @IBOutlet weak var img_latest_video:UIImageView! {
        didSet {
            
        }
    }
    
    @IBOutlet weak var lbl_latest_video:UILabel! {
        didSet {
            lbl_latest_video.textColor = .black
        }
    }
    
    @IBOutlet weak var btn_play_lock_2:UIButton! {
        didSet {
            btn_play_lock_2.isUserInteractionEnabled = false
            btn_play_lock_2.backgroundColor = .lightGray
            btn_play_lock_2.layer.cornerRadius = 15
            btn_play_lock_2.clipsToBounds = true
        }
    }
    
}

// MARK: - COLLECTION CELL ( LATEST AUIDO ) -
class vedanta_profile_collection_series_2_view_cell: UICollectionViewCell {
    
    @IBOutlet weak var img_latest_audio:UIImageView! {
        didSet {
            
        }
    }
    
    @IBOutlet weak var lbl_latest_audio:UILabel! {
        didSet {
            lbl_latest_audio.textColor = .black
        }
    }
    
    @IBOutlet weak var btn_play_lock_3:UIButton! {
        didSet {
            btn_play_lock_3.isUserInteractionEnabled = false
            btn_play_lock_3.backgroundColor = .lightGray
            btn_play_lock_3.layer.cornerRadius = 15
            btn_play_lock_3.clipsToBounds = true
        }
    }
    
}

// MARK: - COLLECTION CELL ( LATEST ARTICLES ) -
class vedanta_profile_collection_series_3_view_cell: UICollectionViewCell {
    
    @IBOutlet weak var img_latest_article:UIImageView! {
        didSet {
            
        }
    }
    
    @IBOutlet weak var lbl_latest_article:UILabel! {
        didSet {
            lbl_latest_article.textColor = .black
        }
    }
    
    @IBOutlet weak var btn_play_lock_4:UIButton! {
        didSet {
            btn_play_lock_4.isUserInteractionEnabled = false
            btn_play_lock_4.backgroundColor = .lightGray
            btn_play_lock_4.layer.cornerRadius = 15
            btn_play_lock_4.clipsToBounds = true
        }
    }
    
}
