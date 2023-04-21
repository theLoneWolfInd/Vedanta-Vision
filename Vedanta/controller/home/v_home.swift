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
import AVFoundation
import AVKit
import WebKit


class v_home: UIViewController {
    
    var str_name:String!
    
    /*========================= TABLE CELL HEIGHT ======================================*/
    
    var cell_height_subscribe:CGFloat = 100
    var cell_height_bhagwat_gita:CGFloat = 160
    var cell_height_knowledge:CGFloat = 200
    var cell_height_social_media:CGFloat = 1450//930//1000
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
    
    var arr_dates:NSMutableArray! = []
    var datesWithEvent:NSMutableArray! = []
    
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
    
    fileprivate lazy var dateFormatter2: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    fileprivate lazy var dateFormatter1: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        return formatter
    }()
    
//    let fillSelectionColors = ["2023/03/24": UIColor.brown, "2015/10/06": UIColor.purple, "2015/10/17": UIColor.gray, "2015/10/21": UIColor.cyan, "2015/11/08": UIColor.green, "2015/11/06": UIColor.purple, "2015/11/17": UIColor.gray, "2015/11/21": UIColor.cyan, "2015/12/08": UIColor.green, "2015/12/06": UIColor.purple, "2015/12/17": UIColor.gray, "2015/12/21": UIColor.cyan]
    
    let borderDefaultColors = ["2015/10/17": UIColor.red]
    
    var _lastContentOffset: CGPoint!
    var panGesture : UIPanGestureRecognizer!
    
    var strIndex:Int! = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = app_BG_color
        
        self.tble_view.separatorColor = .clear
        self.tabBarController?.tabBar.backgroundColor = UIColor.init(red: 250.0/255.0, green: 250.0/255.0, blue: 255.0/255.0, alpha: 1)
        self.tble_view.alwaysBounceVertical = false
        
        self.screenSize = UIScreen.main.bounds
        self.screenWidth = screenSize.width
        self.screenHeight = screenSize.height
        
        self.btn_search.addTarget(self, action: #selector(search_v_home_click_method_2), for: .touchUpInside)
        self.btn_notification.addTarget(self, action: #selector(notification_v_home_click_method), for: .touchUpInside)
        
        self.create_custom_dict()
        
        // self.subscribe_click_method()
        
        
//        let server_date = "Oct 20st, 2022"
//
//        // remove comma from date
//        let removed_comma = server_date.replacingOccurrences(of: ",", with: "")
//        print(removed_comma as Any)
//
//        // 2
//        var myStringArr = removed_comma.components(separatedBy: " ")
//        print(myStringArr)
        
        //
//        print(myStringArr[1].suffix(2))
//
//        if (myStringArr[1].suffix(2) == "st") {
//            print("i am st")
//
//        let removed_st = server_date.replacingOccurrences(of: "\(myStringArr[1])", with: "")
//            print(removed_st)
//
//        } else if (myStringArr[1].suffix(2) == "nd") {
//            print("i am nd")
//        } else if (myStringArr[1].suffix(2) == "rd") {
//            print("i am rd")
//        } else {
//            print("i am th")
//        }
        
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy"
        let date = dateFormatter.date(from: "Oct 20, 2022")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let resultString = dateFormatter.string(from: date!)
        print(resultString)
    }
    
    @objc func search_v_home_click_method_2() {
//        let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "tab_bar_id") as? tab_bar
//
//        push!.hidesBottomBarWhenPushed = true
//        push!.selectedIndex = 1
//
////        push!.str_title = "search"
//
//        self.navigationController?.pushViewController(push!, animated: true)
        
        
        let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "v_wisdom_id") as? v_wisdom
        
        push!.str_search = "yes"
        push!.hidesBottomBarWhenPushed = true
//        push!.selectedIndex = 1
        
//        push!.str_title = "search"
        
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
        
        
        if self.datesWithEvent.contains(resultString) {
            print("yes")
            
            for i in 0..<self.arr_dates.count {
                let item = self.arr_dates[i] as? [String:Any]
                print(item as Any)
                
                if (resultString == item!["eventDate"] as! String) {
                    print("yes open browser")
                    
                    if let url = URL(string: item!["URL"] as! String) {
                        UIApplication.shared.open(url)
                    }
                    return
                }
                
                
                
                
            }
        } else {
            print("no")
        }
        
        
        // self.get_calendar_date_WB(str_date: resultString)
    }
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        let dateString = self.dateFormatter2.string(from: date)
        if self.datesWithEvent.contains(dateString) {
            return 1
        }

        return 0
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillSelectionColorFor date: Date) -> UIColor? {
        let key = self.dateFormatter2.string(from: date)
        if self.datesWithEvent != nil {
            return UIColor.black
        }
        return appearance.selectionColor
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, borderDefaultColorFor date: Date) -> UIColor? {
        let key = self.dateFormatter1.string(from: date)
        if let color = self.borderDefaultColors[key] {
            return color
        }
        return appearance.borderDefaultColor
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
                                let cancel = NewYorkButton(title: "Dismiss", style: .cancel)
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
                             
                            
                            self.all_events_list()
                            
                            
                            // self.video_list_WB()
                            
                            
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
    
    @objc func all_events_list() {
        self.view.endEditing(true)
        
         
        
        if IsInternetAvailable() == false {
            self.please_check_your_internet_connection()
            return
        }
        
        let parameters = [
            "action"    : "eventlist",
             
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
                            print(ar as Any)
                            
                            self.arr_dates.addObjects(from: ar as! [Any])
//                            let arr:NSArray!
                            
                            
                            for i in 0..<ar.count{
//                                print(i)
//                                print(indexx["eventDate"] as! String)
                                
                                let item = ar[i] as? [String:Any]
                                print(item!["eventDate"] as! String)
                                
                                self.datesWithEvent.add(item!["eventDate"] as! String)
//                                var datesWithEvent = ["2023-03-17", "2015-10-06", "2015-10-12", "2015-10-25"]
                            }
                            
//                            print(datesWithEvent)
                            
                            ERProgressHud.sharedInstance.hide()
                            
 
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
                
                //                swipeGesture.ani
                
                UIView.animate(withDuration: 2, animations: {
                if self.adv_gesture_index_stop_right == "0" {
                    
                    self.adv_gesture_index -= 1
                    //                     print(self.adv_gesture_index as Any)
                    
                    self.str_image_suffix_id = String(self.adv_gesture_index)
                    
                    if self.adv_gesture_index <= 1 {
                        
                        print("===> SWIPE RIGHT END HERE <====")
                        self.adv_gesture_index_stop_right = "1"
                        
                    } else {
                        
                        self.adv_gesture_index_stop_left = "0"
                        
                        
                    }
                    
                }
            })
 
                self.tble_view.reloadData()
                
            case UISwipeGestureRecognizer.Direction.down:
                print("Swiped down")
            case UISwipeGestureRecognizer.Direction.left:
                print("Swiped left")
 
                if self.adv_gesture_index_stop_left == "0" {
                    
                    self.adv_gesture_index += 1
                     
                    self.str_image_suffix_id = String(self.adv_gesture_index)
                    
                    if 3 <= self.adv_gesture_index {
                        
                        print("we are same")
                        self.adv_gesture_index_stop_left = "1"
                        
                    } else {

                        self.adv_gesture_index_stop_right = "0"
                        
 
                        
                    }
                    
                }
 
                
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
    
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
//        let tappedImage = tapGestureRecognizer.view as! UIImageView
        if let url = URL(string: "https://vedantavision.org/courses-olc1/") {
            UIApplication.shared.open(url)
        }
        // Your action
    }
    
    @objc func read_more_advertisement_click() {
        
        if let url = URL(string: "https://vedantavision.org/courses-olc1/") {
            UIApplication.shared.open(url)
        }
        
        /*let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "v_advertisement_id") as? v_advertisement
        
        push!.hidesBottomBarWhenPushed = false
        
        self.navigationController?.pushViewController(push!, animated: true)*/
        
    }
    
    
     
    @objc func advertisement_tapped(tapGestureRecognizer: UITapGestureRecognizer) {
//        print(self.str_image_suffix_id as Any)
//        let tappedImage = tapGestureRecognizer.view as! UIImageView
//        print(tappedImage.tag)
//        print("Tapped on Image")
        
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        print(tappedImage.tag)
        
//        let int_1 = (str_image_suffix_id as NSString).integerValue
        
        let item = self.arr_advertisement[tappedImage.tag] as? [String:Any]

        let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "advertisement_details_id") as? advertisement_details

        push!.hidesBottomBarWhenPushed = true
        push!.str_start_date = (item!["startDate"] as! String)
        push!.str_end_date = (item!["endDate"] as! String)
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
    
    @objc func instagram_click_method() {
        if let url = URL(string: "https://www.instagram.com/vedanta_vision/?hl=en") {
            UIApplication.shared.open(url)
        }
    }
    
    @objc func facebook_click_method() {
        if let url = URL(string: "https://www.facebook.com/jayarowvedanta") {
            UIApplication.shared.open(url)
        }
    }
    
    @objc func youtube_click_method() {
        if let url = URL(string: "https://www.youtube.com/user/vedantavision") {
            UIApplication.shared.open(url)
        }
    }
    
    @objc func linked_in_click_method() {
        if let url = URL(string: "https://www.linkedin.com/in/vedanta-vision-546160ab/") {
            UIApplication.shared.open(url)
        }
    }
    
    @objc func spotify_click_method() {
        if let url = URL(string: "https://open.spotify.com/show/7maqOtQsacT6Upja7ND0Kk") {
            UIApplication.shared.open(url)
        }
    }
    
     
    //
    // MARK : TO CHANGE WHILE CLICKING ON PAGE CONTROL
//    func changePage(sender: AnyObject) -> () {
//        let indexPath = IndexPath.init(row: 2, section: 0)
//        let cell = self.tble_view.cellForRow(at: indexPath) as! v_home_table_cell
//        
//        print("one 1.1")
////        let x = CGFloat(cell.page_control.currentPage) * view.frame.size.width
////        view.setContentOffset(CGPoint(x:x, y:0), animated: true)
//    }

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
         _lastContentOffset = scrollView.contentOffset
      }
//
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {

        var str_count = "0"
        
        if _lastContentOffset.y < scrollView.contentOffset.y {
              NSLog("Scrolled Down")
            str_count = "1"
        }

        else if _lastContentOffset.y > scrollView.contentOffset.y {
            NSLog("Scrolled Up")
            
            str_count = "1"
        } else {
//
//
//            let indexPath = IndexPath.init(row: 4, section: 0)
//            let cell = self.tble_view.cellForRow(at: indexPath) as! v_home_table_cell
//
            let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
            print(pageNumber)

//            print(Int(pageNumber))
//            cell.page_control.currentPage = Int(pageNumber)
            self.strIndex = Int(pageNumber)
            self.tble_view.reloadData()
        }
        
//        if str_count == "0" {
//
//
//        }
//

//        print("one 2.1")

    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var isLoading: Bool = false
        
//        if scrollView == self.tble_view {
            let contentOffsetX = scrollView.contentOffset.x
            if contentOffsetX >= (scrollView.contentSize.width - scrollView.bounds.width) - 20 /* Needed offset */ {
     //           guard !self.isLoading else { return }
     //           self.isLoading = true
                // load more data
                // than set self.isLoading to false when new data is loaded
//                print("hello")
            }
//        }
       
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
            
//            print(str_image_suffix_id);
 
            /*let int_1 = (str_image_suffix_id as NSString).integerValue
//
            let item = self.arr_advertisement[int_1-1] as? [String:Any]
            
            cell.img_scroll_advertisement.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
            cell.img_scroll_advertisement.sd_setImage(with: URL(string: (item!["image"] as! String)), placeholderImage: UIImage(named: "logo"))
            
            
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(advertisement_tapped(tapGestureRecognizer:)))
            cell.img_scroll_advertisement.tag = indexPath.row
            cell.img_scroll_advertisement.isUserInteractionEnabled = true
            cell.img_scroll_advertisement.addGestureRecognizer(tapGestureRecognizer)
            
//            panGesture.isLeft(theViewYouArePassing: cell.view_img_scroll_advertisement)
            
            
            // view_img_scroll_advertisement
            
           
            let int = (str_image_suffix_id as NSString).integerValue
            cell.page_control.currentPage = int-1
            
            
             
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

            cell.img_scroll_advertisement.isHidden = true
            
            var imgArray :NSMutableArray!=[];
            imgArray = ["logo.png", "logo.png"]
            
            let scroll_view_advertisement = UIScrollView()
            
               for i in 0..<2 {

                   let imageView = UIImageView()
                   imageView.image = UIImage(name)//(imgArray[i] as! UIImage)
                   let xPosition = self.view.frame.width * CGFloat(i)
                   imageView.frame = CGRect(x: xPosition, y: 0, width:
                                        scroll_view_advertisement.frame.width + 50, height: scroll_view_advertisement.frame.height)
                   
                   scroll_view_advertisement.contentSize.width = scroll_view_advertisement.frame.width * CGFloat(i + 1)
                   scroll_view_advertisement.addSubview(imageView)

                   // 20 , 8  377 , 108
             }*/
            
//            cell.img_scroll_advertisement.isHidden = true
            
//            let scroll_view_advertisement_2 = UIScrollView()
//            scroll_view_advertisement.backgroundColor = .clear
//
//            scroll_view_advertisement.frame =  CGRect(x: 20, y: 0, width:cell.frame.size.width-20, height: cell.frame.size.height-30)
//
//            scroll_view_advertisement.isPagingEnabled = true
//            scroll_view_advertisement.showsHorizontalScrollIndicator = true
//
//            cell.addSubview(scroll_view_advertisement)
//
//            let arr_adv_image = ["logo","logo","logo"]
//
//            for index in 0..<arr_adv_image.count {
//
//                let imageView = UIImageView()
//                if index == 1 {
//                    imageView.image = UIImage(named: "logo")
//                } else {
//                    imageView.image = UIImage(named: "logo")
//                }
////                imageView.image = UIImage(named: arr_adv_image[index])
//
//                imageView.frame =  CGRect(x: 0, y: 0, width:scroll_view_advertisement.frame.size.width, height: scroll_view_advertisement.frame.size.height)
//
//                imageView.backgroundColor = .systemPink
//                imageView.contentMode = .scaleToFill
//
//                scroll_view_advertisement.contentSize.width = scroll_view_advertisement.frame.width * CGFloat(index + 1)
//
//                scroll_view_advertisement.addSubview(imageView)
//            }
//
//            scroll_view_advertisement.delegate = self
            
            ///
            ///
//            scroll_view_advertisement_2.translatesAutoresizingMaskIntoConstraints = false
//            print(UIScreen.main.bounds.width)
            
            /*if (UIScreen.main.bounds.width == 375.0) {
                scroll_view_advertisement_2.frame =  CGRect(x: 20, y: 34, width:cell.frame.size.width-40, height: cell.frame.size.height-30-34)
            } else {
                scroll_view_advertisement_2.frame =  CGRect(x: 20, y: 34, width:cell.frame.size.width-40, height: cell.frame.size.height-30-34)
            }
            
            
            scroll_view_advertisement_2.backgroundColor = .clear
            scroll_view_advertisement_2.showsHorizontalScrollIndicator = false
            scroll_view_advertisement_2.isPagingEnabled = true
            cell.addSubview(scroll_view_advertisement_2)
            
            // print(self.dummy_image_knowledge);
            
            let arr_adv_image = ["banner1","banner2","banner3"]
            
            for index in 0..<arr_adv_image.count {

                frame.origin.x = scroll_view_advertisement_2.frame.size.width * CGFloat(index)    
                frame.size = scroll_view_advertisement_2.frame.size
                
                let imageView = UIImageView()
                imageView.image = UIImage(named: arr_adv_image[index])
                imageView.layer.cornerRadius = 12
                imageView.clipsToBounds = true
                imageView.frame = frame
                
                imageView.contentMode = .scaleToFill
                imageView.backgroundColor = .clear
                
                scroll_view_advertisement_2.contentSize.width = imageView.frame.width * CGFloat(index + 1)
                scroll_view_advertisement_2.addSubview(imageView)
                
            }
            
            scroll_view_advertisement_2.delegate = self*/
            
            // from storyboard
            // # 1
//            cell.scroll_view_advertisement_2.isPagingEnabled = true
//            cell.scroll_view_advertisement_2.showsHorizontalScrollIndicator = true
//
//            let arr_adv_image = ["banner1","banner2","banner3"]
//            for index in 0..<arr_adv_image.count {
//
//                frame.origin.x = cell.scroll_view_advertisement_2.frame.size.width * CGFloat(index)
//                frame.size = cell.scroll_view_advertisement_2.frame.size
//
//                cell.img_view_scroll_2.image = UIImage(named: arr_adv_image[index])
//                cell.img_view_scroll_2.contentMode = .scaleToFill
//
//                cell.scroll_view_advertisement_2.contentSize.width = cell.img_view_scroll_2.frame.width * CGFloat(index + 1)
//            }
//
//            cell.scroll_view_advertisement_2.delegate = self
            
            
            /*cell.scroll_view_advertisement_2.backgroundColor = .clear
            cell.scroll_view_advertisement_2.showsHorizontalScrollIndicator = false
            cell.scroll_view_advertisement_2.isPagingEnabled = true
            // cell.addSubview(cell.scroll_view_advertisement_2)
            
            // print(self.dummy_image_knowledge);
            
            let arr_adv_image = ["banner1","banner2","banner3"]
            
            for index in 0..<arr_adv_image.count {

                frame.origin.x = cell.scroll_view_advertisement_2.frame.size.width * CGFloat(index)
                frame.size = cell.scroll_view_advertisement_2.frame.size
                
//                let imageView = UIImageView()
                cell.img_view_scroll_2.image = UIImage(named: arr_adv_image[index])
                cell.img_view_scroll_2.layer.cornerRadius = 12
                cell.img_view_scroll_2.clipsToBounds = true
                cell.img_view_scroll_2.frame = frame
                
                cell.img_view_scroll_2.contentMode = .scaleToFill
                cell.img_view_scroll_2.backgroundColor = .clear
                
                cell.scroll_view_advertisement_2.contentSize.width = cell.img_view_scroll_2.frame.width * CGFloat(index + 1)
//                cell.scroll_view_advertisement_2.addSubview(imageView)
                
            }
            
            cell.scroll_view_advertisement_2.delegate = self*/
            
            
            cell.cl_view_adv.delegate = self
            cell.cl_view_adv.dataSource = self
            
            cell.page_control.currentPage = self.strIndex
            
            return cell
            
        } else if (item!["status"] as! String) == "subscribe" {
            
            let cell:v_home_table_cell = tableView.dequeueReusableCell(withIdentifier: "v_home_subscribe_table_cell") as! v_home_table_cell
            
            cell.backgroundColor = app_BG_color
            
            let backgroundView = UIView()
            backgroundView.backgroundColor = .clear
            cell.selectedBackgroundView = backgroundView
            
            cell.btn_subscribe.addTarget(self, action: #selector(subscribe_click_method_2), for: .touchUpInside)
            
            let stringValue = "Already Subscribed ? Login"
            
            let attText = NSMutableAttributedString(string: stringValue)
            attText.addAttribute(NSAttributedString.Key.foregroundColor, value: app_red_orange_mix_color, range: NSRange(
                location:21,
                length:5))
//                 attributedText = attText
            
            cell.lbl_already_subscribe.attributedText = attText
            
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

            let youtubeURL = URL(string: "https://www.instagram.com/reel/CenFI1LjP6A/?utm_source=ig_embed&ig_rid=603de0c2-5f0d-46f1-9ea7-eab345741915")
            cell.wv_webview.load( URLRequest(url: youtubeURL!) )
            cell.wv_webview.navigationDelegate = self
            
            cell.mywkwebviewConfig.allowsInlineMediaPlayback = true

            cell.btn_feeds_click.isHidden = true
            cell.btn_feeds_click.addTarget(self, action: #selector(feeds_click_method), for: .touchUpInside)
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
            cell.wv_webview.addGestureRecognizer(tap)
            
            
            
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
            
//            cell.calendar.selectionColor = UIColor.brown
            
            cell.calendar.scope = .month
            
            cell.btn_instagram.addTarget(self, action: #selector(instagram_click_method), for: .touchUpInside)
            cell.btn_facebook.addTarget(self, action: #selector(facebook_click_method), for: .touchUpInside)
            cell.btn_youtube.addTarget(self, action: #selector(youtube_click_method), for: .touchUpInside)
            cell.btn_linked_in.addTarget(self, action: #selector(linked_in_click_method), for: .touchUpInside)
            cell.btn_spotify.addTarget(self, action: #selector(spotify_click_method), for: .touchUpInside)
            
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
            
//            cell.img_scroll_banner.addtar
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
            cell.img_scroll_banner.isUserInteractionEnabled = true
            cell.img_scroll_banner.addGestureRecognizer(tapGestureRecognizer)
            
            
            
            
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
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        // handling code
        if let url = URL(string: "https://www.instagram.com/vedanta_vision/?hl=en") {
            UIApplication.shared.open(url)
        }
    }
    
    @objc func feeds_click_method() {
        
        if let url = URL(string: "https://www.instagram.com/vedanta_vision/?hl=en") {
            UIApplication.shared.open(url)
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
            
            return 200
            
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
    
    @IBOutlet weak var page_control:UIPageControl! {
        didSet {
             page_control.currentPage = 0
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
            btn_subscribe.layer.cornerRadius = 15
            btn_subscribe.clipsToBounds = true
            btn_subscribe.backgroundColor = app_red_orange_mix_color
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
    
    @IBOutlet weak var img_view_scroll_2:UIImageView! {
        didSet {
            img_view_scroll_2.backgroundColor = .clear
//            img_view_scroll_2.isHidden = true
        }
    }
    
    @IBOutlet weak var cl_view_adv:UICollectionView! {
        didSet {
            cl_view_adv.backgroundColor = .clear
            cl_view_adv.tag = 1212
            cl_view_adv.isScrollEnabled = true
            cl_view_adv.isPagingEnabled = true
            cl_view_adv.showsHorizontalScrollIndicator = false
        }
    }
    
    @IBOutlet weak var scroll_view_advertisement_2:UIScrollView! {
        didSet {
            scroll_view_advertisement_2.backgroundColor = .clear
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
    
    @IBOutlet weak var view_img_scroll_advertisement:UIView! {
        didSet {
            view_img_scroll_advertisement.isHidden = true
//            img_scroll_advertisement.layer.cornerRadius = 12
//            img_scroll_advertisement.clipsToBounds = true
//            scroll_view_advertisement.backgroundColor = .clear
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
    
    @IBOutlet weak var wv_webview: WKWebView!
    @IBOutlet weak var indicator_webview:UIActivityIndicatorView! {
        didSet {
            indicator_webview.isHidden = false
            indicator_webview.startAnimating()
            indicator_webview.color = app_red_orange_mix_color
        }
    }
    
    @IBOutlet weak var btn_feeds_click:UIButton!
    
    var mywkwebview: WKWebView?
    let mywkwebviewConfig = WKWebViewConfiguration()
    
    
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
            /*calendar.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            calendar.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            calendar.layer.shadowOpacity = 1.0
            calendar.layer.shadowRadius = 4
            calendar.layer.masksToBounds = false
            calendar.layer.cornerRadius = 22
            calendar.backgroundColor = .white*/
            // calendar.backgroundColor = .white
            
//            calendar.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
//            calendar.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
//            calendar.layer.shadowOpacity = 1.0
//            calendar.layer.shadowRadius = 8
//            calendar.layer.masksToBounds = false
//            calendar.layer.cornerRadius = 8
//            calendar.backgroundColor = .white
            
            calendar.dropShadow()
            
            calendar.appearance.headerTitleFont = UIFont(name: "Poppins-SemiBold", size: 18)
            // 38 33 107
            calendar.appearance.weekdayFont = UIFont(name: "Poppins-Regular", size: 14)
            calendar.appearance.weekdayTextColor = UIColor.init(red: 38.0/255.0, green: 34.0/255.0, blue: 108.0/255.0, alpha: 1)
            
            calendar.appearance.todayColor = app_red_orange_mix_color
             
            
            calendar.appearance.eventDefaultColor = app_red_orange_mix_color
//            calendar.appearance.borderColors = ["":UIColor.purple]
            
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
    
    @IBOutlet weak var btn_instagram:UIButton! {
        didSet {
            
        }
    }
    @IBOutlet weak var btn_facebook:UIButton! {
        didSet {
            
            
        }
    }
    @IBOutlet weak var btn_youtube:UIButton! {
        didSet {
            
        }
    }
    @IBOutlet weak var btn_linked_in:UIButton! {
        didSet {
            
        }
    }
    @IBOutlet weak var btn_spotify:UIButton! {
        didSet {
            
        }
    }
    
}

// collection view
extension v_home: UICollectionViewDataSource , UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView.tag == 3000 {
            return self.arr_mut_video_list.count
        } else if collectionView.tag == 2000 {
            return self.arr_social_list.count
        } else if collectionView.tag == 1212 {
            return 3
        } else {
            return self.arr_mut_category.count
        }
        
    }
    
//    func centerItemsInCollectionView(cellWidth: Double, numberOfItems: Double, spaceBetweenCell: Double, collectionView: UICollectionView) -> UIEdgeInsets {
//        let totalWidth = cellWidth * numberOfItems
//        let totalSpacingWidth = spaceBetweenCell * (numberOfItems - 1)
//        let leftInset = (collectionView.frame.width - CGFloat(totalWidth + totalSpacingWidth)) / 2
//        let rightInset = leftInset
//        return UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: rightInset)
//    }
    
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
            
//            cell.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
//            cell.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
//            cell.layer.shadowOpacity = 1.0
//            cell.layer.shadowRadius = 8
//            cell.layer.masksToBounds = false
//            cell.layer.cornerRadius = 8
//            cell.backgroundColor = .white
            
//            cell.backgroundColor = UIColor(red: 171/255, green: 178/255, blue: 186/255, alpha: 1.0)
            // Shadow Color and Radius
            
            
//            cell.layer.shadowColor = UIColor.lightGray.cgColor//UIColor(red: 226.0/255.0, green: 226.0/255.0, blue: 226.0/255.0, alpha: 1).cgColor
//            cell.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
//            cell.layer.shadowOpacity = 1.0
//            cell.layer.shadowRadius = 3.0
//            cell.layer.masksToBounds = false
//            cell.layer.cornerRadius = 12.0
            
            // cell.addBottomShadow()
            cell.dropShadow()
            
//            cell.layer.cornerRadius = 12
//            cell.clipsToBounds = true
//            cell.backgroundColor = .clear
            // print(self.arr_mut_video_list as Any)
            
            let item = self.arr_mut_video_list[indexPath.row] as? [String:Any]
            print(item as Any)
            
            cell.img_social_media.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
            cell.img_social_media.contentMode = .scaleAspectFit
            
            cell.img_social_media.sd_setImage(
                 with: URL(string: (item!["image"] as! String)),
                 placeholderImage: UIImage(named: "logo"),
                 options: SDWebImageOptions(rawValue: 0),
                 completed: { [] image, error, cacheType, imageURL in
//                              guard let selfNotNil = self else { return }
                              // your rest code
                     print("load")
                     cell.img_social_media.contentMode = .scaleToFill
                    }
            )
            

            
            
            
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
            
//            cell.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
//            cell.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
//            cell.layer.shadowOpacity = 1.0
//            cell.layer.shadowRadius = 8
//            cell.layer.masksToBounds = false
//            cell.layer.cornerRadius = 8
//            cell.backgroundColor = .white
            
            
//            cell.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
//            cell.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
//            cell.layer.shadowOpacity = 1.0
//            cell.layer.shadowRadius = 3.0
//            cell.layer.masksToBounds = false
//            cell.layer.cornerRadius = 12.0
            
            
            cell.dropShadow()
            
            
            let item = self.arr_mut_audio_list[indexPath.row] as? [String:Any]
            
//            cell.img_latest_audio.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
//            cell.img_latest_audio.sd_setImage(with: URL(string: (item!["image"] as! String)), placeholderImage: UIImage(named: "logo"))
            
            
            
            cell.img_latest_audio.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
            cell.img_latest_audio.contentMode = .scaleAspectFit
            
            cell.img_latest_audio.sd_setImage(
                 with: URL(string: (item!["image"] as! String)),
                 placeholderImage: UIImage(named: "logo"),
                 options: SDWebImageOptions(rawValue: 0),
                 completed: { [] image, error, cacheType, imageURL in
//                              guard let selfNotNil = self else { return }
                              // your rest code
                     print("load")
                     cell.img_latest_audio.contentMode = .scaleToFill
                    }
            )
            
            
            
            cell.lbl_latest_audio.text = (item!["title"] as! String)
            
            return cell
            
        } else if collectionView.tag == 5000 {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "v_home_collection_latest_article_view_cell", for: indexPath as IndexPath) as! v_home_collection_latest_article_view_cell
            
            cell.backgroundColor = app_BG_color
            
//            cell.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
//            cell.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
//            cell.layer.shadowOpacity = 1.0
//            cell.layer.shadowRadius = 8
//            cell.layer.masksToBounds = false
//            cell.layer.cornerRadius = 8
//            cell.backgroundColor = .white
            
//            cell.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
//            cell.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
//            cell.layer.shadowOpacity = 1.0
//            cell.layer.shadowRadius = 3.0
//            cell.layer.masksToBounds = false
//            cell.layer.cornerRadius = 12.0
            
            
            cell.dropShadow()
            
            
            let item = self.arr_article_list[indexPath.row] as? [String:Any]

//            cell.img_latest_article.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
//            cell.img_latest_article.sd_setImage(with: URL(string: (item!["image"] as! String)), placeholderImage: UIImage(named: "logo"))
            
            
            
            cell.img_latest_article.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
            cell.img_latest_article.contentMode = .scaleAspectFit
            
            cell.img_latest_article.sd_setImage(
                 with: URL(string: (item!["image"] as! String)),
                 placeholderImage: UIImage(named: "logo"),
                 options: SDWebImageOptions(rawValue: 0),
                 completed: { [] image, error, cacheType, imageURL in
//                              guard let selfNotNil = self else { return }
                              // your rest code
                     print("load")
                     cell.img_latest_article.contentMode = .scaleToFill
                    }
            )
            
            
            

            cell.lbl_latest_article.text = (item!["title"] as! String)
            
            return cell
            
        } else if collectionView.tag == 1212 {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "v_home_adv_cell", for: indexPath as IndexPath) as! v_home_adv_cell
            
            cell.backgroundColor = app_BG_color
            
//            cell.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
//            cell.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
//            cell.layer.shadowOpacity = 1.0
//            cell.layer.shadowRadius = 8
//            cell.layer.masksToBounds = false
//            cell.layer.cornerRadius = 8
//            cell.backgroundColor = .white
            
//            cell.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
//            cell.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
//            cell.layer.shadowOpacity = 1.0
//            cell.layer.shadowRadius = 3.0
//            cell.layer.masksToBounds = false
//            cell.layer.cornerRadius = 12.0
            
            
            cell.dropShadow()
            
//            let item = self.arr_article_list[indexPath.row] as? [String:Any]
            
            let imageView = UIImageView()
            
            if (indexPath.row == 0) {
                imageView.image = UIImage(named: "banner1")
            } else if (indexPath.row == 1) {
                imageView.image = UIImage(named: "banner2")
            } else {
                imageView.image = UIImage(named: "banner3")
            }
            
            imageView.layer.cornerRadius = 12
            imageView.clipsToBounds = true
            
//            imageView.autoresizingMask = UIViewAutoresizing.FlexibleBottomMargin | UIViewAutoresizing.FlexibleHeight | UIViewAutoresizing.FlexibleRightMargin | UIViewAutoresizing.FlexibleLeftMargin | UIViewAutoresizing.FlexibleTopMargin | UIViewAutoresizing.FlexibleWidth
//            imageView.contentMode = UIView.ContentMode.scaleAspectFit
            
            imageView.backgroundColor = .clear
            imageView.frame = CGRect(x: 0, y: 0, width:
                                        cell.frame.width, height: cell.frame.height)
            
            
            
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(advertisement_tapped(tapGestureRecognizer:)))
            imageView.tag = indexPath.row
            imageView.isUserInteractionEnabled = true
            imageView.addGestureRecognizer(tapGestureRecognizer)

            cell.addSubview(imageView)
            
            

//            cell.img_latest_article.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
//            cell.img_latest_article.sd_setImage(with: URL(string: (item!["image"] as! String)), placeholderImage: UIImage(named: "logo"))
//
//            cell.lbl_latest_article.text = (item!["title"] as! String)
            
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
            
//            let videoURL = URL(string: "https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4")
//            let player = AVPlayer(url: videoURL!)
//            let playerLayer = AVPlayerLayer(player: player)
//            playerLayer.frame = self.view.bounds
//            self.view.layer.addSublayer(playerLayer)
//            player.play()
            
            
            
            
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
            return CGSize(width: 80,height: 126)
        } else if collectionView.tag == 2000 {
            return CGSize(width: 50,height: 80)
        } else if collectionView.tag == 1212 {
            return CGSize(width: collectionView.frame.width,height: collectionView.frame.height)
        } else {
            return CGSize(width: 160,height: 120)
        }
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        if collectionView.tag == 1212 {
            return 0
        } else {
            return 20
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout
                        collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        if collectionView.tag == 1000 {
            return 10
        } else if collectionView.tag == 2000 {
            return 20
        } else if collectionView.tag == 1212 {
            return 0
        } else {
            return 20
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        if collectionView.tag == 1000 {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
        } else if collectionView.tag == 1212 {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        } else {
            return UIEdgeInsets(top: 0, left: 6, bottom: 0, right: 10)
        }
        
    }
    
}

class v_home_collection_view_cell: UICollectionViewCell {
    
    
    @IBOutlet weak var img_bhagwat_gita_list:UIImageView! {
        didSet {
            img_bhagwat_gita_list.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            img_bhagwat_gita_list.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            img_bhagwat_gita_list.layer.shadowOpacity = 1.0
            img_bhagwat_gita_list.layer.shadowRadius = 8
            img_bhagwat_gita_list.layer.masksToBounds = false
            img_bhagwat_gita_list.layer.cornerRadius = 8
            img_bhagwat_gita_list.backgroundColor = .white
            
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
            
            let path = UIBezierPath(roundedRect:img_social_media.bounds,
                                    byRoundingCorners:[.topRight, .topLeft],
                                    cornerRadii: CGSize(width: 14, height:  14))

            let maskLayer = CAShapeLayer()

            maskLayer.path = path.cgPath
            img_social_media.layer.mask = maskLayer
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
                                    cornerRadii: CGSize(width: 12, height:  12))

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

//
class v_home_adv_cell: UICollectionViewCell {
    
    @IBOutlet weak var img_adv:UIImageView! {
        didSet {
//            let path = UIBezierPath(roundedRect:img_latest_article.bounds,
//                                    byRoundingCorners:[.topRight, .topLeft],
//                                    cornerRadii: CGSize(width: 12, height:  12))
//
//            let maskLayer = CAShapeLayer()
//
//            maskLayer.path = path.cgPath
//            img_latest_article.layer.mask = maskLayer
        }
    }
    
   
    
    
    
    
}



// MARK: - COLLECTION CELL ( LATEST ARTICLES ) -
class v_home_collection_latest_article_view_cell: UICollectionViewCell {
    
    @IBOutlet weak var img_latest_article:UIImageView! {
        didSet {
            let path = UIBezierPath(roundedRect:img_latest_article.bounds,
                                    byRoundingCorners:[.topRight, .topLeft],
                                    cornerRadii: CGSize(width: 12, height:  12))

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



extension UIPanGestureRecognizer {

    func isLeft(theViewYouArePassing: UIView) -> Bool {
        let detectionLimit: CGFloat = 50
        var velocity : CGPoint = velocity(in: theViewYouArePassing)
        if velocity.x > detectionLimit {
            print("Gesture went right")
            return false
        } else if velocity.x < -detectionLimit {
            print("Gesture went left")
            return true
        }
        return true
    }
}

//extension UIView {
//func addBottomShadow() {
//    layer.masksToBounds = false
//    layer.shadowRadius = 4
//    layer.shadowOpacity = 1
//    layer.cornerRadius = 12
//    layer.shadowColor = UIColor.init(red: 164.0/255.0, green: 164.0/255.0, blue: 164.0/255.0, alpha: 1).cgColor
//    layer.shadowOffset = CGSize(width: 0 , height: 2)
//    layer.shadowPath = UIBezierPath(rect: CGRect(x: 0,
//                                                 y: bounds.maxY - layer.shadowRadius,
//                                                 width: bounds.width,
//                                                 height: layer.shadowRadius)).cgPath
//}
//}

extension v_home: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        print("Start loading")
        
        let indexPath = IndexPath.init(row: 6, section: 0)
        let cell = self.tble_view.cellForRow(at: indexPath) as! v_home_table_cell
        
        cell.indicator_webview.isHidden = false
        cell.indicator_webview.startAnimating()
        
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("End loading")
        
        let indexPath = IndexPath.init(row: 6, section: 0)
        let cell = self.tble_view.cellForRow(at: indexPath) as! v_home_table_cell
        
        cell.indicator_webview.isHidden = true
        cell.indicator_webview.stopAnimating()
        
    }
}
