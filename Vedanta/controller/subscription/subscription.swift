//
//  subscription.swift
//  Vedanta
//
//  Created by Dishant Rajput on 25/10/22.
//

import UIKit
import Alamofire
import Razorpay
import StoreKit

// subscription

class subscription: UIViewController, RazorpayProtocol, SKProductsRequestDelegate, SKPaymentTransactionObserver {

    var razorpayObj : RazorpayCheckout? = nil
    let defaultHeight : CGFloat = 40
    let defaultWidth : CGFloat = 120
    
    var str_selected_product_id:String!
    
    var product_id_for_1_month_in_india: String!
    var product_id_for_1_year_in_india: String!
    
    var product_id_for_1_month_outside_india: String!
    var product_id_for_1_year_outside_india: String!
    
    let razorpayKey = "rzp_test_quxokCn0jdMYYD"
    // let razorpayKey = "rzp_live_sLzp2Hk7Arurvl"
    
    var str_amount_to_send:String! = "0"
    var str_user_select_subscription:String! = "0"
    
    var arr_price_array:NSMutableArray! = []
    
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
            
            tble_view.backgroundColor = .white
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.view_full_view.backgroundColor = app_BG_color
        self.btn_back.addTarget(self, action: #selector(back_click_method), for: .touchUpInside)
        
        self.tble_view.separatorColor = .clear
        
        // in-app purchase
        SKPaymentQueue.default().add(self)
        
        product_id_for_1_month_in_india = "vedanta_vision_1_month_subscription_in_india"
        product_id_for_1_year_in_india = "vedanta_vision_1_year_subscription_in_india"
        product_id_for_1_month_outside_india = "vedanta_vision_1_month_subscription_outside_india"
        product_id_for_1_year_outside_india = "vedanta_vision_1_year_subscription_outside_india"
        
        self.subscriptions_list_WB()
        
    }

    
    
    @IBAction func openCheckoutAction(_ sender: UIButton) {
        // self.openRazorpayCheckout()
    }
    
    private func openRazorpayCheckout(membership_price:Int,
                                      membership_currency:String,
                                      membership_description:String) {
        // 1. Initialize razorpay object with provided key. Also depending on your requirement you can assign delegate to self. It can be one of the protocol from RazorpayPaymentCompletionProtocolWithData, RazorpayPaymentCompletionProtocol.
        razorpayObj = RazorpayCheckout.initWithKey(razorpayKey, andDelegate: self)
        let options: [AnyHashable:Any] = [
            "prefill": [
                "contact": "",
                "email": ""
                
            ],
            "name"          : "Vedanta Membership Plan",
            "description"   : String(membership_description),
            "image"         : "http://www.freepngimg.com/download/light/2-2-light-free-download-png.png",
            "amount"        : membership_price,
            "currency"      : String(membership_currency),
            "timeout"       : 900,
            "theme": [
                "color": "#F37254"
            ]
            
            //            "order_id": "order_B2i2MSq6STNKZV"
            // and all other options
            
        ]
        if let rzp = self.razorpayObj {
            rzp.open(options)
        } else {
            print("Unable to initialize")
        }
    }
    
    // monthly outside
    @IBAction func tapFunction_monthly_oc(sender: UITapGestureRecognizer) {
        print("tap working 1")
        
        let item = self.arr_price_array[0] as? [String:Any]
        
        let final_price = (item!["price"] as! Int)*100
        
        self.str_user_select_subscription = "\(item!["subscriptionId"]!)"
        
        self.str_amount_to_send = "\(item!["price"]!)"
        
        //
        /*
         product_id_for_6_month_in_india = "vedanta_vision_6_months_subscription_in_india"
         product_id_for_1_year_in_india = "vedanta_vision_1_year_subscription_in_india"
         
         product_id_for_6_month_outside_india = "vedanta_vision_6_months_subscription_outside_india"
         product_id_for_1_year_outside_india = "vedanta_vision_1_year_subscription_outside_india"
         */
        
        self.str_selected_product_id = self.product_id_for_1_month_outside_india
        self.submit_subscription_click_method()
        
        /*self.openRazorpayCheckout(membership_price: final_price,
                                  membership_currency: "USD",
                                  membership_description: "Monthly subscription")*/
    }
    
