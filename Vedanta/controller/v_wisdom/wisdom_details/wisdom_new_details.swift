//
//  wisdom_new_details.swift
//  Vedanta
//
//  Created by Dishant Rajput on 02/11/22.
//

import UIKit
import Alamofire
import SDWebImage
import AVFoundation

import YouTubePlayer
import AVKit

struct wisdom_list: Encodable {
    let action: String
    let wisdomId:String
}

//DispensariesStoresProduct(action: "productlist",
//                                       storeId: String(""),
//                                       deal: String("1"),
//                                       pageNo: String("0"))
//
//
//
//"action"    : "wisdomdetail",
//"wisdomId"  : "\(self.dict_wisdom_details["wisdomId"]!)",

class wisdom_new_details: UIViewController {
    
    var page : Int! = 1
    var loadMore : Int! = 1;
    
    var dict_wisdom_details:NSDictionary!
    var arr_mut_video_list:NSMutableArray! = []

    var str_one_one:String!
    var str_one_two:String!
    
    var player: AVPlayer!
    var playerViewController: AVPlayerViewController!
    
    @IBOutlet weak var view_music_player:UIView! {
        didSet {
            view_music_player.isHidden = true
            
            view_music_player.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            view_music_player.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            view_music_player.layer.shadowOpacity = 1.0
            view_music_player.layer.shadowRadius = 4
            view_music_player.layer.masksToBounds = false
            view_music_player.layer.cornerRadius = 28
            view_music_player.backgroundColor = .white
        }
    }
    
    @IBOutlet weak var btn_dismiss_music_player:UIButton!
    
    @IBOutlet weak var img_music_thumbnail:UIImageView! {
        didSet {
            img_music_thumbnail.layer.cornerRadius = 20
            img_music_thumbnail.clipsToBounds = true
        }
    }
    
    
    
    @IBOutlet weak var lbl_music_title:UILabel! {
        didSet {
            lbl_music_title.textColor = .black
        }
    }
    
    @IBOutlet weak var playbackSlider: UISlider!
    
    @IBOutlet weak var lbl_over_all_time:UILabel! {
        didSet {
            lbl_over_all_time.text = "--"
            lbl_over_all_time.textColor = .black
        }
    }
    
    @IBOutlet weak var lbl_played_time:UILabel! {
        didSet {
            lbl_played_time.text = "--"
            lbl_played_time.textColor = .black
        }
    }
    
    @IBOutlet weak var btn_play:UIButton! {
        didSet {
            btn_play.isHidden = true
        }
    }
    @IBOutlet weak var indicators:UIActivityIndicatorView!
    
    @IBOutlet weak var btn_back:UIButton! {
        didSet {
            btn_back.tintColor = .black
        }
    }
    
    @IBOutlet weak var tble_view:UITableView! {
        didSet {
            
            tble_view.backgroundColor = .clear
        }
    }
    
    @IBOutlet weak var view_full_view:UIView! {
        didSet {
            view_full_view.backgroundColor = UIColor.init(red: 246.0/255.0, green: 246.0/255.0, blue: 246.0/255.0, alpha: 1)
        }
    }
    
    @IBOutlet weak var btn_like:UIButton!
    
    @IBOutlet weak var lbl_navigation_title:UILabel!
    
    @IBOutlet weak var btn_share:UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.view_full_view.backgroundColor = app_BG_color
        self.tabBarController?.tabBar.backgroundColor = UIColor.init(red: 250.0/255.0, green: 250.0/255.0, blue: 255.0/255.0, alpha: 1)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        self.tble_view.frame =  CGRect(x: 0, y: 0, width:self.view.frame.size.width, height: self.view.frame.size.height-130)
        self.view_full_view.addSubview(self.tble_view)
        
         print(self.str_one_one as Any)
         print(self.str_one_two as Any)
        
        // print(self.dict_wisdom_details as Any)
        
        if "\(self.dict_wisdom_details["Type"]!)" == "1" {
            self.lbl_navigation_title.text = "Video"
        } else if "\(self.dict_wisdom_details["Type"]!)" == "2" {
            self.lbl_navigation_title.text = "Audio"
        } else {
            // self.lbl_navigation_title.text = "Article"
            
            if String(self.str_one_two) == "1" {
                self.lbl_navigation_title.text = "Articles"
            } else if String(self.str_one_two) == "2" {
                self.lbl_navigation_title.text = "Stories"
            } else {
                self.lbl_navigation_title.text = "Poems"
            }
            
        }
        
        
        
        
        self.tble_view.separatorColor = .clear
        
