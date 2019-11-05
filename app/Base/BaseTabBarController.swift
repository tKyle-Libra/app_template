//
//  BaseTabBarController
//  JC
//
//  Created by harry on 2019/9/9.
//  Copyright © 2019 harry. All rights reserved.
//

import UIKit
import ESTabBarController_swift

class BaseTabBarController: ESTabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        allocItem()
    }
    
    fileprivate func allocItem(){
        home_main.tabBarItem = ESTabBarItem.init(BaseTabbarItem(),
                                                 title: "首页",
                                                 image: UIImage(named: "home"),
                                                 selectedImage: UIImage(named: "home_1"))
        msg_main.tabBarItem = ESTabBarItem.init(BaseTabbarItem(),
                                                title: "客服",
                                                image: UIImage(named: "message"),
                                                selectedImage: UIImage(named: "message_1"))
        mine_main.tabBarItem = ESTabBarItem.init(BaseTabbarItem(),
                                                 title: "我的",
                                                 image: UIImage(named: "me"),
                                                 selectedImage: UIImage(named: "me_1"))
        self.viewControllers = [BaseNavigationController(rootViewController: home_main),
                                BaseNavigationController(rootViewController: msg_main),
                                BaseNavigationController(rootViewController: mine_main)]
    }
    
    
    let home_main:HomeMainController = HomeMainController()
    let msg_main:MsgMainController = MsgMainController()
    let mine_main:MineMainController = MineMainController()
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
