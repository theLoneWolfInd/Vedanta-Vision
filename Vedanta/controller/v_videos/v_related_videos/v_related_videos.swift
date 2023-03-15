//
//  v_related_videos.swift
//  Vedanta
//
//  Created by Dishant Rajput on 11/10/22.
//

import UIKit
import Alamofire
import SDWebImage
import AVFoundation
//"action"    : "videodetails",
//"videoId"   : String(self.str_and_my_id_is)
struct video_list: Encodable {
    let action: String
    let videoId:String
}

class v_related_videos: UIViewController {
    
    var dict_get_video_data:NSDictionary!
    
    var str_check_related_videos:String! = "0"
    
    var page : Int! = 1
    var loadMore : Int! = 1;
    
    var related_arr_mut_video_list:NSMutableArray! = []
    var arr_mut_video_list:NSMutableArray! = []
    
    
    var str_and_my_id_is:String!
    
    @IBOutlet weak var btn_share:UIButton!
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.view_full_view.backgroundColor = app_BG_color
        
        self.tble_view.separatorColor = .clear
        
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        self.btn_back.addTarget(self, action: #selector(back_click_method), for: .touchUpInside)
        
        self.btn_like.addTarget(self, action: #selector(like_click_method), for: .touchUpInside)
        
        self.btn_share.addTarget(self, action: #selector(share_some_data), for: .touchUpInside)
        
        self.create_custom_array()
    }
    
    @objc func create_custom_array() {
        
        print(dict_get_video_data as Any)
        
        /*
         Link = "https://youtu.be/P3HFtPABekM";
         Type = 1;
         categoryId = 20;
         created = "Oct 7th, 2022, 1:47 pm";
         description = "Transform Drudgery Into Dynamism with Vedanta! ";
         homePage = 1;
         image = "";
         title = "Transform Drudgery Into Dynamism with Vedanta! ";
         videoFile = "";
         videoId = 3;
         youLiked = No;
         */
        
        if (self.dict_get_video_data["youLiked"]) == nil {
            print("yes i am nil")
            
            // print()
            
            if (self.dict_get_video_data["audioId"]) == nil {
                self.str_and_my_id_is = "\(self.dict_get_video_data["videoId"]!)"
            } else {
                self.str_and_my_id_is = "\(self.dict_get_video_data["audioId"]!)"
            }
            
            
        } else {
            
            if "\(self.dict_get_video_data["youLiked"]!)" == "No" {
                
                self.btn_like.tag = 0
                self.btn_like.setImage(UIImage(systemName: "heart"), for: .normal)
                self.btn_like.tintColor = .black
                
            } else {
                
                self.btn_like.tag = 1
                self.btn_like.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                self.btn_like.tintColor = .systemPink
                
            }
            
            self.str_and_my_id_is = "\(self.dict_get_video_data["videoId"]!)"
            
        }
        
        
        
        self.video_list_WB(page_number: 1)

    }
    
    // MARK: - WEBSERVICE ( VIDEO LIST ) -
    @objc func video_list_WB(page_number:Int) {
        self.view.endEditing(true)
        
         
            
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
            
            let parameters = video_list(action: "videodetails", videoId: String(self.str_and_my_id_is)
            )
            
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
                                
                                var ar : NSArray!
                                ar = (JSON["relatedData"] as! Array<Any>) as NSArray
//                                print(ar as Any)
                                // self.related_arr_mut_video_list.addObjects(from: ar as! [Any])
                                
                                /*
                                 Link = "https://youtu.be/IpDC8ujskPM";
                                 Type = 1;
                                 categoryId = 36;
                                 created = "Oct 7th, 2022, 7:38 pm";
                                 description = "Is Lord Krishna's Message Relevant in Modern Times?";
                                 homePage = 0;
                                 image = "";
                                 title = "Is Lord Krishna's Message Relevant in Modern Times?";
                                 videoFile = "";
                                 videoId = 10;
                                 */
                                
                                print(self.dict_get_video_data as Any)
                                
                                var get_link:String!
                                
                                /*if (self.dict_get_video_data["Link"]) == nil {
                                    
                                    get_link = (self.dict_get_video_data["link"] as! String)
                                    
                                } else {
                                    
                                    get_link = (self.dict_get_video_data["Link"] as! String)
                                    
                                }
                                
                                if (self.dict_get_video_data["videoFile"]==nil) {
                                    get_link = (self.dict_get_video_data["link"] as! String)
                                } else {
                                    print(self.dict_get_video_data["videoFile"] as! String)
                                    get_link = (self.dict_get_video_data["videoFile"] as! String)
                                }*/
                                
                                
                                if (self.dict_get_video_data["Link"]) as! String == "" {
                                    get_link = (self.dict_get_video_data["videoFile"] as! String)
                                } else {
                                    get_link = (self.dict_get_video_data["Link"] as! String)
                                }
                                print(get_link as Any)
                                    
                                
                                
                                
                                
                                
                                
                                for indexx in 0...2 {
                                    
                                    if indexx == 0 {
                                        
                                        let custom_array = [
                                            "status"    : "header",
                                            "Type":"",
                                            "link"      : String(get_link),//String(get_link),
                                            "created"   : (self.dict_get_video_data["created"] as! String),
                                            "image"     : (self.dict_get_video_data["image"] as! String),
                                            "title"     : (self.dict_get_video_data["title"] as! String),
                                            "description"   : (self.dict_get_video_data["description"] as! String),
                                            "videoId"   : String(self.str_and_my_id_is),
                                            
                                        ]
                                        self.arr_mut_video_list.add(custom_array)
                                        
                                    } else if indexx == 1 {
                                        
                                        let custom_array = ["status"    : "title",
                                                            "Type":"",
                                                            "link"      : "",
                                                            "created"   : "",
                                                            "image"     : "",
                                                            "title"     : "",
                                                            "description"   : "",
                                                            "videoId"   : "",
                                        ]
                                        self.arr_mut_video_list.add(custom_array)
                                        
                                    }
                                    
                                }
                                
                                for indexx in 0..<ar.count {
                                    
                                    self.str_check_related_videos = "1"
                                    
                                    let item = ar[indexx] as? [String:Any]
                                    
                                    let custom_array = ["status"    : "list",
                                                        "Type":"\(item!["Type"]!)",
                                                        "link"      : (item!["Link"] as! String),
                                                        "created"   : (item!["created"] as! String),
                                                        "image"     : (item!["image"] as! String),
                                                        "title"     : (item!["title"] as! String),
                                                        "description"   : (item!["description"] as! String),
                                                        "videoId"   : String(self.str_and_my_id_is),
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
            
        
        /*
        if page_number == 1 {
            ERProgressHud.sharedInstance.showDarkBackgroundView(withTitle: "Please wait...")
        }
        
        
        if IsInternetAvailable() == false {
            self.please_check_your_internet_connection()
            return
        }
        
        let parameters = [
            "action"    : "videodetails",
            "videoId"   : String(self.str_and_my_id_is)
            
            
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
                            ar = (jsonDict["relatedData"] as! Array<Any>) as NSArray
                            print(ar as Any)
                            // self.related_arr_mut_video_list.addObjects(from: ar as! [Any])
                            
                            /*
                             Link = "https://youtu.be/IpDC8ujskPM";
                             Type = 1;
                             categoryId = 36;
                             created = "Oct 7th, 2022, 7:38 pm";
                             description = "Is Lord Krishna's Message Relevant in Modern Times?";
                             homePage = 0;
                             image = "";
                             title = "Is Lord Krishna's Message Relevant in Modern Times?";
                             videoFile = "";
                             videoId = 10;
                             */
                            
                            print(self.dict_get_video_data as Any)
                            
                            let get_link:String!
                            
                            if (self.dict_get_video_data["Link"]) == nil {
                                
                                get_link = (self.dict_get_video_data["link"] as! String)
                                
                            } else {
                                
                                get_link = (self.dict_get_video_data["Link"] as! String)
                                
                            }
                            
                            for indexx in 0...2 {
                                
                                if indexx == 0 {
                                    
                                    let custom_array = [
                                        "status"    : "header",
                                        "link"      : (self.dict_get_video_data["videoFile"] as! String),//String(get_link),
                                        "created"   : (self.dict_get_video_data["created"] as! String),
                                        "image"     : (self.dict_get_video_data["image"] as! String),
                                        "title"     : (self.dict_get_video_data["title"] as! String),
                                        "description"   : (self.dict_get_video_data["description"] as! String),
                                        "videoId"   : String(self.str_and_my_id_is),
                                        
                                    ]
                                    self.arr_mut_video_list.add(custom_array)
                                    
                                } else if indexx == 1 {
                                    
                                    let custom_array = ["status"    : "title",
                                                        "link"      : "",
                                                        "created"   : "",
                                                        "image"     : "",
                                                        "title"     : "",
                                                        "description"   : "",
                                                        "videoId"   : "",
                                    ]
                                    self.arr_mut_video_list.add(custom_array)
                                    
                                }
                                
                            }
                            
                            for indexx in 0..<ar.count {
                                
                                self.str_check_related_videos = "1"
                                
                                let item = ar[indexx] as? [String:Any]
                                
                                let custom_array = ["status"    : "list",
                                                    "link"      : (item!["Link"] as! String),
                                                    "created"   : (item!["created"] as! String),
                                                    "image"     : (item!["image"] as! String),
                                                    "title"     : (item!["title"] as! String),
                                                    "description"   : (item!["description"] as! String),
                                                    "videoId"   : String(self.str_and_my_id_is),
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
            }*/
    }
    
    
    
    @objc func like_click_method() {
        
        if let person = UserDefaults.standard.value(forKey: str_save_login_user_data) as? [String:Any] {
            // let str:String = person["role"] as! String
            print(person as Any)
            
             let x : Int = person["userId"] as! Int
             let myString = String(x)
            
            if self.btn_like.tag == 0 {
                
                self.btn_like.tag = 1
                self.btn_like.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                self.btn_like.tintColor = .systemPink
                
                self.like_unlike_status(str_user_id: String(myString),
                                        str_status: "1")
                
            } else {
                
                self.btn_like.tag = 0
                self.btn_like.setImage(UIImage(systemName: "heart"), for: .normal)
                self.btn_like.tintColor = .black
                
                self.like_unlike_status(str_user_id: String(myString),
                                        str_status: "0")
                
            }
            
            
        } else {
            
            let alert = NewYorkAlertController(title: String("Alert"), message: String("Please login to like this video."), style: .alert)
            
            let login = NewYorkButton(title: "login", style: .default) {
                _ in
                
                self.sign_in_click_method()
            }
            let cancel = NewYorkButton(title: "dismiss", style: .cancel)
            
            alert.addButtons([login , cancel])
            self.present(alert, animated: true)
            
        }
        
        
        
        
    }
    
    @objc func like_unlike_status(str_user_id:String , str_status:String) {
        self.view.endEditing(true)
                
        ERProgressHud.sharedInstance.showDarkBackgroundView(withTitle: "Please wait...")

        if IsInternetAvailable() == false {
            self.please_check_your_internet_connection()
            return
        }
        
        let parameters = [
            
            "action"        : "addfavourite",
            "participantId" : String(self.str_and_my_id_is),
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
                            
                            let userDefaults = UserDefaults.standard
                            userDefaults.set("refresh_page", forKey: "key_refresh_page")
                            
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
    
    @objc func share_some_data() {
        
        let text = (self.dict_get_video_data["title"] as! String)+"\n"+(self.dict_get_video_data["Link"] as! String)
        // let urlss = (self.dict_get_video_data["Link"] as! String)
        
        let textShare = [ text ]
        let activityViewController = UIActivityViewController(activityItems: textShare , applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
        
    }
    
}


extension v_related_videos : UITableViewDelegate , UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return self.arr_mut_video_list.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let item = self.arr_mut_video_list[indexPath.row] as? [String:Any]
        
        if (item!["status"] as! String) == "header" {
            
            let cell:v_related_videos_table_cell = tableView.dequeueReusableCell(withIdentifier: "v_related_videos_header_table_cell") as! v_related_videos_table_cell
            
            cell.backgroundColor = .clear
            
            let backgroundView = UIView()
            backgroundView.backgroundColor = .clear
            cell.selectedBackgroundView = backgroundView
            
            
            cell.img_view.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
            cell.img_view.sd_setImage(with: URL(string: (item!["image"] as! String)), placeholderImage: UIImage(named: "logo"))
            
            cell.lbl_header_date.text = (item!["created"] as! String)
            cell.lbl_header_description.text = (item!["description"] as! String)
            cell.lbl_header_video_title.text = (item!["title"] as! String)
            
            
            
            return cell
            
        } else if (item!["status"] as! String) == "title" {
            
            let cell:v_related_videos_table_cell = tableView.dequeueReusableCell(withIdentifier: "v_related_videos_title_table_cell") as! v_related_videos_table_cell
            
            cell.backgroundColor = .clear
            
            let backgroundView = UIView()
            backgroundView.backgroundColor = .clear
            cell.selectedBackgroundView = backgroundView
            
            cell.btn_see_more.addTarget(self, action: #selector(see_more_click_method), for: .touchUpInside) 
            
            return cell
            
        } else {
            
            let cell:v_related_videos_table_cell = tableView.dequeueReusableCell(withIdentifier: "v_related_videos_list_table_cell") as! v_related_videos_table_cell
            
            cell.backgroundColor = .clear
            
            let backgroundView = UIView()
            backgroundView.backgroundColor = .clear
            cell.selectedBackgroundView = backgroundView
            
            // print(self.related_arr_mut_video_list as Any)
            
            cell.img_view_list.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
            cell.img_view_list.sd_setImage(with: URL(string: (item!["image"] as! String)), placeholderImage: UIImage(named: "logo"))
            
            let yourAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemRed, NSAttributedString.Key.font: UIFont(name: "Poppins-SemiBold", size: 16.0)!]
            let yourOtherAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont(name: "Poppins-Regular", size: 14.0)!]
            
            let partOne = NSMutableAttributedString(string: (item!["title"] as! String)+"\n", attributes: yourAttributes)
            let partTwo = NSMutableAttributedString(string: (item!["description"] as! String), attributes: yourOtherAttributes)
            
            let combination = NSMutableAttributedString()
            
            combination.append(partOne)
            combination.append(partTwo)
            
            cell.lbl_list_description.attributedText = combination
            
            if (item!["Type"] as! String) == "2" {
                
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
                            
                            cell.btn_play.tintColor = .white
                            cell.btn_play.setImage(UIImage(systemName: "play"), for: .normal)
                            
                        } else {
                            
                            print("❌")
                            if (item!["Type"] as! String) == "1" {
                                
                                cell.btn_play.tintColor = .white
                                cell.btn_play.setImage(UIImage(systemName: "play"), for: .normal)
                                
                            } else {
                                
                                cell.btn_play.tintColor = .systemRed
                                cell.btn_play.setImage(UIImage(systemName: "lock"), for: .normal)
                                
                            }
                            
                        }
                        
                    } else {
                        
                        if (item!["Type"] as! String) == "1" {
                            
                            cell.btn_play.tintColor = .white
                            cell.btn_play.setImage(UIImage(systemName: "play"), for: .normal)
                            
                        } else {
                            
                            cell.btn_play.tintColor = .systemRed
                            cell.btn_play.setImage(UIImage(systemName: "lock"), for: .normal)
                            
                        }
                        
                    }
                    
                }
                
                
                
                
                
                
                
                
    //            cell.btn_play.isHidden = false
    //            cell.btn_play.tintColor = .systemRed
    //            cell.btn_play.setImage(UIImage(systemName: "lock"), for: .normal)
                
            } else {
                
                cell.btn_play.tintColor = .white
                cell.btn_play.setImage(UIImage(systemName: "play"), for: .normal)
                
            }
            
            return cell
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        let item = self.arr_mut_video_list[indexPath.row] as? [String:Any]
        
        if (item!["Type"] as! String) == "2" {
            
            
            
            if let person = UserDefaults.standard.value(forKey: str_save_login_user_data) as? [String:Any] {
                
                if (person["subscriptionDate"] as! String) == "" {
                    
                    let alert = NewYorkAlertController(title: String("Subscribe"), message: String("Please Subscribe to get access."), style: .alert)
                    
                    
                    let yes_subscribe = NewYorkButton(title: "Subscribe", style: .default) {
                        _ in
                    }
                    let cancel = NewYorkButton(title: "dismiss", style: .cancel)
                    
                    yes_subscribe.setDynamicColor(.pink)
                    
                    alert.addButtons([yes_subscribe,cancel])
                    self.present(alert, animated: true)
                    
                } else {
                    
//                    print(item)
                    
                    if (item!["Link"]) == nil {
                        self.push_to_video_screen(str_video_file_link: (item!["link"] as! String),
                                                  str_video_title: (item!["title"] as! String))
                    } else {
                        self.push_to_video_screen(str_video_file_link: (item!["Link"] as! String),
                                                  str_video_title: (item!["title"] as! String))
                    }
                    // Subscribe DONE , Play Video
                    
                    
                }
                
            } else {
                
                self.please_login_to_continue()
                
            }
            
            
            
        }
        
        else {
            
            print(item as Any)
            
            
                
                if (item!["link"] as! String) == "" {
                    
                    self.push_to_video_screen(str_video_file_link: (item!["videoFile"] as! String),
                                              str_video_title: (item!["title"] as! String))
                    
                } else {
                    
    
                    self.push_to_video_screen(str_video_file_link: (item!["link"] as! String),
                                              str_video_title: (item!["title"] as! String))
                    
                }
                
            
            
            
            
        }
        
        
        
        
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let item = self.arr_mut_video_list[indexPath.row] as? [String:Any]
        
        if (item!["status"] as! String) == "header" {
            return UITableView.automaticDimension
        } else if (item!["status"] as! String) == "title" {
            
            if self.str_check_related_videos == "0" {
                return 0
            } else {
                return 50
            }
            
        } else {
            return 130
        }
        
    }
    
}

class v_related_videos_table_cell:UITableViewCell {
    
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
    
    @IBOutlet weak var btn_see_more:UIButton!
    
    @IBOutlet weak var btn_play:UIButton! {
        didSet {
            btn_play.isUserInteractionEnabled = false
            btn_play.backgroundColor = .lightGray
            btn_play.tintColor = .white
            btn_play.layer.cornerRadius = 15
            btn_play.clipsToBounds = true
        }
    }
    
}