        self.btn_back.addTarget(self, action: #selector(back_click_method_2), for: .touchUpInside)
        self.btn_share.addTarget(self, action: #selector(share_some_data), for: .touchUpInside)
        
        self.create_custom_array()
        
    }
    
    @objc func back_click_method_2() {
        self.player?.replaceCurrentItem(with: nil)
        
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
//        self.create_custom_array()
        
    }
    
    @objc func create_custom_array() {
        
        self.video_list_WB()
        
        /*if let person = UserDefaults.standard.value(forKey: str_save_login_user_data) as? [String:Any] {
            // let str:String = person["role"] as! String
            print(person as Any)
            
            
            self.video_list_WB(page_number: 1)
            
        } else {
            
            self.video_list_without_like_WB(page_number: 1)
        }*/
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
//        if scrollView == self.tble_view {
//            let isReachingEnd = scrollView.contentOffset.y >= 0
//            && scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height)
//            if(isReachingEnd) {
//                if(loadMore == 1) {
//                    loadMore = 0
//                    page += 1
//                    print(page as Any)
//
//                    self.video_list_WB(page_number: page)
//
//                }
//            }
//        }
        
    }
    
    // MARK: - WEBSERVICE ( VIDEO LIST ) -
    @objc func video_list_WB()
    {
        
        self.view.endEditing(true)
               
        self.arr_mut_video_list.removeAllObjects()
        
        ERProgressHud.sharedInstance.showDarkBackgroundView(withTitle: "Please wait...")

        if IsInternetAvailable() == false {
            self.please_check_your_internet_connection()
            return
        }
        
        ERProgressHud.sharedInstance.showDarkBackgroundView(withTitle: "Please wait...")
//        self.arrListOfAllMyOrders.removeAllObjects()
        
        self.view.endEditing(true)
        
        
        /*let x : Int = (dictGetCanabbiesItemDetails["id"] as! Int)
        let myString = String(x)*/
        
        let parameters = wisdom_list(action: "wisdomdetail",
                                     wisdomId: "\(self.dict_wisdom_details["wisdomId"]!)")
        
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
                        
                        // var strSuccess2 : String!
                        // strSuccess2 = JSON["msg"]as Any as? String
                        
                        if strSuccess == String("success") {
                            
                            print("=====> yes")
                            ERProgressHud.sharedInstance.hide()
                            
                            var dict: Dictionary<AnyHashable, Any>
                            dict = JSON["data"] as! Dictionary<AnyHashable, Any>
                            print(dict as Any)

                            var ar_2 : NSArray!
                            ar_2 = (JSON["RelatedData"] as! Array<Any>) as NSArray
                            print(ar_2 as Any)
                            
                            // self.arr_mut_ask_me.addObjects(from: ar as! [Any])
                            
                                /*
                                 Link = "";
                                 Type = 2;
                                 audioFile = "";
                                 created = "Oct 14th, 2022, 11:58 am";
                                 description = Recreation;
                                 homePage = 0;
                                 image = "";
                                 title = "Chapter 1";
                                 wisdomId = 21;
                                 */
                                
            let custom_array = ["Link"          : (dict["Link"] as! String),
                                "Type"          : "\(dict["Type"]!)",
                                "audioFile"     : "\(dict["audioFile"]!)",
                                "created"       : (dict["created"] as! String),
                                "description"   : (dict["description"] as! String),
                                "homePage"      : "\(dict["homePage"]!)",
                                "image"         : (dict["image"] as! String),
                                "title"         : (dict["title"] as! String),
                                "wisdomId"      : "\(dict["wisdomId"]!)",
                                                         
                                "status"        : "1",
                                                        
                                ]
                            self.arr_mut_video_list.add(custom_array)
                            
                            
                            
                            let custom_array_2 = ["Link"          : "",
                                                "Type"          : "",
                                                "audioFile"     : "",
                                                "created"       : "",
                                                "description"   : "",
                                                "homePage"      : "",
                                                "image"         : "",
                                                "title"         : "",
                                                "wisdomId"      : "",
                                                                         
                                                "status"        : "2",
                                                                        
                                                ]
                                            self.arr_mut_video_list.add(custom_array_2)

                            
                            
                            
                            for indexx in 0..<ar_2.count {
                                
                                let item = ar_2[indexx] as? [String:Any]
                                print(item as Any)
                                
                                let custom_array = ["Link"          : (item!["Link"] as! String),
                                                    "Type"          : "\(item!["Type"]!)",
                                                    "audioFile"     : "\(item!["audioFile"]!)",
                                                    "created"       : (item!["created"] as! String),
                                                    "description"   : (item!["description"] as! String),
                                                    "homePage"      : "\(item!["homePage"]!)",
                                                    "image"         : (item!["image"] as! String),
                                                    "title"         : (item!["title"] as! String),
                                                    "wisdomId"      : "\(item!["wisdomId"]!)",
                                                                             
                                                    "status"        : "3",
                                                                            
                                                    ]
                                                self.arr_mut_video_list.add(custom_array)
                                
                            }
                            
                            
                            print(self.arr_mut_video_list as Any)

                            self.tble_view.delegate = self
                            self.tble_view.dataSource = self
                            self.tble_view.reloadData()
                            self.loadMore = 1
                            
                        } else {
                            print("no")
                            ERProgressHud.sharedInstance.hide()
                            
//                            var strSuccess2 : String!
//                            strSuccess2 = JSON["msg"]as Any as? String
                            
//                            Utils.showAlert(alerttitle: String(strSuccess), alertmessage: String(strSuccess2), ButtonTitle: "Ok", viewController: self)
                            
                        }
                        
                    case let .failure(error):
                        print(error)
                        ERProgressHud.sharedInstance.hide()
                        
//                        Utils.showAlert(alerttitle: SERVER_ISSUE_TITLE, alertmessage: SERVER_ISSUE_MESSAGE, ButtonTitle: "Ok", viewController: self)
                    }
                   }
        
    }
    /*{
        self.view.endEditing(true)
               
        self.arr_mut_video_list.removeAllObjects()
        
        ERProgressHud.sharedInstance.showDarkBackgroundView(withTitle: "Please wait...")

        if IsInternetAvailable() == false {
            self.please_check_your_internet_connection()
            return
        }
         
            let parameters = [
                "action"    : "wisdomdetail",
                "wisdomId"  : "\(self.dict_wisdom_details["wisdomId"]!)",
//                "userId"        : String(myString),
//                "forHomePage"   : ""
                
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
                                
                                var dict: Dictionary<AnyHashable, Any>
                                dict = jsonDict["data"] as! Dictionary<AnyHashable, Any>
                                print(dict as Any)

                                var ar_2 : NSArray!
                                ar_2 = (jsonDict["RelatedData"] as! Array<Any>) as NSArray
                                print(ar_2 as Any)
                                
                                // self.arr_mut_ask_me.addObjects(from: ar as! [Any])
                                
                                    /*
                                     Link = "";
                                     Type = 2;
                                     audioFile = "";
                                     created = "Oct 14th, 2022, 11:58 am";
                                     description = Recreation;
                                     homePage = 0;
                                     image = "";
                                     title = "Chapter 1";
                                     wisdomId = 21;
                                     */
                                    
                let custom_array = ["Link"          : (dict["Link"] as! String),
                                    "Type"          : "\(dict["Type"]!)",
                                    "audioFile"     : "\(dict["audioFile"]!)",
                                    "created"       : (dict["created"] as! String),
                                    "description"   : (dict["description"] as! String),
                                    "homePage"      : "\(dict["homePage"]!)",
                                    "image"         : (dict["image"] as! String),
                                    "title"         : (dict["title"] as! String),
                                    "wisdomId"      : "\(dict["wisdomId"]!)",
                                                             
                                    "status"        : "1",
                                                            
                                    ]
                                self.arr_mut_video_list.add(custom_array)
                                
                                
                                
                                let custom_array_2 = ["Link"          : "",
                                                    "Type"          : "",
                                                    "audioFile"     : "",
                                                    "created"       : "",
                                                    "description"   : "",
                                                    "homePage"      : "",
                                                    "image"         : "",
                                                    "title"         : "",
                                                    "wisdomId"      : "",
                                                                             
                                                    "status"        : "2",
                                                                            
                                                    ]
                                                self.arr_mut_video_list.add(custom_array_2)

                                
                                
                                
                                for indexx in 0..<ar_2.count {
                                    
                                    let item = ar_2[indexx] as? [String:Any]
                                    print(item as Any)
                                    
                                    let custom_array = ["Link"          : (item!["Link"] as! String),
                                                        "Type"          : "\(item!["Type"]!)",
                                                        "audioFile"     : "\(item!["audioFile"]!)",
                                                        "created"       : (item!["created"] as! String),
                                                        "description"   : (item!["description"] as! String),
                                                        "homePage"      : "\(item!["homePage"]!)",
                                                        "image"         : (item!["image"] as! String),
                                                        "title"         : (item!["title"] as! String),
                                                        "wisdomId"      : "\(item!["wisdomId"]!)",
                                                                                 
                                                        "status"        : "3",
                                                                                
                                                        ]
                                                    self.arr_mut_video_list.add(custom_array)
                                    
                                }
                                
                                
                                print(self.arr_mut_video_list as Any)

                                self.tble_view.delegate = self
                                self.tble_view.dataSource = self
                                self.tble_view.reloadData()
                                self.loadMore = 1
                                
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
        //}
    }*/
    
    // MARK: - WEBSERVICE ( VIDEO LIST ) -
    @objc func video_list_without_like_WB(page_number:Int) {
        self.view.endEditing(true)
        
        if page_number == 1 {
            ERProgressHud.sharedInstance.showDarkBackgroundView(withTitle: "Please wait...")
        }
        
        
        if IsInternetAvailable() == false {
            self.please_check_your_internet_connection()
            return
        }
        
        // action: videolist
        // pageNo:
        // forHomePage: 1  //OPTIONAL
        
        let parameters = [
            "action"        : "videolist",
            "pageNo"        : page_number,
            
            "forHomePage"   : ""
            
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
                            
                            
                            for indexx in 0..<ar.count {
                                
                                let item = ar[indexx] as? [String:Any]
                                
                                /*
                                 Link = "https://youtu.be/ro4nbpLbBa0";
                                 Type = 2;
                                 categoryId = 36;
                                 created = "Oct 7th, 2022, 1:45 pm";
                                 description = "The World You See Is a Projection, Not a Creation";
                                 homePage = 1;
                                 image = "";
                                 title = "The World You See Is a Projection, Not a Creation";
                                 videoFile = "";
                                 videoId = 1;
                                 youLiked = Yes;
                                 */
                                
                                
                                if "\(item!["youLiked"]!)" == "No" {
                                    
                                    let custom_array = ["Link"      : (item!["Link"] as! String),
                                                        "Type"      : "\(item!["Type"]!)",
                                                        "categoryId"    : "\(item!["categoryId"]!)",
                                                        "created"   : (item!["created"] as! String),
                                                        "description"   : (item!["description"] as! String),
                                                        "homePage"  : "\(item!["homePage"]!)",
                                                        "image"     : (item!["image"] as! String),
                                                        "videoFile" : (item!["videoFile"] as! String),
                                                        "videoId"   : "\(item!["videoId"]!)",
                                                        "youLiked"  : (item!["youLiked"] as! String),
                                                        "title"     : (item!["title"] as! String),
                                                         
                                                        "status"    : "no",
                                                        
                                    ]
                                    self.arr_mut_video_list.add(custom_array)
                                    
                                } else {
                                    
                                    let custom_array = ["Link"      : (item!["Link"] as! String),
                                                        "Type"      : "\(item!["Type"]!)",
                                                        "categoryId"    : "\(item!["categoryId"]!)",
                                                        "created"   : (item!["created"] as! String),
                                                        "description"   : (item!["description"] as! String),
                                                        "homePage"  : "\(item!["homePage"]!)",
                                                        "image"     : (item!["image"] as! String),
                                                        "videoFile" : (item!["videoFile"] as! String),
                                                        "videoId"   : "\(item!["videoId"]!)",
                                                        "youLiked"  : (item!["youLiked"] as! String),
                                                        "title"     : (item!["title"] as! String),
                                                         
                                                        "status"    : "yes",
                                                        
                                    ]
                                    self.arr_mut_video_list.add(custom_array)
                                    
                                }
                                
                                
                                
                            }
                            
                            
                            // self.arr_mut_video_list.addObjects(from: ar as! [Any])
                            
                            
                            print(self.arr_mut_video_list as Any)
                            
                            
                            
                            self.tble_view.delegate = self
                            self.tble_view.dataSource = self
                            self.tble_view.reloadData()
                            self.loadMore = 1
                            
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
    
    @objc func like_click_method(_ sender:UIButton) {
        
        if let person = UserDefaults.standard.value(forKey: str_save_login_user_data) as? [String:Any] {
            // let str:String = person["role"] as! String
            print(person as Any)
            
            let x : Int = person["userId"] as! Int
            let myString = String(x)
            
            let item = self.arr_mut_video_list[sender.tag] as? [String:Any]
            print(item as Any)
            
            if "\(item!["youLiked"]!)" == "No" {
                self.arr_mut_video_list.removeObject(at: sender.tag)
                
                let custom_array = ["Link"      : (item!["Link"] as! String),
                                    "Type"      : "\(item!["Type"]!)",
                                    "categoryId"    : "\(item!["categoryId"]!)",
                                    "created"   : (item!["created"] as! String),
                                    "description"   : (item!["description"] as! String),
                                    "homePage"  : "\(item!["homePage"]!)",
                                    "image"     : (item!["image"] as! String),
                                    "videoFile" : (item!["videoFile"] as! String),
                                    "videoId"   : "\(item!["videoId"]!)",
                                    "youLiked"  : (item!["youLiked"] as! String),
                                    "title"     : (item!["title"] as! String),
                                     
                                    "status"    : "yes",
                                    
                ]
                
                self.arr_mut_video_list.insert(custom_array, at: sender.tag)
                
                self.like_unlike_status(str_video_id: "\(item!["videoId"]!)",
                                        str_user_id: String(myString),
                                        str_status: "1")
                
            } else {
                self.arr_mut_video_list.removeObject(at: sender.tag)
                
                let custom_array = ["Link"      : (item!["Link"] as! String),
                                    "Type"      : "\(item!["Type"]!)",
                                    "categoryId"    : "\(item!["categoryId"]!)",
                                    "created"   : (item!["created"] as! String),
                                    "description"   : (item!["description"] as! String),
                                    "homePage"  : "\(item!["homePage"]!)",
                                    "image"     : (item!["image"] as! String),
                                    "videoFile" : (item!["videoFile"] as! String),
                                    "videoId"   : "\(item!["videoId"]!)",
                                    "youLiked"  : (item!["youLiked"] as! String),
                                    "title"     : (item!["title"] as! String),
                                     
                                    "status"    : "no",
                                    
                ]
                
                self.arr_mut_video_list.insert(custom_array, at: sender.tag)
                
                self.like_unlike_status(str_video_id: "\(item!["videoId"]!)",
                                        str_user_id: String(myString),
                                        str_status: "0")
            }
            
            self.tble_view.reloadData()
            
        } else {
            
            let alert = NewYorkAlertController(title: String("Alert"), message: String("Please login to like this Video."), style: .alert)
            
            let login = NewYorkButton(title: "Login", style: .default) {
                _ in
                
                self.sign_in_click_method()
            }
            let cancel = NewYorkButton(title: "Dismiss", style: .cancel)
            
            alert.addButtons([login , cancel])
            self.present(alert, animated: true)
            
        }
        
        
        
        
    }
    
    @objc func like_unlike_status(str_video_id:String , str_user_id:String , str_status:String) {
        self.view.endEditing(true)
        
        // ERProgressHud.sharedInstance.showDarkBackgroundView(withTitle: "Please wait...")
        
        if IsInternetAvailable() == false {
            self.please_check_your_internet_connection()
            return
        }
        
        /*
         "action:addfavourite
         participantId:1
         userId:2
         status:1
         type:   1=Audio,2=Video,3=Article"
         */
        let parameters = [
            
            "action"        : "addfavourite",
            "participantId" : String(str_video_id),
            "userId"        : String(str_user_id),
            "status"        : String(str_status),
            "type"          : "2"
            
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
                            
                            // self.tble_view.reloadData()
                            // self.video_list_WB(page_number: 1)
                            
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
    
    // MARK: - DISMISS MUSIC PLAYER -
    @objc func music_player_close_click_method() {
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
            
            self.tble_view.frame =  CGRect(x: 0, y: 8, width:self.view_full_view.frame.size.width, height: self.view_full_view.frame.size.height)
            
            self.view_music_player.isHidden = true
            
        }, completion: nil)
        
    }
    
    @objc func setup_voice_functionality(get_url:NSURL) {
        
        // self.btn_speaker.tag = 0
        // self.btn_speaker.setImage(UIImage(systemName: "speaker.wave.2.fill"), for: .normal)
        
        print(get_url as Any)
        
        // speaker
        let recordingSession = AVAudioSession.sharedInstance()
        do {
            // Set the audio session category, mode, and options.
            try recordingSession.setCategory(.playAndRecord, mode: .default, options: [.defaultToSpeaker])
            try recordingSession.setActive(true)
        } catch {
            print("Failed to set audio session category.")
        }
        
        // player!.volume = 1.0
        
        // Add playback slider
        playbackSlider.minimumValue = 0
        
        playbackSlider.addTarget(self, action: #selector(v_audio.playbackSliderValueChanged(_:)), for: .valueChanged)
        
        // get ull
        let url = get_url
        
        let playerItem:AVPlayerItem = AVPlayerItem(url: url as URL)
        
        player = AVPlayer(playerItem: playerItem)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.finishedPlaying(_:)), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: playerItem)
        
        let duration : CMTime = playerItem.asset.duration
        let seconds : Float64 = CMTimeGetSeconds(duration)
        self.lbl_over_all_time.text = self.stringFromTimeInterval(interval: seconds)
        
        let duration1 : CMTime = playerItem.currentTime()
        let seconds1 : Float64 = CMTimeGetSeconds(duration1)
        self.lbl_played_time.text = self.stringFromTimeInterval(interval: seconds1)
        
        playbackSlider.maximumValue = Float(seconds)
        playbackSlider.isContinuous = true
        playbackSlider.tintColor = UIColor(red: 0.93, green: 0.74, blue: 0.00, alpha: 1.00)
        
        player!.addPeriodicTimeObserver(forInterval: CMTimeMakeWithSeconds(1, preferredTimescale: 1), queue: DispatchQueue.main) { (CMTime) -> Void in
            if self.player!.currentItem?.status == .readyToPlay {
                let time : Float64 = CMTimeGetSeconds(self.player!.currentTime());
                self.playbackSlider.value = Float ( time );
                
                self.lbl_played_time.text = self.stringFromTimeInterval(interval: time)
            }
            
            
            
        }
        
        _ =
        self.player?.currentItem?.isPlaybackLikelyToKeepUp
        
        print("Buffering completed")
        self.playbackSlider.isEnabled = true
        
        print(self.btn_play.tag as Any)
        
        self.indicators.isHidden = true
        self.indicators.stopAnimating()
        
        self.btn_play.isHidden = false
        
        // play audio
        self.btn_play.tag = 1
        self.btn_play.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        
        self.player!.play()
        
        
        self.btn_play.addTarget(self, action: #selector(play_audio_file), for: .touchUpInside)
        
    }
    
    // play audio file button
    @objc func play_audio_file() {
        
        if self.btn_play.tag == 1 {
            print("====> AUDIO PAUSE <=====")
            
            self.player!.pause()
            self.btn_play.setImage(UIImage(systemName: "play.fill"), for: .normal)
            
            self.btn_play.tag = 2
            
        } else {
            print("====> AUDIO PLAY <=====")
            
            self.player!.play()
            self.btn_play.setImage(UIImage(systemName: "pause.fill"), for: .normal)
            
            self.btn_play.tag = 1
        }
    }
    
    @objc func playbackSliderValueChanged(_ playbackSlider:UISlider) {
        let seconds : Int64 = Int64(playbackSlider.value)
        let targetTime:CMTime = CMTimeMake(value: seconds, timescale: 1)
        
        player!.seek(to: targetTime)
        
        if player!.rate == 0
        {
            player?.play()
        }
    }
    
    @objc func finishedPlaying( _ myNotification:NSNotification) {
        print("dishant rajput called")
        // self.btn_play.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        // ButtonPlay.setImage(UIImage(named: "ic_orchadio_play"), for: UIControl.State.normal)
        
    }
    
    func stringFromTimeInterval(interval: TimeInterval) -> String {
        
        let interval = Int(interval)
        let seconds = interval % 60
        let minutes = (interval / 60) % 60
        let hours = (interval / 3600)
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
    
    
    @objc func clear_audio_player_controller() {
        
        self.indicators.isHidden = false
        self.indicators.startAnimating()
        self.btn_play.isHidden = true
        
        self.lbl_played_time.text = "--"
        self.lbl_over_all_time.text = "--"
        
        self.playbackSlider.maximumValue = 0
        
        
        self.view_music_player.isHidden = false
        
    }
    
    @objc func tapFunction(sender:UITapGestureRecognizer) {
        print("tap working")
            
        let push = self.storyboard?.instantiateViewController(withIdentifier: "wisdom_sub_details_id") as! wisdom_sub_details
            
        push.hidesBottomBarWhenPushed = false

        print(self.str_one_one)
        print(self.str_one_two)
        
        push.str_one = String(self.str_one_one)
        push.str_two = String(self.str_one_two)
            
        self.navigationController?.pushViewController(push, animated: true)
            
        }
    
    
    @objc func share_some_data() {
        
        /*let text = (self.dict_wisdom_details["title"] as! String)
        let urlss = (self.dict_wisdom_details["Link"] as! String)
        
        let textShare = [ text , urlss ]
        let activityViewController = UIActivityViewController(activityItems: textShare , applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)*/
        
        
        let text = (self.dict_wisdom_details["title"] as! String)+"\n"+(self.dict_wisdom_details["Link"] as! String)
        // let image = UIImage(named: "Product")
        // let myWebsite = NSURL(string:(self.dict_wisdom_details["Link"] as! String))
        
        let shareAll = [text] as [Any]
        let activityViewController = UIActivityViewController(activityItems: shareAll, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
        
    }
    
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {

        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tble_view.cellForRow(at: indexPath) as! wisdom_new_details_table_cell
        
        cell.custom_video_player.isHidden = false
        let videoURL = URL(string: "https://app.vedantavision.org/img/uploads/wisdom/22_videoFile.mp4")
        self.player = AVPlayer(url: videoURL!)
        self.playerViewController = AVPlayerViewController()
        playerViewController.player = self.player
        playerViewController.view.frame = cell.custom_video_player.frame
        playerViewController.player?.pause()
        cell.custom_video_player.addSubview(playerViewController.view)
        
        
    }
    
}


extension wisdom_new_details : UITableViewDelegate , UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arr_mut_video_list.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // arr_mut_video_list
        
        // v_related_videos_list_table_cell
        
        let item = self.arr_mut_video_list[indexPath.row] as? [String:Any]
        print(item as Any)
        
        if (item!["status"] as! String) == "1" {
             
            let cell:wisdom_new_details_table_cell = tableView.dequeueReusableCell(withIdentifier: "wisdom_new_details_table_cell") as! wisdom_new_details_table_cell
            
            cell.backgroundColor = .clear
            
            let backgroundView = UIView()
            backgroundView.backgroundColor = .clear
            cell.selectedBackgroundView = backgroundView
            
            
//            cell.custom_video_player.isHidden = true
//            cell.videoPlayer.isHidden = true
            
            if (item!["image"] as! String) == ""  {
                cell.img_view.image = UIImage(named: "logo")
                cell.img_view.contentMode = .scaleAspectFit
            } else {
//                cell.img_view.contentMode = .scaleToFill
//                cell.img_view.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
//                cell.img_view.sd_setImage(with: URL(string: (item!["image"] as! String)), placeholderImage: UIImage(named: "logo"))
                
                
                cell.img_view.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
                cell.img_view.contentMode = .scaleAspectFit
                
                cell.img_view.sd_setImage(
                     with: URL(string: (item!["image"] as! String)),
                     placeholderImage: UIImage(named: "logo"),
                     options: SDWebImageOptions(rawValue: 0),
                     completed: { [] image, error, cacheType, imageURL in
    //                              guard let selfNotNil = self else { return }
                                  // your rest code
                         print("load")
                         cell.img_view.contentMode = .scaleToFill
                        }
                )
                
            }
            
            cell.lbl_header_video_title.text = (item!["title"] as! String)
            cell.lbl_header_description.text = (item!["description"] as! String)
            cell.lbl_header_description.lineBreakMode = .byWordWrapping
            cell.lbl_header_description.sizeToFit()
            
            
//            let yourAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemRed, NSAttributedString.Key.font: UIFont(name: "Poppins-SemiBold", size: 16.0)!]
            let yourOtherAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont(name: "Poppins-Regular", size: 16.0)!]
            
//            let partOne = NSMutableAttributedString(string: (item!["title"] as! String)+"\n", attributes: yourAttributes)
            let partTwo = NSMutableAttributedString(string: (item!["description"] as! String), attributes: yourOtherAttributes)
            
            let combination = NSMutableAttributedString()
            
//            combination.append(partOne)
            combination.append(partTwo)
            
            cell.lbl_header_description.attributedText = combination
            
            
            // date
            cell.lbl_header_date.text = (item!["created"] as! String)
            
            if (item!["status"] as! String) == "no" {

                self.btn_like.setImage(UIImage(systemName: "heart"), for: .normal)
                self.btn_like.tintColor = .black

            } else {

                self.btn_like.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                self.btn_like.tintColor = .systemPink

            }
            
            if (item!["Type"] as! String) == "1" || (item!["Type"] as! String) == "2" {
                
                cell.btn_play.isHidden = false
                cell.btn_play.tintColor = .white
                cell.btn_play.setImage(UIImage(systemName: "play"), for: .normal)
                
            } else {
                
                cell.btn_play.isHidden = true
                cell.btn_play.tintColor = .systemRed
                cell.btn_play.setImage(UIImage(systemName: "lock"), for: .normal)
                
            }
            
            
            // print(item as Any)
            // print(item!["Link"] as! String)
            
            // cell.view_indicator.isHidden = false
            // cell.view_indicator.startAnimating()
            
            if (item!["Type"] as! String) == "3" {
            
                cell.videoPlayer.isHidden = true
                cell.custom_video_player.isHidden = true
                
                cell.btn_play.isHidden = true
//                cell.view_indicator.isHidden = true
//                cell.view_indicator.startAnimating()
                
            } else {
                
                
                
                if (item!["Link"] as! String) == "" {
                    
                    cell.videoPlayer.isHidden = true
                    cell.custom_video_player.isHidden = true
                    
                    // cell.img_view.image = thumbnail
                    // cell.img_view.contentMode = .scaleAspectFill
                    cell.img_view.image = UIImage(named: "logo")
                    cell.img_view.contentMode = .scaleAspectFit
                    
                    
                    _ = Timer.scheduledTimer(withTimeInterval: 4, repeats: true) { timer in
                        print("Timer fired!")
                        
                        cell.btn_play.isHidden = true
//                        cell.view_indicator.isHidden = true
//                        cell.view_indicator.startAnimating()
                        cell.custom_video_player.isHidden = false
                        timer.invalidate()
                    }
                    
                    let videoURL = URL(string: (item!["audioFile"] as! String))
                    self.player = AVPlayer(url: videoURL!)
                    self.playerViewController = AVPlayerViewController()
                    playerViewController.player = self.player
                    playerViewController.view.frame = cell.custom_video_player.frame
                    playerViewController.player?.pause()
                    cell.custom_video_player.addSubview(playerViewController.view)
                    
                    
                } else {
                    
                    cell.btn_play.isHidden = true
//                    cell.view_indicator.isHidden = true
//                    cell.view_indicator.startAnimating()
                    
                    cell.custom_video_player.isHidden = true
                    // youtube
                    let myVideoURL = NSURL(string: (item!["Link"] as! String))
                    cell.videoPlayer.loadVideoURL(myVideoURL! as URL)
                    cell.videoPlayer.play()
                    
                }
                
            }
            
            
            
            // btn_play
            self.btn_like.isHidden = true
            self.btn_like.tag = indexPath.row
            self.btn_like.addTarget(self, action: #selector(like_click_method), for: .touchUpInside)
            
            return cell
            
        } else if (item!["status"] as! String) == "2" {
            
            let cell:wisdom_new_details_table_cell = tableView.dequeueReusableCell(withIdentifier: "two") as! wisdom_new_details_table_cell
            
            cell.backgroundColor = .clear
            
            let backgroundView = UIView()
            backgroundView.backgroundColor = .clear
            cell.selectedBackgroundView = backgroundView
            
            
            if "\(self.dict_wisdom_details["Type"]!)" == "1" {
                cell.lbl_related_mid.text = "Related Video"
            } else if "\(self.dict_wisdom_details["Type"]!)" == "2" {
                cell.lbl_related_mid.text = "Related Audio"
            } else {
                if String(self.str_one_two) == "1" {
                    // self.lbl_navigation_title.text = "Articles"
                    cell.lbl_related_mid.text = "Related Articles"
                } else if String(self.str_one_two) == "2" {
                    // self.lbl_navigation_title.text = "Stories"
                    cell.lbl_related_mid.text = "Related Stories"
                } else {
                    // self.lbl_navigation_title.text = "Poems"
                    cell.lbl_related_mid.text = "Related Poems"
                }
                
                
            }
            let tap = UITapGestureRecognizer(target: self, action: #selector(wisdom_new_details.tapFunction))
            cell.lbl_view_more.isUserInteractionEnabled = true
            cell.lbl_view_more.addGestureRecognizer(tap)
            
 
            return cell
            
        } else {
            
            let cell:wisdom_new_details_table_cell = tableView.dequeueReusableCell(withIdentifier: "three") as! wisdom_new_details_table_cell
            
            cell.backgroundColor = .clear
            
            let backgroundView = UIView()
            backgroundView.backgroundColor = .clear
            cell.selectedBackgroundView = backgroundView
            
            
//            print(item!["image"] as! String)
            if (item!["image"] as! String) == ""  {
                cell.img_view_list.image = UIImage(named: "logo")
                cell.img_view_list.contentMode = .scaleAspectFit
            } else {
               
                cell.img_view_list.contentMode = .scaleToFill
                cell.img_view_list.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
                cell.img_view_list.sd_setImage(with: URL(string: (item!["image"] as! String)), placeholderImage: UIImage(named: "logo"))
            }
            
            // cell.lbl_header_video_title.text = (item!["title"] as! String)
//            cell.lbl_list_description.text = (item!["description"] as! String)
            
            
//            let yourAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemRed, NSAttributedString.Key.font: UIFont(name: "Poppins-SemiBold", size: 16.0)!]
            let yourOtherAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont(name: "Poppins-Regular", size: 16.0)!]
            
//            let partOne = NSMutableAttributedString(string: (item!["title"] as! String)+"\n", attributes: yourAttributes)
            let partTwo = NSMutableAttributedString(string: (item!["description"] as! String), attributes: yourOtherAttributes)
            
            let combination = NSMutableAttributedString()
            
//            combination.append(partOne)
            combination.append(partTwo)
            
            cell.lbl_list_description.attributedText = combination
            
            
            
            /*if (item!["status"] as! String) == "no" {

                self.btn_like.setImage(UIImage(systemName: "heart"), for: .normal)
                self.btn_like.tintColor = .black

            } else {

                self.btn_like.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                self.btn_like.tintColor = .systemPink

            }
            
            if (item!["Type"] as! String) == "1" || (item!["Type"] as! String) == "2" {
                
                cell.btn_play.isHidden = false
                cell.btn_play.tintColor = .white
                cell.btn_play.setImage(UIImage(systemName: "play"), for: .normal)
                
            } else {
                
                cell.btn_play.isHidden = true
                cell.btn_play.tintColor = .systemRed
                cell.btn_play.setImage(UIImage(systemName: "lock"), for: .normal)
                
            }
            
            // btn_play
            
            self.btn_like.tag = indexPath.row
            self.btn_like.addTarget(self, action: #selector(like_click_method), for: .touchUpInside)*/
            
            return cell
        }
        
        
       
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        let item = self.arr_mut_video_list[indexPath.row] as? [String:Any]
        
        if (item!["Type"] as! String) == "2" { // audio
            
            if (item!["status"] as! String) == "1" {
                
                if (item!["audioFile"] as! String) == "" {
                    
                    let alert = NewYorkAlertController(title: String("Invalid Link"), message: String("Link is invalid. Please check and try again."), style: .alert)
                    let cancel = NewYorkButton(title: "Dismiss", style: .cancel)
                    alert.addButtons([cancel])
                    self.present(alert, animated: true)
                    
                } else {
                
                    self.player?.replaceCurrentItem(with: nil)
                    
                    UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
                        
                        self.tble_view.frame =  CGRect(x: 0, y: 120, width:self.view_full_view.frame.size.width, height: self.view_full_view.frame.size.height-114)
                        
                        self.view_music_player.isHidden = false
                        
                    }, completion: nil)
                    
                    
                    self.view_full_view.addSubview(self.tble_view)
                    
                    self.img_music_thumbnail.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
                    self.img_music_thumbnail.sd_setImage(with: URL(string: (item!["image"] as! String)), placeholderImage: UIImage(named: "logo"))
                    
                    self.lbl_music_title.text = (item!["title"] as! String)
                    
                    self.clear_audio_player_controller()
                    
                    print(item as Any)
                    
                    DispatchQueue.main.async(execute: {
                        
                        let url = URL(string: (item!["audioFile"] as! String))
                        print(url as Any)
                        
                        self.setup_voice_functionality(get_url: url! as NSURL)
                        
                    })
                    
                }
                
                
                
            } else if (item!["status"] as! String) == "3" {
                
                let item = self.arr_mut_video_list[indexPath.row] as? [String:Any]
                
                let push = self.storyboard?.instantiateViewController(withIdentifier: "wisdom_new_details_id") as! wisdom_new_details
                
                push.str_one_one = String(self.str_one_one)
                push.str_one_two = String(self.str_one_two)
                
                push.hidesBottomBarWhenPushed = false
                push.dict_wisdom_details = item as NSDictionary?
                
                self.navigationController?.pushViewController(push, animated: true)
                
            } else {
                
            }
            

        } else if (item!["Type"] as! String) == "1" { // video
            
            if (item!["status"] as! String) == "1" {
                
                print(item as Any)
                
                let item = self.arr_mut_video_list[indexPath.row] as? [String:Any]
                
                if (item!["Link"] as! String) == "" {
                    
                    self.push_to_video_screen(str_video_file_link: (item!["audioFile"] as! String),
                                                          str_video_title: (item!["title"] as! String))
                    
                } else {
                    
                    /*let indexPath = IndexPath.init(row: 0, section: 0)
                    let cell = self.tble_view.cellForRow(at: indexPath) as! wisdom_new_details_table_cell
                    
                    let myVideoURL = NSURL(string: (item!["Link"] as! String))
                    cell.videoPlayer.loadVideoURL(myVideoURL! as URL)
                    cell.videoPlayer.play()*/
                    
//                    self.push_to_video_screen(str_video_file_link: (item!["Link"] as! String),
//                                                          str_video_title: (item!["title"] as! String))
                    
                }
                
                
                
            } else if (item!["status"] as! String) == "3" {
                
                let item = self.arr_mut_video_list[indexPath.row] as? [String:Any]
                
                let push = self.storyboard?.instantiateViewController(withIdentifier: "wisdom_new_details_id") as! wisdom_new_details
                
                push.str_one_one = String(self.str_one_one)
                push.str_one_two = String(self.str_one_two)
                push.hidesBottomBarWhenPushed = false
                push.dict_wisdom_details = item as NSDictionary?
                
                self.navigationController?.pushViewController(push, animated: true)
                
            } else {
                
            }
            
            
        } else {
            
            if (item!["status"] as! String) == "1" {
                
                let item = self.arr_mut_video_list[indexPath.row] as? [String:Any]
                
                let pushVC = self.storyboard?.instantiateViewController(withIdentifier: "read_article_id") as! read_article
                
                pushVC.hidesBottomBarWhenPushed = false
                pushVC.str_description = (item!["description"] as! String)
                
                self.navigationController?.pushViewController(pushVC, animated: true)
                
            } else if (item!["status"] as! String) == "3" {
                
                let push = self.storyboard?.instantiateViewController(withIdentifier: "wisdom_new_details_id") as! wisdom_new_details
                
                push.hidesBottomBarWhenPushed = false
                push.dict_wisdom_details = item as NSDictionary?
                
                // print(self.str_one_one)
                // print(self.str_one_two)
                
                push.str_one_one = String(self.str_one_one)
                push.str_one_two = String(self.str_one_two)
                
                self.navigationController?.pushViewController(push, animated: true)
                
            } else {
                
            }
            
            
        }
        
            
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       
        let item = self.arr_mut_video_list[indexPath.row] as? [String:Any]
        
        if (item!["status"] as! String) == "1" {
            
            print(item as Any)
            
//            if ((item!["description"] as! String).count) <= 150 {
                return UITableView.automaticDimension
//            } else {
//                return 380
//            }
            
            
            
        } else if (item!["status"] as! String) == "2" {
            
            return 34
            
//            print(item as Any)
//
//            if ((item!["description"] as! String).count) >= 150 {
//                return UITableView.automaticDimension
//            } else {
//                return 50
//            }
            
            
            
        } else {
            return 130
        }
        
        
    }
    
}

