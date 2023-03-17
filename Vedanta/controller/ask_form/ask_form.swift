//
//  ask_form.swift
//  Vedanta
//
//  Created by Dishant Rajput on 15/09/22.
//

import UIKit
import Alamofire

class ask_form: UIViewController , UITextViewDelegate {

    var str_category_id:String!
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.view_full_view.backgroundColor = app_BG_color
        
        self.tble_view.separatorColor = .clear
        
        self.btn_back.addTarget(self, action: #selector(back_click_method), for: .touchUpInside)
        
        
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
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tble_view.cellForRow(at: indexPath) as! ask_form_table_cell
        
        if cell.txt_view.textColor == UIColor.lightGray {
            cell.txt_view.text = ""
            cell.txt_view.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tble_view.cellForRow(at: indexPath) as! ask_form_table_cell
        
        if cell.txt_view.text == "" {

            cell.txt_view.text = "Write Your question here..."
            cell.txt_view.textColor = UIColor.lightGray
        }
    }
    
    @objc func category_select_click_method() {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tble_view.cellForRow(at: indexPath) as! ask_form_table_cell
        
        let dummyList = ["Category 1" , "Category 2" , "Category 3" , "Category 4" , "Category 5"]
        RPicker.selectOption(title: "Select category", cancelText: "Cancel", dataArray: dummyList, selectedIndex: 0) {[] (selctedText, atIndex) in
            
            cell.txt_choose_category.text = "\(selctedText)%"
            
            
        }
    }

    @objc func validation_before_add_ask() {
        
        // add_ask_WB
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tble_view.cellForRow(at: indexPath) as! ask_form_table_cell
        
        if cell.txt_your_name.text == "" {
            
            let alert = NewYorkAlertController(title: String("Alert").uppercased(), message: String("Name should not be empty"), style: .alert)
            let cancel = NewYorkButton(title: "dismiss", style: .cancel)
            alert.addButtons([cancel])
            self.present(alert, animated: true)
            
        } else if cell.txt_your_email.text == "" {
            
            let alert = NewYorkAlertController(title: String("Alert").uppercased(), message: String("Email should not be empty"), style: .alert)
            let cancel = NewYorkButton(title: "dismiss", style: .cancel)
            alert.addButtons([cancel])
            self.present(alert, animated: true)
            
        } else if cell.txt_choose_category.text == "" {
            
            let alert = NewYorkAlertController(title: String("Alert").uppercased(), message: String("Please choose category"), style: .alert)
            let cancel = NewYorkButton(title: "dismiss", style: .cancel)
            alert.addButtons([cancel])
            self.present(alert, animated: true)
            
        } else if cell.txt_view.text == "" {
            
            let alert = NewYorkAlertController(title: String("Alert").uppercased(), message: String("Enter comment"), style: .alert)
            let cancel = NewYorkButton(title: "dismiss", style: .cancel)
            alert.addButtons([cancel])
            self.present(alert, animated: true)
            
        } else {
            
            self.add_ask_WB()
            
        }
        
    }
    
    @objc func add_ask_WB() {
        self.view.endEditing(true)
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tble_view.cellForRow(at: indexPath) as! ask_form_table_cell
        
        ERProgressHud.sharedInstance.showDarkBackgroundView(withTitle: "Please wait...")
        
        if IsInternetAvailable() == false {
            self.please_check_your_internet_connection()
            return
        }
    
        if let person = UserDefaults.standard.value(forKey: str_save_login_user_data) as? [String:Any] {
            // let str:String = person["role"] as! String
            print(person as Any)
            
            let x : Int = person["userId"] as! Int
            let myString = String(x)
            
            let parameters = [
                "action"        : "addask",
                "categoryId"    : String(self.str_category_id),
                "userId"        : String(myString),
                "name"          : String(cell.txt_your_name.text!),
                "email"         : String(cell.txt_your_email.text!),
                "question"      : String(cell.txt_view.text!),
            ]
            
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
                                
                                let alert = NewYorkAlertController(title: String("Success").uppercased(), message: String(str_data_message), style: .alert)
                                
                                let cancel = NewYorkButton(title: "dismiss", style: .cancel) {
                                    _ in
                                    self.navigationController?.popViewController(animated: true)
                                }
                                
                                alert.addButtons([cancel])
                                self.present(alert, animated: true)
                                
                                
                                
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
                    }
                }
        }
    }
    
     
    
}


