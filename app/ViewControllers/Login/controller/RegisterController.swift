//
//  RegisterController.swift
//  app
//
//  Created by harry on 2019/10/30.
//  Copyright © 2019 harry. All rights reserved.
//

import UIKit
import GT3Captcha

class RegisterController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interfaceSetup()
    }
    
    private func interfaceSetup(){
        submitBtn.delegate = self
        usernameField.addTarget(self, action: #selector(inputFieldChange(inputField:)), for: .editingChanged)
        smscodeField.addTarget(self, action: #selector(inputFieldChange(inputField:)), for: .editingChanged)
        smscodeField.rightView = smscodeBtn
        passwordField.addTarget(self, action: #selector(inputFieldChange(inputField:)), for: .editingChanged)
        repasswordField.addTarget(self, action: #selector(inputFieldChange(inputField:)), for: .editingChanged)
//        submitBtn.addTarget(self, action: #selector(submit), for: .touchUpInside)
        smscodeBtn.addTarget(self, selector: #selector(countDown(sender:)))
        self.view.addSubview(usernameField)
        self.view.addSubview(smscodeField)
        self.view.addSubview(smscodeBtn)
        self.view.addSubview(passwordField)
        self.view.addSubview(repasswordField)
        self.view.addSubview(submitBtn)
        usernameField.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(50);
            make.left.equalTo(self.view).offset(15);
            make.right.equalTo(self.view).offset(-15)
            make.height.equalTo(50)
        }
        smscodeField.snp.makeConstraints { (make) in
            make.top.equalTo(self.usernameField.snp.bottom).offset(50);
            make.left.equalTo(self.view).offset(15);
            make.right.equalTo(self.view).offset(-15)
            make.height.equalTo(50)
        }
        passwordField.snp.makeConstraints { (make) in
            make.top.equalTo(self.smscodeField.snp.bottom).offset(50);
            make.left.equalTo(self.view).offset(15);
            make.right.equalTo(self.view).offset(-15)
            make.height.equalTo(50)
        }
        repasswordField.snp.makeConstraints { (make) in
            make.top.equalTo(self.passwordField.snp.bottom).offset(50);
            make.left.equalTo(self.view).offset(15);
            make.right.equalTo(self.view).offset(-15)
            make.height.equalTo(50)
        }
        submitBtn.snp.makeConstraints { (make) in
            make.top.equalTo(self.repasswordField.snp.bottom).offset(50);
            make.left.equalTo(self.view).offset(15);
            make.right.equalTo(self.view).offset(-15)
            make.height.equalTo(50)
        }
    }
    
    let usernameField = UITextField().then {
        $0.backgroundColor = .red
        $0.placeholder = "请输入电话号码"
    }
    let smscodeField = UITextField().then {
        $0.backgroundColor = .red
        $0.placeholder = "请输入短信验证码"
        $0.rightViewMode = .always
    }
    let smscodeBtn = VerificationCodeButton(when: "register").then {
        $0.setText("发送验证码", for: .normal)
        $0.setText("获取中", for: .sending)
        $0.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
    }
    
    let passwordField = UITextField().then {
        $0.backgroundColor = .red
        $0.placeholder = "请输入密码"
        $0.isSecureTextEntry = true
    }
    let repasswordField = UITextField().then {
        $0.backgroundColor = .red
        $0.placeholder = "请输入密码"
        $0.isSecureTextEntry = true
    }
    let submitBtn = GT3Button().then(){
        $0.setTitle("提交", for: .normal)
        $0.isEnabled = false
        $0.jk_setBackgroundColor(.red, for: .normal)
        $0.jk_setBackgroundColor(.orange, for: .disabled)
    }
    
    var username = ""
    var smscode = ""
    var password = ""
    var repassword = ""
}



fileprivate extension RegisterController{
    @objc func inputFieldChange(inputField:UITextField){
        let str = NSString(string: inputField.text!);
        if (inputField == usernameField){
            username = str.jk_isMobileNumber() ? inputField.text! : ""
        }else if (inputField == smscodeField){
            smscode = str.jk_isValid(withMinLenth: 4,
                                     maxLenth: 8,
                                     containChinese: false,
                                     containDigtal: true,
                                     containLetter: false,
                                     containOtherCharacter: "",
                                     firstCannotBeDigtal: false) ? inputField.text! : ""
        }else if (inputField == passwordField){
            password = str.jk_isValid(withMinLenth: 8,
                                      maxLenth: 16,
                                      containChinese: false,
                                      firstCannotBeDigtal: false) ? inputField.text! : ""
        }else{
            repassword = str.jk_isValid(withMinLenth: 8,
                                        maxLenth: 16,
                                        containChinese: false,
                                        firstCannotBeDigtal: false) ? inputField.text! : ""
        }
        submitBtn.isEnabled = username.count > 0 && smscode.count > 0 && password.count > 0 && repassword.count > 0
    }
    
    @objc func countDown(sender:VerificationCodeButton){
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            sender.countDown()
        }
    }
    
    @objc func submit(){
        
    }
}

extension RegisterController:GT3ButtonDelegate{
    
    func didReceive(captchaData: Data, response: URLResponse, error: GT3Error) {
        
    }
}
