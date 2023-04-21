//
//  ask_me.swift
//  Vedanta
//
//  Created by Dishant Rajput on 15/09/22.
//

import UIKit
import Alamofire

class ask_me: UIViewController {
    
    var int_expand_cell_index:Int!
    
    var str_index_click:String! = "0"
    
    var arr_mut_ask_me:NSMutableArray! = []
    
    @IBOutlet weak var btn_back:UIButton! {
        didSet {
            btn_back.tintColor = .black
        }
    }
    
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
        
        self.tble_view.separatorColor = UIColor.clear
//        UIColor.init(red: 230.0/255.0, green: 40.0/255.0, blue: 36.0/255.0, alpha: 1)
        
        // self.btn_back.addTarget(self, action: #selector(back_click_method), for: .touchUpInside)
        
//        self.tabBarController?.tabBar.backgroundColor = UIColor.init(red: 250.0/255.0, green: 250.0/255.0, blue: 255.0/255.0, alpha: 1)
        
        self.ask_me_anything(page_number: 1)
        
        // self.create_custom_array()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if let person = UserDefaults.standard.value(forKey: "key_from_ask_quesiton") as? [String:Any] {
            
            print(person as Any)
            
            // self.tble_view.delegate
            self.tble_view.reloadData()
            
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
    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//
//        if scrollView == self.tble_view {
//            let isReachingEnd = scrollView.contentOffset.y >= 0
//            && scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height)
//            if(isReachingEnd) {
//                if(loadMore == 1) {
//                    loadMore = 0
//                    page += 1
//                    print(page as Any)
//
//                    self.ask_me_anything(page_number: page)
//
//                }
//            }
//        }
//    }
    
