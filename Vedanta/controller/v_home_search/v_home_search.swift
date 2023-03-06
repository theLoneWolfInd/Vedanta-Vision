//
//  v_home_search.swift
//  Vedanta
//
//  Created by Dishant Rajput on 14/09/22.
//

import UIKit

class v_home_search: UIViewController , UITextFieldDelegate {

    var selected_color = UIColor.init(red: 230.0/255.0, green: 40.0/255.0, blue: 36.0/255.0, alpha: 1)
    var de_selected_color = UIColor.init(red: 58.0/255.0, green: 59.0/255.0, blue: 60.0/255.0, alpha: 1)
    
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
    
    @IBOutlet weak var txt_search:UITextField! {
        didSet {
            txt_search.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            txt_search.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            txt_search.layer.shadowOpacity = 1.0
            txt_search.layer.shadowRadius = 8
            txt_search.layer.masksToBounds = false
            txt_search.layer.cornerRadius = 8
            txt_search.backgroundColor = .white
            txt_search.setLeftPaddingPoints(24)
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
    
    

    
    @objc func watch_click_method() {
        
        self.btn_watch.backgroundColor = selected_color
        
        self.btn_listen.backgroundColor = de_selected_color
        self.btn_read.backgroundColor = de_selected_color
        
    }
    
    @objc func listen_click_method() {
        
        self.btn_listen.backgroundColor = selected_color
        
        self.btn_watch.backgroundColor = de_selected_color
        self.btn_read.backgroundColor = de_selected_color
        
    }
    
    @objc func read_click_method() {
        
        self.btn_read.backgroundColor = selected_color
        
        self.btn_listen.backgroundColor = de_selected_color
        self.btn_watch.backgroundColor = de_selected_color
        
    }
    
    @IBOutlet weak var tble_view:UITableView! {
        didSet {
            tble_view.delegate = self
            tble_view.dataSource = self
            tble_view.backgroundColor = .clear
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.view_full_view.backgroundColor = app_BG_color
        
        self.tble_view.separatorColor = .clear
        
        self.btn_back.addTarget(self, action: #selector(back_click_method), for: .touchUpInside)
        
        self.btn_watch.addTarget(self, action: #selector(watch_click_method), for: .touchUpInside)
        self.btn_listen.addTarget(self, action: #selector(listen_click_method), for: .touchUpInside)
        self.btn_read.addTarget(self, action: #selector(read_click_method), for: .touchUpInside)
        
        self.txt_search.delegate = self
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
    }
    
}

extension v_home_search : UITableViewDelegate , UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:v_home_search_table_cell = tableView.dequeueReusableCell(withIdentifier: "v_home_search_table_cell") as! v_home_search_table_cell
        
        cell.backgroundColor = .clear
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = .clear
        cell.selectedBackgroundView = backgroundView
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
}

class v_home_search_table_cell:UITableViewCell {
    
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
    
}