    // yearly outside country
    @IBAction func tapFunction_yearly_oc(sender: UITapGestureRecognizer) {
        print("tap working 2")
        
        let item = self.arr_price_array[1] as? [String:Any]
        
        let final_price = (item!["price"] as! Int)*100
        
        self.str_user_select_subscription = "\(item!["subscriptionId"]!)"
        self.str_amount_to_send = "\(item!["price"]!)"
        
        
        /*
         product_id_for_6_month_in_india = "vedanta_vision_6_months_subscription_in_india"
         product_id_for_1_year_in_india = "vedanta_vision_1_year_subscription_in_india"
         
         product_id_for_6_month_outside_india = "vedanta_vision_6_months_subscription_outside_india"
         product_id_for_1_year_outside_india = "vedanta_vision_1_year_subscription_outside_india"
         */
        
        self.str_selected_product_id = self.product_id_for_1_year_outside_india
        self.submit_subscription_click_method()
        
        /*self.openRazorpayCheckout(membership_price: final_price,
                                  membership_currency: "USD",
                                  membership_description: "Yearly subscription")*/
        
        
        
        // self.update_payment_WB()
    }
    
    // monthly inside
    @IBAction func tapFunction_monthly_in(sender: UITapGestureRecognizer) {
        print("tap working in 1")
        
        let item = self.arr_price_array[0] as? [String:Any]
        
        let final_price = (item!["price_IND"] as! Int)*100
        
        self.str_user_select_subscription = "\(item!["subscriptionId"]!)"
        self.str_amount_to_send = "\(item!["price_IND"]!)"
        
        
        /*
         product_id_for_6_month_in_india = "vedanta_vision_6_months_subscription_in_india"
         product_id_for_1_year_in_india = "vedanta_vision_1_year_subscription_in_india"
         
         product_id_for_6_month_outside_india = "vedanta_vision_6_months_subscription_outside_india"
         product_id_for_1_year_outside_india = "vedanta_vision_1_year_subscription_outside_india"
         */
        
        self.str_selected_product_id = self.product_id_for_1_month_in_india
        self.submit_subscription_click_method()
        
        /*self.openRazorpayCheckout(membership_price: final_price,
                                  membership_currency: "INR",
                                  membership_description: "Monthly subscription")*/
    }
    
    // yearly inside
    @IBAction func tapFunction_yearly_in(sender: UITapGestureRecognizer) {
        print("tap working in 2")
        
        let item = self.arr_price_array[1] as? [String:Any]
        
        let final_price = (item!["price_IND"] as! Int)*100
        
        self.str_user_select_subscription = "\(item!["subscriptionId"]!)"
        self.str_amount_to_send = "\(item!["price_IND"]!)"
        
        
        
        /*
         product_id_for_6_month_in_india = "vedanta_vision_6_months_subscription_in_india"
         product_id_for_1_year_in_india = "vedanta_vision_1_year_subscription_in_india"
         
         product_id_for_6_month_outside_india = "vedanta_vision_6_months_subscription_outside_india"
         product_id_for_1_year_outside_india = "vedanta_vision_1_year_subscription_outside_india"
         */
        
        self.str_selected_product_id = self.product_id_for_1_year_in_india
        self.submit_subscription_click_method()
        /*self.openRazorpayCheckout(membership_price: final_price,
                                  membership_currency: "INR",
                                  membership_description: "Yearly subscription")*/
        
    }
    
    
    @objc func submit_subscription_click_method() {
        
        print(self.str_selected_product_id as Any)
        
        self.init_in_app_purchase()
    }
    
    
    @objc func init_in_app_purchase() {
        
        // print(str_selected_product_id)
        if (SKPaymentQueue.canMakePayments()) {
            
            ERProgressHud.sharedInstance.showDarkBackgroundView(withTitle: "please wait...")
            
            let productID:NSSet = NSSet(object: self.str_selected_product_id!);
            print(productID)
            
            let productsRequest:SKProductsRequest = SKProductsRequest(productIdentifiers: productID as! Set<String>);
            productsRequest.delegate = self
            productsRequest.start()
            print("Fetching Products")
            
            
            
        } else {
            
            print("Can't make purchases")
            
        }
        
    }
    
    
    func buyProduct(product: SKProduct) {
        
        print("Sending the Payment Request to Apple");
        let payment = SKPayment(product: product)
        SKPaymentQueue.default().add(payment);
        
    }
    
    
    
