//
//  HTTPHeaderPlugin.swift
//  JC
//
//  Created by harry on 2019/9/6.
//  Copyright © 2019 harry. All rights reserved.
//

import UIKit
import Moya
import CoreTelephony
import CryptoSwift

struct HTTPHeaderPlugin:PluginType {
    let token:String
    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        var request = request
        //  令牌
        if (token.count > 0){
            request.addValue(token, forHTTPHeaderField: "authorization")
        }
        //  系统类型
        request.addValue("ios" , forHTTPHeaderField: "systemType")
        //  设备名称
        let deviceName = UIDevice.current.name
        request.addValue(deviceName, forHTTPHeaderField: "deviceName")
        //  系统版本
        let sysVersion = UIDevice.current.systemVersion
        request.addValue(sysVersion, forHTTPHeaderField: "sysVersion")
        //  设备唯一码
        let identity:UUID! = UIDevice.current.identifierForVendor
        let identity_str:String = identity.uuidString
        request.addValue(identity_str, forHTTPHeaderField: "deviceId")
        //  app 版本号
        let infoDic:Dictionary! = Bundle.main.infoDictionary
        let appVersion:String = infoDic["CFBundleShortVersionString"] as! String
        request.addValue(appVersion, forHTTPHeaderField: "appVersion")
        //  运营商名称
        //        let operator_name:String = CTTelephonyNetworkInfo().subscriberCellularProvider?.carrierName ?? ""
        //        request.addValue(operator_name, forHTTPHeaderField: "operator")
        //  网络连接类型
        request.addValue(appVersion, forHTTPHeaderField: "connectionType")
        //  请求时间戳
        let utime:String = "\(Int(Date().timeIntervalSince1970))"
        //  随机字符串
        let noncestr = NSUUID().uuidString
        //  添加功能参数
        var argument_str:String = String(data: request.httpBody!, encoding: .utf8) ?? ""
        if (argument_str.count > 0){
            argument_str = "\(argument_str)&"
        }
        argument_str = "\(argument_str)utime=\(utime)&noncestr=\(noncestr)"
        request.httpBody = argument_str.data(using: .utf8)
        //  url参数解析
        let url:URL = URL(string: "\(request.url!.absoluteString)?\(argument_str)")!
        let uu = NSURLComponents(url: url, resolvingAgainstBaseURL: true)
        let dict:NSMutableDictionary = NSMutableDictionary()
        for item in (uu?.queryItems)!{
            dict.setValue(item.value, forKey: item.name)
        }
        // 排序
        let keys = dict.allKeys.sorted { (obj_1, obj_2) -> Bool in
            return sortedByKey(str_1: obj_1 as! NSString, str_2: obj_2 as! NSString,index: 0)
        }
        var sign:String! = "";
        for key in keys{
            sign += "\(key)=\(dict[key] ?? "")"
        }
        sign.append(global_http_key);
        let sign_sha1 = sign.sha1().uppercased();
        //  签名
        request.addValue(sign_sha1, forHTTPHeaderField: "sign")
        return request
    }
    
    // 数组循环排序
    func sortedByKey(str_1:NSString,str_2:NSString,index:NSInteger) -> Bool {
        let asciiCode_1:Int = Int(str_1.character(at: index))
        let asciiCode_2:Int = Int(str_1.character(at: index))
        if asciiCode_1 == asciiCode_2 {
            if index == str_1.length-1 && str_1.length < str_2.length {
                return false;
            }else if(index == str_2.length-1 && str_2.length < str_1.length){
                return true;
            }else{
                return sortedByKey(str_1: str_1, str_2: str_2, index: index+1)
            }
        }
        else if (asciiCode_1 < asciiCode_2) {
            return false;
        }else{
            return true;
        }
    }
    
}
