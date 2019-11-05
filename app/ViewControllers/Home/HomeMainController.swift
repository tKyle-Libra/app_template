//
//  HomeMainController.swift
//  JC
//
//  Created by harry on 2019/9/9.
//  Copyright © 2019 harry. All rights reserved.
//

import UIKit

class HomeMainController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let btn = UIButton(frame: CGRect(x: 0, y: navigation_bar_height()+100, width: 50, height: 50))
        btn.addTarget(self, action: #selector(btnEvent), for: .touchUpInside)
        btn.backgroundColor = .red
        self.view.addSubview(btn)
        
    }
    
    @objc fileprivate func btnEvent(){
        let liveDetailsController = LoginController()
        self.navigationController?.pushViewController(liveDetailsController, animated: true)
//        let dict:NSMutableDictionary = NSMutableDictionary()
//        dict.ssdkSetupShareParams(byText: "test",
//                                  images: "http://www.mob.com/assets/images/ShareSDK_pic_1-09d293a6.png",
//                                  url: URL(string: "http://www.mob.com/"),
//                                  title: "title",
//                                  type: .image)
//        ShareSDK.showShareActionSheet(nil, items: nil, shareParams: dict) { (state, type, userdata, contentEntity, erroe, isFinished) in
//
//        }
        
    }


}