extension ask_form : UITableViewDelegate , UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:ask_form_table_cell = tableView.dequeueReusableCell(withIdentifier: "ask_form_table_cell") as! ask_form_table_cell
        
        cell.backgroundColor = .clear
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = .clear
        cell.selectedBackgroundView = backgroundView
        
        cell.txt_view.delegate = self
        
        cell.btn_ask_me.addTarget(self, action: #selector(validation_before_add_ask), for: .touchUpInside)
        
        cell.btn_category.addTarget(self, action: #selector(category_select_click_method), for: .touchUpInside)
        cell.btn_push_to_category.addTarget(self, action: #selector(all_category_v_home_click_method), for: .touchUpInside)
        
        
        if let person = UserDefaults.standard.value(forKey: str_save_login_user_data) as? [String:Any] {
            // let str:String = person["role"] as! String
            print(person as Any)
            
            cell.txt_your_name.text = (person["fullName"] as! String)
            cell.txt_your_email.text = (person["email"] as! String)
            
        }
        
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
    
}

class ask_form_table_cell:UITableViewCell, UITextViewDelegate {
    
    @IBOutlet weak var view_bg:UIView! {
        didSet {
//            view_bg.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
//            view_bg.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
//            view_bg.layer.shadowOpacity = 1.0
//            view_bg.layer.shadowRadius = 4
//            view_bg.layer.masksToBounds = false
//            view_bg.layer.cornerRadius = 8
            view_bg.backgroundColor = .clear
        }
    }
    
    @IBOutlet weak var img_view:UIImageView! {
        didSet {
            img_view.layer.cornerRadius = 8
            img_view.clipsToBounds = true
            img_view.backgroundColor = UIColor.init(red: 208.0/255.0, green: 208.0/255.0, blue: 208.0/255.0, alpha: 1)
        }
    }
    
    @IBOutlet weak var txt_your_name:UITextField! {
        didSet {
            txt_your_name.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            txt_your_name.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            txt_your_name.layer.shadowOpacity = 1.0
            txt_your_name.layer.shadowRadius = 8
            txt_your_name.layer.masksToBounds = false
            txt_your_name.layer.cornerRadius = 8
            txt_your_name.backgroundColor = .white
            txt_your_name.setLeftPaddingPoints(24)
            txt_your_name.isUserInteractionEnabled = false
        }
    }
    
    @IBOutlet weak var txt_your_email:UITextField! {
        didSet {
            txt_your_email.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            txt_your_email.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            txt_your_email.layer.shadowOpacity = 1.0
            txt_your_email.layer.shadowRadius = 8
            txt_your_email.layer.masksToBounds = false
            txt_your_email.layer.cornerRadius = 8
            txt_your_email.backgroundColor = .white
            txt_your_email.setLeftPaddingPoints(24)
            txt_your_email.isUserInteractionEnabled = false
        }
    }
    
    @IBOutlet weak var txt_choose_category:UITextField! {
        didSet {
            txt_choose_category.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            txt_choose_category.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            txt_choose_category.layer.shadowOpacity = 1.0
            txt_choose_category.layer.shadowRadius = 8
            txt_choose_category.layer.masksToBounds = false
            txt_choose_category.layer.cornerRadius = 8
            txt_choose_category.backgroundColor = .white
            txt_choose_category.setLeftPaddingPoints(24)
        }
    }
    
    @IBOutlet weak var txt_view:UITextView! {
        didSet {
            txt_view.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            txt_view.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            txt_view.layer.shadowOpacity = 1.0
            txt_view.layer.shadowRadius = 8
            txt_view.layer.masksToBounds = false
            txt_view.layer.cornerRadius = 8
            txt_view.backgroundColor = .white
            // txt_view.setLeftPaddingPoints(24)
            
            
            txt_view.text = "Write Your question here..."
            txt_view.textColor = UIColor.lightGray
            
        }
    }
    
    @IBOutlet weak var btn_ask_me:UIButton! {
        didSet {
            btn_ask_me.backgroundColor = UIColor.init(red: 230.0/255.0, green: 40.0/255.0, blue: 36.0/255.0, alpha: 1)
            btn_ask_me.setTitle("Ask", for: .normal)
            btn_ask_me.setTitleColor(.white, for: .normal)
            btn_ask_me.layer.cornerRadius = 20
            btn_ask_me.clipsToBounds = true
        }
    }
    
    
    @IBOutlet weak var btn_category:UIButton!
    @IBOutlet weak var btn_push_to_category:UIButton!
    
}
