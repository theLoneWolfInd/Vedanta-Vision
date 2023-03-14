//
//  youtube_video.swift
//  Vedanta
//
//  Created by Dishant Rajput on 14/03/23.
//

import UIKit
// Import Swift module
import YouTubePlayer

class youtube_video: UIViewController {

    var strVideoTitle:String!
    var strVideoLink:String!
    
    @IBOutlet var lbl_navigation_title: UILabel! {
        didSet {
            lbl_navigation_title.textColor = .white
        }
    }
    @IBOutlet var videoPlayer: YouTubePlayerView!
    
    @IBOutlet weak var btn_back:UIButton! {
        didSet {
            btn_back.tintColor = .white
            btn_back.addTarget(self, action: #selector(back_click_method), for: .touchUpInside)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .black
        self.lbl_navigation_title.text = String(self.strVideoTitle)
        
        // Load video from YouTube URL
        let myVideoURL = NSURL(string: strVideoLink)
        videoPlayer.loadVideoURL(myVideoURL! as URL)
        videoPlayer.play()
        
    }

}
