//
//  LoginController.swift
//  app
//
//  Created by harry on 2019/10/16.
//  Copyright © 2019 harry. All rights reserved.
//

import UIKit
import Moya

class LoginController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        interfaceSetup()
    }
    
    func interfaceSetup(){
           usernameField.addTarget(self, action: #selector(inputFieldChange(inputField:)), for: .editingChanged)
           passwordField.addTarget(self, action: #selector(inputFieldChange(inputField:)), for: .editingChanged)
           loginButton.addTarget(self, action: #selector(loginWithWeixin), for: .touchUpInside)
           self.view.addSubview(usernameField)
           self.view.addSubview(passwordField)
           self.view.addSubview(loginButton)
           usernameField.snp.makeConstraints { (make) in
               make.top.equalTo(self.view).offset(100);
               make.left.equalTo(self.view).offset(15);
               make.right.equalTo(self.view).offset(-15)
               make.height.equalTo(50)
           }
           passwordField.snp.makeConstraints { (make) in
               make.top.equalTo(self.usernameField.snp.bottom).offset(100);
               make.left.equalTo(self.view).offset(15);
               make.right.equalTo(self.view).offset(-15)
               make.height.equalTo(50)
           }
           loginButton.snp.makeConstraints { (make) in
               make.left.equalTo(self.view).offset(15);
               make.right.equalTo(self.view).offset(-15)
               make.top.equalTo(self.passwordField.snp.bottom).offset(100);
               make.height.equalTo(50)
           }
       }
    
    let usernameField:UITextField = UITextField().then {
        $0.placeholder = "输入用户名"
        $0.backgroundColor = .red
    };
    let passwordField:UITextField = UITextField().then {
        $0.placeholder = "输入密码"
        $0.backgroundColor = .red
        $0.isSecureTextEntry = true
    }
    let loginButton:UIButton = UIButton().then {
        $0.setTitle("登录", for: .normal)
        $0.backgroundColor = .red
        $0.jk_setBackgroundColor(.blue, for: .normal)
        $0.jk_setBackgroundColor(.orange, for: .disabled)
        $0.isEnabled = false
    };
    
    var username = ""
    var password = ""
}

//  action
fileprivate extension LoginController{
    @objc func inputFieldChange(inputField:UITextField){
        let str = NSString(string: inputField.text!);
        if (inputField == usernameField){
            username = str.jk_isMobileNumber() ? inputField.text! : ""
        }else{
            password = str.jk_isValid(withMinLenth: 8, maxLenth: 16, containChinese: false, firstCannotBeDigtal: false) ? inputField.text! : ""
        }
        loginButton.isEnabled = username.count > 0 && password.count > 0
    }
    
    @objc func login(){
        let loginProvider = MoyaProvider<LoginRegister>(plugins:global_http_plugin)
        loginProvider.request_callback(target: .login(username: username, password: password), success: { (response, msg) in
            
        }) { (msg, code) in
            
        }
    }
    
    @objc func loginWithWeixin(){
        ShareSDK.getUserInfo(.typeWechat) { (state, user, error) in
            
        }
    }
}
