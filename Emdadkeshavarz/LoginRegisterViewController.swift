//
//  ViewController.swift
//  Emdadkeshavarz
//
//  Created by Behnava on 10/9/18.
//  Copyright © 2018 Behnava. All rights reserved.
//
import UIKit
import Alamofire
import SwiftyJSON
import Toast

class LoginRegisterViewControler: UIViewController {
    @IBOutlet weak var IPlbl: UILabel!
    @IBOutlet weak var RegView: UIView!
    @IBOutlet weak var ftMobile: UITextField!
    @IBOutlet weak var ftName: UITextField!
    @IBOutlet weak var ftFamily: UITextField!
    @IBOutlet weak var LoginView: UIView!
    @IBOutlet weak var pvOstan: UIPickerView!
      let provinceDic:[(name: String, code: Int)] = [("Oregon", 8), ("Wisconsin", 9)]
    var province : String = "100"
    @IBOutlet weak var RegCodeLogin: UIView!
    @IBOutlet weak var tfMobileLogin: UITextField!
    @IBOutlet weak var tfCodeLogin: UITextField!
    
    
    @IBAction func btnGoLogin(_ sender: Any) {
        RegView.isHidden = true
        LoginView.isHidden = false
    }
    
    @IBAction func btnGoRegister(_ sender: Any) {
        LoginView.isHidden = true
        RegView.isHidden = false
        
    }
    
    @IBAction func btnRegister(_ sender: Any) {
        
      
        let name : String = ftName.text!
        let fname : String = ftFamily.text!
        let mobile : String = ftMobile.text!
      
        
        Alamofire.request("http://emdadkeshavarz.com/api/emdadapplicantregister", method: .post, parameters: ["Name": name, "FamilyName": fname, "Province": province, "Mobile": mobile, "Type" : "Register", "Token" : "asert"])
            .validate()
            .responseString { response in
                switch response.result {
                case .success:
                    //print("Validation Successful")
                    self.RegView.isHidden = false
                case .failure(let error):
                    let Code = response.response?.statusCode
                    print(error)
                    if Code == 403{
                        self.view.makeToast("شما قبلا عضو شده ايد",duration : 0.5,position:"bottom")}
                    else if Code == 500{
                        self.view.makeToast("خطا در برقراري ارتباط با سرور",duration : 0.5,position:"bottom")}
                    else {
                        self.view.makeToast("خطا در برقراري ارتباط با سرور",duration : 0.5,position:"bottom") }
                    
                }
        }
    }
    
    @IBAction func btnLogin(_ sender: Any) {
        let mobile : String = tfMobileLogin.text!
        Alamofire.request("http://emdadkeshavarz.com/api/emdadapplicantregister", method: .post, parameters: ["Mobile": mobile, "Type" : "Login", "Token" : "asert"])
            .validate()
            .responseString { response in
                switch response.result {
                case .success:
                    //print("Validation Successful")
                    self.RegCodeLogin.isHidden = true
                case .failure(let error):
                    let Code = response.response?.statusCode
                    print(error)
                    if Code == 403{
                        self.view.makeToast("شما قبلا عضو شده ايد",duration : 0.5,position:"bottom")}
                    else if Code == 500{
                        self.view.makeToast("خطا در برقراري ارتباط با سرور",duration : 0.5,position:"bottom")}
                    else {
                        self.view.makeToast("خطا در برقراري ارتباط با سرور",duration : 0.5,position:"bottom") }
                    
                }
        }
      
    }
    
    @IBAction func btnSubmitCode(_ sender: Any) {
        let mobile : String = tfMobileLogin.text!
        let Code : String = tfCodeLogin.text!
        Alamofire.request("http://emdadkeshavarz.com/api/emdadapplicationverification", method: .post, parameters: ["Mobile": mobile, "SmsCode" : Code])
            .validate()
            .responseString { response in
                switch response.result {
                case .success:
                    //print("Validation Successful")
                     self.view.makeToast("با موفقيت وارد شديد",duration : 0.5,position:"bottom")
                    self.RegCodeLogin.isHidden = true
                case .failure(let error):
                    let Code = response.response?.statusCode
                    print(error)
                    if Code == 403{
                        self.view.makeToast("شما قبلا عضو شده ايد",duration : 0.5,position:"bottom")}
                    else if Code == 500{
                        self.view.makeToast("خطا در برقراري ارتباط با سرور",duration : 0.5,position:"bottom")}
                    else {
                        self.view.makeToast("خطا در برقراري ارتباط با سرور",duration : 0.5,position:"bottom") }
                    
                }
        }
    }
    
    let stateInfo:[(name: String, tax: Double)] = [("Alabama", 6.000), ("Illinois", 7.000), ("Oregon", 8.000), ("Wisconsin", 9.000)]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        pvOstan.dataSource = self
        pvOstan.delegate = self
        LoginView.isHidden = true
        LoginView.layer.cornerRadius = 10.0
        RegView.layer.cornerRadius = 10.0
        RegCodeLogin.isHidden = false
      
        Alamofire.request("https://httpbin.org/ip").responseJSON { (responseData) -> Void in
            if((responseData.result.value) != nil) {
                let swiftyJsonVar = JSON(responseData.result.value!)
                self.IPlbl.text = swiftyJsonVar["origin"].string
    
            }
        }
    }
    
}



extension LoginRegisterViewControler :   UIPickerViewDelegate,UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.provinceDic.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
       self.province = "\(self.provinceDic[row].code)"
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.provinceDic[row].name
    }
    
}

