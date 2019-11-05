//
//  HTTPLoggerPlugin.swift
//  JC
//
//  Created by harry on 2019/9/6.
//  Copyright © 2019 harry. All rights reserved.
//

import UIKit
import Moya
import CocoaLumberjack
import Result
import SwiftyJSON

class HTTPLoggerPlugin: PluginType {
    func willSend(_ request: RequestType, target: TargetType) {
        let url_request:URLRequest = request.request!
        let argument_str:String = String(data: url_request.httpBody!, encoding: .utf8) ?? ""
        let url:URL = URL(string: "\(url_request.url!.absoluteString)?\(argument_str)")!
        let uu = NSURLComponents(url: url, resolvingAgainstBaseURL: true)
        DDLogDebug("☀️☀️☀️☀️☀️☀️☀️☀️☀️☀️☀️☀️☀️☀️☀️☀️☀️☀️☀️☀️☀️")
        DDLogDebug("🌈 url：\(url_request.url!.absoluteString) 🌈")
        
        let headers:[String:String] = url_request.allHTTPHeaderFields!
        for dict in headers {
            DDLogDebug("⚡️ \(dict.key)：\(dict.value)")
        }
        for item in (uu?.queryItems)!{
            DDLogDebug("🔥 \(item.name)：\(item.value!)")
        }
    }
    
    func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        switch result {
        case let .success(response):
            let json = JSON(response.data)
            if json["code"] == 1{
                DDLogDebug("✅ data：\(json["data"])")
                DDLogDebug("✅ msg：\(json["msg"])")
            }else{
                DDLogDebug("⛔️ code = \(json["code"])")
                DDLogDebug("🆘 msg = \(json["msg"])")
            }
            break
        case let .failure(error):
            DDLogDebug("❌ error = \(error)")
            break
        }
        DDLogDebug("--------------------------------------------------------------------------------------------------------------------------------------------")
    }
}
