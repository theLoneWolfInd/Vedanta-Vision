//
//  v_home.swift
//  Vedanta
//
//  Created by Dishant Rajput on 13/09/22.
//

import UIKit
import FSCalendar
import Alamofire
import SDWebImage
import Firebase

class v_home: UIViewController {
    
    var str_name:String!
    
    /*========================= TABLE CELL HEIGHT ======================================*/
    
    var cell_height_subscribe:CGFloat = 100
    var cell_height_bhagwat_gita:CGFloat = 160
    var cell_height_knowledge:CGFloat = 200
    var cell_height_social_media:CGFloat = 1000
    var cell_height_feeds:CGFloat = 0 // 340
    
    /*============================= CALENDAR =====================================*/
    
    fileprivate lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        return formatter
    }()
    
    /*=========================================================================*/
    
    var frame = CGRect(x: 0, y: 0, width: 0, height: 0)
    var screenSize: CGRect!
    var screenWidth: CGFloat!
    var screenHeight: CGFloat!
    
    var arr_mut_home_page_data:NSMutableArray! = []
    
    var dummy_bhagwat_gita_image = ["knowledge_1","knowledge_2","knowledge_3","knowledge_4","knowledge_4","knowledge_4"]
    var dummy_bhagwat_title = ["Demystify Bhagava" , "Inspiring Stories" , "Whimsical Treasure" , "Gita for the young" , "Soul String Sounds" , "Kids Come"]
    
    var dummy_image_knowledge = ["banner3"]
    
    var dummy_social_media = ["instagram","facebook","youtube","linked-in","spotify","twitter"]
    
    var arr_mut_video_list:NSMutableArray! = []
    var arr_mut_audio_list:NSMutableArray! = []
    var arr_quotation_list:NSMutableArray! = []
    var arr_article_list:NSMutableArray! = []
    var arr_advertisement:NSMutableArray! = []
    var arr_social_list:NSMutableArray! = []
    var arr_mut_category:NSMutableArray! = []
    
    var gesture_index:Int! = 0
    var gesture_index_stop_right:String! = "0"
    var gesture_index_stop_left:String! = "0"
    
    //
    var adv_gesture_index:Int! = 1
    var adv_gesture_index_stop_right:String! = "0"
    var adv_gesture_index_stop_left:String! = "0"
    var str_image_suffix_id="1"
    
    var str_quotation:String! = "dghghgjjh"
    
    @IBOutlet weak var tble_view:UITableView! {
        didSet {
            tble_view.backgroundColor = .clear
        }
    }
    
    @IBOutlet weak var btn_notification:UIButton! {
        didSet {
            btn_notification.isUserInteractionEnabled = true
        }
    }
    
    @IBOutlet weak var btn_search:UIButton! {
        didSet {
            btn_search.isUserInteractionEnabled = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = app_BG_color
        
        self.tble_view.separatorColor = .clear
        self.tabBarController?.tabBar.backgroundColor = UIColor.init(red: 250.0/255.0, green: 250.0/255.0, blue: 255.0/255.0, alpha: 1)
        
        self.screenSize = UIScreen.main.bounds
        self.screenWidth = screenSize.width
        self.screenHeight = screenSize.height
        
        self.btn_search.addTarget(self, action: #selector(search_v_home_click_method_2), for: .touchUpInside)
        self.btn_notification.addTarget(self, action: #selector(notification_v_home_click_method), for: .touchUpInside)
        
        self.create_custom_dict()
        
        // self.subscribe_click_method()
        
    }
    
    @objc func search_v_home_click_method_2() {
        let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "tab_bar_id") as? tab_bar
        push!.hidesBottomBarWhenPushed = true
        push!.selectedIndex = 1
        self.navigationController?.pushViewController(push!, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
//        print("test")
        
        
        if let loadedString = UserDefaults.standard.string(forKey: "key_refresh_page") {
            print(loadedString) // "Hello World"
            
            self.arr_mut_home_page_data.removeAllObjects()
            self.arr_mut_video_list.removeAllObjects()
            self.arr_mut_audio_list.removeAllObjects()
            self.arr_social_list.removeAllObjects()
            self.arr_article_list.removeAllObjects()
            
            self.create_custom_dict()
            
            let userDefaults = UserDefaults.standard
            userDefaults.set("", forKey: "key_refresh_page")
            userDefaults.set(nil, forKey: "key_refresh_page")
            
        } else {
            
            if UserDefaults.standard.value(forKey: str_save_login_user_data) is [String:Any] {
                
                self.tble_view.reloadData()
                
            } else {
                
                self.tble_view.reloadData()
                
            }
            
        }
       
        
        
    }
    
    @objc func create_custom_dict() {
        
        for indexx in 0...7 {
            
             if indexx == 0 {
              
              let custom_dict = ["status" : "heading"]
              
              self.arr_mut_home_page_data.add(custom_dict)
              
          } else if indexx == 1 {
                
                let custom_dict = ["status" : "quotes"]
                
                self.arr_mut_home_page_data.add(custom_dict)
                
            }  else if indexx == 4 {
                
                let custom_dict = ["status" : "knowledge"]
                
                self.arr_mut_home_page_data.add(custom_dict)
                
            } else if indexx == 3 {
                
                let custom_dict = ["status" : "bhagwat_gita"]
                
                self.arr_mut_home_page_data.add(custom_dict)
                
            } else if indexx == 2 {
                
                let custom_dict = ["status" : "welcome_text"]
                
                self.arr_mut_home_page_data.add(custom_dict)
                
            } else if indexx == 5 {
                
                let custom_dict = ["status" : "subscribe"]
                
                self.arr_mut_home_page_data.add(custom_dict)
                
            }    else if indexx == 6 {
                
                let custom_dict = ["status" : "social_media"]
                
                self.arr_mut_home_page_data.add(custom_dict)
                
            } else if indexx == 7 {
                
                let custom_dict = ["status" : "feeds"]
                
                self.arr_mut_home_page_data.add(custom_dict)
                
            } else if indexx == 8 {
                
                let custom_dict = ["status" : "welcome"]
                
                self.arr_mut_home_page_data.add(custom_dict)
                
            }
            
            
        }
        
        self.home_bhagwat_gita_categories_WB()
        
        
        
    }
    
    func minimumDate(for calendar: FSCalendar) -> Date {
        return Date()
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
        // let indexPath = IndexPath.init(row: 5, section: 0)
        // let cell = self.tble_view.cellForRow(at: indexPath) as! v_home_table_cell
        
        let foramtter = DateFormatter()
        
        // foramtter.dateFormat = "EEE MM-dd-YYYY"
        
        foramtter.dateFormat = "yyyy-MM-dd"
        
        let date = foramtter.string(from: date)
        
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date_set = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let resultString = dateFormatter.string(from: date_set!)
        // cell.lblSelectedDate.text = "Selected Date: " + resultString
        
        print("Selected Date: " + resultString)
        
        self.get_calendar_date_WB(str_date: resultString)
    }
    
    /*
     "action: eventlist
     pageNo:
     eventdate:   (YYYY-mm-dd)  //OPTIONAL"
     */
    
    @objc func get_calendar_date_WB(str_date:String) {
        self.view.endEditing(true)
        
        ERProgressHud.sharedInstance.showDarkBackgroundView(withTitle: "Please wait...")
        
        if IsInternetAvailable() == false {
            self.please_check_your_internet_connection()
            return
        }
        
        let parameters = [
            "action"    : "eventlist",
            "pageNo"    : "1",
            "eventdate"    : String(str_date),
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
                            
                            
                            var ar : NSArray!
                            ar = (jsonDict["social"] as! Array<Any>) as NSArray
                            
                            self.arr_social_list.addObjects(from: ar as! [Any])
                            
                            
                            
                            // quptation
                            var ar_quot : NSArray!
                            ar_quot = (jsonDict["quot"] as! Array<Any>) as NSArray
                            self.arr_quotation_list.addObjects(from: ar_quot as! [Any])
                            
                            
                            //
                            // arr_advertisement
                            var ar_advertisement : NSArray!
                            ar_advertisement = (jsonDict["advertisement"] as! Array<Any>) as NSArray
                            self.arr_advertisement.addObjects(from: ar_advertisement as! [Any])
                            
                            
                            // categories
                            
                            var ar_category : NSArray!
                            ar_category = (jsonDict["category"] as! Array<Any>) as NSArray
                            
                            for indexx in 0..<ar_category.count {
                                
                                let item = ar_category[indexx] as? [String:Any]
                                
                                if (item!["type"] as! String) == "Video" {
                                    
                                    let custom_dict_category = [
                                        "id"    : "\(item!["type"]!)",
                                        "image" : (item!["image"] as! String),
                                        "name"  : (item!["name"] as! String),
                                        "type"  : (item!["type"] as! String),
                                        
                                    ]
                                    
                                    self.arr_mut_category.add(custom_dict_category)
                                    
                                }
                            }
                            
                            // print(self.arr_mut_category as Any)
                            
                            // video
                            var ar_video : NSArray!
                            ar_video = (jsonDict["videoFree"] as! Array<Any>) as NSArray
                            self.arr_mut_video_list.addObjects(from: ar_video as! [Any])
                            
                            // audio
                            var ar_audio : NSArray!
                            ar_audio = (jsonDict["audioFree"] as! Array<Any>) as NSArray
                            self.arr_mut_audio_list.addObjects(from: ar_audio as! [Any])
                            
                            // article
                            var ar_article : NSArray!
                            ar_article = (jsonDict["articleFree"] as! Array<Any>) as NSArray
                            self.arr_article_list.addObjects(from: ar_article as! [Any])
                             
                            
                            ERProgressHud.sharedInstance.hide()
                            
                            self.tble_view.delegate = self
                            self.tble_view.dataSource = self
                            self.tble_view.reloadData()
                            
                            // self.video_list_WB()
                            
                            
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
    
    // MARK: - WEBSERVICE ( VIDEO LIST ) -
    @objc func video_list_WB() {
        self.view.endEditing(true)
        
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
            "action"        : "videolist",
            "pageNo"        : "1",
            "forHomePage"   : "1",
            "userId"        : String(myString),
            
        ] as [String : Any]
        
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
                                // ERProgressHud.sharedInstance.hide()
                                
                                var ar : NSArray!
                                ar = (jsonDict["data"] as! Array<Any>) as NSArray
                                self.arr_mut_video_list.addObjects(from: ar as! [Any])
                                
                                self.audio_list_WB()
                                
                                
                                // self.loadMore = 1
                                
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
                        print(response.error as Any, terminator: "")
                    }
                }
            }
    }
    
    // MARK: - WEBSERVICE ( AUDIO LIST ) -
    @objc func audio_list_WB() {
        self.view.endEditing(true)
        
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
            "action"        : "audiolist",
            "pageNo"        : "1",
            "forHomePage"   : "1",
            "userId"        : String(myString),
            
        ] as [String : Any]
        
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
                                // ERProgressHud.sharedInstance.hide()
                                
                                var ar : NSArray!
                                ar = (jsonDict["data"] as! Array<Any>) as NSArray
                                self.arr_mut_audio_list.addObjects(from: ar as! [Any])
                                
                                self.article_list_WB()
                                
                                
                                // self.loadMore = 1
                                
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
                        print(response.error as Any, terminator: "")
                    }
                }
            }
    }
    
    // MARK: - WEBSERVICE ( ARTICLE LIST ) -
    @objc func article_list_WB() {
        self.view.endEditing(true)
        
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
            "action"        : "articlelist",
            "pageNo"        : "1",
            "forHomePage"   : "1",
            "userId"        : String(myString),
            
        ] as [String : Any]
        
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
                                ar = (jsonDict["data"] as! Array<Any>) as NSArray
                                self.arr_article_list.addObjects(from: ar as! [Any])
                                
                                
                                self.tble_view.delegate = self
                                self.tble_view.dataSource = self
                                self.tble_view.reloadData()
                                // self.loadMore = 1
                                
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
                        print(response.error as Any, terminator: "")
                    }
                }
            }
    }
    
    
    //
    @objc func gesture_to_swipe_gesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizer.Direction.right:
                print("Swiped right")
