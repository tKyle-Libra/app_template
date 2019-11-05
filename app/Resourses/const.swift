//
//  bdl.swift
//  JC
//
//  Created by harry on 2019/9/6.
//  Copyright © 2019 harry. All rights reserved.
//

import UIKit
import Moya

func screen_width()->CGFloat{
    return UIScreen.main.bounds.size.width
}

func screen_height()->CGFloat{
    return UIScreen.main.bounds.size.height
}

func global_scale()->CGFloat{
    return screen_width()==375 ? 1.0 : screen_width()/375
}

func status_bar_height()->CGFloat{
    return UIApplication.shared.statusBarFrame.size.height
}

func PingFangSC_Medium(size:Float)->UIFont{
    return UIFont(name: "PingFangSC-Medium", size: CGFloat(size))!
}

func PingFangSC_Semibold(size:Float)->UIFont{
    return UIFont(name: "PingFangSC-Semibold", size: CGFloat(size))!
}

func PingFangSC_Light(size:Float)->UIFont{
    return UIFont(name: "PingFangSC-Light", size: CGFloat(size))!
}

func PingFangSC_Ultralight(size:Float)->UIFont{
    return UIFont(name: "PingFangSC-Ultralight", size: CGFloat(size))!
}

func PingFangSC_Regular(size:Float)->UIFont{
    return UIFont(name: "PingFangSC-Regular", size: CGFloat(size))!
}

func PingFangSC_Thin(size:Float)->UIFont{
    return UIFont(name: "PingFangSC-Thin", size: CGFloat(size))!
}

func navigation_bar_height()->CGFloat{
    return status_bar_height()+44.0;

}

func tabbar_height()->CGFloat{
    return status_bar_height()>20 ? 83.0 : 49.0;
    
}

func global_token()->String{
    return UserDefaults.standard.object(forKey: "token") as? String ?? ""
    
}

func global_key_window()->UIWindow{
    return UIApplication.shared.keyWindow!
}


let global_base_url = "http://app.bdz365.com/"

let global_http_key = "EFSDFSDLLJL7845645JKJdfLKNKKKkjjjksd"

//fileprivate let activity_indicator = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 200, height: 200),
//                                                             type: .circleStrokeSpin,
//                                                             color: .red,
//                                                             padding: 20)

fileprivate let http_activity_plugin = NetworkActivityPlugin { (change,obj)  -> () in
    switch(change) {
    case .ended:
//        activity_indicator.stopAnimating()
        break;
    case .began:
//        activity_indicator.startAnimating()
        break;
    }
}

let global_http_plugin:[PluginType] = [HTTPHeaderPlugin(token: global_token()),
                                       HTTPLoggerPlugin(),
                                       http_activity_plugin]