    @objc func ask_me_anything(page_number:Int) {
        self.view.endEditing(true)
        
        self.arr_mut_ask_me.removeAllObjects()
        
        ERProgressHud.sharedInstance.showDarkBackgroundView(withTitle: "Please wait...")
        
        if IsInternetAvailable() == false {
            self.please_check_your_internet_connection()
            return
        }
        
        let parameters = [
            "action"    : "category",
            "type"      : String("Faq"),
            
            // "categoryId"    : page_number,
            // "pageNo"        : page_number,
            
           // "action"    : "category",
           // "type"      : String("Faq"),
            /*"action"    : "faqlist",
            "pageNo"    : page_number*/
            
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
                            // self.arr_mut_ask_me.addObjects(from: ar as! [Any])
                            
                            for _ in 0..<1 {
                                
                                let custom_array = [
                                    "status":"header"
                                ]
                                self.arr_mut_ask_me.add(custom_array)
                                
                            }
                            
                            for indexx in 0..<ar.count {
                                
                                let item = ar[indexx] as? [String:Any]
                                
                                let custom_array = [
                                    "status"    : "list",
                                    "id"        : "\(item!["id"]!)",
                                    "name"      : (item!["name"] as! String),
                                    "image"     : (item!["image"] as! String),
                                    
                                    
                                ]
                                self.arr_mut_ask_me.add(custom_array)
                                
                            }
                            
                            print(self.arr_mut_ask_me as Any)
                            
                            self.tble_view.delegate = self
                            self.tble_view.dataSource = self
                            self.tble_view.reloadData()
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

extension ask_me : UITableViewDelegate , UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arr_mut_ask_me.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let item = self.arr_mut_ask_me[indexPath.row] as? [String:Any]
        
        if (item!["status"] as! String) == "header" {
            
            let cell:ask_me_table_cell = tableView.dequeueReusableCell(withIdentifier: "ask_me_header_table_cell") as! ask_me_table_cell
            
            cell.backgroundColor = .clear
            
            let backgroundView = UIView()
            backgroundView.backgroundColor = .clear
            cell.selectedBackgroundView = backgroundView
            
            cell.segment_control.addTarget(self, action: #selector(segment_control_click_2), for: .valueChanged)
            cell.btn_ask_me.addTarget(self, action: #selector(ask_me_click_method), for: .touchUpInside)
            
            return cell
            
        } else {
            
            let cell:ask_me_table_cell = tableView.dequeueReusableCell(withIdentifier: "ask_me_list_table_cell") as! ask_me_table_cell
            
            cell.backgroundColor = .clear
            
            let backgroundView = UIView()
            backgroundView.backgroundColor = .clear
            cell.selectedBackgroundView = backgroundView
            
            /*let int_1 = (item!["question"] as! String).count
            print(int_1)
            
            let yourAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemRed, NSAttributedString.Key.font: UIFont(name: "Avenir Next Bold", size: 16.0)!]
            let yourOtherAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont(name: "Avenir Next", size: 14.0)!]
            
            let partOne = NSMutableAttributedString(string: (item!["question"] as! String)+"\n\n", attributes: yourAttributes)
            let partTwo = NSMutableAttributedString(string: (item!["answer"] as! String), attributes: yourOtherAttributes)
            
            let combination = NSMutableAttributedString()
            
            combination.append(partOne)
            combination.append(partTwo)*/
            
            cell.lbl_list_answer.text = (item!["name"] as! String) // attributedText = combination
            
//            cell.accessoryType = .disclosureIndicator
            
            return cell
            
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // self.int_expand_cell_index = 0
        // self.int_expand_cell_index = indexPath.row
        
        // self.str_index_click = "1"
        
        // self.tble_view.reloadData()
        
        let item = self.arr_mut_ask_me[indexPath.row] as? [String:Any]
        
        let pushVC = self.storyboard?.instantiateViewController(withIdentifier: "ask_me_faq_cat_id") as! ask_me_faq_cat
        
        pushVC.str_category_name = (item!["name"] as! String)
        pushVC.str_category_id = "\(item!["id"]!)"
        
        self.navigationController?.pushViewController(pushVC, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let item = self.arr_mut_ask_me[indexPath.row] as? [String:Any]
        
        if (item!["status"] as! String) == "header" {
            return 240
        } else {
            
            return 60
        }
        
    }
    
}

class ask_me_table_cell:UITableViewCell {
    
    @IBOutlet weak var view_bg:UIView! {
        didSet {
//            view_bg.createDottedLine(width: 5.0, color: UIColor.cyan.cgColor)
//            /*view_bg.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
//            view_bg.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
//            view_bg.layer.shadowOpacity = 1.0
//            view_bg.layer.shadowRadius = 4
//            view_bg.layer.masksToBounds = false
//            view_bg.layer.cornerRadius = 15
//            view_bg.backgroundColor = .white*/
//            view_bg.backgroundColor = .white
//            view_bg.layer.borderWidth = 1
//            view_bg.layer.borderColor = UIColor.gray.cgColor
            
//            let yourViewBorder = CAShapeLayer()
//            yourViewBorder.strokeColor = UIColor.black.cgColor
//            yourViewBorder.lineDashPattern = [2, 2]
////            yourViewBorder.frame = view_bg.bounds
//            yourViewBorder.fillColor = nil
//            yourViewBorder.path = UIBezierPath(rect: view_bg.bounds).cgPath
//            view_bg.layer.addSublayer(yourViewBorder)
            
//            view_bg.addDashedBorder()
            view_bg.backgroundColor = .clear
//            view_bg.layer.cornerRadius = 14
//            view_bg.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var lbl_header_message:UILabel! {
        didSet {
            lbl_header_message.text = "Dealing with an issue and need guidance ? Post your question here."
//            lbl_header_message.textColor = .systemOrange
            lbl_header_message.textColor = UIColor.init(red: 237.0/255.0, green: 123.0/255.0, blue: 116.0/255.0, alpha: 1)
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
    
    @IBOutlet weak var view_bg_cell:UIView! {
        didSet {
            view_bg_cell.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            view_bg_cell.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            view_bg_cell.layer.shadowOpacity = 1.0
            view_bg_cell.layer.shadowRadius = 4
            view_bg_cell.layer.masksToBounds = false
            view_bg_cell.layer.cornerRadius = 4
            view_bg_cell.backgroundColor = .white
            view_bg_cell.backgroundColor = .white
//            view_bg.layer.borderWidth = 1
//            view_bg.layer.borderColor = UIColor.gray.cgColor
        }
    }
    
    @IBOutlet weak var lbl_list_answer:UILabel!
    
}


extension UIView {
    func addDashedBorder() {
        let color = UIColor.red.cgColor

        let shapeLayer:CAShapeLayer = CAShapeLayer()
        let frameSize = self.frame.size
        let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width, height: frameSize.height)

        shapeLayer.bounds = shapeRect
        shapeLayer.position = CGPoint(x: frameSize.width/2, y: frameSize.height/2)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color
        shapeLayer.lineWidth = 2
        shapeLayer.lineJoin = CAShapeLayerLineJoin.round
        shapeLayer.lineDashPattern = [6,3]
        shapeLayer.path = UIBezierPath(roundedRect: shapeRect, cornerRadius: 5).cgPath

        self.layer.addSublayer(shapeLayer)
        }
//   func createDottedLine(width: CGFloat, color: CGColor) {
//      let caShapeLayer = CAShapeLayer()
//      caShapeLayer.strokeColor = color
//      caShapeLayer.lineWidth = width
//      caShapeLayer.lineDashPattern = [2,3]
//      let cgPath = CGMutablePath()
//      let cgPoint = [CGPoint(x: 0, y: 0), CGPoint(x: self.frame.width, y: 0)]
//      cgPath.addLines(between: cgPoint)
//      caShapeLayer.path = cgPath
//      layer.addSublayer(caShapeLayer)
//   }
}
