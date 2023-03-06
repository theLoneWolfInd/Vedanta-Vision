//
//  my_question_list.swift
//  Vedanta
//
//  Created by Dishant Rajput on 17/10/22.
//

import UIKit
import Alamofire
import SDWebImage

class my_question_list: UIViewController {
    
    var page : Int! = 1
    var loadMore : Int! = 1;
    
    var arr_mut_video_list:NSMutableArray! = []
    
    @IBOutlet weak var btn_back:UIButton! {
        didSet {
            btn_back.tintColor = .black
        }
    }
    
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
        
        self.tabBarController?.tabBar.backgroundColor = UIColor.init(red: 250.0/255.0, green: 250.0/255.0, blue: 255.0/255.0, alpha: 1)
        
        self.tble_view.separatorColor = .clear
        
        self.btn_back.addTarget(self, action: #selector(back_click_method_222), for: .touchUpInside)
        
        self.create_custom_array()
    }
    
    @objc func back_click_method_222() {
        
        let custom_dict = ["status":"yes"]
        
        let defaults = UserDefaults.standard
        defaults.setValue(custom_dict, forKey: "key_from_ask_quesiton")
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @objc func create_custom_array() {
        
        self.like_unlike_status()
        
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
                    
                    // self.video_list_WB(page_number: page)
                    
                }
            }
        }
    }
    
    // MARK: - WEBSERVICE ( VIDEO LIST ) -
    
    
    
    
    @objc func like_unlike_status() {
        self.view.endEditing(true)
                
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
                "action"        : "asklist",
                "userId"        : String(myString),
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
                                self.arr_mut_video_list.addObjects(from: ar as! [Any])
                                
                                self.tble_view.delegate = self
                                self.tble_view.dataSource = self
                                self.tble_view.reloadData()
                                
                                // self.tble_view.reloadData()
                                // self.video_list_WB(page_number: 1)
                                
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
    
    
}

extension my_question_list : UITableViewDelegate , UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arr_mut_video_list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:my_question_list_table_cell = tableView.dequeueReusableCell(withIdentifier: "my_question_list_table_cell") as! my_question_list_table_cell
        
        cell.backgroundColor = .clear
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = .clear
        cell.selectedBackgroundView = backgroundView
        
        let item = self.arr_mut_video_list[indexPath.row] as? [String:Any]
        print(item as Any)
        
        /*
         askId = 7;
         categoryId = 29;
         created = "Oct 17th, 2022, 8:35 am";
         email = "test1@gmail.com";
         name = "test_1";
         question = "Uhuhuh hub high vcng";
         reply = "";
         replyDate = "";
         userId = 8;
         */
        
        let yourAttributes_1 = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont(name: "Poppins-SemiBold", size: 16.0)!]
        
        let yourAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemRed, NSAttributedString.Key.font: UIFont(name: "Poppins-SemiBold", size: 16.0)!]
        let yourOtherAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont(name: "Poppins-Regular", size: 14.0)!]
        
        let partOne_1 = NSMutableAttributedString(string: "", attributes: yourAttributes_1)
        
        let partOne = NSMutableAttributedString(string: "Q\(indexPath.row+1). "+(item!["question"] as! String)+"\n", attributes: yourAttributes)
        let partTwo = NSMutableAttributedString(string: "Ans. "+(item!["reply"] as! String), attributes: yourOtherAttributes)
        
        let combination = NSMutableAttributedString()
        
        combination.append(partOne_1)
        combination.append(partOne)
        combination.append(partTwo)
        
        cell.lbl_title.attributedText = combination
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
        
    }
    
}

class my_question_list_table_cell:UITableViewCell {
    
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
    
    
}
