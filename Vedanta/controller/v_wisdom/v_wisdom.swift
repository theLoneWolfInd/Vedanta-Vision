//
//  v_wisdom.swift
//  Vedanta
//
//  Created by Dishant Rajput on 14/09/22.
//

import UIKit
import Alamofire
import SDWebImage
import AVFoundation

struct wisdom_list_new: Encodable {
    let action: String
    let type:String
    let articleType:String
    let keyword:String
    let pageNo:Int
}

class v_wisdom: UIViewController, CustomSegmentedControlDelegate  , UITextFieldDelegate {

    var page : Int! = 1
    var loadMore : Int! = 1;
    
    var str_search:String!
    
    var str_title:String!
    
    var str_wisdom_title:String! = "Articles"
    
    var str_which_index:String!
    
    var cell_height_when_clicked:String! = "0"
    
    var arr_wisdom_list:NSMutableArray! = []
    
    var str_wisdom_click_status:String = "1"
    
    var selected_color = UIColor.init(red: 230.0/255.0, green: 40.0/255.0, blue: 36.0/255.0, alpha: 1)
    var de_selected_color = UIColor.init(red: 58.0/255.0, green: 59.0/255.0, blue: 60.0/255.0, alpha: 1)
    
    var player:AVPlayer!
    
    var str_img_audio_file_path:String!
    var str_img_audio_file:String!
    var str_audio_file_name:String!
    
    var str_one:String!
    var str_two:String!
    
    var str_click_panel = "1"
    
    @IBOutlet weak var lbl_navigation_title:UILabel! {
        didSet {
            
        }
    }
    
    @IBOutlet weak var btn_search:UIButton! {
        didSet {
            btn_search.tintColor = .black
            btn_search.isHidden = false
        }
    }
    
     
    
    @IBOutlet weak var view_full_view:UIView! {
        didSet {
            view_full_view.backgroundColor = UIColor.init(red: 246.0/255.0, green: 246.0/255.0, blue: 246.0/255.0, alpha: 1)
        }
    }
    
    @IBOutlet weak var txt_search:UITextField! {
        didSet {
//            txt_search.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
//            txt_search.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
//            txt_search.layer.shadowOpacity = 1.0
//            txt_search.layer.shadowRadius = 8
//            txt_search.layer.masksToBounds = false
//            txt_search.layer.cornerRadius = 8
//            txt_search.backgroundColor = .white
//            txt_search.setLeftPaddingPoints(12)
//            txt_search.placeholder = "search..."
            
            txt_search.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            txt_search.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            txt_search.layer.shadowOpacity = 1.0
            txt_search.layer.shadowRadius = 3.0
            txt_search.layer.masksToBounds = false
            txt_search.layer.cornerRadius = 4
            txt_search.backgroundColor = .white
            txt_search.setLeftPaddingPoints(12)
        }
    }
    
    
    @IBOutlet weak var btn_watch:UIButton! {
        didSet {
            btn_watch.layer.cornerRadius = 20
            btn_watch.clipsToBounds = true
            btn_watch.setTitle("Watch", for: .normal)
            btn_watch.setTitleColor(.white, for: .normal)
            btn_watch.backgroundColor = UIColor.init(red: 230.0/255.0, green: 40.0/255.0, blue: 36.0/255.0, alpha: 1)
        }
    }
    
    @IBOutlet weak var btn_listen:UIButton! {
        didSet {
            btn_listen.layer.cornerRadius = 20
            btn_listen.clipsToBounds = true
            btn_listen.setTitle("Listen", for: .normal)
            btn_listen.setTitleColor(.white, for: .normal)
            btn_listen.backgroundColor = UIColor.init(red: 58.0/255.0, green: 59.0/255.0, blue: 60.0/255.0, alpha: 1)
        }
    }
    @IBOutlet weak var btn_read:UIButton! {
        didSet {
            btn_read.layer.cornerRadius = 20
            btn_read.clipsToBounds = true
            btn_read.setTitle("Read", for: .normal)
            btn_read.setTitleColor(.white, for: .normal)
            btn_read.backgroundColor = UIColor.init(red: 58.0/255.0, green: 59.0/255.0, blue: 60.0/255.0, alpha: 1)
        }
    }
    
    @IBOutlet weak var tble_view:UITableView! {
        didSet {
            // tble_view.delegate = self
            // tble_view.dataSource = self
            tble_view.backgroundColor = .clear
        }
    }
    
