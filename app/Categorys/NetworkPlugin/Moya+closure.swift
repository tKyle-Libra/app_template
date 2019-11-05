//
//  Moya+closure.swift
//  JC
//
//  Created by harry on 2019/9/6.
//  Copyright © 2019 harry. All rights reserved.
//

import Foundation
import Moya
import SwiftyJSON
import Toast_Swift
import ObjectMapper

extension MoyaProvider{
    // 请求成功的回调
    typealias successCallback = (_ result: Any,_ msg:String) -> Void
    // 请求失败的回调
    typealias failureCallback = (_ error: String,_ code:Int) -> Void
    
    func request_callback(target:Target,
                          success: @escaping successCallback,
                          failure: @escaping failureCallback){
        request(target) { (result) in
            switch result {
            case let .success(response):
                let json = JSON(response.data)
                let code = json["code"].intValue
                let msg = json["msg"].stringValue
                if code == 1{
                    success(json["data"].arrayValue,msg)
                }else{
                    failure(self.errorCodeHanlde(code: code),code)
                }
                break;
            case let .failure(error):
                failure(error.localizedDescription,111111111)
                break;
            }
        }
    }
    
    
    func errorCodeHanlde(code:Int)->String{
        var msg:String
        if code == 50006{
            // 登陆
            msg = "登陆超时请重新登陆"
        }else{
            let error_code_path = Bundle.main.path(forResource: "errorcode", ofType: "plist")
            let error_code_dict = NSMutableDictionary(contentsOfFile: error_code_path!)
            let key = "\(code)"
            if NSArray(array: error_code_dict!.allKeys).contains(key){
                msg = error_code_dict![key] as! String
            }else{
                msg = "未知错误"
            }
        }
        global_key_window().makeToast(msg)
        return msg;
    }
}
