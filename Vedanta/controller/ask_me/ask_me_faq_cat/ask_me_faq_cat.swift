//
//  ask_me_faq_cat.swift
//  Vedanta
//
//  Created by Dishant Rajput on 18/10/22.
//

import UIKit
import Alamofire

class ask_me_faq_cat: UIViewController {
    
    var page : Int! = 1
    var loadMore : Int! = 1;
    
    var str_category_id:String!
    var str_category_name:String!
    
    var int_expand_cell_index:Int!
    
    var str_index_click:String! = "0"
    
    var arr_mut_ask_me:NSMutableArray! = []
    
    @IBOutlet weak var btn_back:UIButton! {
        didSet {
            btn_back.tintColor = .black
        }
    }
    
    @IBOutlet weak var lbl_navigation_title:UILabel!
    
    @IBOutlet weak var btn_search:UIButton!
    @IBOutlet weak var btn_filter:UIButton!
    
    @IBOutlet weak var tble_view:UITableView! {
        didSet {
            
            tble_view.backgroundColor = .clear
        }
    }
    
    @IBOutlet weak var view_full_view:UIView! {
        didSet {
            view_full_view.backgroundColor = UIColor.init(red: 246.0/255.0, green: 246.0/255.0, blue: 246.0/255.0, alpha: 1)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.view_full_view.backgroundColor = app_BG_color
        
        self.tble_view.separatorColor = UIColor.init(red: 230.0/255.0, green: 40.0/255.0, blue: 36.0/255.0, alpha: 1)
        
        self.btn_back.addTarget(self, action: #selector(back_click_method), for: .touchUpInside)
        
        self.lbl_navigation_title.text = String(self.str_category_name)
        
        self.tabBarController?.tabBar.backgroundColor = UIColor.init(red: 250.0/255.0, green: 250.0/255.0, blue: 255.0/255.0, alpha: 1)
        
        
        if self.str_category_name == "All" {
            
            self.show_all_category_WB(page_number: 1)
            
            
        } else {
            
            self.ask_me_anything(page_number: 1)
            
        }
        
        
        // self.create_custom_array()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if let person = UserDefaults.standard.value(forKey: "key_from_ask_quesiton") as? [String:Any] {
            
            print(person as Any)
            
            let indexPath = IndexPath.init(row: 0, section: 0)
            let cell = self.tble_view.cellForRow(at: indexPath) as! ask_me_table_cell
            
            cell.segment_control.selectedSegmentIndex = 0
            
            let defaults = UserDefaults.standard
            defaults.setValue("", forKey: "key_from_ask_quesiton")
            defaults.setValue(nil, forKey: "key_from_ask_quesiton")
        }
        
    }
    
    @objc func create_custom_array() {
        
        for indexx in 0...9 {
            
            if indexx == 0 {
                
                let custom_array = ["status":"header"]
                self.arr_mut_ask_me.add(custom_array)
                
            } else {
                
                let custom_array = ["status"    : "list",
                                    "question"  : "Faq Svadharma",
                                    "answer"    : "is anything else i can do to get rooted in the knowledge of Bhagwat Gita ?is anything else i can do to get rooted in the knowledge of Bhagwat Gita ?is anything else i can do to get rooted in the knowledge of Bhagwat Gita ?is anything else i can do to get rooted in the knowledge of Bhagwat Gita ?is anything else i can do to get rooted in the knowledge of Bhagwat Gita ?is anything else i can do to get rooted in the knowledge of Bhagwat Gita ?",
                ]
                self.arr_mut_ask_me.add(custom_array)
                
            }
            
        }
        
        self.tble_view.delegate = self
        self.tble_view.dataSource = self
        
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
    
                        // self.show_all_category_WB(page_number: page)
    
                        if self.str_category_name == "All" {
                            
                            self.show_all_category_WB(page_number: page)
                            
                            
                        } else {
                            self.ask_me_anything(page_number: page)
                        }
                        
                    }
                }
            }
        }
    
    @objc func ask_me_anything(page_number:Int) {
        self.view.endEditing(true)
        
//        self.arr_mut_ask_me.removeAllObjects()
        
        if (page_number == 1) {
            ERProgressHud.sharedInstance.showDarkBackgroundView(withTitle: "Please wait...")
        }
        
        
        if IsInternetAvailable() == false {
            self.please_check_your_internet_connection()
            return
        }

        let parameters = [
            "action"    : "faqlist",
             "pageNo"    : page_number,
            "categoryId"    : String(self.str_category_id),
            
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
                            self.arr_mut_ask_me.addObjects(from: ar as! [Any])
                            
                            
                            self.tble_view.delegate = self
                            self.tble_view.dataSource = self
                            self.tble_view.reloadData()
                            self.loadMore = 1
                            
                            
//                            if self.arr_mut_ask_me.count == 0 {
//                                print("no data")
//                                /*let alert = NewYorkAlertController(title: String("Alert"), message: String("No data found."), style: .alert)
//                                let cancel = NewYorkButton(title: "Dismiss", style: .cancel) {
//                                    _ in
//                                    self.back_click_method()
//                                }
//                                alert.addButtons([cancel])
//                                self.present(alert, animated: true)*/
//
//
//                            } else {
//
//                                print(self.arr_mut_ask_me as Any)
//
//                                self.tble_view.delegate = self
//                                self.tble_view.dataSource = self
//                                self.tble_view.reloadData()
//                                self.loadMore = 1
//                            }
                            
                            
                            // self.loadMore = 1
                            
                        } else {
                            
                            print("=====> no")
                            ERProgressHud.sharedInstance.hide()
                            
                            let alert = NewYorkAlertController(title: String(status_alert), message: String(str_data_message), style: .alert)
                            let cancel = NewYorkButton(title: "Dismiss", style: .cancel)
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
    
    
    @objc func show_all_category_WB(page_number:Int) {
        self.view.endEditing(true)
        
        // self.arr_mut_ask_me.removeAllObjects()
        
        if page_number == 1 {
            ERProgressHud.sharedInstance.showDarkBackgroundView(withTitle: "Please wait...")
        }
        
        
        if IsInternetAvailable() == false {
            self.please_check_your_internet_connection()
            return
        }
        
        
        
        
        
        let parameters = [
            "action"    : "faqlist",
            "pageNo"    : page_number,
            "categoryId"    : String(""),
            
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
                            self.arr_mut_ask_me.addObjects(from: ar as! [Any])
                            
                            /*if self.arr_mut_ask_me.count == 0 {
                                
                                let alert = NewYorkAlertController(title: String("Alert"), message: String("No data found."), style: .alert)
                                let cancel = NewYorkButton(title: "Dismiss", style: .cancel) {
                                    _ in
                                    self.back_click_method()
                                }
                                alert.addButtons([cancel])
                                self.present(alert, animated: true)
                                
                                
                            } else {*/
                                
                                print(self.arr_mut_ask_me as Any)
                                
                                self.tble_view.delegate = self
                                self.tble_view.dataSource = self
                                self.tble_view.reloadData()
                                
                            // }
                            
                            
                            // self.loadMore = 1
                            
                        } else {
                            
                            print("=====> no")
                            ERProgressHud.sharedInstance.hide()
                            
                            let alert = NewYorkAlertController(title: String(status_alert), message: String(str_data_message), style: .alert)
                            let cancel = NewYorkButton(title: "Dismiss", style: .cancel)
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
    
    
    @objc func segment_control_click_2() {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tble_view.cellForRow(at: indexPath) as! ask_me_table_cell
        
        print(cell.segment_control.selectedSegmentIndex)
        
        if cell.segment_control.selectedSegmentIndex == 1 {
            
            if let person = UserDefaults.standard.value(forKey: str_save_login_user_data) as? [String:Any] {
                // let str:String = person["role"] as! String
                print(person as Any)
                
                let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "my_question_list_id") as? my_question_list
                
                push!.hidesBottomBarWhenPushed = false
                
                self.navigationController?.pushViewController(push!, animated: true)
                
            } else {
                
                cell.segment_control.selectedSegmentIndex = 0
                
                let alert = NewYorkAlertController(title: String("Alert"), message: String("Please login check your all questions."), style: .alert)
                
                let login = NewYorkButton(title: "Login", style: .default) {
                    _ in
                    
                    self.sign_in_click_method()
                }
                let cancel = NewYorkButton(title: "Dismiss", style: .cancel)
                
                alert.addButtons([login , cancel])
                self.present(alert, animated: true)
                
            }
            
            
            
        }
        
        
    }
    
    // push : - ASK FORM -
    @objc func ask_me_click_method() {
        
        if let person = UserDefaults.standard.value(forKey: str_save_login_user_data) as? [String:Any] {
            // let str:String = person["role"] as! String
            print(person as Any)
            
            
            let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ask_form_id") as? ask_form
            push!.hidesBottomBarWhenPushed = false
            self.navigationController?.pushViewController(push!, animated: true)
            
        } else {
            
            let alert = NewYorkAlertController(title: String("Alert"), message: String("Please login to ask any question."), style: .alert)
            
            let login = NewYorkButton(title: "Login", style: .default) {
                _ in
                
                self.sign_in_click_method()
            }
            let cancel = NewYorkButton(title: "Dismiss", style: .cancel)
            
            alert.addButtons([login , cancel])
            self.present(alert, animated: true)
        }
        
        
    }
    
}

extension ask_me_faq_cat : UITableViewDelegate , UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arr_mut_ask_me.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let item = self.arr_mut_ask_me[indexPath.row] as? [String:Any]
        
        
        let cell:ask_me_faq_cat_table_cell = tableView.dequeueReusableCell(withIdentifier: "ask_me_faq_cat_table_cell") as! ask_me_faq_cat_table_cell
        
        cell.backgroundColor = .clear
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = .clear
        cell.selectedBackgroundView = backgroundView
        
        let int_1 = (item!["question"] as! String).count
        print(int_1)
        
        let yourAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black
                              , NSAttributedString.Key.font: UIFont(name: "Poppins-SemiBold", size: 16.0)!]
        let yourOtherAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont(name: "Poppins-Regular", size: 14.0)!]
        
        let partOne = NSMutableAttributedString(string: "Q."+"\(indexPath.row+1) "+(item!["question"] as! String)+"\n\n", attributes: yourAttributes)
        let partTwo = NSMutableAttributedString(string: "Ans. "+(item!["answer"] as! String), attributes: yourOtherAttributes)
        
        let combination = NSMutableAttributedString()
        
        combination.append(partOne)
        combination.append(partTwo)
        
        cell.lbl_list_answer.attributedText = combination
        
        return cell
        
        
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // self.int_expand_cell_index = 0
        self.int_expand_cell_index = indexPath.row
        
        // self.str_index_click = "1"
        
        self.tble_view.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