//                print(self.adv_gesture_index as Any)
                
                
//                self.str_image_suffix_id = String(self.adv_gesture_index)
                
                
                
                
                if self.adv_gesture_index_stop_right == "0" {
                    
                    self.adv_gesture_index -= 1
//                     print(self.adv_gesture_index as Any)
                    
                    self.str_image_suffix_id = String(self.adv_gesture_index)
                    
                    if self.adv_gesture_index <= 1 {
                        
                        print("===> SWIPE RIGHT END HERE <====")
                        self.adv_gesture_index_stop_right = "1"
                        
                    } else {

                        self.adv_gesture_index_stop_left = "0"
                        
//                        let item = self.arr_quotation_list[self.gesture_index-1] as? [String:Any]
//                        print(item!["description"] as! String)
//                        self.str_quotation = (item!["description"] as! String)
//                        print("Swipe left")
//                        self.tble_view.reloadData()
                        
                    }
                    
                }
                
//                print("dishant")
//                print(self.str_image_suffix_id as Any)
//                print("dishant")
                
                
//                print("dishant")
//                print(self.str_image_suffix_id as Any)
//                print("dishant")
                self.tble_view.reloadData()
                
            case UISwipeGestureRecognizer.Direction.down:
                print("Swiped down")
            case UISwipeGestureRecognizer.Direction.left:
                print("Swiped left")
