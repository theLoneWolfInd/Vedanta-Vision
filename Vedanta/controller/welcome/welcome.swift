//
//  welcome.swift
//  Vedanta
//
//  Created by Dishant Rajput on 15/09/22.
//

import UIKit

class welcome: UIViewController {

    @IBOutlet weak var btn_back:UIButton! {
        didSet {
            btn_back.tintColor = .black
        }
    }
    
    @IBOutlet weak var img_view:UIImageView! {
        didSet {
            img_view.backgroundColor = .clear
        }
    }
    
    @IBOutlet weak var view_full_view:UIView! {
        didSet {
            view_full_view.backgroundColor = UIColor.init(red: 246.0/255.0, green: 246.0/255.0, blue: 246.0/255.0, alpha: 1)
        }
    }
    
    @IBOutlet weak var btn_sign_in:UIButton! {
        didSet {
            btn_sign_in.layer.cornerRadius = 8
            btn_sign_in.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var btn_sign_up:UIButton! {
        didSet {
            btn_sign_up.layer.cornerRadius = 8
            btn_sign_up.clipsToBounds = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.view_full_view.backgroundColor = app_BG_color
        
        self.btn_back.addTarget(self, action: #selector(back_click_method), for: .touchUpInside)
        
        self.btn_sign_in.addTarget(self, action: #selector(sign_in_click_method), for: .touchUpInside)
        self.btn_sign_up.addTarget(self, action: #selector(sign_up_click_method), for: .touchUpInside)
        
    }
    

}