class wisdom_new_details_table_cell:UITableViewCell {
    
    @IBOutlet weak var view_indicator:UIActivityIndicatorView! {
        didSet {
//            view_indicator.lar
            view_indicator.startAnimating()
            view_indicator.isHidden = false
        }
    }
    
    @IBOutlet weak var custom_video_player:UIView! {
        didSet {
            custom_video_player.backgroundColor = .clear
//            let path = UIBezierPath(roundedRect:custom_video_player.bounds,
//                                    byRoundingCorners:[.topRight, .topLeft],
//                                    cornerRadii: CGSize(width: 12, height:  12))
//
//            let maskLayer = CAShapeLayer()
//
//            maskLayer.path = path.cgPath
//            custom_video_player.layer.mask = maskLayer
            
//            custom_video_player.roundCorners(corners: [.topLeft, .topRight])
            
        }
    }
    @IBOutlet var videoPlayer: YouTubePlayerView! {
        didSet {
            videoPlayer.backgroundColor = .clear
//            let path = UIBezierPath(roundedRect:videoPlayer.bounds,
//                                    byRoundingCorners:[.topRight, .topLeft],
//                                    cornerRadii: CGSize(width: 12, height:  12))
//
//            let maskLayer = CAShapeLayer()
//
//            maskLayer.path = path.cgPath
//            videoPlayer.layer.mask = maskLayer
            
//            videoPlayer.roundCorners(corners: [.topLeft, .topRight])
            
        }
    }
   
    
    @IBOutlet weak var view_bg:UIView! {
        didSet {
//            view_bg.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
//            view_bg.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
//            view_bg.layer.shadowOpacity = 1.0
//            view_bg.layer.shadowRadius = 4
//            view_bg.layer.masksToBounds = false
//            view_bg.layer.cornerRadius = 8
            view_bg.backgroundColor = .white
            
            view_bg.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            view_bg.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            view_bg.layer.shadowOpacity = 1.0
            view_bg.layer.shadowRadius = 3.0
            view_bg.layer.masksToBounds = false
            view_bg.layer.cornerRadius = 12.0
            
        }
    }
    