//                print(self.adv_gesture_index as Any)
                
//                print("dishant")
                
                
                
                if self.adv_gesture_index_stop_left == "0" {
                    
                    self.adv_gesture_index += 1
                     
                    self.str_image_suffix_id = String(self.adv_gesture_index)
                    
                    if 3 <= self.adv_gesture_index {
                        
                        print("we are same")
                        self.adv_gesture_index_stop_left = "1"
                        
                    } else {

                        self.adv_gesture_index_stop_right = "0"
                        
//                        let item = self.arr_quotation_list[self.gesture_index-1] as? [String:Any]
//                        print(item!["description"] as! String)
//                        self.str_quotation = (item!["description"] as! String)
//                        print("Swipe left")
//                        self.tble_view.reloadData()
                        
                    }
                    
                }
                
//                print("dishant")
//                print(self.adv_gesture_index as Any)
//                print(self.str_image_suffix_id as Any)
//                print("dishant")
                
                self.tble_view.reloadData()
                
                
            case UISwipeGestureRecognizer.Direction.up:
                print("Swiped up")
            default:
                break
            }
        }
    }
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizer.Direction.right:
                print("Swiped right")
                
                if self.gesture_index_stop_right == "0" {
                    
                    self.gesture_index -= 1
                     print(self.gesture_index as Any)
                    
                    if self.gesture_index <= 1 {
                        
                        print("===> SWIPE RIGHT END HERE <====")
                        self.gesture_index_stop_right = "1"
                        
                    } else {

                        self.gesture_index_stop_left = "0"
                        
                        let item = self.arr_quotation_list[self.gesture_index-1] as? [String:Any]
                        print(item!["description"] as! String)
                        self.str_quotation = (item!["description"] as! String)
                        print("Swipe left")
                        self.tble_view.reloadData()
                        
                    }
                    
                }
                
            case UISwipeGestureRecognizer.Direction.down:
                print("Swiped down")
            case UISwipeGestureRecognizer.Direction.left:
                print("Swiped left")
                
                if self.gesture_index_stop_left == "0" {
                    
                    self.gesture_index += 1
                     print(self.gesture_index as Any)
                    
                    if self.arr_quotation_list.count <= self.gesture_index {
                        
                        print("we are same")
                        self.gesture_index_stop_left = "1"
                        
                    } else {

                        self.gesture_index_stop_right = "0"
                        
                        let item = self.arr_quotation_list[self.gesture_index-1] as? [String:Any]
                        print(item!["description"] as! String)
                        self.str_quotation = (item!["description"] as! String)
                        print("Swipe left")
                        self.tble_view.reloadData()
                        
                    }
                    
                }
                
                
            case UISwipeGestureRecognizer.Direction.up:
                print("Swiped up")
            default:
                break
            }
        }
    }
    
    
    @objc func read_more_advertisement_click() {
        
        if let url = URL(string: "https://vedantavision.org/courses-olc1/") {
            UIApplication.shared.open(url)
        }
        
        /*let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "v_advertisement_id") as? v_advertisement
        
        push!.hidesBottomBarWhenPushed = false
        
        self.navigationController?.pushViewController(push!, animated: true)*/
        
    }
    
    
    @objc
    func tappedMe(_ sender:AnyObject) {
        print(sender.view.tag)
        print("Tapped on Image")
        
        let item = self.arr_advertisement[sender.view!.tag] as? [String:Any]
        
        let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "advertisement_details_id") as? advertisement_details
        
        push!.str_description = (item!["description"] as! String)
        push!.str_img_advertisement = (item!["image"] as! String)
        
        self.navigationController?.pushViewController(push!, animated: true)
        
        
        // img_advertisement
        
    }
    
    
    @objc func subscribe_click_method_2() {
        
        let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "welcome_id") as? welcome
        push!.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(push!, animated: true)
        
    }
    
}

