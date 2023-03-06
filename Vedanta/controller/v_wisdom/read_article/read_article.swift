//
//  read_article.swift
//  Vedanta
//
//  Created by Dishant Rajput on 11/10/22.
//

import UIKit
import Alamofire
import SDWebImage

class read_article: UIViewController {

    var str_navigation_title:String!
    
    var str_description:String!
    
 
    @IBOutlet weak var view_full_view:UIView! {
        didSet {
            view_full_view.backgroundColor = UIColor.init(red: 246.0/255.0, green: 246.0/255.0, blue: 246.0/255.0, alpha: 1)
        }
    }
    
    @IBOutlet weak var btn_back:UIButton!
    
    @IBOutlet weak var view_article:UITextView! {
        didSet {
            view_article.textColor = .black
            view_article.backgroundColor = .clear
        }
    }
    
    
    @IBOutlet weak var lbl_navigation_title:UILabel! {
        didSet {
            lbl_navigation_title.textColor = .black
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.view_full_view.backgroundColor = app_BG_color
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        self.btn_back.addTarget(self, action: #selector(back_click_method), for: .touchUpInside)
        
        self.view_article.text = String(self.str_description)
         
        if self.str_navigation_title == nil {
            self.lbl_navigation_title.text = "Article"
        } else {
            self.lbl_navigation_title.text = String(self.str_navigation_title)
        }
    }

}
