//
//  more_app_settings.swift
//  Vedanta
//
//  Created by Dishant Rajput on 16/09/22.
//

import UIKit
import Alamofire

class more_app_settings: UIViewController {
    
    var close_window:String! = "1"
    
    var str_notification_click:String! = "na"
    
    // var arr_app_setting_title = ["Notifications" , "Feedback" , "Share this App"]
    var arr_app_setting_title = ["Notifications"]
    
    @IBOutlet weak var btn_back:UIButton! {
        didSet {
            btn_back.tintColor = .black
        }
    }
    
    @IBOutlet weak var tble_view:UITableView! {
        didSet {
            tble_view.backgroundColor = .clear
            tble_view.delegate = self
            tble_view.dataSource = self
        }
    }
    
    @IBOutlet weak var view_full_view:UIView! {
        didSet {
            view_full_view.backgroundColor = UIColor.init(red: 246.0/255.0, green: 246.0/255.0, blue: 246.0/255.0, alpha: 1)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.view_full_view.backgroundColor = app_BG_color
        
        self.tble_view.separatorColor = .lightGray
        
        self.btn_back.addTarget(self, action: #selector(back_click_method), for: .touchUpInside)
    }
    
    // MARK: - NOTIFICATION ( AUDIO ) -
    @objc func notification_audio_click() {
        
        if let person = UserDefaults.standard.value(forKey: str_save_login_user_data) as? [String:Any] {
            // let str:String = person["role"] as! String
            print(person as Any)
            
            if "\(person["notification_Setting_audio"]!)" == "1" {
  
                self.update_notification_for(str_for_audio: "2",
                                             str_for_video: "\(person["notification_Setting_video"]!)",
                                             str_for_article: "\(person["notification_Setting_article"]!)",
                                             str_for_quot: "\(person["notification_Setting_quotes"]!)",
                                             str_for_events: "\(person["notification_Setting_event"]!)")
                
            } else {
                 
                self.update_notification_for(str_for_audio: "1",
                                             str_for_video: "\(person["notification_Setting_video"]!)",
                                             str_for_article: "\(person["notification_Setting_article"]!)",
                                             str_for_quot: "\(person["notification_Setting_quotes"]!)",
                                             str_for_events: "\(person["notification_Setting_event"]!)")
                
            }
    
        }
        
    }
    
    // MARK: - NOTIFICATION ( VIDEO ) -
    @objc func notification_video_click() {
        
        if let person = UserDefaults.standard.value(forKey: str_save_login_user_data) as? [String:Any] {
            // let str:String = person["role"] as! String
            print(person as Any)
            
            
            if "\(person["notification_Setting_video"]!)" == "1" {
  
                self.update_notification_for(str_for_audio: "\(person["notification_Setting_audio"]!)",
                                             str_for_video: "2",
                                             str_for_article: "\(person["notification_Setting_article"]!)",
                                             str_for_quot: "\(person["notification_Setting_quotes"]!)",
                                             str_for_events: "\(person["notification_Setting_event"]!)")
                
            } else {
                 
                self.update_notification_for(str_for_audio: "\(person["notification_Setting_audio"]!)",
                                             str_for_video: "1",
                                             str_for_article: "\(person["notification_Setting_article"]!)",
                                             str_for_quot: "\(person["notification_Setting_quotes"]!)",
                                             str_for_events: "\(person["notification_Setting_event"]!)")
                
            }
    
        }
        
    }
    
    // MARK: - NOTIFICATION ( ARTICLE ) -
    @objc func notification_article_click() {
        
        if let person = UserDefaults.standard.value(forKey: str_save_login_user_data) as? [String:Any] {
            // let str:String = person["role"] as! String
            print(person as Any)
            
            if "\(person["notification_Setting_article"]!)" == "1" {
  
                self.update_notification_for(str_for_audio: "\(person["notification_Setting_audio"]!)",
                                             str_for_video: "\(person["notification_Setting_video"]!)",
                                             str_for_article: "2",
                                             str_for_quot: "\(person["notification_Setting_quotes"]!)",
                                             str_for_events: "\(person["notification_Setting_event"]!)")
                
            } else {
                 
                self.update_notification_for(str_for_audio: "\(person["notification_Setting_audio"]!)",
                                             str_for_video: "\(person["notification_Setting_video"]!)",
                                             str_for_article: "1",
                                             str_for_quot: "\(person["notification_Setting_quotes"]!)",
                                             str_for_events: "\(person["notification_Setting_event"]!)")
                
            }
    
        }
        
    }
    
    // MARK: - NOTIFICATION ( EVENTS ) -
    @objc func notification_event_click() {
        
        if let person = UserDefaults.standard.value(forKey: str_save_login_user_data) as? [String:Any] {
            // let str:String = person["role"] as! String
            print(person as Any)
            
            if "\(person["notification_Setting_event"]!)" == "1" {
  
                self.update_notification_for(str_for_audio: "\(person["notification_Setting_audio"]!)",
                                             str_for_video: "\(person["notification_Setting_video"]!)",
                                             str_for_article: "\(person["notification_Setting_article"]!)",
                                             str_for_quot: "\(person["notification_Setting_quotes"]!)",
                                             str_for_events: "2")
                
            } else {
                 
                self.update_notification_for(str_for_audio: "\(person["notification_Setting_audio"]!)",
                                             str_for_video: "\(person["notification_Setting_video"]!)",
                                             str_for_article: "\(person["notification_Setting_article"]!)",
                                             str_for_quot: "\(person["notification_Setting_quotes"]!)",
                                             str_for_events: "1")
                
            }
    
        }
        
    }
    
    // MARK: - NOTIFICATION ( QUOTES ) -
    @objc func notification_quotation_click() {
        
        if let person = UserDefaults.standard.value(forKey: str_save_login_user_data) as? [String:Any] {
            // let str:String = person["role"] as! String
            print(person as Any)
            
            
            if "\(person["notification_Setting_quotes"]!)" == "1" {
  
                self.update_notification_for(str_for_audio: "\(person["notification_Setting_audio"]!)",
                                             str_for_video: "\(person["notification_Setting_video"]!)",
                                             str_for_article: "\(person["notification_Setting_article"]!)",
                                             str_for_quot: "2",
                                             str_for_events: "\(person["notification_Setting_event"]!)")
                
            } else {
                 
                self.update_notification_for(str_for_audio: "\(person["notification_Setting_audio"]!)",
                                             str_for_video: "\(person["notification_Setting_video"]!)",
                                             str_for_article: "\(person["notification_Setting_article"]!)",
                                             str_for_quot: "1",
                                             str_for_events: "\(person["notification_Setting_event"]!)")
                
            }
    
        }
        
    }
    
    // WB
    @objc func update_notification_for(str_for_audio:String,
                                       str_for_video:String,
                                       str_for_article:String,
                                       str_for_quot:String,
                                       str_for_events:String) {
        ERProgressHud.sharedInstance.showDarkBackgroundView(withTitle: "Please wait...")
        
        self.view.endEditing(true)
        
        if let person = UserDefaults.standard.value(forKey: "keyLoginFullData") as? [String:Any] {
            // let str:String = person["role"] as! String
            
            let x : Int = person["userId"] as! Int
            let myString = String(x)
            
            let parameters = [
                "action"                        : "editprofile",
                "userId"                        : String(myString),
                "notification_Setting_audio"    : String(str_for_audio),
                "notification_Setting_video"    : String(str_for_video),
                "notification_Setting_article"  : String(str_for_article),
                "notification_Setting_quotes"   : String(str_for_quot),
                "notification_Setting_event"    : String(str_for_events),
            ]
            
            print(parameters as Any)
            
            AF.request(application_base_url,
                       method: .post,
                       parameters: parameters,
                       encoder: JSONParameterEncoder.default).responseJSON { response in
                // debugPrint(response.result)
                
                switch response.result {
                case let .success(value):
                    
                    let JSON = value as! NSDictionary
                    print(JSON as Any)
                    
                    var strSuccess : String!
                    strSuccess = JSON["status"]as Any as? String
                    
                    var strSuccess2 : String!
                    strSuccess2 = JSON["msg"]as Any as? String
                    
                    if strSuccess == String("success") {
                        print("yes")
                        ERProgressHud.sharedInstance.hide()
                        
                        var dict: Dictionary<AnyHashable, Any>
                        dict = JSON["data"] as! Dictionary<AnyHashable, Any>
                        
                        let defaults = UserDefaults.standard
                        defaults.setValue(dict, forKey: str_save_login_user_data)
                        
                        let alert = NewYorkAlertController(title: String("Success"), message: String(strSuccess2), style: .alert)
                        let cancel = NewYorkButton(title: "Ok", style: .cancel)
                        alert.addButtons([cancel])
                        self.present(alert, animated: true)
   
                        
                    } else {
                        
                        print("no")
                        ERProgressHud.sharedInstance.hide()
                        
                        var strSuccess2 : String!
                        strSuccess2 = JSON["msg"]as Any as? String
                        
                        let alert = UIAlertController(title: String(strSuccess), message: String(strSuccess2), preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                        
                    }
                    
                case let .failure(error):
                    print(error)
                    ERProgressHud.sharedInstance.hide()
                    
                    let alert = UIAlertController(title: String("Error!"), message: String("Server Issue"), preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    
                }
            }
        }
    }
    
}

extension more_app_settings : UITableViewDelegate , UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arr_app_setting_title.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell:more_app_settings_table_cell = tableView.dequeueReusableCell(withIdentifier: "more_app_settings_table_cell") as! more_app_settings_table_cell
        
        cell.backgroundColor = .clear
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = .clear
        cell.selectedBackgroundView = backgroundView
        
        cell.lbl_title.text = "\(self.arr_app_setting_title[indexPath.row])"
        
        cell.preservesSuperviewLayoutMargins = false
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        
        if indexPath.row == 0 {
            cell.accessoryType = .none
        }
        else {
            cell.accessoryType = .disclosureIndicator
        }

        if let person = UserDefaults.standard.value(forKey: str_save_login_user_data) as? [String:Any] {
            // let str:String = person["role"] as! String
            print(person as Any)
            
            if indexPath.row == 0 {
                
                if "\(person["notification_Setting_article"]!)" == "1" {
                    
                    cell.segment_control_article.selectedSegmentIndex = 0
                    
                } else {
                    cell.segment_control_article.selectedSegmentIndex = 1
                }

                
                if "\(person["notification_Setting_audio"]!)" == "1" {
                    
                    cell.segment_control_audio.selectedSegmentIndex = 0
                    
                } else {
                    
                    cell.segment_control_audio.selectedSegmentIndex = 1
                }

                
                if "\(person["notification_Setting_event"]!)" == "1" {
                    
                    cell.segment_control_event.selectedSegmentIndex = 0
                    
                } else {
                    
                    cell.segment_control_event.selectedSegmentIndex = 1
                }

                
                if "\(person["notification_Setting_quotes"]!)" == "1" {
                    
                    cell.segment_control_quotes.selectedSegmentIndex = 0
                    
                } else {
                    
                    cell.segment_control_quotes.selectedSegmentIndex = 1
                }

                
                if "\(person["notification_Setting_video"]!)" == "1" {
                    
                    cell.segment_control_video.selectedSegmentIndex = 0
                    
                } else {
                    
                    cell.segment_control_video.selectedSegmentIndex = 1
                }
                
            } else {
                
            }
            
            
        }

        cell.segment_control_audio.addTarget(self, action: #selector(notification_audio_click), for: .valueChanged)
        
        cell.segment_control_video.addTarget(self, action: #selector(notification_video_click), for: .valueChanged)
        
        cell.segment_control_article.addTarget(self, action: #selector(notification_article_click), for: .valueChanged)
        
        cell.segment_control_event.addTarget(self, action: #selector(notification_event_click), for: .valueChanged)
        
        cell.segment_control_quotes.addTarget(self, action: #selector(notification_quotation_click), for: .valueChanged)
        
        return cell

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row == 0 {
            
            if UserDefaults.standard.value(forKey: str_save_login_user_data) is [String:Any] {

                    // ALL PROPERTY MATCHED
                    if self.close_window == "1" {
                        self.close_window = "2"
                        
                        self.str_notification_click = "\(indexPath.row)"
                        self.tble_view.reloadData()
                        
                    } else {
                        
                        self.close_window = "1"
                        self.str_notification_click = "na"
                        self.tble_view.reloadData()
                        
                    }

            } else {
                
                self.please_login_to_continue()
                
            }
            
        } else {
            
            self.str_notification_click = "na"
            self.tble_view.reloadData()
            
        }
        
    }
    
    /*
     Messaging.messaging().subscribe(toTopic: notification_subscription_for_audio) { error in
       print("Subscribed to weather topic")
     }
     */
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if self.str_notification_click == "na" {

            return 60
            
        } else {
            
            if indexPath.row == 0 {
                return 388
                
            }
            return 60
            
        }
        
    }
    
}

class more_app_settings_table_cell:UITableViewCell {
    
    @IBOutlet weak var lbl_title:UILabel! {
        didSet {
            lbl_title.textColor = .black
        }
    }
    
    
    @IBOutlet weak var segment_control_video:UISegmentedControl!
    @IBOutlet weak var segment_control_audio:UISegmentedControl!
    @IBOutlet weak var segment_control_article:UISegmentedControl!
    @IBOutlet weak var segment_control_event:UISegmentedControl!
    @IBOutlet weak var segment_control_quotes:UISegmentedControl!
}