extension v_home : UITableViewDelegate , UITableViewDataSource, FSCalendarDelegate,FSCalendarDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arr_mut_home_page_data.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item  = self.arr_mut_home_page_data[indexPath.row] as? [String:Any]
        
        if (item!["status"] as! String) == "heading" {
            
            let cell:v_home_table_cell = tableView.dequeueReusableCell(withIdentifier: "v_home_header") as! v_home_table_cell
            
            cell.backgroundColor = app_BG_color
            
            let backgroundView = UIView()
            backgroundView.backgroundColor = .clear
            cell.selectedBackgroundView = backgroundView
            
            // let item = self.arr_quotation_list[self.gesture_index] as? [String:Any]
            
            // cell.lbl_heading.text = (item!["description"] as! String)
            

            return cell
            
        }
        else if (item!["status"] as! String) == "quotes" {
            
            let cell:v_home_table_cell = tableView.dequeueReusableCell(withIdentifier: "v_home_quotes_table_cell") as! v_home_table_cell
            
            cell.backgroundColor = app_BG_color
            
            let backgroundView = UIView()
            backgroundView.backgroundColor = .clear
            cell.selectedBackgroundView = backgroundView
            
            let item = self.arr_quotation_list[self.gesture_index] as? [String:Any]
            
            cell.lbl_quotes.text = (item!["description"] as! String)
            
            let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
            swipeRight.direction = UISwipeGestureRecognizer.Direction.right
            cell.lbl_quotes.isUserInteractionEnabled = true
            cell.lbl_quotes.addGestureRecognizer(swipeRight)

                let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
            swipeDown.direction = UISwipeGestureRecognizer.Direction.left
            cell.lbl_quotes.isUserInteractionEnabled = true
            cell.lbl_quotes.addGestureRecognizer(swipeDown)

            return cell
            
        } else if (item!["status"] as! String) == "knowledge" {
            
            let cell:v_home_table_cell = tableView.dequeueReusableCell(withIdentifier: "v_home_knowledge_table_cell") as! v_home_table_cell
            
            cell.backgroundColor = app_BG_color
            
            let backgroundView = UIView()
            backgroundView.backgroundColor = .clear
            cell.selectedBackgroundView = backgroundView
            
            //            let view = UIScrollView()
            
            // img_scroll_advertisement
            // lbl_scroll_count
            let create_image_path = "banner"+String(self.str_image_suffix_id)
            cell.img_scroll_advertisement.image = UIImage(named: create_image_path)
            
            cell.lbl_scroll_count.text = String(self.str_image_suffix_id)+"/3"
            
            let swipe_left = UISwipeGestureRecognizer(target: self, action: #selector(self.gesture_to_swipe_gesture(gesture:)))
            swipe_left.direction = .left
             cell.img_scroll_advertisement.isUserInteractionEnabled = true
            cell.img_scroll_advertisement.addGestureRecognizer(swipe_left)
            
            // right
            let swipe_right = UISwipeGestureRecognizer(target: self, action: #selector(self.gesture_to_swipe_gesture(gesture:)))
            swipe_right.direction = .right
             cell.img_scroll_advertisement.isUserInteractionEnabled = true
            cell.img_scroll_advertisement.addGestureRecognizer(swipe_right)

            return cell
            
        } else if (item!["status"] as! String) == "subscribe" {
            
            let cell:v_home_table_cell = tableView.dequeueReusableCell(withIdentifier: "v_home_subscribe_table_cell") as! v_home_table_cell
            
            cell.backgroundColor = app_BG_color
            
            let backgroundView = UIView()
            backgroundView.backgroundColor = .clear
            cell.selectedBackgroundView = backgroundView
            
            cell.btn_subscribe.addTarget(self, action: #selector(subscribe_click_method_2), for: .touchUpInside)
            
            return cell
            
            
        } else if (item!["status"] as! String) == "bhagwat_gita" {
            
            let cell:v_home_table_cell = tableView.dequeueReusableCell(withIdentifier: "v_home_bhagwat_gita_table_cell") as! v_home_table_cell
            
            cell.backgroundColor = app_BG_color
            
            let backgroundView = UIView()
            backgroundView.backgroundColor = .clear
            cell.selectedBackgroundView = backgroundView
            
            // bhagwat gita
            cell.cl_view_bhagwat_gita.delegate = self
            cell.cl_view_bhagwat_gita.dataSource = self
            
            return cell
            
            
        }  else if (item!["status"] as! String) == "social_media" {
            
            let cell:v_home_table_cell = tableView.dequeueReusableCell(withIdentifier: "v_home_social_media_table_cell") as! v_home_table_cell
            
            cell.backgroundColor = app_BG_color
            
            let backgroundView = UIView()
            backgroundView.backgroundColor = .clear
            cell.selectedBackgroundView = backgroundView
            
            // social media
            cell.cl_view_social_media.delegate = self
            cell.cl_view_social_media.dataSource = self
            
            // latest video
            cell.cl_view_latest_video.delegate = self
            cell.cl_view_latest_video.dataSource = self
            
            cell.btn_see_more_video.addTarget(self, action: #selector(see_more_click_method), for: .touchUpInside)
            
            cell.btn_see_more_audio.addTarget(self, action: #selector(see_more_audio_click_method), for: .touchUpInside)
            
            cell.btn_see_more_articles.addTarget(self, action: #selector(see_more_article_click_method), for: .touchUpInside)
            
            // latest audio
            cell.cl_view_latest_audio.delegate = self
            cell.cl_view_latest_audio.dataSource = self
            
            // latest article
            cell.cl_view_latest_article.delegate = self
            cell.cl_view_latest_article.dataSource = self
            
            // calendar
            cell.calendar.delegate = self
            cell.calendar.dataSource = self
            
            cell.calendar.scope = .month
            
            
            return cell
            
            
        } else if (item!["status"] as! String) == "feeds" {
            
            let cell:v_home_table_cell = tableView.dequeueReusableCell(withIdentifier: "v_home_feeds_table_cell") as! v_home_table_cell
            
            cell.backgroundColor = app_BG_color
            
            let backgroundView = UIView()
            backgroundView.backgroundColor = .clear
            cell.selectedBackgroundView = backgroundView
            
            return cell
            
            
        } else if (item!["status"] as! String) == "welcome" {
            
            let cell:v_home_table_cell = tableView.dequeueReusableCell(withIdentifier: "v_home_welcome_table_cell") as! v_home_table_cell
            /*
            cell.backgroundColor = app_BG_color
            
            let backgroundView = UIView()
            backgroundView.backgroundColor = .clear
            cell.selectedBackgroundView = backgroundView
            
            cell.scroll_view_advertisement.translatesAutoresizingMaskIntoConstraints = false
            cell.view_banner_1_free_online.backgroundColor = .clear
            cell.scroll_view_advertisement.frame =  CGRect(x: 0, y: 0, width:cell.view_banner_1_free_online.frame.size.width, height: cell.view_banner_1_free_online.frame.size.height)
            
             cell.scroll_view_advertisement.backgroundColor = .brown
//            cell.scroll_view_advertisement.backgroundColor = .clear
            cell.scroll_view_advertisement.showsHorizontalScrollIndicator = false
            cell.scroll_view_advertisement.isPagingEnabled = true
            cell.view_banner_1_free_online.addSubview(cell.scroll_view_advertisement)
            
            for index in 0..<self.dummy_image_knowledge.count {
                
                // let item = self.arr_advertisement[index] as? [String:Any]
                // print((item!["image"] as! String))
                
                frame.origin.x = cell.view_banner_1_free_online.frame.size.width * CGFloat(index)
                frame.size = cell.view_banner_1_free_online.frame.size
                
                let imageView = UIImageView()
                imageView.image = UIImage(named: self.dummy_image_knowledge[index])
                
                // imageView.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
                // imageView.sd_setImage(with: URL(string: (item!["image"] as! String)), placeholderImage: UIImage(named: "logo"))
                
                imageView.frame = frame
                imageView.contentMode = .scaleToFill
                imageView.backgroundColor = .systemPink
                
                
                
                
                /*CGRect(x: 0, y: 0, width:
                 self.scrollViewBanner.frame.width, height: self.scrollViewBanner.frame.height)*/
                
                cell.scroll_view_advertisement.contentSize.width = cell.scroll_view_advertisement.frame.width * CGFloat(index + 1)
                cell.scroll_view_advertisement.addSubview(imageView)
                
            }
            
            // self.scrollViewBanner.contentSize = CGSize(width: self.scrollViewBanner.frame.size.width * CGFloat(self.arrAddQuestions.count), height: self.scrollViewBanner.frame.size.height)
            cell.scroll_view_advertisement.delegate = self
            
            
            
            
            cell.btn_read_more.addTarget(self, action: #selector(read_more_advertisement_click), for: .touchUpInside)
            */
            return cell
            
        } else {
            
            let cell:v_home_table_cell = tableView.dequeueReusableCell(withIdentifier: "v_home_welcome_table_cell") as! v_home_table_cell
            
            cell.backgroundColor = app_BG_color
            
            let backgroundView = UIView()
            backgroundView.backgroundColor = .clear
            cell.selectedBackgroundView = backgroundView
            
            let create_image_path = "banner"+String("3")
            cell.img_scroll_banner.image = UIImage(named: create_image_path)
            
             
            
            
            
            
            /*cell.scroll_view_advertisement.translatesAutoresizingMaskIntoConstraints = false
            cell.view_banner_1_free_online.backgroundColor = .clear
            cell.scroll_view_advertisement.frame =  CGRect(x: 0, y: 0, width:cell.view_banner_1_free_online.frame.size.width, height: cell.view_banner_1_free_online.frame.size.height)
            
//             cell.scroll_view_advertisement.backgroundColor = .brown
            cell.scroll_view_advertisement.backgroundColor = .clear
            cell.scroll_view_advertisement.showsHorizontalScrollIndicator = false
            cell.scroll_view_advertisement.isPagingEnabled = true
            cell.view_banner_1_free_online.addSubview(cell.scroll_view_advertisement)
            
            for index in 0..<self.dummy_image_knowledge.count {
                
                // let item = self.arr_advertisement[index] as? [String:Any]
                // print((item!["image"] as! String))
                
                frame.origin.x = cell.view_banner_1_free_online.frame.size.width * CGFloat(index)
                frame.size = cell.view_banner_1_free_online.frame.size
                
                let imageView = UIImageView()
                imageView.image = UIImage(named: self.dummy_image_knowledge[index])
                
                // imageView.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
                // imageView.sd_setImage(with: URL(string: (item!["image"] as! String)), placeholderImage: UIImage(named: "logo"))
                
                imageView.frame = frame
                imageView.contentMode = .scaleToFill
                imageView.backgroundColor = .clear
                
                
                
                
                /*CGRect(x: 0, y: 0, width:
                 self.scrollViewBanner.frame.width, height: self.scrollViewBanner.frame.height)*/
                
                cell.scroll_view_advertisement.contentSize.width = cell.scroll_view_advertisement.frame.width * CGFloat(index + 1)
                cell.scroll_view_advertisement.addSubview(imageView)
                
            }
            
            // self.scrollViewBanner.contentSize = CGSize(width: self.scrollViewBanner.frame.size.width * CGFloat(self.arrAddQuestions.count), height: self.scrollViewBanner.frame.size.height)
            cell.scroll_view_advertisement.delegate = self
            
            
            
            */
            cell.btn_read_more.addTarget(self, action: #selector(read_more_advertisement_click), for: .touchUpInside)
            
            return cell
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let item  = self.arr_mut_home_page_data[indexPath.row] as? [String:Any]
        
        if (item!["status"] as! String) == "subscribe" {
            
            if let person = UserDefaults.standard.value(forKey: str_save_login_user_data) as? [String:Any] {
                
                print(person as Any)
                return 0
                
            } else {
                return self.cell_height_subscribe
                
            }
            
            
            
        } else if (item!["status"] as! String) == "bhagwat_gita" {
            
            return self.cell_height_bhagwat_gita
            
        } else if (item!["status"] as! String) == "knowledge" {
            
            return 200 //self.cell_height_knowledge
            
        } else if (item!["status"] as! String) == "social_media" {
            
            return self.cell_height_social_media
            
        } else if (item!["status"] as! String) == "feeds" {
            
            return self.cell_height_feeds
            
        } else if (item!["status"] as! String) == "heading" {
            
            return 76
            
        } else if (item!["status"] as! String) == "quotes" {
            
            
            return UITableView.automaticDimension
        } else {
            
            return 214
            
        }
        
    }
    
}

class v_home_table_cell:UITableViewCell {
    
    @IBOutlet weak var img_advertisement:UIImageView!
    
    @IBOutlet weak var view_quotes:UIView! {
        didSet {
            view_quotes.layer.shadowColor = UIColor(red: 255.0/255.0, green: 219.0/255.0, blue: 220.0/255.0, alpha: 1).cgColor
            view_quotes.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            view_quotes.layer.shadowOpacity = 1.0
            view_quotes.layer.shadowRadius = 15.0
            view_quotes.layer.masksToBounds = false
            view_quotes.layer.cornerRadius = 25
            
            view_quotes.roundCorners(corners: [.bottomLeft, .topRight])
            
        }
    }
    
    @IBOutlet weak var lbl_quotes:UILabel! {
        didSet {
            lbl_quotes.text = "Dishant rajput rajput rajput rajput rajput rajput rajput rajput rajput rajput rajput rajput rajput rajput rajput rajput rajput rajput rajput rajput rajput rajput rajput rajput rajput rajput rajput rajput rajput rajput rajput"
            lbl_quotes.textColor = UIColor.init(red: 62.0/255.0, green: 62.0/255.0, blue: 62.0/255.0, alpha: 1)
        }
    }
    
    @IBOutlet weak var view_double_quotes_top_left:UIView! {
        didSet {
            view_double_quotes_top_left.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            view_double_quotes_top_left.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            view_double_quotes_top_left.layer.shadowOpacity = 1.0
            view_double_quotes_top_left.layer.shadowRadius = 15.0
            view_double_quotes_top_left.layer.masksToBounds = false
            view_double_quotes_top_left.layer.cornerRadius = 25
            view_double_quotes_top_left.backgroundColor = .white
            
        }
    }
    
    @IBOutlet weak var view_double_quotes_bottom_right:UIView! {
        didSet {
            view_double_quotes_bottom_right.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            view_double_quotes_bottom_right.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            view_double_quotes_bottom_right.layer.shadowOpacity = 1.0
            view_double_quotes_bottom_right.layer.shadowRadius = 15.0
            view_double_quotes_bottom_right.layer.masksToBounds = false
            view_double_quotes_bottom_right.layer.cornerRadius = 25
            view_double_quotes_bottom_right.backgroundColor = .white
        }
    }
    
    @IBOutlet weak var lbl_welcome_to_vedanta:UILabel! {
        didSet {
            lbl_welcome_to_vedanta.text = "WELCOME TO VEDANTA VISION"
            // lbl_welcome_to_vedanta.textColor = .systemOrange
        }
    }
    
    @IBOutlet weak var lbl_heading:UILabel! {
        didSet {
            lbl_heading.text = "Begin your Journey to self discovery!"
//            lbl_heading.font = UIFont(name: "Popins-Regular", size: 40.0)
            // lbl_welcome_to_vedanta.textColor = .systemOrange
        }
    }
    
    @IBOutlet weak var lbl_master_text:UILabel! {
        didSet {
            lbl_master_text.text = "Master the Science of\nSelf Management"
            // lbl_master_text.textColor = .systemPurple
        }
    }
    
    
    
    // subscribe
    
    @IBOutlet weak var view_advertisement:UIView! {
        didSet {
            view_advertisement.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            view_advertisement.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            view_advertisement.layer.shadowOpacity = 1.0
            view_advertisement.layer.shadowRadius = 4
            view_advertisement.layer.masksToBounds = false
            view_advertisement.layer.cornerRadius = 22
            view_advertisement.backgroundColor = .white
        }
    }
    
    @IBOutlet weak var view_subscribe:UIView! {
        didSet {
            view_subscribe.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            view_subscribe.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            view_subscribe.layer.shadowOpacity = 1.0
            view_subscribe.layer.shadowRadius = 4
            view_subscribe.layer.masksToBounds = false
            view_subscribe.layer.cornerRadius = 22
            view_subscribe.backgroundColor = .white
        }
    }
    
    @IBOutlet weak var image_subscribe:UIView! {
        didSet {
            image_subscribe.layer.cornerRadius = 8
            image_subscribe.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var btn_subscribe:UIButton! {
        didSet {
            btn_subscribe.layer.cornerRadius = 6
            btn_subscribe.clipsToBounds = true
            
        }
    }
    
    @IBOutlet weak var lbl_already_subscribe:UILabel! {
        didSet {
            lbl_already_subscribe.textColor = .white
        }
    }
    
    
    // collection view bhagwat gita
    @IBOutlet weak var cl_view_bhagwat_gita:UICollectionView! {
        didSet {
            cl_view_bhagwat_gita.backgroundColor = .clear
            
        }
    }
    
    // banner 3
    @IBOutlet weak var view_banner_1_free_online:UIView! {
        didSet {
            view_banner_1_free_online.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            view_banner_1_free_online.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            view_banner_1_free_online.layer.shadowOpacity = 1.0
            view_banner_1_free_online.layer.shadowRadius = 8
            view_banner_1_free_online.layer.masksToBounds = false
            view_banner_1_free_online.layer.cornerRadius = 22
            view_banner_1_free_online.backgroundColor = .white
        }
    }
    // scroll view
    @IBOutlet weak var view_scroll:UIView! {
        didSet {
            view_scroll.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            view_scroll.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            view_scroll.layer.shadowOpacity = 1.0
            view_scroll.layer.shadowRadius = 4
            view_scroll.layer.masksToBounds = false
            view_scroll.layer.cornerRadius = 22
            view_scroll.backgroundColor = .clear
        }
    }
    
    @IBOutlet weak var scroll_view_quotes:UIScrollView! {
        didSet {
            scroll_view_quotes.backgroundColor = .clear
        }
    }
    
    @IBOutlet weak var scroll_view_advertisement:UIScrollView! {
        didSet {
            scroll_view_advertisement.backgroundColor = .clear
        }
    }
    
    @IBOutlet weak var view_scroll_adv:UIView! {
        didSet {
            view_scroll_adv.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            view_scroll_adv.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            view_scroll_adv.layer.shadowOpacity = 1.0
            view_scroll_adv.layer.shadowRadius = 4
            view_scroll_adv.layer.masksToBounds = false
            view_scroll_adv.layer.cornerRadius = 22
            view_scroll_adv.backgroundColor = .clear
        }
    }
    
    @IBOutlet weak var lbl_scroll_count:UILabel! {
        didSet {
            lbl_scroll_count.textColor = .white
        }
    }
    
    @IBOutlet weak var img_scroll_advertisement:UIImageView! {
        didSet {
            img_scroll_advertisement.layer.cornerRadius = 12
            img_scroll_advertisement.clipsToBounds = true
//            scroll_view_advertisement.backgroundColor = .clear
        }
    }
    
    @IBOutlet weak var img_scroll_banner:UIImageView! {
        didSet {
            img_scroll_banner.layer.cornerRadius = 12
            img_scroll_banner.clipsToBounds = true
//            scroll_view_advertisement.backgroundColor = .clear
        }
    }
    
    @IBOutlet weak var scroll_view_banner:UIScrollView! {
        didSet {
            scroll_view_banner.backgroundColor = .clear
        }
    }
    
    
    // collection view social media
    @IBOutlet weak var cl_view_social_media:UICollectionView! {
        didSet {
            cl_view_social_media.backgroundColor = .clear
            
        }
    }
    
    @IBOutlet weak var btn_see_more_video:UIButton!
    
    // collection view latest video
    @IBOutlet weak var cl_view_latest_video:UICollectionView! {
        didSet {
            cl_view_latest_video.backgroundColor = .clear
            
        }
    }
    
    @IBOutlet weak var btn_see_more_audio:UIButton!
    
    // collection view latest audio
    @IBOutlet weak var cl_view_latest_audio:UICollectionView! {
        didSet {
            cl_view_latest_audio.backgroundColor = .clear
        }
    }
    
    @IBOutlet weak var btn_see_more_articles:UIButton!
    
    // collection view latest articles
    @IBOutlet weak var cl_view_latest_article:UICollectionView! {
        didSet {
            cl_view_latest_article.backgroundColor = .clear
        }
    }
    
    // calendar
    @IBOutlet weak var calendar: FSCalendar! {
        didSet {
            calendar.backgroundColor = .clear
            calendar.scope = .month
        }
    }
    
    
    @IBOutlet weak var view_feeds:UIView! {
        didSet {
            view_feeds.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            view_feeds.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            view_feeds.layer.shadowOpacity = 1.0
            view_feeds.layer.shadowRadius = 4
            view_feeds.layer.masksToBounds = false
            view_feeds.layer.cornerRadius = 22
            view_feeds.backgroundColor = .white
        }
    }
    
    @IBOutlet weak var btn_read_more:UIButton!
    
}

// collection view
extension v_home: UICollectionViewDataSource , UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView.tag == 3000 {
            return self.arr_mut_video_list.count
        } else if collectionView.tag == 2000 {
            return self.arr_social_list.count
        } else {
            return self.arr_mut_category.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView.tag == 1000 {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "v_home_collection_view_cell", for: indexPath as IndexPath) as! v_home_collection_view_cell
            
            cell.backgroundColor = app_BG_color
            
            let item = self.arr_mut_category[indexPath.row] as? [String:Any]
            print(item as Any)
            
            cell.lbl_bhagwat_gita_title.text = (item!["name"] as! String)
            
            let urlString = (item!["image"] as! String).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)

            cell.img_bhagwat_gita_list.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
            cell.img_bhagwat_gita_list.sd_setImage(with: URL(string: String(urlString!)), placeholderImage: UIImage(named: "logo"))
             
            cell.layer.cornerRadius = 8
            
            return cell
            
        } else if collectionView.tag == 2000 {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "v_home_collection_social_media_view_cell", for: indexPath as IndexPath) as! v_home_collection_social_media_view_cell
            
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
            
            // cell.img_social_media.sd_setImage(with: URL(string: (item!["media_link"] as! String)), placeholderImage: UIImage(named: "logo"))
            
            cell.layer.cornerRadius = 8
            
            return cell
            
        } else if collectionView.tag == 3000 {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "v_home_collection_latest_video_view_cell", for: indexPath as IndexPath) as! v_home_collection_latest_video_view_cell
            
            cell.backgroundColor = app_BG_color
            
            cell.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            cell.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            cell.layer.shadowOpacity = 1.0
            cell.layer.shadowRadius = 8
            cell.layer.masksToBounds = false
            cell.layer.cornerRadius = 8
            cell.backgroundColor = .white
            
            // print(self.arr_mut_video_list as Any)
            
            let item = self.arr_mut_video_list[indexPath.row] as? [String:Any]
            print(item as Any)
            
            cell.img_social_media.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
            cell.img_social_media.sd_setImage(with: URL(string: (item!["image"] as! String)), placeholderImage: UIImage(named: "logo"))
            
            cell.lbl_latest_video.text = (item!["title"] as! String)
            
            /*
             Link = "https://youtu.be/ro4nbpLbBa0";
             Type = 2;
             categoryId = 36;
             created = "Oct 7th, 2022, 1:45 pm";
             description = "The World You See Is a Projection, Not a Creation";
             homePage = 1;
             image = "https://demo4.evirtualservices.net/vedanta/img/uploads/video/1.jpg";
             title = "The World You See Is a Projection, Not a Creation";
             videoFile = "https://demo4.evirtualservices.net/vedanta/img/uploads/video/1_videoFile.jpg";
             videoId = 1;
             */
            
            return cell
            
        } else if collectionView.tag == 4000 {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "v_home_collection_latest_audio_view_cell", for: indexPath as IndexPath) as! v_home_collection_latest_audio_view_cell
            
            cell.backgroundColor = app_BG_color
            
            cell.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            cell.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            cell.layer.shadowOpacity = 1.0
            cell.layer.shadowRadius = 8
            cell.layer.masksToBounds = false
            cell.layer.cornerRadius = 8
            cell.backgroundColor = .white
            
            let item = self.arr_mut_audio_list[indexPath.row] as? [String:Any]
            
            cell.img_latest_audio.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
            cell.img_latest_audio.sd_setImage(with: URL(string: (item!["image"] as! String)), placeholderImage: UIImage(named: "logo"))
            
            cell.lbl_latest_audio.text = (item!["title"] as! String)
            
            return cell
            
        } else if collectionView.tag == 5000 {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "v_home_collection_latest_article_view_cell", for: indexPath as IndexPath) as! v_home_collection_latest_article_view_cell
            
            cell.backgroundColor = app_BG_color
            
            cell.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            cell.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            cell.layer.shadowOpacity = 1.0
            cell.layer.shadowRadius = 8
            cell.layer.masksToBounds = false
            cell.layer.cornerRadius = 8
            cell.backgroundColor = .white
            
            let item = self.arr_article_list[indexPath.row] as? [String:Any]

            cell.img_latest_article.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
            cell.img_latest_article.sd_setImage(with: URL(string: (item!["image"] as! String)), placeholderImage: UIImage(named: "logo"))

            cell.lbl_latest_article.text = (item!["title"] as! String)
            
            return cell
            
        } else {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "v_home_collection_latest_article_view_cell", for: indexPath as IndexPath) as! v_home_collection_latest_article_view_cell
            
            cell.backgroundColor = app_BG_color
            
            cell.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            cell.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            cell.layer.shadowOpacity = 1.0
            cell.layer.shadowRadius = 8
            cell.layer.masksToBounds = false
            cell.layer.cornerRadius = 8
            cell.backgroundColor = .white
            
            return cell
            
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
         
        if collectionView.tag == 1000 {
            
            let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "tab_bar_id") as? tab_bar
            push!.hidesBottomBarWhenPushed = true
            push!.selectedIndex = 2
            self.navigationController?.pushViewController(push!, animated: true)
            
        }
        
        else if collectionView.tag == 3000 {
            
            let item = self.arr_mut_video_list[indexPath.row] as? [String:Any]
            print(item as Any)
            
            let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "v_related_videos_id") as? v_related_videos
            push!.hidesBottomBarWhenPushed = false
            
            push!.dict_get_video_data = item as NSDictionary?
            self.navigationController?.pushViewController(push!, animated: true)
            
        } else if collectionView.tag == 2000 {

            let item = self.arr_social_list[indexPath.row] as? [String:Any]
            
            let pushVC = self.storyboard?.instantiateViewController(withIdentifier: "play_videos_id") as! play_videos
            pushVC.str_video_link = (item!["media_link"] as! String)
            pushVC.str_video_header = (item!["name"] as! String)
            self.navigationController?.pushViewController(pushVC, animated: true)
            
        } else if collectionView.tag == 4000 {
            
            let item = self.arr_mut_audio_list[indexPath.row] as? [String:Any]
            
            let push = self.storyboard?.instantiateViewController(withIdentifier: "v_related_audio_id") as! v_related_audio
            
            push.hidesBottomBarWhenPushed = false
            push.dict_get_audio_data = item as NSDictionary?
            
            self.navigationController?.pushViewController(push, animated: true)
            
        } else if collectionView.tag == 5000 {
            
            let item = self.arr_article_list[indexPath.row] as? [String:Any]
            
            let push = self.storyboard?.instantiateViewController(withIdentifier: "related_article_id") as! related_article
            
            push.hidesBottomBarWhenPushed = false
            push.dict_get_article_data = item as NSDictionary?
            
            self.navigationController?.pushViewController(push, animated: true)
            
        }
        
    }
    
    
}