    @IBOutlet weak var interfaceSegmented: CustomSegmentedControl! {
        didSet {
            interfaceSegmented.backgroundColor = .clear
            self.interfaceSegmented.setButtonTitles(buttonTitles: ["Music","Broadcast"])
            interfaceSegmented.selectorViewColor = UIColor.init(red: 22.0/255.0, green: 12.0/255.0, blue: 86.0/255.0, alpha: 1)
            interfaceSegmented.selectorTextColor = UIColor.init(red: 22.0/255.0, green: 12.0/255.0, blue: 86.0/255.0, alpha: 1)
            interfaceSegmented.isHidden = true
//            interfaceSegmented
        }
    }
    
    @IBOutlet weak var lbl_line:UILabel! {
        didSet {
            lbl_line.backgroundColor = UIColor.init(red: 216.0/255.0, green: 216.0/255.0, blue: 216.0/255.0, alpha: 1)
            lbl_line.isHidden = true
        }
    }
    
    // for listen music
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
    
    @IBOutlet weak var btn_back:UIButton! {
        didSet {
            btn_back.addTarget(self, action: #selector(back_click_method), for: .touchUpInside)
        }
    }
    
    @IBOutlet weak var indicators:UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.view_full_view.backgroundColor = app_BG_color
        self.tabBarController?.tabBar.backgroundColor = UIColor.init(red: 250.0/255.0, green: 250.0/255.0, blue: 255.0/255.0, alpha: 1)
        
        self.tble_view.separatorColor = .clear
        
        self.btn_watch.addTarget(self, action: #selector(watch_click_method), for: .touchUpInside)
        self.btn_listen.addTarget(self, action: #selector(listen_click_method), for: .touchUpInside)
        self.btn_read.addTarget(self, action: #selector(read_click_method), for: .touchUpInside)
        
        self.txt_search.delegate = self
        
        self.tble_view.frame =  CGRect(x: 0, y: 114, width:self.view.frame.size.width, height: self.view.frame.size.height-240)
        self.view_full_view.addSubview(self.tble_view)
         
        self.str_one = "1"
        self.str_two = ""
        
        self.wisdom_WB(str_type: String(self.str_wisdom_click_status),
                       str_article_type: String(""), page_number: 0)
        
        self.btn_search.addTarget(self, action: #selector(search_in_wisdom_WB), for: .touchUpInside)
        
        if self.str_search == "yes" {
            
            self.lbl_navigation_title.text = "Search"
            self.btn_back.isHidden = false
            self.txt_search.becomeFirstResponder()
            
        } else {
            
            self.lbl_navigation_title.text = "Wisdom"
            self.btn_back.isHidden = true
//            txt_search.becomeFirstResponder()
            
        }
        
    }
    
    @objc func watch_click_method() {
        
        //
        self.page = 1
        self.str_click_panel = "1"
        self.arr_wisdom_list.removeAllObjects()
        //
        
        
        
        
        self.view_music_player.isHidden = true
        self.player?.replaceCurrentItem(with: nil)
        
        self.cell_height_when_clicked = "0"
        
        self.str_wisdom_click_status = "1"
        
        self.btn_watch.backgroundColor = selected_color
        
        self.btn_listen.backgroundColor = de_selected_color
        self.btn_read.backgroundColor = de_selected_color
        
        self.interfaceSegmented.isHidden = true
        self.lbl_line.isHidden = true
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {

            self.tble_view.frame =  CGRect(x: 0, y: 114, width:self.view_full_view.frame.size.width, height: self.view_full_view.frame.size.height-114)
            
        }, completion: nil)
        
        self.view_full_view.addSubview(self.tble_view)
        
        self.str_one = "1"
        self.str_two = ""
        
        self.wisdom_WB(str_type: "1", str_article_type: "", page_number: 0)
    }
    
    @objc func listen_click_method() {
        
        //
        self.page = 1
        self.str_click_panel = "2"
        self.arr_wisdom_list.removeAllObjects()
        //
        
        
        self.cell_height_when_clicked = "0"
        
        self.str_wisdom_click_status = "2"
        
        self.btn_listen.backgroundColor = selected_color
        
        self.btn_watch.backgroundColor = de_selected_color
        self.btn_read.backgroundColor = de_selected_color
        
        
        self.interfaceSegmented.isHidden = false
        self.lbl_line.isHidden = false
        
        self.interfaceSegmented.backgroundColor = .white
        self.interfaceSegmented.setButtonTitles(buttonTitles: ["Music","Broadcast"])
        self.interfaceSegmented.delegate = self
//        self.interfaceSegmented.font = UIFont(name: "Poppins.Regular", size: 16.0)
        
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {

            self.tble_view.frame =  CGRect(x: 0, y: 174, width:self.view_full_view.frame.size.width, height: self.view_full_view.frame.size.height-174)
            
        }, completion: nil)
        
        
        self.view_full_view.addSubview(self.tble_view)
        
        self.str_one = "2"
        self.str_two = "1"
        
        self.wisdom_WB(str_type: "2", str_article_type: "1", page_number: 0)
    }
    
    @objc func read_click_method() {
        
        //
        self.page = 1
        self.str_click_panel = "3"
        self.arr_wisdom_list.removeAllObjects()
        //
        
        
        
        
        self.view_music_player.isHidden = true
        self.player?.replaceCurrentItem(with: nil)
        
        self.cell_height_when_clicked = "0"
        
        self.str_wisdom_click_status = "3"
        
        self.btn_read.backgroundColor = selected_color
        
        self.btn_listen.backgroundColor = de_selected_color
        self.btn_watch.backgroundColor = de_selected_color
        
        self.interfaceSegmented.isHidden = false
        self.lbl_line.isHidden = false
        
        self.interfaceSegmented.backgroundColor = .white
        self.interfaceSegmented.setButtonTitles(buttonTitles: ["Articles","Stories","Poems"])
        self.interfaceSegmented.delegate = self
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {

            self.tble_view.frame =  CGRect(x: 0, y: 166, width:self.view_full_view.frame.size.width, height: self.view_full_view.frame.size.height-166)
            
        }, completion: nil)
        
        self.view_full_view.addSubview(self.tble_view)
        
        self.str_one = "3"
        self.str_two = "1"
        
        self.wisdom_WB(str_type: "3", str_article_type: "1", page_number: 0)
        
    }
    
    func change(to index:Int) {
        
        
        
        print("segmentedControl index changed to \(index)")
        
        print(self.str_wisdom_click_status as Any)
        
        if String(self.str_wisdom_click_status) == "2" {
            
            //
            self.page = 1
            self.str_click_panel = "2"
            self.arr_wisdom_list.removeAllObjects()
            //
            
            if "\(index)" == "0" {
                
                self.str_one = "2"
                self.str_two = "1"
                
                self.wisdom_WB(str_type: "2", str_article_type: "1", page_number: 0)
                
            } else {
                
                self.str_one = "2"
                self.str_two = "2"
                
                self.wisdom_WB(str_type: "2", str_article_type: "2", page_number: 0)
                
            }
            
            
        } else if String(self.str_wisdom_click_status) == "3" {
            
            //
            self.page = 1
            self.str_click_panel = "3"
            self.arr_wisdom_list.removeAllObjects()
            //
            
            if "\(index)" == "0" {
                
                self.str_one = "3"
                self.str_two = "1"
                
                self.str_wisdom_title = "Articles"
                self.wisdom_WB(str_type: "3", str_article_type: "1", page_number: 0)
                
            } else if "\(index)" == "1" {
                
                self.str_one = "3"
                self.str_two = "2"
                
                self.str_wisdom_title = "Stories"
                self.wisdom_WB(str_type: "3", str_article_type: "2", page_number: 0)
                
            } else {
                
                self.str_one = "3"
                self.str_two = "3"
                
                self.str_wisdom_title = "Poems"
                self.wisdom_WB(str_type: "3", str_article_type: "3", page_number: 0)
                
            }
            
        } else {
            
        }
        
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        
        self.search_in_wisdom_WB()
        
        return true
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView == self.tble_view {
            let isReachingEnd = scrollView.contentOffset.y >= 0
            && scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height)
            if(isReachingEnd) {
                if(loadMore == 1) {
                    loadMore = 0
                    page += 1
                    print(page as Any)
                    
                    if (self.str_click_panel=="1") {
                        
                        self.wisdom_WB(str_type: String(self.str_wisdom_click_status),
                                       str_article_type: String(""),
                                       page_number: page)
                        
                    } else if (self.str_click_panel == "2") {
                        
                        self.wisdom_WB(str_type: "2",
                                       str_article_type: "1",
                                       page_number: page)
                        
                    }
                     
                    
                }
            }
        }
    }
    
