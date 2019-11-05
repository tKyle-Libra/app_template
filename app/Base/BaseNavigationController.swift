//
//  BaseNavigationController.swift
//  JC
//
//  Created by harry on 2019/9/6.
//  Copyright © 2019 harry. All rights reserved.
//

import UIKit
import JKCategories

class BaseNavigationController: UINavigationController {

    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        defaultNavigationBarStyle()
    }
    
    func defaultNavigationBarStyle(){
//        navigationBar.barStyle = .default;
//        navigationBar.shadowImage = UIImage()
//        navigationBar.setBackgroundImage(UIImage(), for: .default)
//        navigationBar.barTintColor = .white
        let image = UIImage(named: "back")!.withRenderingMode(.alwaysOriginal)
        navigationBar.backIndicatorImage = image
        navigationBar.backIndicatorTransitionMaskImage = image
//        navigationBar.isTranslucent = true
//        navigationBar.titleTextAttributes = [NSAttributedString.Key.font:PingFangSC_Regular(size: 18),
//                                             NSAttributedString.Key.foregroundColor:UIColor.white]
        
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if self.viewControllers.count > 0{
            viewController.hidesBottomBarWhenPushed = true
//            viewController.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        }
        super.pushViewController(viewController, animated: true)
    }
    
    override func show(_ vc: UIViewController, sender: Any?) {
        if self.viewControllers.count > 0{
            vc.hidesBottomBarWhenPushed = true
        }
        super.show(vc, sender: sender)
    }
    
    override func setViewControllers(_ viewControllers: [UIViewController], animated: Bool) {
        if viewControllers.count > 0{
            for vc in viewControllers{
                if (vc != viewControllers.first){
                    vc.hidesBottomBarWhenPushed = true
                }
            }
        }
        super.setViewControllers(viewControllers, animated: animated)
    }
    
    override var shouldAutorotate: Bool{
        return false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        return .portrait
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation{
        return .portrait
    }
    
    
}
