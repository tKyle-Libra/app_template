//
//  BaseViewController.swift
//  JC
//
//  Created by harry on 2019/9/6.
//  Copyright © 2019 harry. All rights reserved.
//

import UIKit
import DynamicColor
import NVActivityIndicatorView
import SnapKit
import Then
import JKCategories


class BaseViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
    }
    
    deinit {
        self.navigationItem.backBarButtonItem = nil
    }
}