    // delegate method
    func productsRequest (_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        
        let count : Int = response.products.count
        if (count>0) {
            let validProduct: SKProduct = response.products[0] as SKProduct
            if (validProduct.productIdentifier == self.str_selected_product_id) {
                
                print(validProduct.localizedTitle)
                print(validProduct.localizedDescription)
                print(validProduct.price)
                buyProduct(product: validProduct)
                
            } else {
                
                print(validProduct.productIdentifier)
                
            }
        } else {
            
            ERProgressHud.sharedInstance.hide()
            print("nothing")
            print(response)
            print(request)
            
        }
    }
    
    
    func request(_ request: SKRequest, didFailWithError error: Error) {
        print("Error Fetching product information");
        
        ERProgressHud.sharedInstance.hide()
        
        let alertController = UIAlertController(title: "Error", message: "Error Fetching product information. Please try again after sometime", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action:UIAlertAction!) in
        }
        
        alertController.addAction(cancel)
        self.present(alertController, animated: true, completion:nil)
    }
    
    func paymentQueue(_ queue: SKPaymentQueue,
                      updatedTransactions transactions: [SKPaymentTransaction])
    
    {
        print("Received Payment Transaction Response from Apple");
        
        for transaction:AnyObject in transactions {
            if let trans:SKPaymentTransaction = transaction as? SKPaymentTransaction{
                switch trans.transactionState {
                case .purchased:
                    
                    
                    
                    
                    // if you successfully purchased an item
                    print("Product Purchased")
                    SKPaymentQueue.default().finishTransaction(transaction as! SKPaymentTransaction)
                    // Handle the purchase
                    UserDefaults.standard.set(true , forKey: "purchased")
                    
                    
                    // UPDATE PAYMENT IN OUR SERVER
                    self.update_payment_WB(str_transaction_id: "in-app-purchase")
//                    self.update_payment_in_our_Server()
                    
                    
                    
                    //adView.hidden = true
                    
                    break;
                case .failed:
                    
                    ERProgressHud.sharedInstance.hide()
                    print("Purchased Failed");
                    SKPaymentQueue.default().finishTransaction(transaction as! SKPaymentTransaction)
                    
                    break;
                    
                case .restored:
                    
                    ERProgressHud.sharedInstance.hide()
                    
                    print("Already Purchased");
                    SKPaymentQueue.default().restoreCompletedTransactions()
                    
                    
                    // Handle the purchase
                    UserDefaults.standard.set(true , forKey: "purchased")
                    //adView.hidden = true
                    
                    
                    
                    break;
                    
                default:
                    break;
                }
            }
        }
        
    }
    
    
    
    
    
    
    
    @objc func subscriptions_list_WB() {
        ERProgressHud.sharedInstance.showDarkBackgroundView(withTitle: "Please wait...")
        
        self.view.endEditing(true)
        
            let parameters = [
                "action"            : "subscriptionslist",
            ]
            
            AF.request(application_base_url,
                       method: .post,
                       parameters: parameters,
                       encoder: JSONParameterEncoder.default).responseJSON { response in
                // debugPrint(response.result)
                
                switch response.result {
                case let .success(value):
                    
                    let JSON = value as! NSDictionary
                    print(JSON as Any)
                    
                    var strSuccess : String!
                    strSuccess = JSON["status"]as Any as? String
                    
                    var strSuccess2 : String!
                    strSuccess2 = JSON["msg"]as Any as? String
                    
                    if strSuccess == String("success") {
                        print("yes")
                        ERProgressHud.sharedInstance.hide()
                         
                            
                        var ar : NSArray!
                        ar = (JSON["data"] as! Array<Any>) as NSArray
                             
                        print(ar as Any)
                        
                        self.arr_price_array.addObjects(from: ar as! [Any])
                        
                        self.tble_view.delegate = self
                        self.tble_view.dataSource = self
                        self.tble_view.reloadData()
                        
                    } else {
                        
                        print("no")
                        ERProgressHud.sharedInstance.hide()
                        
                        var strSuccess2 : String!
                        strSuccess2 = JSON["msg"]as Any as? String
                        
                        let alert = UIAlertController(title: String(strSuccess), message: String(strSuccess2), preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                        
                    }
                    
                case let .failure(error):
                    print(error)
                    ERProgressHud.sharedInstance.hide()
                    
                    let alert = UIAlertController(title: String("Error!"), message: String("Server Issue"), preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    
                }
            }
        
    }
    
    
    
    
    
    @objc func update_payment_WB(str_transaction_id:String) {
        // ERProgressHud.sharedInstance.showDarkBackgroundView(withTitle: "Please wait...")
        
        self.view.endEditing(true)
        
        if let person = UserDefaults.standard.value(forKey: "keyLoginFullData") as? [String:Any] {
            // let str:String = person["role"] as! String
            
            let x : Int = person["userId"] as! Int
            let myString = String(x)
            
            /*
             product_id_for_1_month_in_india = "vedanta_vision_1_month_subscription_in_india"
             product_id_for_1_year_in_india = "vedanta_vision_1_year_subscription_in_india"
             product_id_for_1_month_outside_india = "vedanta_vision_1_month_subscription_outside_india"
             product_id_for_1_year_outside_india = "vedanta_vision_1_year_subscription_outside_india"
             */
            
            var str_in_app_purchase:String! = "0"
            
            if self.str_selected_product_id == "vedanta_vision_1_month_subscription_in_india" {
                str_in_app_purchase = "1500"
            } else if self.str_selected_product_id == "vedanta_vision_1_year_subscription_in_india" {
                str_in_app_purchase = "15000"
            } else if self.str_selected_product_id == "vedanta_vision_1_month_subscription_outside_india" {
                str_in_app_purchase = "20"
            } else {
                str_in_app_purchase = "220"
            }
            
            
            
            let parameters = [
                "action"            : "updatesubscription",
                "userId"            : String(myString),
                "transactionId"     : String(str_transaction_id),
                "amount"            : String(str_in_app_purchase),
                "subscriptionId"    : String(self.str_user_select_subscription),
            ]
            
            print(parameters as Any)
            
            AF.request(application_base_url,
                       method: .post,
                       parameters: parameters,
                       encoder: JSONParameterEncoder.default).responseJSON { response in
                // debugPrint(response.result)
                
                switch response.result {
                case let .success(value):
                    
                    let JSON = value as! NSDictionary
                    print(JSON as Any)
                    
                    var strSuccess : String!
                    strSuccess = JSON["status"]as Any as? String
                    
                    var strSuccess2 : String!
                    strSuccess2 = JSON["msg"]as Any as? String
                    
                    if strSuccess == String("success") {
                        print("yes")
                        // ERProgressHud.sharedInstance.hide()
                        
                        self.get_profile_data(str_message: strSuccess2)
                        // self.back_click_method()
                        
                        
                        
                    } else {
                        
                        print("no")
                        ERProgressHud.sharedInstance.hide()
                        
                        var strSuccess2 : String!
                        strSuccess2 = JSON["msg"]as Any as? String
                        
                        let alert = UIAlertController(title: String(strSuccess), message: String(strSuccess2), preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                        
                    }
                    
                case let .failure(error):
                    print(error)
                    ERProgressHud.sharedInstance.hide()
                    
                    let alert = UIAlertController(title: String("Error!"), message: String("Server Issue"), preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    
                }
            }
        }
    }
    
    
    
    @objc func get_profile_data(str_message:String) {
        self.view.endEditing(true)
        
        // ERProgressHud.sharedInstance.showDarkBackgroundView(withTitle: "Please wait...")
        
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
                "action"    : "profile",
                "userId"   : String(myString)
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
                                
                                var dict: Dictionary<AnyHashable, Any>
                                dict = jsonDict["data"] as! Dictionary<AnyHashable, Any>
                                
                                let defaults = UserDefaults.standard
                                defaults.setValue(dict, forKey: str_save_login_user_data)
                                 
                                // self.back_click_method()
                                
                                
                                let alert = UIAlertController(title: String("Success"), message: String(str_message), preferredStyle: UIAlertController.Style.alert)
                                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { action in
                                    
                                    self.navigationController?.popViewController(animated: true)
                                    
                                    
                                }))
                                self.present(alert, animated: true, completion: nil)
                                
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
                        
                        print(response.error?.localizedDescription as Any, terminator: "<==== I AM ERROR")
                        
                        self.something_went_wrong_with_WB()
                        
                    }
                }
        }
    }
    
}

