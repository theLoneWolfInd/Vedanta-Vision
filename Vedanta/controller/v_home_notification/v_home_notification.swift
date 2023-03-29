//
//  v_home_notification.swift
//  Vedanta
//
//  Created by Dishant Rajput on 14/09/22.
//

import UIKit
import Alamofire
import SDWebImage
import AVFoundation

class v_home_notification: UIViewController {
    
    var page : Int! = 1
    var loadMore : Int! = 1;
    
    var player:AVPlayer!
    
    var arr_notification_list:NSMutableArray! = []
    
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
        
        self.tble_view.frame =  CGRect(x: 0, y: 8, width:self.view.frame.size.width, height: self.view.frame.size.height-120)
        self.view_full_view.addSubview(self.tble_view)
        
        self.tble_view.separatorColor = .clear
        
        self.btn_back.addTarget(self, action: #selector(back_click_method_2), for: .touchUpInside)
        
        
        self.validate_before_notification()
        
    }
    
    @objc func back_click_method_2() {
        
        self.navigationController?.popViewController(animated:true)
        self.player?.replaceCurrentItem(with: nil)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        
        
    }
    
    @objc func validate_before_notification() {
        
        if let person = UserDefaults.standard.value(forKey: str_save_login_user_data) as? [String:Any] {
            
            print(person as Any)
            
            
            // notification_Setting_event
            // notification_Setting_article
            // notification_Setting_quotes
            // notification_Setting_video
            // notification_Setting_audio
            
            var str_audio:String! = ""
            
            if "\(person["notification_Setting_audio"]!)" == "1" {
                str_audio = "1,"
            } else {
                str_audio = ""
            }
            
            // video
            var str_video:String! = ""
            
            if "\(person["notification_Setting_video"]!)" == "1" {
                str_video = "2,"
            } else {
                str_video = ""
            }
            
            // article
            var str_article:String! = ""
            
            if "\(person["notification_Setting_article"]!)" == "1" {
                str_article = "3,"
            } else {
                str_article = ""
            }
            
            // quotes
            var str_quot:String! = ""
            
            if "\(person["notification_Setting_quotes"]!)" == "1" {
                str_quot = "4,"
            } else {
                str_quot = ""
            }
            
            // events
            var str_event:String! = ""
            
            if "\(person["notification_Setting_quotes"]!)" == "1" {
                str_event = "5"
            } else {
                str_event = ""
            }
            
            self.notification_list_WB(str_get_audio: String(str_audio),
                                      str_get_video: String(str_video),
                                      str_get_article: String(str_article),
                                      str_get_quot: String(str_quot),
                                      str_events: String(str_event), page_number: 1)
            
        } else {
            
            self.notification_list_WB(str_get_audio: "1",
                                      str_get_video: "2",
                                      str_get_article: "3",
                                      str_get_quot: "4",
                                      str_events: "5", page_number: 1)
            
        }
        
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
                    
                    if let person = UserDefaults.standard.value(forKey: str_save_login_user_data) as? [String:Any] {
                        
                        print(person as Any)
                        
                        
                        // notification_Setting_event
                        // notification_Setting_article
                        // notification_Setting_quotes
                        // notification_Setting_video
                        // notification_Setting_audio
                        
                        var str_audio:String! = ""
                        
                        if "\(person["notification_Setting_audio"]!)" == "1" {
                            str_audio = "1,"
                        } else {
                            str_audio = ""
                        }
                        
                        // video
                        var str_video:String! = ""
                        
                        if "\(person["notification_Setting_video"]!)" == "1" {
                            str_video = "2,"
                        } else {
                            str_video = ""
                        }
                        
                        // article
                        var str_article:String! = ""
                        
                        if "\(person["notification_Setting_article"]!)" == "1" {
                            str_article = "3,"
                        } else {
                            str_article = ""
                        }
                        
                        // quotes
                        var str_quot:String! = ""
                        
                        if "\(person["notification_Setting_quotes"]!)" == "1" {
                            str_quot = "4,"
                        } else {
                            str_quot = ""
                        }
                        
                        // events
                        var str_event:String! = ""
                        
                        if "\(person["notification_Setting_quotes"]!)" == "1" {
                            str_event = "5"
                        } else {
                            str_event = ""
                        }
                        
                        self.notification_list_WB(str_get_audio: String(str_audio),
                                                  str_get_video: String(str_video),
                                                  str_get_article: String(str_article),
                                                  str_get_quot: String(str_quot),
                                                  str_events: String(str_event), page_number: page)
                        
                    } else {
                        
                        self.notification_list_WB(str_get_audio: "1",
                                                  str_get_video: "2",
                                                  str_get_article: "3",
                                                  str_get_quot: "4",
                                                  str_events: "5", page_number: page)
                        
                    }
                    
                }
            }
        }
    }
    
    @objc func notification_list_WB(str_get_audio:String,
                                    str_get_video:String,
                                    str_get_article:String,
                                    str_get_quot:String,
                                    str_events:String,page_number:Int) {
        self.view.endEditing(true)
        
//        self.arr_notification_list.removeAllObjects()
        
        ERProgressHud.sharedInstance.showDarkBackgroundView(withTitle: "Please wait...")
        
        if IsInternetAvailable() == false {
            self.please_check_your_internet_connection()
            return
        }
        
        if let person = UserDefaults.standard.value(forKey: str_save_login_user_data) as? [String:Any] {
            // let str:String = person["role"] as! String
            print(person as Any)
        let parameters = [
            
            "action"            : "notificationlist",
            "notificationType"  : str_get_audio+str_get_video+str_get_article+str_get_quot+str_events,
            "created"           : (person["created"] as! String),
            "pageNo"            : page_number,
            
        ] as [String : Any]
        
        print(parameters as Any)
        
        AF.request(application_base_url, method: .post, parameters: parameters)
        
            .response { response in
                
                do {
                    if response.error != nil {
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
                            
                            var ar : NSArray!
                            ar = (jsonDict["data"] as! Array<Any>) as NSArray
                            self.arr_notification_list.addObjects(from: ar as! [Any])
                            
                            ERProgressHud.sharedInstance.hide()
                            
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
                    
                    print(response.error?.localizedDescription as Any, terminator: "<==== I AM ERROR")
                    
                    self.something_went_wrong_with_WB()
                    
                }
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
    
    
}

extension v_home_notification : UITableViewDelegate , UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arr_notification_list.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item = self.arr_notification_list[indexPath.row] as? [String:Any]
        
        /*if "\(item!["type"]!)" == "4" {
            
            let cell:v_home_notification_table_cell = tableView.dequeueReusableCell(withIdentifier: "two") as! v_home_notification_table_cell
            
            cell.backgroundColor = .clear
            
            let backgroundView = UIView()
            backgroundView.backgroundColor = .clear
            cell.selectedBackgroundView = backgroundView
            
            
            cell.btn_notification_event_quot.setImage(UIImage(named: "notification_quotes"), for: .normal)
            cell.lbl_notification_quotation.text = (item!["message"] as! String)
            
            return cell
            
        } else */if "\(item!["type"]!)" == "5" {
            
            let cell:v_home_notification_table_cell = tableView.dequeueReusableCell(withIdentifier: "two") as! v_home_notification_table_cell
            
            cell.backgroundColor = .clear
            
            let backgroundView = UIView()
            backgroundView.backgroundColor = .clear
            cell.selectedBackgroundView = backgroundView
            
            if (item!["image"] as! String) == ""  {
                
                cell.img_view_event.image = UIImage(named: "logo")
                cell.img_view_event.contentMode = .scaleAspectFit
                
            } else {
                
                cell.img_view_event.contentMode = .scaleAspectFill
                cell.img_view_event.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
                cell.img_view_event.sd_setImage(with: URL(string: (item!["image"] as! String)), placeholderImage: UIImage(named: "logo"))
                
            }
            // cell.btn_notification_event_quot.setImage(UIImage(named: "calendar"), for: .normal)
            
            // cell.lbl_notification_quotation.text = "New Event"
            // cell.lbl_list_description.text = (item!["created"] as! String)
            // cell.btn_play.isHidden = true
            
            /*let yourAttributes_1 = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont(name: "Avenir Next Bold", size: 18.0)!]
            
            let yourAttributes = [NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.font: UIFont(name: "Avenir Next Demi Bold", size: 16.0)!]
            
            
            let partOne_1 = NSMutableAttributedString(string: "New Event"+"\n", attributes: yourAttributes_1)
            
            let partOne_2 = NSMutableAttributedString(string: (item!["created"] as! String)+"\n\n", attributes: yourAttributes)
            
            
            let combination = NSMutableAttributedString()
            
            combination.append(partOne_1)
            combination.append(partOne_2)
            
            cell.lbl_notification_quotation.attributedText = combination*/
            
            let yourAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont(name: "Poppins-Regular", size: 18.0)!]
            
//            let partOne_1 = NSMutableAttributedString(string: "New Event"+"\n", attributes: yourAttributes_1)
            
            let partOne_2 = NSMutableAttributedString(string: (item!["description"] as! String)+"\n\n", attributes: yourAttributes)
            
            
            let combination = NSMutableAttributedString()
            
//            combination.append(partOne_1)
            combination.append(partOne_2)
            
//            cell.lbl_list_description.text = (item!["message"] as! String)
            cell.lbl_list_description.attributedText = combination
            
            return cell
            
        } else {
            
            let cell:v_home_notification_table_cell = tableView.dequeueReusableCell(withIdentifier: "v_home_notification_table_cell") as! v_home_notification_table_cell
            
            cell.backgroundColor = .clear
            
            let backgroundView = UIView()
            backgroundView.backgroundColor = .clear
            cell.selectedBackgroundView = backgroundView
            
            
            
//            cell.lbl_title.text = (item!["title"] as! String)
            
            
//            let yourAttributes_1 = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont(name: "Avenir Next Bold", size: 18.0)!]
            
            let yourAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont(name: "Poppins-Regular", size: 18.0)!]
            
//            let partOne_1 = NSMutableAttributedString(string: "New Event"+"\n", attributes: yourAttributes_1)
            
            let partOne_2 = NSMutableAttributedString(string: (item!["message"] as! String)+"\n\n", attributes: yourAttributes)
            
            
            let combination = NSMutableAttributedString()
            
//            combination.append(partOne_1)
            combination.append(partOne_2)
            
//            cell.lbl_list_description.text = (item!["message"] as! String)
            cell.lbl_list_description.attributedText = combination
            
            if (item!["image"] as! String) == ""  {
                cell.img_view_list.image = UIImage(named: "logo")
                cell.img_view_list.contentMode = .scaleAspectFit
            } else {
                cell.img_view_list.contentMode = .scaleToFill
                cell.img_view_list.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
                cell.img_view_list.sd_setImage(with: URL(string: (item!["image"] as! String)), placeholderImage: UIImage(named: "logo"))
            }
            
//            cell.img_view_list.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
//            cell.img_view_list.sd_setImage(with: URL(string: (item!["image"] as! String)), placeholderImage: UIImage(named: "logo"))
            
            
            if "\(item!["type"]!)" == "3" {
                cell.btn_play.isHidden = true
            } else {
                cell.btn_play.isHidden = false
            }
            
            return cell
            
        }
        
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let item = self.arr_notification_list[indexPath.row] as? [String:Any]
        
        if "\(item!["type"]!)" == "1" {
            
            
            if "\(item!["paidType"]!)" == "1" {
                
                if (item!["audioFile"] as! String) == "" {
                    
                    let alert = NewYorkAlertController(title: String("Invalid Link"), message: String("This Link is not valid. Please check and try again"), style: .alert)
                    
                    
                    let cancel = NewYorkButton(title: "dismiss", style: .cancel)
                    
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
                    
                    
                    DispatchQueue.main.async(execute: {
                        
                        let url = URL(string: (item!["audioFile"] as! String))
                        print(url as Any)
                        
                        self.setup_voice_functionality(get_url: url! as NSURL)
                        
                    })
                }
                
                

                
            } else { // paid
                
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
                            
                            
                            
                            self.img_music_thumbnail.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
                            self.img_music_thumbnail.sd_setImage(with: URL(string: (item!["image"] as! String)), placeholderImage: UIImage(named: "logo"))
                            
                            self.lbl_music_title.text = (item!["title"] as! String)
                            
                            print(item as Any)
                            
                            if (item!["audioFile"] as! String=="") {
                                
                                print("yes, URL is nil")

                                //
                                let alert = NewYorkAlertController(title: String("Invalid Link"), message: String("This Link is not valid. Please check and try again"), style: .alert)
                                
                                
//                                let yes_subscribe = NewYorkButton(title: "Dismiss", style: .default)
                                
                                let cancel = NewYorkButton(title: "dismiss", style: .cancel)
                                
//                                yes_subscribe.setDynamicColor(.pink)
                                
                                alert.addButtons([cancel])
                                self.present(alert, animated: true)
                                
                                
                            } else {
                                self.player?.replaceCurrentItem(with: nil)
                                
                                self.clear_audio_player_controller()
                                
                                
                                //
                                UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
                                    
                                    self.tble_view.frame =  CGRect(x: 0, y: 120, width:self.view_full_view.frame.size.width, height: self.view_full_view.frame.size.height-114)
                                    
                                    self.view_music_player.isHidden = false
                                    
                                }, completion: nil)
                                
                                
                                self.view_full_view.addSubview(self.tble_view)
                                //
                                
                                DispatchQueue.main.async(execute: {
                                    
                                    let url = URL(string: (item!["audioFile"] as! String))
                                    print(url as Any)
                                    

                                    if (url == nil) {
                                        print("yes, URL is nil")
                                    } else {
                                        self.setup_voice_functionality(get_url: url! as NSURL)
                                    }

                                })
                                
                            }
                            
                            
                            
                            
                        } else {
                            
                            
                            let alert = NewYorkAlertController(title: String("Subscribe"), message: String("Please Subscribe to get access."), style: .alert)
                            
                            
                            let yes_subscribe = NewYorkButton(title: "Subscribe", style: .default) {
                                _ in
                                
                                self.subscribe_click_method()
                                
                            }
                            
                            let cancel = NewYorkButton(title: "dismiss", style: .cancel)
                            
                            yes_subscribe.setDynamicColor(.pink)
                            
                            alert.addButtons([yes_subscribe,cancel])
                            self.present(alert, animated: true)
                            
                        }
                        
                    }
                    
                } else {
                    
                    self.please_login_to_continue()
                    
                }
                
                
                
            }
                        
        } else if "\(item!["type"]!)" == "2" {
            
            
            if "\(item!["paidType"]!)" == "1" {
                
                let item = self.arr_notification_list[indexPath.row] as? [String:Any]
                
                if (item!["videoFile"] as! String) == "" {
                    self.push_to_video_screen(str_video_file_link: (item!["file_link"] as! String),
                                              str_video_title: (item!["title"] as! String))
                } else {
                    self.push_to_video_screen(str_video_file_link: (item!["videoFile"] as! String),
                                              str_video_title: (item!["title"] as! String))
                }
                print(item as Any)
                
                
                
            } else { // paid
                
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
                            
                            let item = self.arr_notification_list[indexPath.row] as? [String:Any]
                            self.push_to_video_screen(str_video_file_link: (item!["file_link"] as! String),
                                                      str_video_title: (item!["title"] as! String))
                            
                            
                        } else {
                            
                            
                            let alert = NewYorkAlertController(title: String("Subscribe"), message: String("Please Subscribe to get access."), style: .alert)
                            
                            
                            let yes_subscribe = NewYorkButton(title: "Subscribe", style: .default) {
                                _ in
                                
                                self.subscribe_click_method()
                                
                            }
                            
                            let cancel = NewYorkButton(title: "dismiss", style: .cancel)
                            
                            yes_subscribe.setDynamicColor(.pink)
                            
                            alert.addButtons([yes_subscribe,cancel])
                            self.present(alert, animated: true)
                            
                        }
                        
                    }
                    
                } else {
                    
                    self.please_login_to_continue()
                    
                }
                
                
                
            }
                        
        } else if "\(item!["type"]!)" == "3" {
            
            
            if "\(item!["paidType"]!)" == "1" {
                
                
                let pushVC = self.storyboard?.instantiateViewController(withIdentifier: "read_article_id") as! read_article
                
                pushVC.hidesBottomBarWhenPushed = true
                pushVC.str_description = (item!["description"] as! String)
                
                self.navigationController?.pushViewController(pushVC, animated: true)
                
            } else { // paid
                
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
                            
                            let pushVC = self.storyboard?.instantiateViewController(withIdentifier: "read_article_id") as! read_article
                            
                            pushVC.hidesBottomBarWhenPushed = true
                            pushVC.str_description = (item!["description"] as! String)
                            
                            self.navigationController?.pushViewController(pushVC, animated: true)
                            
                            
                        } else {
                            
                            
                            let alert = NewYorkAlertController(title: String("Subscribe"), message: String("Please Subscribe to get access."), style: .alert)
                            
                            
                            let yes_subscribe = NewYorkButton(title: "Subscribe", style: .default) {
                                _ in
                                
                                self.subscribe_click_method()
                                
                            }
                            
                            let cancel = NewYorkButton(title: "dismiss", style: .cancel)
                            
                            yes_subscribe.setDynamicColor(.pink)
                            
                            alert.addButtons([yes_subscribe,cancel])
                            self.present(alert, animated: true)
                            
                        }
                        
                    }
                    
                } else {
                    
                    self.please_login_to_continue()
                    
                }
                
                
                
            }
            
        } else if "\(item!["type"]!)" == "5" {
            
            if let url = URL(string: (item!["URL"] as! String)) {
                UIApplication.shared.open(url)
            }
            
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let item = self.arr_notification_list[indexPath.row] as? [String:Any]
        
        if "\(item!["type"]!)" == "4" {
            return 0
        } else if "\(item!["type"]!)" == "5" {
            return 130//UITableView.automaticDimension
        } else {
            return 130
        }
        
    }
    
}

class v_home_notification_table_cell:UITableViewCell {
    
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
    
    @IBOutlet weak var img_view_event:UIImageView! {
        didSet {
            img_view_event.layer.cornerRadius = 8
            img_view_event.clipsToBounds = true
            img_view_event.backgroundColor = UIColor.init(red: 208.0/255.0, green: 208.0/255.0, blue: 208.0/255.0, alpha: 1)
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
    
    @IBOutlet weak var lbl_notification_quotation:UILabel!
    
    @IBOutlet weak var btn_notification_event_quot:UIButton! {
        didSet {
             
        }
    }
    
    @IBOutlet weak var btn_play:UIButton! {
        didSet {
            btn_play.isUserInteractionEnabled = false
//            btn_play.backgroundColor = .lightGray
//            btn_play.tintColor = .white
//            btn_play.layer.cornerRadius = 15
//            btn_play.clipsToBounds = true
        }
    }
    
}