    @objc func wisdom_WB(str_type:String , str_article_type:String,page_number:Int) {
        self.view.endEditing(true)
        
//        self.arr_wisdom_list.removeAllObjects()
        
        if page == 1 {
            ERProgressHud.sharedInstance.showDarkBackgroundView(withTitle: "Please wait...")
        }
        
        
        if IsInternetAvailable() == false {
            self.please_check_your_internet_connection()
            return
        }
        
        
        let parameters = wisdom_list_new(action: "wisdomist", type: String(str_type), articleType: String(str_article_type), keyword: "", pageNo: page_number)
         
        
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
                    print("=====> yes")
                    ERProgressHud.sharedInstance.hide()
                    
                    var ar : NSArray!
                    ar = (JSON["data"] as! Array<Any>) as NSArray
                    self.arr_wisdom_list.addObjects(from: ar as! [Any])
                    
                    self.tble_view.delegate = self
                    self.tble_view.dataSource = self
                    self.tble_view.reloadData()
                     self.loadMore = 1
                    
                } else {
                    
                    print("=====> no")
                    ERProgressHud.sharedInstance.hide()
                    
                    let alert = NewYorkAlertController(title: String(strSuccess), message: String(strSuccess2), style: .alert)
                    let cancel = NewYorkButton(title: "dismiss", style: .cancel)
                    alert.addButtons([cancel])
                    self.present(alert, animated: true)
                    
                }
                