//        let item = self.arr_mut_ask_me[indexPath.row] as? [String:Any]
        
        /*if (item!["status"] as! String) == "header" {
         return 198
         } else {*/
        
        // print(indexPath.row)
        // print(self.int_expand_cell_index as Any)
        
        if  indexPath.row == self.int_expand_cell_index {
            return UITableView.automaticDimension
        } else {
            return 240
        }
        
        // }
        
    }
    
}

class ask_me_faq_cat_table_cell:UITableViewCell {
    
    @IBOutlet weak var view_bg:UIView! {
        didSet {
            view_bg.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            view_bg.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            view_bg.layer.shadowOpacity = 1.0
            view_bg.layer.shadowRadius = 4
            view_bg.layer.masksToBounds = false
            view_bg.layer.cornerRadius = 15
            view_bg.backgroundColor = .white
        }
    }
    
    @IBOutlet weak var lbl_header_message:UILabel! {
        didSet {
            lbl_header_message.text = "Dealing with an issue and need guidance ? \nPost your question here."
            lbl_header_message.textColor = .systemOrange
        }
    }
    
    @IBOutlet weak var btn_ask_me:UIButton! {
        didSet {
            btn_ask_me.backgroundColor = UIColor.init(red: 230.0/255.0, green: 40.0/255.0, blue: 36.0/255.0, alpha: 1)
            btn_ask_me.setTitle("Ask", for: .normal)
            btn_ask_me.setTitleColor(.white, for: .normal)
            btn_ask_me.layer.cornerRadius = 8
            btn_ask_me.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var segment_control:UISegmentedControl! {
        didSet {
            segment_control.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
            segment_control.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .normal)
            
            segment_control.selectedSegmentTintColor = UIColor.init(red: 22.0/255.0, green: 12.0/255.0, blue: 86.0/255.0, alpha: 1)
            
        }
    }
    
    
    @IBOutlet weak var lbl_list_question:UILabel! {
        didSet {
            lbl_list_question.textColor = UIColor.init(red: 230.0/255.0, green: 40.0/255.0, blue: 36.0/255.0, alpha: 1)
        }
    }
    
    @IBOutlet weak var lbl_list_answer:UILabel!
    
}