extension v_home: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView.tag == 1000 {
            return CGSize(width: 90,height: 154)
        } else if collectionView.tag == 2000 {
            return CGSize(width: 50,height: 80)
        } else {
            return CGSize(width: 160,height: 120)
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
            return 10
        } else if collectionView.tag == 2000 {
            return 20
        } else {
            return 10
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        if collectionView.tag == 1000 {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
        } else {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
        }
        
    }
    
}

class v_home_collection_view_cell: UICollectionViewCell {
    
    
    @IBOutlet weak var img_bhagwat_gita_list:UIImageView! {
        didSet {
//            img_bhagwat_gita_list.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
//            img_bhagwat_gita_list.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
//            img_bhagwat_gita_list.layer.shadowOpacity = 1.0
//            img_bhagwat_gita_list.layer.shadowRadius = 8
//            img_bhagwat_gita_list.layer.masksToBounds = false
//            img_bhagwat_gita_list.layer.cornerRadius = 8
//            img_bhagwat_gita_list.backgroundColor = .white
            
            img_bhagwat_gita_list.layer.cornerRadius = 8
            img_bhagwat_gita_list.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var lbl_bhagwat_gita_title:UILabel! {
        didSet {
            lbl_bhagwat_gita_title.textColor = .black
        }
    }
    
    
}

// MARK: - COLLECTION CELL ( SOCIAL MEDIA ) -
class v_home_collection_social_media_view_cell: UICollectionViewCell {
    
    @IBOutlet weak var img_social_media:UIImageView! {
        didSet {
            
        }
    }
    
}

// MARK: - COLLECTION CELL ( LATEST VIDEOS ) -
class v_home_collection_latest_video_view_cell: UICollectionViewCell {
    
    @IBOutlet weak var img_social_media:UIImageView! {
        didSet {
            
        }
    }
    
    @IBOutlet weak var lbl_latest_video:UILabel! {
        didSet {
            lbl_latest_video.textColor = .black
        }
    }
    
}

// MARK: - COLLECTION CELL ( LATEST AUIDO ) -
class v_home_collection_latest_audio_view_cell: UICollectionViewCell {
    
    @IBOutlet weak var img_latest_audio:UIImageView! {
        didSet {
//            img_latest_audio.layer.cornerRadius = 8
//            img_latest_audio.clipsToBounds = true
            
            let path = UIBezierPath(roundedRect:img_latest_audio.bounds,
                                    byRoundingCorners:[.topRight, .topLeft],
                                    cornerRadii: CGSize(width: 8, height:  8))

            let maskLayer = CAShapeLayer()

            maskLayer.path = path.cgPath
            img_latest_audio.layer.mask = maskLayer
            
        }
    }
    
    @IBOutlet weak var lbl_latest_audio:UILabel! {
        didSet {
            lbl_latest_audio.textColor = .black
        }
    }
    
    
    
}

// MARK: - COLLECTION CELL ( LATEST ARTICLES ) -
class v_home_collection_latest_article_view_cell: UICollectionViewCell {
    
    @IBOutlet weak var img_latest_article:UIImageView! {
        didSet {
            let path = UIBezierPath(roundedRect:img_latest_article.bounds,
                                    byRoundingCorners:[.topRight, .topLeft],
                                    cornerRadii: CGSize(width: 8, height:  8))

            let maskLayer = CAShapeLayer()

            maskLayer.path = path.cgPath
            img_latest_article.layer.mask = maskLayer
        }
    }
    
    @IBOutlet weak var lbl_latest_article:UILabel! {
        didSet {
            lbl_latest_article.textColor = .black
        }
    }
}


