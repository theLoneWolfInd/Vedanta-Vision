//
//  advertisement_details.swift
//  Vedanta
//
//  Created by Dishant Rajput on 12/10/22.
//

import UIKit
import Alamofire
import SDWebImage

class advertisement_details: UIViewController {
    
    var str_img_advertisement:String!
    var str_description:String!
    var str_start_date:String!
    var str_end_date:String!
    
    var str_navigation_title:String!
    
    @IBOutlet weak var view_full_view:UIView! {
        didSet {
            view_full_view.backgroundColor = UIColor.init(red: 246.0/255.0, green: 246.0/255.0, blue: 246.0/255.0, alpha: 1)
        }
    }
    
    @IBOutlet weak var btn_back:UIButton!
    
    
    @IBOutlet weak var img_advertisement:UIImageView!
    
    @IBOutlet weak var view_article:UITextView! {
        didSet {
            view_article.textColor = .black
            view_article.backgroundColor = .clear
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.view_full_view.backgroundColor = app_BG_color
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        self.btn_back.addTarget(self, action: #selector(back_click_method), for: .touchUpInside)
        
        self.img_advertisement.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
        self.img_advertisement.sd_setImage(with: URL(string: String(self.str_img_advertisement)), placeholderImage: UIImage(named: "logo"))
        
        // self.img_advertisement.image = UIImage(named: String(self.str_img_advertisement))
        
        let date_description =
 
        "Start Date : \n"+String(self.str_start_date)+"\n\nEnd Date : \n"+String(self.str_end_date)//+"\n\nEnd Date : "+String(self.str_end_date)
        
        
        self.view_article.text = String(date_description)+"\n\n"+String(self.str_description)
         
    }

}
