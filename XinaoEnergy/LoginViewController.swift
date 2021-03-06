//
//  LoginViewController.swift
//  XinaoEnergy
//
//  Created by zx on 1976/4/1.
//  Copyright © 2018年 jun. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class LoginViewController: UIViewController,UIScrollViewDelegate,UITextFieldDelegate {
    
    var scrollView : UIScrollView = UIScrollView()
    var textPassField : UITextField = UITextField()
    var textNameField : UITextField = UITextField()
    let contentView = UIView()
    //本地存储
    var userDefault = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        textNameField.delegate = self
        textPassField.delegate = self
        scrollView.delegate = self
        setLayoutFrame()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardDidHide, object: nil)
    }
    
    @objc func keyboardWillShow(notification:NSNotification){
        if ((notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue) != nil {
        let width = self.view.frame.size.width
        let height = self.view.frame.size.height
        let rect = CGRect(x: 0, y: -156, width: width, height: height)
        self.view.frame = rect
        }
    }

    @objc func keyboardWillHide(notification:NSNotification){
        let width = self.view.frame.size.width
        let height = self.view.frame.size.height
        let rect = CGRect(x: 0, y: 0, width: width, height: height)
        self.view.frame = rect
    }
    func setLayoutFrame(){
        
        
        contentView.backgroundColor = UIColor.white
        
        let logoView = UIImageView(image: UIImage(named: "Group 13"))
        logoView.frame = CGRect(x: view.frame.width/2-20, y: UIScreen.main.bounds.height*2/5-50, width: 40, height: 50)
        contentView.addSubview(logoView)
        
        let inputView = UIView(frame: CGRect(x: 15, y: UIScreen.main.bounds.height*2/5+20, width: view.frame.width-30, height: 80))
        let inputNameView = UIView(frame: CGRect(x: 0, y: 0, width: inputView.frame.width, height: 40))
        let inputNameImageView = UIImageView(image: UIImage(named: "用户名 copy"))
        inputNameImageView.frame = CGRect(x: 0, y: 10, width: 20, height: 20)
        
        textNameField.frame = CGRect(x: 30, y: 0, width: inputNameView.frame.width-30, height: inputNameView.frame.height)
        textNameField.adjustsFontSizeToFitWidth=true  //当文字超出文本框宽度时，自动调整文字大小
        textNameField.minimumFontSize=11  //最小可缩小的字号
        /** 水平对齐 **/
        textNameField.textAlignment = .left
        /** 垂直对齐 **/
        textNameField.contentVerticalAlignment = .center
        textNameField.clearButtonMode = .whileEditing  //编辑时出现清除按钮
        //textField.clearButtonMode = .unlessEditing  //编辑时不出现，编辑后才出现清除按钮
        //textNameField.clearButtonMode = .always  //一直显示清除按钮
        textNameField.keyboardType = UIKeyboardType.default
        //textNameField.becomeFirstResponder()
        textNameField.font = UIFont.boldSystemFont(ofSize: 14)
        textNameField.tag = 1
        textNameField.returnKeyType = UIReturnKeyType.next
        textNameField.placeholder = "用户名"
        textNameField.text = ""
        
        let nameButtomLabel = UILabel(frame: CGRect(x: 0, y: 39, width: inputNameView.frame.width, height: 1))
        nameButtomLabel.backgroundColor = UIColor(red: 229/255, green: 229/255, blue: 229/255, alpha: 1)
        inputNameView.addSubview(inputNameImageView)
        inputNameView.addSubview(nameButtomLabel)
        inputNameView.addSubview(textNameField)
        inputView.addSubview(inputNameView)
        
        
        let inputPassView = UIView(frame: CGRect(x: 0, y: 40, width: inputView.frame.width, height: 40))
        let inputPassImageView = UIImageView(image: UIImage(named: "密码 copy"))
        inputPassImageView.frame = CGRect(x: 0, y: 10, width: 20, height: 20)
        
        textPassField.frame = CGRect(x: 30, y: 0, width: inputPassView.frame.width-30, height: inputPassView.frame.height)
        textPassField.adjustsFontSizeToFitWidth=true  //当文字超出文本框宽度时，自动调整文字大小
        textPassField.minimumFontSize=11  //最小可缩小的字号
        /** 水平对齐 **/
        textPassField.textAlignment = .left
        /** 垂直对齐 **/
        textPassField.contentVerticalAlignment = .center
        textPassField.clearButtonMode = .whileEditing  //编辑时出现清除按钮
        //textField.clearButtonMode = .unlessEditing  //编辑时不出现，编辑后才出现清除按钮
        //textPassField.clearButtonMode = .always  //一直显示清除按钮
        textPassField.keyboardType = UIKeyboardType.default
        textPassField.returnKeyType = UIReturnKeyType.done //表示完成输入
        textPassField.font = UIFont.boldSystemFont(ofSize: 14)
        textPassField.tag = 2
        textPassField.placeholder = "密码"
        textPassField.text = ""
        
        let passButtomLabel = UILabel(frame: CGRect(x: 0, y: 39, width: inputNameView.frame.width, height: 1))
        passButtomLabel.backgroundColor = UIColor(red: 229/255, green: 229/255, blue: 229/255, alpha: 1)
        inputPassView.addSubview(inputPassImageView)
        inputPassView.addSubview(passButtomLabel)
        inputPassView.addSubview(textPassField)
        inputView.addSubview(inputPassView)
        contentView.addSubview(inputView)
        
        let buttonView = UIButton(frame: CGRect(x: 20, y: UIScreen.main.bounds.height*2/5+120, width: view.frame.width-40, height: 40))
        buttonView.setTitle("登录", for: UIControlState.normal)
        buttonView.setTitle("登录", for: UIControlState.highlighted)
        buttonView.setTitleColor(UIColor.white,for: .normal) //普通状态下文字的颜色
        buttonView.setTitleColor(UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1),for: .highlighted) //触摸状态下文字的颜色
        buttonView.layer.cornerRadius = 15
        buttonView.layer.backgroundColor = UIColor(red: 31/255, green: 65/255, blue: 172/255, alpha: 1).cgColor
        buttonView.addTarget(self, action: #selector(LoginViewController.startTouch(_:)), for: UIControlEvents.touchUpInside)
        contentView.addSubview(buttonView)
        //MARK:设置内容页大小
        contentView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: UIScreen.main.bounds.height*2/5+160)
        scrollView.contentSize = CGSize(width: contentView.frame.width, height: UIScreen.main.bounds.height*2/5+160)
        scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: contentView.frame.height)
        scrollView.backgroundColor = UIColor.white
        scrollView.addSubview(contentView)
        view.addSubview(scrollView)
        let name1 = self.userDefault.string(forKey: "name")
        textNameField.text = (name1 != nil) ? name1 : ""
        let Value = self.userDefault.string(forKey: "password")
        textPassField.text = (Value != nil) ? Value : ""
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.tag == 2{
            //收起键盘
            textField.resignFirstResponder()
            
            //登录
            requestLoginNet()
        }else{
            textPassField.becomeFirstResponder()
        }
        print("123")
        //打印出文本框中的值
        print(textField.text as Any)
        return true;
    }
    
    @objc func startTouch(_ button:UIButton){
        UIView.animate(withDuration: 0.2, animations: {
            button.backgroundColor = UIColor(red: 31/255, green: 65/255, blue: 172/255, alpha: 0.5)
        }) { (true) in
            button.backgroundColor = UIColor(red: 31/255, green: 65/255, blue: 172/255, alpha: 1)
        }
        requestLoginNet()
    }
    func requestLoginNet(){
        let username : String = textNameField.text!
        let password : String = textPassField.text!
        if username == ""{
            windowAlert(msges: "用户名不能为空")
            return
        }
        if password == ""{
            windowAlert(msges: "密码不能为空")
            return
        }
        //网络请求
        let urlStr = "http://192.168.24.1:2567/app/sys/login1"
        let headers: HTTPHeaders = [
            "Authorization": "Basic QWxhZGRpbjpvcGVuIHNlc2FtZQ==",
            "Accept": "application/json"
        ]
        let contentData : [String : Any] = ["method":"login","info":["username":username,"password":password]]
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 10
        
        let sessionManager = Alamofire.SessionManager(configuration: configuration)
        sessionManager.request(urlStr, method: .post, parameters: contentData, encoding: JSONEncoding.default, headers: headers).responseJSON { (resultData) in
            
            switch resultData.result {
            case .success(let value):
                //把账号和密码保存本地
                self.userDefault.set(username, forKey: "name")
                self.userDefault.set(password,forKey:"password")
                let json = JSON(value)
                print(json)
                print(json["method"])
                print(json["info"])
                print(json["info"]["username"])
                print(value)
                //实例化将要跳转的controller
                let sb = UIStoryboard(name: "Main", bundle:nil)
                let vc = sb.instantiateViewController(withIdentifier: "mainStoryboardViewController") as! FrameViewController
                self.present(vc, animated: false, completion: nil)
            case .failure(let error):
                //self.windowAlert(msges: "数据请求失败")
                self.userDefault.set(username, forKey: "name")
                self.userDefault.set(password,forKey:"password")
                let sb = UIStoryboard(name: "Main", bundle:nil)
                let vc = sb.instantiateViewController(withIdentifier: "mainStoryboardViewController") as! FrameViewController
                self.present(vc, animated: false, completion: nil)
                print("error:\(error)")
                return
                
            }
            
        }
        
        
        
    }
    
    /**
     字典转换为JSONString
     
     - parameter dictionary: 字典参数
     
     - returns: JSONString
     */
    func getJSONStringFromDictionary(dictionary:NSDictionary) -> String {
        if (!JSONSerialization.isValidJSONObject(dictionary)) {
            print("无法解析出JSONString")
            return ""
        }
        let data : NSData! = try? JSONSerialization.data(withJSONObject: dictionary, options: []) as NSData!
        let JSONString = NSString(data:data as Data,encoding: String.Encoding.utf8.rawValue)
        return JSONString! as String
        
    }
    
    /// JSONString转换为字典
    ///
    /// - Parameter jsonString: <#jsonString description#>
    /// - Returns: <#return value description#>
    func getDictionaryFromJSONString(jsonString:String) ->NSDictionary{
        
        let jsonData:Data = jsonString.data(using: .utf8)!
        
        let dict = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
        if dict != nil {
            return dict as! NSDictionary
        }
        return NSDictionary()
        
        
    }
    //MARK:alert弹框
    func windowAlert(msges : String){
        let alertView = UIAlertController(title: "提示", message: msges, preferredStyle: UIAlertControllerStyle.alert)
        let yes = UIAlertAction(title: "确认", style: UIAlertActionStyle.default, handler: nil)
        alertView.addAction(yes)
        self.present(alertView,animated:true,completion:nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
