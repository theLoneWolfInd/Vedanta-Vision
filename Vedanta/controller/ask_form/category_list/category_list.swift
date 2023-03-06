//
//  category_list.swift
//  Vedanta
//
//  Created by Dishant Rajput on 14/10/22.
//

import UIKit
import Alamofire

class category_list: UIViewController , UITextViewDelegate {
    
    var str_segment_index:String! = "0"
    
    var arr_mut_add_all_categories:NSMutableArray! = []
    
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
    
    @IBOutlet weak var segment_control:UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.view_full_view.backgroundColor = app_BG_color
        
        self.tble_view.separatorColor = .clear
        
        self.btn_back.addTarget(self, action: #selector(back_click_method), for: .touchUpInside)
        
        self.tabBarController?.tabBar.backgroundColor = UIColor.init(red: 250.0/255.0, green: 250.0/255.0, blue: 255.0/255.0, alpha: 1)
        
        self.segment_control.selectedSegmentIndex = 0
        self.segment_control.addTarget(self, action: #selector(segment_control_click), for: .valueChanged)
        
        self.add_ask_WB()
        
    }
    
    @objc func segment_control_click() {
        
        if self.segment_control.selectedSegmentIndex == 0 {
            
            self.str_segment_index = "0"
            self.tble_view.reloadData()
            
        } else if self.segment_control.selectedSegmentIndex == 1 {
            
            self.str_segment_index = "1"
            self.tble_view.reloadData()
            
        } else if self.segment_control.selectedSegmentIndex == 2 {
            
            self.str_segment_index = "2"
            self.tble_view.reloadData()
            
        } else if self.segment_control.selectedSegmentIndex == 3 {
            
            self.str_segment_index = "3"
            self.tble_view.reloadData()
            
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
//        let indexPath = IndexPath.init(row: 0, section: 0)
//        let cell = self.tble_view.cellForRow(at: indexPath) as! ask_form_table_cell
//
//        let dummyList = ["Category 1" , "Category 2" , "Category 3" , "Category 4" , "Category 5"]
//        RPicker.selectOption(title: "Select category", cancelText: "Cancel", dataArray: dummyList, selectedIndex: 0) {[] (selctedText, atIndex) in
//
//            cell.txt_choose_category.text = "\(selctedText)%"
//
//
//        }
    }
    
    /*
     Add Ask    "action:addask
     categoryId:
     userId:
     name:
     email:
     queation:"
     
     Ask List    "action: asklist
     userId:   .//OPTIONAL"
     */
    
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
        
        ERProgressHud.sharedInstance.showDarkBackgroundView(withTitle: "Please wait...")
        
        if IsInternetAvailable() == false {
            self.please_check_your_internet_connection()
            return
        }
        
        
        let parameters = [
            "action"    : "category",
            "type"      : String("Faq"),
            
        ]
        
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
                            self.arr_mut_add_all_categories.addObjects(from: ar as! [Any])
                            
                            self.tble_view.delegate = self
                            self.tble_view.dataSource = self
                            self.tble_view.reloadData()
                            
                            // self.audio_list_WB()
                            
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


extension category_list : UITableViewDelegate , UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arr_mut_add_all_categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:category_list_table_cell = tableView.dequeueReusableCell(withIdentifier: "category_list_table_cell") as! category_list_table_cell
        
        cell.backgroundColor = .clear
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = .clear
        cell.selectedBackgroundView = backgroundView
        
        let item = self.arr_mut_add_all_categories[indexPath.row] as? [String:Any]
        cell.lbl_category.text = (item!["name"] as! String)

        cell.btn_img_category.setImage(UIImage(systemName: "questionmark.circle.fill"), for: .normal)

        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let item = self.arr_mut_add_all_categories[indexPath.row] as? [String:Any]
        
        let custom_dict = [
            "category_id"       : "\(item!["id"]!)",
            "category_title"    : (item!["name"] as! String),
        ]
        
        let defaults = UserDefaults.standard
        defaults.setValue(custom_dict, forKey: "key_select_categories")
        
        self.navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        return 80
        
    }
    
}

class category_list_table_cell:UITableViewCell, UITextViewDelegate {
    
    
    
    @IBOutlet weak var btn_img_category:UIButton!
    
    @IBOutlet weak var lbl_category:UILabel!
    
}
