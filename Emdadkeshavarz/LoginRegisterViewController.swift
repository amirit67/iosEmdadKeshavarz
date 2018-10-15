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

    @IBAction func btnRegister(_ sender: Any) {
        RegView.isHidden = true
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        RegView.layer.cornerRadius = 8.0

        
        
        Alamofire.request("https://httpbin.org/ip").responseJSON { (responseData) -> Void in
            if((responseData.result.value) != nil) {
                let swiftyJsonVar = JSON(responseData.result.value!)
                self.IPlbl.text = swiftyJsonVar["origin"].string
    
            }
        }
    }


}