            case let .failure(error):
                print(error)
                ERProgressHud.sharedInstance.hide()
                
                self.please_check_your_internet_connection()
                
            }
        }
        
        /*AF.request(application_base_url, method: .post, parameters: parameters)
        
            .response { response in
                
                do {
                    if response.error != nil{
                        print(response.error as Any, terminator: "")
                    }
                    
                    AF.request(application_base_url,
                               method: .post,
                               parameters: parameters,
                               encoder: JSONParameterEncoder.default).responseJSON { response in
                        
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
                            self.arr_wisdom_list.addObjects(from: ar as! [Any])
                            
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
    
    @objc func search_in_wisdom_WB() {
        self.view.endEditing(true)
        
        self.arr_wisdom_list.removeAllObjects()
        
        ERProgressHud.sharedInstance.showDarkBackgroundView(withTitle: "Please wait...")
        
        if IsInternetAvailable() == false {
            self.please_check_your_internet_connection()
            return
        }
        
        let parameters = [
            "action"        : "wisdomist",
            "type"          : String(self.str_one),
            "articleType"   : String(self.str_two),
            "keyword"       : String(self.txt_search.text!)
            
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
                            self.arr_wisdom_list.addObjects(from: ar as! [Any])
                            
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
    
    
    @objc func setup_voice_functionality(get_url:NSURL) {
        
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
    
    
    
}

extension v_wisdom : UITableViewDelegate , UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arr_wisdom_list.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:v_wisdom_table_cell = tableView.dequeueReusableCell(withIdentifier: "v_wisdom_table_cell") as! v_wisdom_table_cell
        
        cell.backgroundColor = .clear
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = .clear
        cell.selectedBackgroundView = backgroundView
        
        cell.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        cell.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        cell.layer.shadowOpacity = 1.0
        cell.layer.shadowRadius = 3.0
        cell.layer.masksToBounds = false
        cell.layer.cornerRadius = 12.0
        
        // print(self.arr_wisdom_list as Any)
        
        let item = self.arr_wisdom_list[indexPath.row] as? [String:Any]
        print(item as Any)
        
        if (item!["image"] as! String) == ""  {
            cell.img_view.image = UIImage(named: "logo")
            cell.img_view.contentMode = .scaleAspectFit
        } else {
            cell.img_view.contentMode = .scaleToFill
            cell.img_view.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
            cell.img_view.sd_setImage(with: URL(string: (item!["image"] as! String)), placeholderImage: UIImage(named: "logo"))
        }
        
        
        // let int_1 = (item!["question"] as! String).count
        // print(int_1)
        
//        let yourAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemRed, NSAttributedString.Key.font: UIFont(name: "Poppins-SemiBold", size: 16.0)!]
        let yourOtherAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont(name: "Poppins-Regular", size: 18.0)!]
        
        //let partOne = NSMutableAttributedString(string: (item!["title"] as! String)+"\n", attributes: yourAttributes)
        let partTwo = NSMutableAttributedString(string: (item!["description"] as! String), attributes: yourOtherAttributes)
        
        let combination = NSMutableAttributedString()
        
//        combination.append(partOne)
        combination.append(partTwo)
        
        cell.lbl_description.attributedText = combination
        
        // cell.lbl_description.text = (item!["description"] as! String)
        
        if "\(item!["Type"]!)" == "1" {
            
            // show video
            cell.btn_play.isHidden = false
            
        } else if "\(item!["Type"]!)" == "2" {
            
            // show audio
            cell.btn_play.isHidden = false
            
//            print(self.str_which_index as Any)
            
        } else {
            // show article
            cell.btn_play.isHidden = true
        }
        
        return cell
        
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
        
        self.player!.seek(to: targetTime)
        
        if self.player!.rate == 0 {
            self.player?.play()
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let item = self.arr_wisdom_list[indexPath.row] as? [String:Any]
        
        if "\(item!["Type"]!)" == "1" {
            // show video
            self.view_music_player.isHidden = true
            
            
            
            
            
            let item = self.arr_wisdom_list[indexPath.row] as? [String:Any]
            
            let push = self.storyboard?.instantiateViewController(withIdentifier: "wisdom_new_details_id") as! wisdom_new_details
            
            push.hidesBottomBarWhenPushed = false
            push.dict_wisdom_details = item as NSDictionary?
            
            push.str_one_one = String(self.str_one)
            push.str_one_two = String(self.str_two)
            
            self.navigationController?.pushViewController(push, animated: true)
            
            
            
            
            
            
            
            
            
            
            /*let pushVC = self.storyboard?.instantiateViewController(withIdentifier: "play_videos_id") as! play_videos
            
            pushVC.hidesBottomBarWhenPushed = true
            pushVC.str_video_link = (item!["Link"] as! String)
            pushVC.str_video_header = (item!["description"] as! String)
            
            self.navigationController?.pushViewController(pushVC, animated: true)*/
            
        } else if "\(item!["Type"]!)" == "2" {
            
            // show audio
            let item = self.arr_wisdom_list[indexPath.row] as? [String:Any]
            
            let push = self.storyboard?.instantiateViewController(withIdentifier: "wisdom_new_details_id") as! wisdom_new_details
            
            push.hidesBottomBarWhenPushed = false
            push.dict_wisdom_details = item as NSDictionary?
            
            /*
             self.str_one = "2"
             self.str_two = "1"
             */
            
            push.str_one_one = String(self.str_one)
            push.str_one_two = String(self.str_two)
            
            self.navigationController?.pushViewController(push, animated: true)
            
            
            /*let item = self.arr_wisdom_list[indexPath.row] as? [String:Any]
            
            let push = self.storyboard?.instantiateViewController(withIdentifier: "v_related_audio_id") as! v_related_audio
            
            push.hidesBottomBarWhenPushed = false
            push.dict_get_audio_data = item as NSDictionary?
            
            self.navigationController?.pushViewController(push, animated: true)*/
            
            
            
            
            
            
            
            
            /*self.view_music_player.isHidden = false
            
            self.player?.replaceCurrentItem(with: nil)
            
            self.str_img_audio_file_path = (item!["Link"] as! String)
            self.str_img_audio_file = (item!["image"] as! String)
            self.str_audio_file_name = (item!["description"] as! String)
            
            self.img_music_thumbnail.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
            self.img_music_thumbnail.sd_setImage(with: URL(string: String(self.str_img_audio_file)), placeholderImage: UIImage(named: "logo"))
            
            self.lbl_music_title.text = String(self.str_audio_file_name)
            
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {

                self.tble_view.frame =  CGRect(x: 0, y: 232, width:self.view_full_view.frame.size.width, height: self.view_full_view.frame.size.height)
                
            }, completion: nil)
            
            
            self.view_full_view.addSubview(self.tble_view)
            
            DispatchQueue.main.async(execute: {
                
                self.indicators.isHidden = false
                self.indicators.startAnimating()
                
                let url = URL(string: (item!["audioFile"] as! String))
                print(url as Any)
                
                self.setup_voice_functionality(get_url: url! as NSURL)
                
            })*/
            
        } else {
            
            // show article
//            self.view_music_player.isHidden = true
//
//            let pushVC = self.storyboard?.instantiateViewController(withIdentifier: "read_article_id") as! read_article
//
//            pushVC.str_navigation_title = String(self.str_wisdom_title)
//            pushVC.hidesBottomBarWhenPushed = true
//            pushVC.str_description = (item!["description"] as! String)
//
//            self.navigationController?.pushViewController(pushVC, animated: true)
            
            let item = self.arr_wisdom_list[indexPath.row] as? [String:Any]
            
            let push = self.storyboard?.instantiateViewController(withIdentifier: "wisdom_new_details_id") as! wisdom_new_details
            
            push.hidesBottomBarWhenPushed = false
            push.dict_wisdom_details = item as NSDictionary?
            
            print(String(self.str_one))
            print(String(self.str_two))
            
            push.str_one_one = String(self.str_one)
            push.str_one_two = String(self.str_two)
            
            self.navigationController?.pushViewController(push, animated: true)
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 128
    }
    
}

class v_wisdom_table_cell:UITableViewCell {
    
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
    
    @IBOutlet weak var lbl_description:UILabel! {
        didSet {
            lbl_description.textColor = .black
        }
    }
    
    @IBOutlet weak var btn_play:UIButton! {
        didSet {
            btn_play.isUserInteractionEnabled = false
        }
    }
    
    
    
    
}