extension subscription : UITableViewDelegate , UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:subscription_table_cell = tableView.dequeueReusableCell(withIdentifier: "subscription_table_cell") as! subscription_table_cell
        
        cell.backgroundColor = .white
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = .clear
        cell.selectedBackgroundView = backgroundView
        
        let locale: NSLocale = NSLocale.current as NSLocale
        let country: String? = locale.countryCode
        print(country ?? "no country")
        
        cell.lbl_annual.text = "Annualy"
        cell.lbl_monthly.text = "Monthly"
        
        
        
        if "\(country!)" == "IN" {
            
            // arr_price_array
            
            for indexx in 0..<self.arr_price_array.count {
                
                let item = self.arr_price_array[indexx] as? [String:Any]
                
                if indexx == 0 {
                    cell.lbl_monthly_price.text = "\(item!["price_IND"]!)"
                } else {
                    cell.lbl_yearly_price.text = "\(item!["price_IND"]!)"
                }
                
            }
            
            
            
            
            
            let tap_monthly = UITapGestureRecognizer(target: self, action: #selector(subscription.tapFunction_monthly_in))
            cell.lbl_monthly_price.isUserInteractionEnabled = true
            cell.lbl_monthly_price.addGestureRecognizer(tap_monthly)
            
            let tap_yearly = UITapGestureRecognizer(target: self, action: #selector(subscription.tapFunction_yearly_in))
            cell.lbl_yearly_price.isUserInteractionEnabled = true
            cell.lbl_yearly_price.addGestureRecognizer(tap_yearly)
            
        } else {
            
            // cell.lbl_yearly_price.text = "USD 220/-"
            // cell.lbl_monthly_price.text = "USD 20/-"
            
            for indexx in 0..<self.arr_price_array.count {
                
                let item = self.arr_price_array[indexx] as? [String:Any]
                
                if indexx == 0 {
                    cell.lbl_monthly_price.text = "$\(item!["price"]!)"
                } else {
                    cell.lbl_yearly_price.text = "$\(item!["price"]!)"
                }
                
            }
            
            let tap_monthly = UITapGestureRecognizer(target: self, action: #selector(subscription.tapFunction_monthly_oc))
            cell.lbl_monthly_price.isUserInteractionEnabled = true
            cell.lbl_monthly_price.addGestureRecognizer(tap_monthly)
            
            let tap_yearly = UITapGestureRecognizer(target: self, action: #selector(subscription.tapFunction_yearly_oc))
            cell.lbl_yearly_price.isUserInteractionEnabled = true
            cell.lbl_yearly_price.addGestureRecognizer(tap_yearly)
            
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
         
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 630
    }
    
}

class subscription_table_cell:UITableViewCell {
    
    @IBOutlet weak var view_bg:UIView! {
        didSet {
            view_bg.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            view_bg.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            view_bg.layer.shadowOpacity = 1.0
            view_bg.layer.shadowRadius = 4
            view_bg.layer.masksToBounds = false
            view_bg.layer.cornerRadius = 8
            view_bg.backgroundColor = UIColor.init(red: 22.0/255.0, green: 12.0/255.0, blue: 87.0/255.0, alpha: 1)
        }
    }
    
    @IBOutlet weak var lbl_annual:UILabel! {
        didSet {
            lbl_annual.backgroundColor = UIColor.init(red: 22.0/255.0, green: 12.0/255.0, blue: 87.0/255.0, alpha: 1)
            lbl_annual.layer.cornerRadius = 6
            lbl_annual.clipsToBounds = true
            lbl_annual.textColor = .white
        }
    }
    
    @IBOutlet weak var lbl_monthly:UILabel! {
        didSet {
            lbl_monthly.backgroundColor = UIColor.init(red: 22.0/255.0, green: 12.0/255.0, blue: 87.0/255.0, alpha: 1)
            lbl_monthly.layer.cornerRadius = 6
            lbl_monthly.clipsToBounds = true
            lbl_monthly.textColor = .white
        }
    }
    
    @IBOutlet weak var view_2_1:UIView! {
        didSet {
            view_2_1.backgroundColor = .clear
        }
    }
    
    @IBOutlet weak var view_2_2:UIView! {
        didSet {
            view_2_2.backgroundColor = UIColor.init(red: 230.0/255.0, green: 41.0/255.0, blue: 36.0/355.0, alpha: 1)
            view_2_2.layer.cornerRadius = 8
            view_2_2.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var view_3_1:UIView! {
        didSet {
            view_3_1.backgroundColor = .clear
            
        }
    }
    @IBOutlet weak var view_3_2:UIView! {
        didSet {
            view_3_2.backgroundColor = UIColor.init(red: 230.0/255.0, green: 41.0/255.0, blue: 36.0/355.0, alpha: 1)
            view_3_2.layer.cornerRadius = 8
            view_3_2.clipsToBounds = true
            
             
            
        }
    }
    
    @IBOutlet weak var lbl_monthly_price:UILabel!
    @IBOutlet weak var lbl_yearly_price:UILabel!
    
    @IBOutlet weak var view_1_full:UIView! {
        didSet {
            view_1_full.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            view_1_full.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            view_1_full.layer.shadowOpacity = 1.0
            view_1_full.layer.shadowRadius = 4
            view_1_full.layer.masksToBounds = false
            view_1_full.layer.cornerRadius = 8
            view_1_full.backgroundColor = .clear
        }
    }
    
    @IBOutlet weak var view_2_full:UIView! {
        didSet {
            view_2_full.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            view_2_full.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            view_2_full.layer.shadowOpacity = 1.0
            view_2_full.layer.shadowRadius = 4
            view_2_full.layer.masksToBounds = false
            view_2_full.layer.cornerRadius = 8
            view_2_full.backgroundColor = .clear
        }
    }
    
}

extension subscription : RazorpayPaymentCompletionProtocol {
    
    func onPaymentError(_ code: Int32, description str: String) {
        print("error: ", code, str)
        ERProgressHud.sharedInstance.hide()
        
        self.presentAlert(withTitle: "Alert", message: str)
    }
    
    func onPaymentSuccess(_ payment_id: String) {
        print("success: ", payment_id)
        self.presentAlert(withTitle: "Success", message: "Payment Succeeded")
        
        ERProgressHud.sharedInstance.hide()
        self.update_payment_WB(str_transaction_id: payment_id)
    }
    
}

// RazorpayPaymentCompletionProtocolWithData - This will returns you the data in both error and success case. On payment failure you will get a code and description. In payment success you will get the payment id.
extension subscription: RazorpayPaymentCompletionProtocolWithData {
    
    func onPaymentError(_ code: Int32, description str: String, andData response: [AnyHashable : Any]?) {
        print("error: ", code)
        self.presentAlert(withTitle: "Alert", message: str)
    }
    
    func onPaymentSuccess(_ payment_id: String, andData response: [AnyHashable : Any]?) {
        print("success: ", payment_id)
        self.presentAlert(withTitle: "Success", message: "Payment Succeeded")
    }
    
}

extension subscription {
    
    func presentAlert(withTitle title: String?, message : String?) {
        
        DispatchQueue.main.async {
            
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "Okay", style: .default)
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion: nil)

        }
        
    }
    
}

