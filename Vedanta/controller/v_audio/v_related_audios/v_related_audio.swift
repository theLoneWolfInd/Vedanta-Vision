//
//  v_related_audio.swift
//  Vedanta
//
//  Created by Dishant Rajput on 10/10/22.
//

import UIKit
import Alamofire
import SDWebImage
import AVFoundation

import AVKit

class v_related_audio: UIViewController {
    
    var player: AVPlayer!
    var playerViewController: AVPlayerViewController!
    
    var dict_get_audio_data:NSDictionary!
    
    var page : Int! = 1
    var loadMore : Int! = 1;
    
    var arr_mut_audio_list:NSMutableArray! = []
    
    var str_check_related_auidos:String! = "0"
    
     
    
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
    
    @IBOutlet weak var btn_like:UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.view_full_view.backgroundColor = app_BG_color
        
        self.tble_view.separatorColor = .clear
        self.tble_view.frame =  CGRect(x: 0, y: 8, width:self.view.frame.size.width, height: self.view.frame.size.height-110)
        self.view_full_view.addSubview(self.tble_view)
        
        self.btn_back.addTarget(self, action: #selector(back_click_method_22), for: .touchUpInside)
        self.btn_dismiss_music_player.addTarget(self, action: #selector(music_player_close_click_method), for: .touchUpInside)
        
        self.btn_like.addTarget(self, action: #selector(like_click_method), for: .touchUpInside)
        
        self.btn_share.addTarget(self, action: #selector(share_some_data), for: .touchUpInside)
        
//        do {
//            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [.mixWithOthers, .allowAirPlay])
//            print("Playback OK")
//            try AVAudioSession.sharedInstance().setActive(true)
//            print("Session is Active")
//        } catch {
//            print(error)
//        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.create_custom_array()
    }
    
    @objc func back_click_method_22() {
        self.navigationController?.popViewController(animated: true)
        // self.player?.replaceCurrentItem(with: nil)
    }
    
    @objc func create_custom_array() {
        
        // print(self.dict_get_audio_data as Any)
        
        if "\(self.dict_get_audio_data["youLiked"]!)" == "No" {
            
            self.btn_like.tag = 0
            self.btn_like.setImage(UIImage(systemName: "heart"), for: .normal)
            self.btn_like.tintColor = .black
            
        } else {
            
            self.btn_like.tag = 1
            self.btn_like.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            self.btn_like.tintColor = .systemPink
            
        }
        
        self.audio_list_WB(page_number: 1)
        
        /*for indexx in 0...9 {
        
            if indexx == 0 {
                
                let custom_array = ["status":"header"]
                self.arr_mut_audio_list.add(custom_array)
                
            } else if indexx == 1 {
                
                let custom_array = ["status":"title"]
                self.arr_mut_audio_list.add(custom_array)
                
            } else {
                
                let custom_array = ["status":"list"]
                self.arr_mut_audio_list.add(custom_array)
                
            }
            
        }
        
        
        self.tble_view.delegate = self
        self.tble_view.dataSource = self*/
        
    }

    /*func scrollViewDidScroll(_ scrollView: UIScrollView) {
                
        if scrollView == self.tble_view {
            let isReachingEnd = scrollView.contentOffset.y >= 0
                && scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height)
            if(isReachingEnd) {
                if(loadMore == 1) {
                    loadMore = 0
                    page += 1
                    print(page as Any)
                    
                    self.audio_list_WB(page_number: page)
                    
                }
            }
        }
    }*/
    
    // MARK: - WEBSERVICE ( AUDIO LIST ) -
    @objc func audio_list_WB(page_number:Int) {
        self.view.endEditing(true)
        
        ERProgressHud.sharedInstance.showDarkBackgroundView(withTitle: "Please wait...")
        
        if IsInternetAvailable() == false {
            self.please_check_your_internet_connection()
            return
        }
        
    // action: videolist
    // pageNo:
    // forHomePage: 1  //OPTIONAL
        
        let parameters = [
            "action"    : "audiodetails",
            "audioId"   : "\(self.dict_get_audio_data["audioId"]!)"
            
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
                            // self.related_arr_mut_audio_list.addObjects(from: ar as! [Any])
                            
                            /*
                             audioFile = "https://youtu.be/IpDC8ujskPM";
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
                            
//                             print(self.dict_get_audio_data);
                            for indexx in 0...2 {
                                
                                if indexx == 0 {
                                    print(self.dict_get_audio_data as Any)
                                    let custom_array = ["status"    : "header",
                                                        "Type":"",
                                                        "audioFile"      : (self.dict_get_audio_data["audioFile"] as! String),
                                                        "created"   : (self.dict_get_audio_data["created"] as! String),
                                                        "image"     : (self.dict_get_audio_data["image"] as! String),
                                                        "title"     : (self.dict_get_audio_data["title"] as! String),
                            "description"   : (self.dict_get_audio_data["description"] as! String),
                            "youLiked"   : (self.dict_get_audio_data["youLiked"] as! String),
                            "audioId"   : "\(self.dict_get_audio_data["audioId"]!)",
                                    ]
                                    self.arr_mut_audio_list.add(custom_array)
                                    
                                } else if indexx == 1 {
                                    
                                    let custom_array = ["status"    : "title",
                                                        "audioFile"      : "",
                                                        "Type":"",
                                                        "created"   : "",
                                                        "image"     : "",
                                                        "title"     : "",
                                                        "description"   : "",
                                                        "youLiked"   : "",
                                                        "audioId"   : ""
                                    ]
                                    self.arr_mut_audio_list.add(custom_array)
                                    
                                }
                                
                            }
                            
                            for indexx in 0..<ar.count {
                                
                                self.str_check_related_auidos = "1"
                                
                                let item = ar[indexx] as? [String:Any]
//                                print(item)
                                let custom_array = ["status"    : "list",
                                                    "Type":"\(item!["Type"]!)",
                                                    "audioFile"      : (item!["audioFile"] as! String),
                                                    "created"   : (item!["created"] as! String),
                                                    "image"     : (item!["image"] as! String),
                                                    "title"     : (item!["title"] as! String),
                                                    "description"   : (item!["description"] as! String),
                                                    "youLiked"   : (item!["youLiked"] as! String),
                                                    "audioId"   : "\(item!["audioId"]!)",
                                ]
                                self.arr_mut_audio_list.add(custom_array)
                                
                                
                            }
                            
                             // print(self.arr_mut_audio_list as Any)
                            
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
        
        if player!.rate == 0 {
            player?.play()
        }
        
    }
    
    @objc func finishedPlaying( _ myNotification:NSNotification) {
        print("dishant rajput called")
        
        self.player?.replaceCurrentItem(with: nil)
        self.btn_play.setImage(UIImage(systemName: "play.fill"), for: .normal)
        // self.playbackSlider.maximumValue = 0
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
            "participantId" : "\(self.dict_get_audio_data["audioId"]!)",
            "userId"        : String(str_user_id),
            "status"        : String(str_status),
            "type"          : "1"
            
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
        
        let text = (self.dict_get_audio_data["title"] as! String)+"\n"+(self.dict_get_audio_data["Link"] as! String)
        // let urlss = (self.dict_get_audio_data["Link"] as! String)
        
        let textShare = [ text  ]
        let activityViewController = UIActivityViewController(activityItems: textShare , applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
        
    }
    
}


extension v_related_audio : UITableViewDelegate , UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arr_mut_audio_list.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let item = self.arr_mut_audio_list[indexPath.row] as? [String:Any]
        
        if indexPath.row == 0 {
            
            let cell:v_related_audio_table_cell = tableView.dequeueReusableCell(withIdentifier: "v_related_audio_table_cell_1") as! v_related_audio_table_cell
            
            cell.backgroundColor = .clear
            
            let backgroundView = UIView()
            backgroundView.backgroundColor = .clear
            cell.selectedBackgroundView = backgroundView
            
            // let item = self.arr_mut_audio_list[0] as? [String:Any]
            
            cell.img_view.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
            cell.img_view.sd_setImage(with: URL(string: (item!["image"] as! String)), placeholderImage: UIImage(named: "logo"))
            
            cell.lbl_header_date.text = (item!["created"] as! String)
            // cell.lbl_list_description.text = (item!["description"] as! String)
            cell.lbl_header_description.text = (item!["description"] as! String)
            cell.lbl_header_video_title.text = (item!["title"] as! String)
            
            cell.custom_video_player.isHidden = true
            
            
            
            _ = Timer.scheduledTimer(withTimeInterval: 4, repeats: true) { timer in
                print("Timer fired!")

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
            
            return cell
            
        } else if indexPath.row == 1 {
            
            let cell:v_related_audio_table_cell = tableView.dequeueReusableCell(withIdentifier: "v_related_audio_table_cell_2") as! v_related_audio_table_cell
            
            cell.backgroundColor = .clear
            
            let backgroundView = UIView()
            backgroundView.backgroundColor = .clear
            cell.selectedBackgroundView = backgroundView
            
            cell.btn_see_more_audio.addTarget(self, action: #selector(see_more_audio_click_method), for: .touchUpInside)
            
            return cell
            
        } else {
            
            let cell:v_related_audio_table_cell = tableView.dequeueReusableCell(withIdentifier: "v_related_audio_table_cell_3") as! v_related_audio_table_cell
            
            cell.backgroundColor = .clear
            
            let backgroundView = UIView()
            backgroundView.backgroundColor = .clear
            cell.selectedBackgroundView = backgroundView
            
            cell.img_view_list.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
            cell.img_view_list.sd_setImage(with: URL(string: (item!["image"] as! String)), placeholderImage: UIImage(named: "logo"))
            
            let yourAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont(name: "Poppins-Regular", size: 16.0)!]
 
            let partOne = NSMutableAttributedString(string: (item!["title"] as! String)+"\n", attributes: yourAttributes)
 
            let combination = NSMutableAttributedString()
            
            combination.append(partOne)
 
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
        
        let item = self.arr_mut_audio_list[indexPath.row] as? [String:Any]
        
        if (item!["Type"] as! String) == "2"
        {
            
            if let person = UserDefaults.standard.value(forKey: str_save_login_user_data) as? [String:Any] {
                
                if (person["subscriptionDate"] as! String) == "" {
                    
                    let alert = NewYorkAlertController(title: String("Subscribe"), message: String("Please Subscribe to get access."), style: .alert)
                    
                    
                    let yes_subscribe = NewYorkButton(title: "Subscribe", style: .default) {
                        _ in
                        
                        self.subscribe_click_method()
                        
                    }
                    let cancel = NewYorkButton(title: "dismiss", style: .cancel)
                    
                    yes_subscribe.setDynamicColor(.pink)
                    
                    alert.addButtons([yes_subscribe,cancel])
                    self.present(alert, animated: true)
                    
                } else {
                    //
                    self.player?.replaceCurrentItem(with: nil)
                    //
                    let item = self.arr_mut_audio_list[indexPath.row] as? [String:Any]
                    print(item as Any)
                    
                    let push = self.storyboard?.instantiateViewController(withIdentifier: "v_related_audio_id") as! v_related_audio
                    
                    push.hidesBottomBarWhenPushed = false
                    push.dict_get_audio_data = item as NSDictionary?
                    
                    self.navigationController?.pushViewController(push, animated: true)
                    
                    /*// Subscribe DONE , Play Video
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
                    
                    
                    DispatchQueue.main.async(execute: {
                        
                        let url = URL(string: (item!["audioFile"] as! String))
                        print(url as Any)
                        
                        self.setup_voice_functionality(get_url: url! as NSURL)
                        
                    })*/
                    
                }
                
            } else {
                //
                self.player?.replaceCurrentItem(with: nil)
                //
                self.please_login_to_continue()
                
            }
            
            
            
        }
        
        else {
            
            
            if (indexPath.row == 0) {
                
            } else if (indexPath.row == 1) {
                
            } else {
                
                self.player?.replaceCurrentItem(with: nil)
                //
                let item = self.arr_mut_audio_list[indexPath.row] as? [String:Any]
                print(item as Any)
                
                let push = self.storyboard?.instantiateViewController(withIdentifier: "v_related_audio_id") as! v_related_audio
                
                push.hidesBottomBarWhenPushed = false
                push.dict_get_audio_data = item as NSDictionary?
                
                self.navigationController?.pushViewController(push, animated: true)
                
            }
            
            
            /*
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
            
            
            DispatchQueue.main.async(execute: {
                
                let url = URL(string: (item!["audioFile"] as! String))
                print(url as Any)
                
                self.setup_voice_functionality(get_url: url! as NSURL)
                
            })*/
            
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let item = self.arr_mut_audio_list[indexPath.row] as? [String:Any]
        
        if (item!["status"] as! String) == "header" {
            return UITableView.automaticDimension
        } else if (item!["status"] as! String) == "title" {
            return 34
//            if self.str_check_related_auidos == "0" {
//                return 0
//            } else {
//                return 50
//            }
            
        } else {
            return 130
        }
        
    }
    
}

class v_related_audio_table_cell:UITableViewCell {
    
    
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
    @IBOutlet weak var lbl_list_description:UILabel!
    
    
    @IBOutlet weak var btn_see_more_audio:UIButton!
    
    @IBOutlet weak var btn_play:UIButton! {
        didSet {
            btn_play.isUserInteractionEnabled = false
            btn_play.backgroundColor = .lightGray
            btn_play.tintColor = .white
            btn_play.layer.cornerRadius = 15
            btn_play.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var custom_video_player:UIView! {
        didSet {
            custom_video_player.backgroundColor = .clear
        }
    }
    
    
    @IBOutlet weak var view_bg1:UIView! {
        didSet {
            /*view_bg.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            view_bg.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            view_bg.layer.shadowOpacity = 1.0
            view_bg.layer.shadowRadius = 4
            view_bg.layer.masksToBounds = false
            view_bg.layer.cornerRadius = 8*/
            view_bg1.backgroundColor = .clear
        }
    }
    
    @IBOutlet weak var view_bg:UIView! {
        didSet {
            view_bg.backgroundColor = .white
            
            view_bg.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            view_bg.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            view_bg.layer.shadowOpacity = 1.0
            view_bg.layer.shadowRadius = 3.0
            view_bg.layer.masksToBounds = false
            view_bg.layer.cornerRadius = 12.0
        }
    }
    
    @IBOutlet weak var view_indicator:UIActivityIndicatorView! {
        didSet {
//            view_indicator.lar
            view_indicator.startAnimating()
            view_indicator.isHidden = false
        }
    }
    
}