    @IBOutlet weak var view_bg1:UIView! {
        didSet {
            view_bg1.backgroundColor = .clear
        }
    }
    
    @IBOutlet weak var img_view:UIImageView! {
        didSet {
            img_view.layer.cornerRadius = 8
            img_view.clipsToBounds = true
            img_view.backgroundColor = UIColor.init(red: 208.0/255.0, green: 208.0/255.0, blue: 208.0/255.0, alpha: 1)
        }
    }
    
    @IBOutlet weak var lbl_header_video_title:UILabel!
    @IBOutlet weak var lbl_header_date:UILabel!
    @IBOutlet weak var lbl_header_description:UILabel! {
        didSet {
            lbl_header_description.text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."
        }
    }
    
    @IBOutlet weak var img_view_list:UIImageView! {
        didSet {
            img_view_list.layer.cornerRadius = 8
            img_view_list.clipsToBounds = true
            img_view_list.backgroundColor = UIColor.init(red: 208.0/255.0, green: 208.0/255.0, blue: 208.0/255.0, alpha: 1)
        }
    }
    
    @IBOutlet weak var lbl_title:UILabel!
    @IBOutlet weak var lbl_list_description:UILabel!
    
    @IBOutlet weak var btn_like:UIButton!
    
    @IBOutlet weak var btn_play:UIButton! {
        didSet {
            btn_play.isUserInteractionEnabled = false
            btn_play.backgroundColor = .lightGray
            btn_play.tintColor = .white
            btn_play.layer.cornerRadius = 15
            btn_play.clipsToBounds = true
            btn_play.isHidden = true
        }
    }
    
    @IBOutlet weak var lbl_view_more:UILabel!
    
    @IBOutlet weak var lbl_related_mid:UILabel!
    
}
