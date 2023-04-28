//
//  play_videos.swift
//  GAIT
//
//  Created by Apple on 09/06/22.
//  Copyright © 2022 EVS. All rights reserved.
//

import UIKit
import WebKit

class play_videos: UIViewController {
    
    @IBOutlet weak var wv: WKWebView!
    var mywkwebview: WKWebView?
    let mywkwebviewConfig = WKWebViewConfiguration()
    
    var str_video_link:String!
    var str_video_header:String!
    
    
    
    @IBOutlet weak var btn_back:UIButton! {
        didSet {
            btn_back.tintColor = .black
        }
    }
    
    @IBOutlet weak var lbl_one:UILabel! {
        didSet {
            lbl_one.textColor = .black
        }
    }
    @IBOutlet weak var lbl_two:UILabel! {
        didSet {
            lbl_two.textColor = .black
        }
    }
    
    
    @IBOutlet weak var indicator_webview:UIActivityIndicatorView! {
        didSet {
            indicator_webview.isHidden = false
            indicator_webview.startAnimating()
            indicator_webview.color = app_red_orange_mix_color
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("ok ok ")
        
        print(self.str_video_link as Any)
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.loadYoutube(videoID: String(self.str_video_link))
        
        self.lbl_one.text = String(self.str_video_header)
        
        self.btn_back.addTarget(self, action: #selector(btn_back_click_method), for: .touchUpInside)
        
        //
        self.wv.navigationDelegate = self
        
    }
    
    @objc func btn_back_click_method() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func loadYoutube(videoID:String) {
        guard
            let youtubeURL = URL(string: videoID)
        else { return }
        wv.load( URLRequest(url: youtubeURL) )
    }
    
}


extension play_videos: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        print("Start loading")
        
        // let indexPath = IndexPath.init(row: 6, section: 0)
        // let cell = self.tble_view.cellForRow(at: indexPath) as! v_home_table_cell
        
        self.indicator_webview.isHidden = false
        self.indicator_webview.startAnimating()
        
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("End loading")
        
        // let indexPath = IndexPath.init(row: 6, section: 0)
        // let cell = self.tble_view.cellForRow(at: indexPath) as! v_home_table_cell
        
        self.indicator_webview.isHidden = true
        self.indicator_webview.stopAnimating()
        
    }
}
