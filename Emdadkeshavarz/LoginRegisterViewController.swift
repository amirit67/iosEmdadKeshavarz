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

class LoginRegisterViewControler: UIViewController {
    @IBOutlet weak var IPlbl: UILabel!
    @IBOutlet weak var RegView: UIView!
    @IBOutlet weak var ftMobile: UITextField!
    @IBOutlet weak var ftName: UITextField!
    @IBOutlet weak var ftFamily: UITextField!
    @IBOutlet weak var LoginView: UIView!
    @IBOutlet weak var pvOstan: UIPickerView!

    @IBAction func btnRegister(_ sender: Any) {
        RegView.isHidden = true
        LoginView.isHidden = false
    }
    
    @IBAction func btnLogin(_ sender: Any) {
       LoginView.isHidden = true
      
    }
    
    let stateInfo:[(name: String, tax: Double)] = [("Alabama", 6.000), ("Illinois", 7.000), ("Oregon", 8.000), ("Wisconsin", 9.000)]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        pvOstan.dataSource = self
        pvOstan.delegate = self
        LoginView.isHidden = true
        LoginView.layer.cornerRadius = 10.0
        RegView.layer.cornerRadius = 10.0
      
  
        
        
        Alamofire.request("https://httpbin.org/ip").responseJSON { (responseData) -> Void in
            if((responseData.result.value) != nil) {
                let swiftyJsonVar = JSON(responseData.result.value!)
                self.IPlbl.text = swiftyJsonVar["origin"].string
    
            }
        }
    }
}

extension LoginRegisterViewControler: UIPickerViewDelegate, UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
         return 1
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
         return stateInfo.count
    }
    
    func pickerView(pvOstan: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        ftName.text = "\( stateInfo[row].tax )"
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return stateInfo[row].name
    }
}

