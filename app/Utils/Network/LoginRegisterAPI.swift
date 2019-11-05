//
//  LoginRegisterAPI.swift
//  Project
//
//  Created by zw-bdz-003 on 2019/4/29.
//  Copyright © 2019 harry. All rights reserved.
//

import Moya

public enum LoginRegister {
    case login(username:String,password:String)
}

extension LoginRegister:TargetType{
    public var baseURL: URL {
        return URL(string: global_base_url)!
    }
    
    public var path: String {
        switch self {
        case .login:return "New_Joke/getRecommendList"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .login:
            return .post
        }
    }
    
    public var sampleData: Data {
        return "{}".data(using: String.Encoding.utf8)!
    }
    
    public var task: Task {
        var argument:[String:Any]
        switch self {
        case .login:
//            argument = ["tel":tel,
//                        "password":pwd]
//            argument = ["min_score":"1552338005"]
            
            break
        }
        return Task.requestParameters(parameters: ["min_score":"0"], encoding: URLEncoding.default)
    }
    
    public var headers: [String : String]? {
        return nil
    }
    

}

