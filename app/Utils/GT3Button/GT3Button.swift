//
//  GT3Button.swift
//  app
//
//  Created by harry on 2019/10/30.
//  Copyright © 2019 harry. All rights reserved.
//

import UIKit
import GT3Captcha


let api_1 = "http://www.geetest.com/demo/gt/register-slide"
let api_2 = "http://www.geetest.com/demo/gt/validate-slide"

@objc protocol GT3ButtonDelegate {
    @objc optional func shouldBeginTapAction(button:GT3Button)->Bool;
    @objc optional func didReceive(captchaData:Data,response:URLResponse,error:GT3Error)
    @objc optional func errorHandle(manager:GT3CaptchaManager,error:GT3Error);
}

class GT3Button: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        manager.delegate = self
        self.manager.registerCaptcha {
            print("注册成功")
        }
        self.addTarget(self, action: #selector(startCaptcha), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        stopCaptcha()
    }
    
    @objc func startCaptcha() {
        if delegate != nil{
            self.manager.startGTCaptchaWith(animated: true)
        }
    }
    
    func stopCaptcha(){
        manager.stopGTCaptcha()
    }
    
    
    let manager:GT3CaptchaManager = GT3CaptchaManager(api1: api_1, api2: api_2, timeout: 5.0).then {
        $0.enableDebugMode(true)
        $0.useVisualView(with: UIBlurEffect.init(style: .dark))
    }
    
    let indicatorView:UIActivityIndicatorView = UIActivityIndicatorView(style: .gray).then {
        $0.hidesWhenStopped = true
        $0.stopAnimating()
    }
    
    var delegate:GT3ButtonDelegate?
}


extension GT3Button:GT3CaptchaManagerDelegate{
    func gtCaptcha(_ manager: GT3CaptchaManager!, errorHandler error: GT3Error!) {
        
    }
    
    func gtCaptcha(_ manager: GT3CaptchaManager!, didReceiveSecondaryCaptchaData data: Data!, response: URLResponse!, error: GT3Error!, decisionHandler: ((GT3SecondaryCaptchaPolicy) -> Void)!) {
        if error == nil{
            decisionHandler(GT3SecondaryCaptchaPolicy.allow)
        }else{
            decisionHandler(GT3SecondaryCaptchaPolicy.forbidden)
        }
        if delegate != nil{
            delegate!.didReceive!(captchaData: data, response: response, error: error)
        }
    }
    
    func gtCaptcha(_ manager: GT3CaptchaManager!, willSendRequestAPI1 originalRequest: URLRequest!, withReplacedHandler replacedHandler: ((URLRequest?) -> Void)!) {
        replacedHandler(originalRequest)
    }
}
