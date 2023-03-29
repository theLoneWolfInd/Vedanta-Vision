//
//  wisdom_sub_details.swift
//  Vedanta
//
//  Created by Dishant Rajput on 07/11/22.
//

import UIKit
import Alamofire
import SDWebImage
import AVFoundation

class wisdom_sub_details: UIViewController {
    
    var page : Int! = 1
    var loadMore : Int! = 1;
    
    var arr_wisdom_list:NSMutableArray! = []
    
    var str_category_id:String!
    
    var player:AVPlayer!
    
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
            tble_view.delegate = self
            tble_view.dataSource = self
            tble_view.backgroundColor = .clear
        }
    }
    
    @IBOutlet weak var lbl_navigation_title:UILabel!
    
    var str_one:String!
    var str_two:String!
    
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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.view_full_view.backgroundColor = app_BG_color
        
        self.tble_view.frame =  CGRect(x: 0, y: 8, width:self.view.frame.size.width-20, height: self.view.frame.size.height-120)
        self.view_full_view.addSubview(self.tble_view)
        
        self.tble_view.separatorColor = .clear
        
        self.btn_back.addTarget(self, action: #selector(back_click_method_2), for: .touchUpInside)
        
        self.wisdom_WB(str_type: String(self.str_one),
                       str_article_type: String(self.str_two),
                       page_number: 1)
        
        
          // print(self.str_one)
         // print(self.str_two)
        
        if String(self.str_one) == "1" {
            self.lbl_navigation_title.text = "Video"
        } else if String(self.str_one) == "2" {
            self.lbl_navigation_title.text = "Audio"
        } else {
            
            if String(self.str_two) == "1" {
                self.lbl_navigation_title.text = "Articles"
            } else if String(self.str_two) == "2" {
                self.lbl_navigation_title.text = "Stories"
            } else {
                self.lbl_navigation_title.text = "Poems"
            }
            
            
        }
    }
    
    @objc func back_click_method_2() {
        
        self.navigationController?.popViewController(animated:true)
        self.player?.replaceCurrentItem(with: nil)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if let person = UserDefaults.standard.value(forKey: "key_select_categories") as? [String:Any] {
        
            print(person as Any)
            
            let indexPath = IndexPath.init(row: 0, section: 0)
            let cell = self.tble_view.cellForRow(at: indexPath) as! ask_form_table_cell
            
            self.str_category_id = "\(person["category_id"]!)"
            cell.txt_choose_category.text = (person["category_title"] as! String)
            
            let defaults = UserDefaults.standard
            defaults.setValue("", forKey: "key_select_categories")
            defaults.setValue(nil, forKey: "key_select_categories")
            
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

                    self.wisdom_WB(str_type: String(self.str_one),
                                   str_article_type: String(self.str_two),
                                   page_number: page)

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
    
    
    @objc func wisdom_WB(str_type:String ,
                         str_article_type:String,
                         page_number:Int) {
        
        self.view.endEditing(true)
        
        // self.arr_wisdom_list.removeAllObjects()
        
        ERProgressHud.sharedInstance.showDarkBackgroundView(withTitle: "Please wait...")
        
        if IsInternetAvailable() == false {
            self.please_check_your_internet_connection()
            return
        }
        
        let parameters = [
            "action"        : "wisdomist",
            "type"          : String(str_type),
            "articleType"   : String(str_article_type),
            "keyword"       : "",
            "pageNo"        : page_number
            
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
    
     
    
}


extension wisdom_sub_details : UITableViewDelegate , UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arr_wisdom_list.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:wisdom_sub_details_table_cell = tableView.dequeueReusableCell(withIdentifier: "wisdom_sub_details_table_cell") as! wisdom_sub_details_table_cell
        
        cell.backgroundColor = .clear
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = .clear
        cell.selectedBackgroundView = backgroundView
       
        
        let item = self.arr_wisdom_list[indexPath.row] as? [String:Any]
        print(item as Any)
        
        cell.img_view_list.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
        cell.img_view_list.sd_setImage(with: URL(string: (item!["image"] as! String)), placeholderImage: UIImage(named: "logo"))
        
        // let int_1 = (item!["question"] as! String).count
        // print(int_1)
        
//        let yourAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemRed, NSAttributedString.Key.font: UIFont(name: "Avenir Next Bold", size: 14.0)!]
        let yourOtherAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont(name: "Poppins-Regular", size: 16.0)!]
        
//        let partOne = NSMutableAttributedString(string: (item!["title"] as! String)+"\n\n", attributes: yourAttributes)
        let partTwo = NSMutableAttributedString(string: (item!["description"] as! String), attributes: yourOtherAttributes)
        
        let combination = NSMutableAttributedString()
        
//        combination.append(partOne)
        combination.append(partTwo)
        
        cell.lbl_list_description.attributedText = combination
        
        // cell.lbl_description.text = (item!["description"] as! String)
        
        if "\(item!["Type"]!)" == "1" {
            
            // show video
            cell.btn_play.isHidden = false
            
        } else if "\(item!["Type"]!)" == "2" {
            
            // show audio
            cell.btn_play.isHidden = false
            
            // print(self.str_which_index as Any)
            
        } else {
            // show article
            cell.btn_play.isHidden = true
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let item = self.arr_wisdom_list[indexPath.row] as? [String:Any]
        print(item as Any)
        
        if "\(item!["Type"]!)" == "1" { // video
            
            
            let item = self.arr_wisdom_list[indexPath.row] as? [String:Any]
            
            let push = self.storyboard?.instantiateViewController(withIdentifier: "wisdom_new_details_id") as! wisdom_new_details
            
            push.hidesBottomBarWhenPushed = false
            push.dict_wisdom_details = item as NSDictionary?
            
            push.str_one_one = String(self.str_one)
            push.str_one_two = String(self.str_two)
            
            self.navigationController?.pushViewController(push, animated: true)
            
            
            
            
            // video
//            self.push_to_video_screen(str_video_file_link: (item!["Link"] as! String),
//                                      str_video_title: (item!["title"] as! String))
            
        } else if "\(item!["Type"]!)" == "2" { // audio
            
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
            
        } else {
            
            let pushVC = self.storyboard?.instantiateViewController(withIdentifier: "read_article_id") as! read_article
            
            pushVC.hidesBottomBarWhenPushed = false
            pushVC.str_description = (item!["description"] as! String)
            
            self.navigationController?.pushViewController(pushVC, animated: true)
            
        }
        
        
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
}

class wisdom_sub_details_table_cell:UITableViewCell, UITextViewDelegate {
    
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
    
    @IBOutlet weak var lbl_title:UILabel!
    
    @IBOutlet weak var img_view_list:UIImageView! {
        didSet {
            img_view_list.layer.cornerRadius = 8
            img_view_list.clipsToBounds = true
            img_view_list.backgroundColor = UIColor.init(red: 208.0/255.0, green: 208.0/255.0, blue: 208.0/255.0, alpha: 1)
        }
    }
    @IBOutlet weak var lbl_list_description:UILabel!
    
    @IBOutlet weak var btn_play:UIButton! {
        didSet {
            btn_play.isUserInteractionEnabled = false
        }
    }
    
    @IBOutlet weak var btn_play_2:UIButton! {
        didSet {
            btn_play_2.isUserInteractionEnabled = false
            btn_play_2.backgroundColor = .lightGray
            btn_play_2.tintColor = .white
            btn_play_2.layer.cornerRadius = 15
            btn_play_2.clipsToBounds = true
        }
    }
    
}
